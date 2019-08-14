#include "fsi.h"
int gidmsh1(coor0,elem)
struct coordinates coor0;
struct element elem;
{
    FILE *fp;
    int i,j,n,dim,knode,*nnode,*node,*nelem;
    double *coor,d;
    int *mlgnode;
    char str[100];
    knode = coor0.knode;
    dim = coor0.dim;
    coor = coor0.coor;
    nnode = elem.nnode;
    node = elem.node;
    nelem = elem.nelem;
    n = 0;
    if ((fp = fopen("./output/fsi.solid.msh","w"))==NULL)
    {
        printf("cannot open %s\n", "fsi.solid.msh");
        return  1;
    }
    fprintf(fp,"%s\n","Mesh \"fet3\" Dimension 2 Elemtype Triangle Nnode 3");
    fprintf(fp,"%s\n","Coordinates");
    for (j=1; j<=knode; ++j)
    {
        fprintf(fp,"%d",j);
        for (i=1; i<=dim; ++i)
        {
            fprintf(fp," %e",coor[(i-1)*knode+j-1]);
        }
        fprintf(fp,"\n");
    }
    fprintf(fp,"%s\n","End coordinates");
    fprintf(fp,"%s\n","Elements");
    for (i=1; i<=nelem[1]; ++i)
    {
        fprintf(fp,"%d",i);
        for (j=1; j<=nnode[1]; ++j)
        {
            fprintf(fp," %d",node[++n]);
        }
        fprintf(fp,"\n");
    }
    fprintf(fp,"%s\n","End elements");
    fclose(fp);
    if ((fp = fopen("./output/fsi.solid.res","w"))==NULL)
    {
        ;
        printf("cannot open %s\n", "fsi.solid.res");
        return  1;
    }
    fprintf(fp,"%s\n","GID Post Results File 1.0");
    fclose(fp);
    return 0;
}
