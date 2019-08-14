#include "fsi.h"
void ddtv(ddjd,ufluid,usolid,dof)
struct ddmatrice ddjd;
double *ufluid, *usolid;
int dof;
{
    int *jd,nnode,knode,knode1,i,j,k,ii;
    double *dd,d;

    nnode=ddjd.nr;
    knode1=ddjd.nc;
    jd = ddjd.jd;
    dd = ddjd.dd;

    knode=coor0.knode;
//	printf("%d, %d, %d \n",dof,knode1,knode);

    for(j=1; j<=dof; ++j)
        for(i=1; i<=knode1; ++i)
        {
            usolid[(j-1)*knode1+i-1]=0.0;
            for (k=1; k<=nnode; ++k)
            {
                ii=jd[(i-1)*nnode+k-1];
                usolid[(j-1)*knode1+i-1] += dd[(i-1)*nnode+k-1]*
                                            ufluid[(j-1)*knode+ii-1];
            }
        }

    /*
            for(i=1; i<=knode1; ++i)
            {
    			printf("%s,%d\n","node number:",i);
                for (k=1; k<=nnode; ++k)
                {
                    ii=jd[(i-1)*nnode+k-1];
                    d=dd[(i-1)*nnode+k-1];
    				printf("%d,%lf\n",ii,d);
                }
    			exit(0);
    		}
    */

    return;
}

