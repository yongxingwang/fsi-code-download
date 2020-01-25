#include "fsi.h"

void restart()
{
    FILE *fp;
    int j,knode,ngaus,nelem;

    fp = fopen("time","w");
    fprintf(fp,"%d\n",it);
    fprintf(fp,"%lf\n",time_now);
    fclose(fp);

    knode=coor0.knode;
    fp = fopen("unodc","w");
    for (j=1; j<=knode; ++j)
    {
        fprintf(fp," %e",unodc[0*knode+j-1]);
        fprintf(fp," %e",unodc[1*knode+j-1]);
//        fprintf(fp," %e",unodc[2*knode+j-1]);
    }
    fclose(fp);

    knode=coor1.knode;
    fp = fopen("unodf","w");
    for (j=1; j<=knode; ++j)
    {
        fprintf(fp," %e",unodf[0*knode+j-1]);
        fprintf(fp," %e",unodf[1*knode+j-1]);
//        fprintf(fp," %e",unodf[2*knode+j-1]);
    }
    fclose(fp);

    fp = fopen("unods","w");
    for (j=1; j<=knode; ++j)
    {
        fprintf(fp," %e",unods[0*knode+j-1]);
        fprintf(fp," %e",unods[1*knode+j-1]);
//        fprintf(fp," %e",unods[2*knode+j-1]);
    }
    fclose(fp);

    ngaus=3;
    nelem=elem1.nelem[1];
    fp = fopen("gstr","w");
    for (j=1; j<=nelem*ngaus*3+1; ++j)
        fprintf(fp," %e",gstr[j]);

    fclose(fp);

    return;
}
