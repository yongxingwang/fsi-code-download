#include "fsi.h"
int gidmsh(struct coordinates,struct element);
int gidres1(coor0)
struct coordinates coor0;
{
    FILE *fp;
    int i,j,dim,knode,ik;
// double *coor,d;
    int *mlgnode;
    char str[100];
    knode = coor0.knode;
    dim = coor0.dim;
    if (it==0) it=1;
    if ((it%nstep)!=0) goto l100;
    ik = it/nstep;
    if ((fp = fopen("./output/fsi.solid.res","a"))==NULL)
    {
        printf("cannot open %s\n", "fsi.solid.res");
        return  1;
    }

//... writing velocity
    fprintf(fp,"%s%d%s\n","Result \"velocity\" \"Load Analysis\"  ",ik," Vector OnNodes");
    fprintf(fp,"%s\n","ComponentNames \"u\" \"v\" ");
    fprintf(fp,"%s\n","Values");
    for (j=1; j<=knode; ++j)
    {
        fprintf(fp,"%d",j );
        fprintf(fp," %e",unodf[0*knode+j-1]);
        fprintf(fp," %e",unodf[1*knode+j-1]);
        fprintf(fp,"\n");
    }
    fprintf(fp,"%s\n","End Values");

//... writing displacement
    fprintf(fp,"%s%d%s\n","Result \"displacement\" \"Load Analysis\"  ",ik," Vector OnNodes");
    fprintf(fp,"%s\n","ComponentNames \"u\" \"v\" ");
    fprintf(fp,"%s\n","Values");
    for (j=1; j<=knode; ++j)
    {
        fprintf(fp,"%d",j );
        fprintf(fp," %e",unods[0*knode+j-1]);
        fprintf(fp," %e",unods[1*knode+j-1]);
        fprintf(fp,"\n");
    }
    fprintf(fp,"%s\n","End Values");

//... writing stress
    fprintf(fp,"%s%d%s\n","Result \"stress\" \"Load Analysis\"  ",ik," Vector OnNodes");
    fprintf(fp,"%s\n","ComponentNames \"sxx\" \"syy\" \"sxy\" ");
    fprintf(fp,"%s\n","Values");
    for (j=1; j<=knode; ++j)
    {
        fprintf(fp,"%d",j );
        fprintf(fp," %e",unode[0*knode+j-1]);
        fprintf(fp," %e",unode[1*knode+j-1]);
        fprintf(fp," %e",unode[2*knode+j-1]);
        fprintf(fp,"\n");
    }
    fprintf(fp,"%s\n","End Values");

    fclose(fp);
l100:
    return 0;
}
