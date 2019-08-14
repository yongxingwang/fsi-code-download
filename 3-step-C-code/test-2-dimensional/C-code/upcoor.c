// update the solid nodal cordinates
#include "fsi.h"
void upcoor(coor1,disp,vel,dof)
struct coordinates coor1;
double *disp,*vel;
int dof;
{
    int i,j,knode;
    double *coor,r[4],rr;
    const double x0=0.2,y0=0.2,r0=5.e-2,ep=1.e-4;

    knode = coor1.knode;
    coor=coor1.coor;
///////////////////////////////////////////////
    /*
        for (i=1; i<=knode; i++)
        {
            for (j=1; j<=dim; j++)
                r[j] = coor[(j-1)*knode+i-1];

            rr=sqrt((r[1]-x0)*(r[1]-x0)+(r[2]-y0)*(r[2]-y0));

            if(fabs(rr-r0) < ep)
                for (j=1; j<=dim; j++)
                    vel[(j-1)*knode+i-1]=0.;

        }
    */
////////////////////////////////////////////////
    for (j=1; j<=dof; ++j)
        for (i=1; i<=knode; ++i)
        {
            disp[(j-1)*(knode)+i-1] += vel[(j-1)*knode+i-1]*dt;
            coor[(j-1)*(knode)+i-1] += vel[(j-1)*knode+i-1]*dt;
        }
    return;
}
