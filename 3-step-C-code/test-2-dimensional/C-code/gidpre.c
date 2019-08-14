#include "fsi.h"
#include <string.h>
double initial (double *, int);
double bound (double, double *, int);
int idnod (double *, int);
int gidpre(void)
{
    FILE *fp;
    int i,j,knode,nnode,nelem,nmate,nprmt;
    int m,mm,n,nn,mkd;
    double *coor, r[3];
    char mystring[160];
	double re[10],rhor[10],mur[10],c1bar[10],fr[10];
	
	/*  read file time0  */
    if ((fp = fopen("./input/time0","r"))==NULL)
    {
        printf("cannot open %s\n", "time0");
		exit(1);
    }
    fgets(mystring,4,fp);
    if(strcmp(mystring,"\xEF\xBB\xBF")!=0)rewind(fp);
    fscanf(fp,"%lf",&tmax);
    fgets(mystring,160,fp);
    fscanf(fp,"%lf",&dt);
    fgets(mystring,160,fp);
    fscanf(fp,"%d",&nstep);
    fgets(mystring,160,fp);
    fscanf(fp,"%d",&itnmax);
    fgets(mystring,160,fp);
    fscanf(fp,"%lf",&tolerance);
    fgets(mystring,160,fp);
    fscanf(fp,"%lf",&dampalfa);
    fgets(mystring,160,fp);
    fscanf(fp,"%lf",&dampbeta);
    fgets(mystring,160,fp);
    fclose(fp);
    itn=1;
    end=0;
    it=0;
    stop=0;
    time_now=0.0;
	
	/*  read dimensions */
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
 
    exit(1);
*/	

	/* only for restarting the programme */
    if (fp = fopen("time","r"))
    {
        fscanf(fp,"%d",&it);
        fscanf(fp,"%lf",&time_now);
        fclose(fp);
    }


	/* read the coordinates */
    if ((fp = fopen("./input/coor0.txt","r"))==NULL)
    {
        printf("cannot open %s\n","coor0.txt");
		exit(1);
    }
    fscanf(fp,"%d",&n);
    fgets(mystring,160,fp);
    coor0.knode = n;
    knode = n;
	
	printf("knode:  %d\n", knode);
	
    coor0.dim = dim;
    coor0.coor = (double *) calloc(knode*dim,sizeof(double));
    coor = coor0.coor;
	for (j=1; j<=knode; ++j)
		for (i=1; i<=dim; ++i)
			fscanf(fp,"%lf",&coor[(i-1)*knode+j-1]);
	fclose(fp);

    nbdetype = 1;
	
	if(dim == 2)
	{
		dofa = 2;
		dofb = 2;
		dofc = 3;
		dofd = 3;
		dofe = 3;
		doff = 2;
	}
	else
	{
		dofa = 3;
		dofb = 3;
		dofc = 4;
		dofd = 4;
		dofe = 6;
		doff = 3;				
	}
	
    mkd = knode*dofa;
    ubfa = (double *) calloc(mkd,sizeof(double));
    ida = (int *) calloc(mkd,sizeof(int));

    mkd = knode*dofc;
    ubfc = (double *) calloc(mkd,sizeof(double));
    idc = (int *) calloc(mkd,sizeof(int));
    unodc = (double *) calloc(mkd,sizeof(double));
    for (m=0; m<mkd; m++) unodc[m] = 0.0;


    /*  initial velocity for the background fluid */
    /*  boundary velocity at time_now=0.0 for the background fluid */
	/*  idnod (-1, 0, or 1) for the background fluid */
	for (j=1; j<=knode; ++j)
	{
		for (i=1; i<=dim; ++i)	
			r[i-1]=coor[(i-1)*knode+j-1];
		for (i=1; i<=dofc; ++i)
		{
			unodc[(i-1)*knode+j-1]=initial(r,i);
			ubfc[(i-1)*knode+j-1]=bound(time_now,r,i);
			idc[(i-1)*knode+j-1]=idnod(r,i);		
		}
		for (i=1; i<=dofa; ++i)
		{
			ubfa[(i-1)*knode+j-1]=ubfc[(i-1)*knode+j-1];
			ida[(i-1)*knode+j-1]=idc[(i-1)*knode+j-1];	
		}				
	}
	
	
	
	/* only for restarting the programme */
    if (fp = fopen("unodc","r"))
    {
        for (j=1; j<=knode; ++j)
        {
            fscanf(fp," %lf",&unodc[0*knode+j-1]);
            fscanf(fp," %lf",&unodc[1*knode+j-1]);
        }
        fclose(fp);
    }

	
	/* read the elements */
	nprmt=2;
	if (dim ==2) nnode=10;
	if (dim ==3) nnode=28;
	
    if ((fp = fopen("./input/elem0.txt","r"))==NULL)
    {
        printf("cannot open %s\n","elem0.txt");
		exit(1);
    }
    fscanf(fp,"%d",&nelem);
    fgets(mystring,160,fp);	
	printf("nelem:  %d\n", nelem);	
	
	elem0.ntype=1;
	elem0.nelem[1]=nelem;
	elem0.nnode[1]=nnode;
	elem0.nmate[1]=nmate;
	elem0.nprmt[1]=nprmt;	
    elem0.node = (int *) calloc(nelem*nnode+1,sizeof(int));	
	elem0.mate = (double *) calloc(nmate*nprmt+1,sizeof(double));

	nn=0;
	for(j=1; j<=nelem; ++j)
		for(i=1; i<=nnode; ++i)
			fscanf(fp,"%d",&elem0.node[++nn]);	
		
	mm=0;
	for (i=1; i<=nmate; ++i)
	{
		elem0.mate[++mm]=re[i-1];
		elem0.mate[++mm]=fr[i-1];
	}
	
	fclose(fp);
    return 0;
}
