#include "fsi.h"
#include <string.h>
double initial (double *, int);
double bound (double, double *, int);
int idnod (double *, int);
int gidpre1(void)
{
    FILE *fp;
    int i,j,knode,nnode,nelem,nmate,nprmt;
    int m,mm,n,nn,mkd;
    double *coor, r[3];
    char mystring[160];
	double re[10],rhor[10],mur[10],c1bar[10],fr[10];


    if ((fp = fopen("./input/dimension","r"))==NULL)
    {
        printf("cannot open %s\n", "dimension");
        exit(1);
    }
    fscanf(fp,"%d",&dim);
    fclose(fp);		

	/*  read material paramters and write into fsi.mat*/
    if ((fp = fopen("./input/materials","r"))==NULL)
    {
        printf("cannot open %s\n", "materials");
        exit(1);
    }
    fscanf(fp,"%d",&nmate);
    fgets(mystring,160,fp);
	for (i=1; i<=nmate; ++i)
		fscanf(fp,"%lf",&re[i-1]);
    fgets(mystring,160,fp);	
	for (i=1; i<=nmate; ++i)
		fscanf(fp,"%lf",&rhor[i-1]);
    fgets(mystring,160,fp);	
	for (i=1; i<=nmate; ++i)
		fscanf(fp,"%lf",&mur[i-1]);
    fgets(mystring,160,fp);	
	for (i=1; i<=nmate; ++i)
		fscanf(fp,"%lf",&c1bar[i-1]);
    fgets(mystring,160,fp);		
	for (i=1; i<=nmate; ++i)
		fscanf(fp,"%lf",&fr[i-1]);
    fgets(mystring,160,fp);		
    fclose(fp);

/*
	printf("materials: %d\n", nmate);
	for (i=1; i<=nmate; ++i)	
		printf("  re: %e", re[i-1]);
	printf("\n");	
	for (i=1; i<=nmate; ++i)	
		printf("  rhor: %e", rhor[i-1]);
	printf("\n");	
	for (i=1; i<=nmate; ++i)	
		printf("  mur: %e", mur[i-1]);
	printf("\n");	
	for (i=1; i<=nmate; ++i)	
		printf("  c1bar: %e", c1bar[i-1]);
	printf("\n");	
	for (i=1; i<=nmate; ++i)	
		printf("  Fr: %e", fr[i-1]);
	printf("\n");
*/
	

	/* only for restarting the programme */
    if (fp = fopen("time","r"))
    {
        fscanf(fp,"%d",&it);
        fscanf(fp,"%lf",&time_now);
        fclose(fp);
    }

	/* read the coordinates */
    if ((fp = fopen("./input/coor1.txt","r"))==NULL)
    {
        printf("cannot open %s\n","coor1.txt");
		exit(1);
    }
    fscanf(fp,"%d",&n);
    fgets(mystring,160,fp);
    coor1.knode = n;
    knode = n;

	printf("knode:  %d\n", knode);
	
    coor1.dim = dim;
    coor1.coor = (double *) calloc(knode*dim,sizeof(double));
    coor = coor1.coor;
	for (j=1; j<=knode; ++j)
		for (i=1; i<=dim; ++i)
			fscanf(fp,"%lf",&coor[(i-1)*knode+j-1]);
	fclose(fp);
		
    nbdetype = 1;

    mkd = knode*dofe;
    unode = (double *) calloc(mkd,sizeof(double));
    for (m=0; m<mkd; m++) unode[m] = 0.0;
	
    mkd = knode*doff;
    ubff = (double *) calloc(mkd,sizeof(double));
    idf = (int *) calloc(mkd,sizeof(int));
    unodf = (double *) calloc(mkd,sizeof(double));
    for (m=0; m<mkd; m++)
	{
		unodf[m] = 0.0;
		ubff[m] = 0.0;
		idf[m] = 1;		
	}

	/* only for restarting the programme */
    if (fp = fopen("unodf","r"))
    {
        for (j=1; j<=knode; ++j)
        {
            fscanf(fp," %lf",&unodf[0*knode+j-1]);
            fscanf(fp," %lf",&unodf[1*knode+j-1]);
        }
        fclose(fp);
    }

	
	/* read the elements */
	nprmt=5;
	if (dim ==2) nnode=4;
	if (dim ==3) nnode=5;
	
    if ((fp = fopen("./input/elem1.txt","r"))==NULL)
    {
        printf("cannot open %s\n","elem1.txt");
		exit(1);
    }
    fscanf(fp,"%d",&nelem);
    fgets(mystring,160,fp);	
	printf("nelem:  %d\n", nelem);	
	
	elem1.ntype=1;
	elem1.nelem[1]=nelem;
	elem1.nnode[1]=nnode;
	elem1.nmate[1]=nmate;
	elem1.nprmt[1]=nprmt;	
    elem1.node = (int *) calloc(nelem*nnode+1,sizeof(int));	
	elem1.mate = (double *) calloc(nmate*nprmt+1,sizeof(double));

	nn=0;
	for(j=1; j<=nelem; ++j)
		for(i=1; i<=nnode; ++i)
			fscanf(fp,"%d",&elem1.node[++nn]);			
	mm=0;
	for (i=1; i<=nmate; ++i)
	{
		elem1.mate[++mm]=c1bar[i-1];
		elem1.mate[++mm]=re[i-1];
		elem1.mate[++mm]=rhor[i-1];
		elem1.mate[++mm]=mur[i-1];
		elem1.mate[++mm]=fr[i-1];		
	}
	
	fclose(fp);
    return 0;
}




