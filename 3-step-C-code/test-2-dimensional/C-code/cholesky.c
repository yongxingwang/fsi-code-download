/*
cccccccccccccc choleskey factorizaiton:cccccccccccccccc
c                       u11  u12  u13  u14  u15
c                            u22  u23  u24  u25
c    	     L^t=                 u33  u34  u35
c                                      u44  u45
c                                           u55
ccccccccccccccccccccccccccccccccccccccccccccccccccccccc
*/
#include "fsi.h"

void cholesky(matrix)
struct matrice matrix;
{
    int *jdiag,*na,*numcol,neq,ir,nir1,irdiag,j,jj,ii0,ii1,ijr0,ij,ijr,ii,nii0,jrdiag;
    double *a;

    a = matrix.p;
    na = matrix.na;
    neq = matrix.neq;
    jdiag = matrix.jdiag;
    numcol = matrix.numcol;

    for (ir=1; ir<=neq; ++ir)
    {
        nir1 = numcol[ir];
        irdiag=jdiag[ir-1];
        a[irdiag]=sqrt(a[irdiag]);
        for(j=irdiag+1; j<=nir1; ++j) a[j] /= a[irdiag];

        for(jj = irdiag+1; jj<=nir1; ++jj)
        {
            ii0 = jdiag[na[jj]-1];
            ii1 = numcol[na[jj]];
            ijr0=irdiag+1;
            for(ij=ii0; ij<=ii1; ++ij)
            {
                for(ijr=ijr0; ijr<=nir1; ++ijr)
                {
                    if(na[ijr] == na[ij])
                    {
                        a[ij] -= a[jj]*a[ijr];
                        ijr0=ijr+1;
                        break;
                    }
                }
            }
        }
// inverse the diagonal and copy upper triangle to the lower triangle
        a[irdiag]=1.0/a[irdiag];
        for(ii = irdiag+1; ii<=nir1; ++ii)
        {
            nii0 = numcol[na[ii]-1]+1;
            jrdiag=jdiag[na[ii]-1];
            for(jj=nii0; jj<=jrdiag-1; ++jj)
            {
                if(na[jj] == ir)
                {
                    a[jj]=a[ii];
                    break;
                }
            }
        }

    }

    return;
}
