/*
For time-dependent problem
1, update time; time_now and time step it
2, check whether arriving at tmax
3, give the boundary condition and load vector that depend on time
*/
#include "fsi.h"
/* bftbound(): compute dynamic boundary conditions */
void bftbound(struct coordinates,int,int*,double*,double*);
double bound(double,double *,int);

void bft()
{
    /*
    time_now:  current time
    it:        current time step
    end:       non-linear interation
    stop:      the index for tiem loop
    */

    time_now += dt;
    it   += 1;
    end   = 0;
    printf("time_now,it=%f,%d%c",time_now,it,endl);

    if (time_now<tmax)
    {
        stop = 0;
    }
    else
    {
        stop = 1;
    }
	
//    bftbound(coor0,dofa,ida,ubfa,ubfc);

    return;
}


/* compute dynamic boundary conditions */
void bftbound(coor0,dof,nv,bf,bfc)
struct coordinates coor0;
int dof,*nv;
double *bf,*bfc;
{
    int dim,knode,n,i,id;
    double *coor,*r;
    dim   = coor0.dim;
    knode = coor0.knode;
    coor  = coor0.coor;
    r = (double *) calloc(dim,sizeof(double));
    for (n=1; n<=knode; n++)
    {
        for (i=1; i<=dim; i++)
        {
            r[i-1] = coor[(i-1)*(knode)+n-1];
        }
        for (i=1; i<=dof; i++)
        {
            id = nv[(i-1)*knode+n-1];
            if (id<0)
            {
                bf[(i-1)*knode+n-1] = bound(time_now,r,i);
                bfc[(i-1)*knode+n-1] = bf[(i-1)*knode+n-1];
            }
        }
    }
    free(r);
}

