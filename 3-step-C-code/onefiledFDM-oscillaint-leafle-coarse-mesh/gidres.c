#include "fsi.h"
int gidmsh(struct coordinates,struct element);
int gidres(coor0)
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
    if ((fp = fopen("./output/fsi.fluid.res","a"))==NULL)
    {
        printf("cannot open %s\n", "fsi.fluid.res");
        return  1;
    }

    fprintf(fp,"%s%d%s\n","Result \"velocity\" \"Load Analysis\"  ",ik," Vector OnNodes");
    fprintf(fp,"%s\n","ComponentNames \"u\" \"v\" ");
    fprintf(fp,"%s\n","Values");
    for (j=1; j<=knode; ++j)
    {
        fprintf(fp,"%d",j );
        fprintf(fp," %e",unodc[0*knode+j-1]);
        fprintf(fp," %e",unodc[1*knode+j-1]);
        fprintf(fp,"\n");
    }
    fprintf(fp,"%s\n","End Values");
    fprintf(fp,"%s%d%s\n","Result \"pressure\" \"Load Analysis\"  ",ik," Scalar OnNodes");
    fprintf(fp,"%s\n","ComponentNames \"p\" ");
    fprintf(fp,"%s\n","Values");
    for (j=1; j<=knode; ++j)
    {
        fprintf(fp,"%d",j );
        fprintf(fp," %e",unodc[2*knode+j-1]);
        fprintf(fp,"\n");
    }
    fprintf(fp,"%s\n","End Values");

    fclose(fp);
l100:
    return 0;
}
