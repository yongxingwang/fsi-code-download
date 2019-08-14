/*
Adjust the solution vector: include the boundary values into the solution vector
*/

#include "fsi.h"
/* subroutine */
void ufsia(coor0,dof,nodvar,u,f)
int dof,*nodvar;
double *u,*f;
struct coordinates coor0;
{
    /*
     dim£º   dimensions
     knode£º number of all the nodes
     kvar:   number of the total degrees of freedom
     dof£º   degrees of freedom of every node
    *coor£º  coordinates
    *nodvar£ºequation number of all the degrees of freedom, -1 means constraint
    */
    int i,j,n,nrw,kvar;
    int dim,knode;
    double *coor;
    double *vectu;
    dim   = coor0.dim;
    knode = coor0.knode;
    coor  = coor0.coor;
    kvar  = knode*dof;
    vectu = (double *) calloc(kvar,sizeof(double));
    /*  Include the value of boundary condition into the final solution vector */
    for (i=1; i<=dof; ++i)
        for (j=1; j<=knode; ++j)
        {
            vectu[(i-1)*(knode)+j-1] = u[(i-1)*(knode)+j-1];
            n = nodvar[(i-1)*(knode)+j-1];
            if (n>0)
                vectu[(i-1)*(knode)+j-1] = f[n];
        }
//    free(unodc);
    n=0;
    n=n+dof;
//    unodc = (double *) calloc(n*knode,sizeof(double));
    nrw = 0*dof;
    for (j=1; j<=dof; ++j)
        for (i=1; i<=knode; ++i)
            unodc[(nrw+j-1)*knode+i-1] = vectu[(j-1)*(knode)+i-1];
    nrw += dof;
    free(vectu);
    return;
}
