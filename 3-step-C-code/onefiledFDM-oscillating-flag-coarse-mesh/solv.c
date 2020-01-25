#include "fsi.h"

void adda(na,a,numcol,nd,lm,estif,neq,maxa)
int *na,*numcol,*lm,nd,neq,maxa;
double *a,*estif;
{
    int i,ii,j,jj,k,n0,n1;
    for (i=1; i<=nd; ++i)
    {
        /*300*/
        ii = lm[i];
        if (ii<0) goto l300;
        n0 = numcol[ii-1]+1;
        n1 = numcol[ii];
        for (j=1; j<=nd; ++j)
        {
            /*280*/
            jj = lm[j];
            if (jj<0) goto l500;
            for (k=n0; k<=n1; ++k)
            {
                if (na[k]==jj)  a[k] = a[k] + estif[(i-1)*nd+j-1];
            }
l500:
            continue;
        } /*280*/
l300:
        continue;
    } /*300*/

    return;
}

void illredu(a, u, na, numcol ,jdiag, neq)
int *na, *numcol, *jdiag, neq;
double *a, *u;
{
    int i,j,n0,n1,idiag;
    for (i=1; i<=neq; ++i)
    {
        n0 = numcol[i-1]+1;
        idiag=jdiag[i-1];
        for(j=n0; j<=idiag-1; ++j) u[i] -= a[j]*u[na[j]];
        u[i] *= a[idiag];
    }
    for (i=1; i<=neq; ++i)
    {
        n1 = numcol[neq-i+1];
        idiag=jdiag[neq-i];
        for(j=idiag+1; j<=n1; ++j) u[neq-i+1] -= a[j]*u[na[j]];
        u[neq-i+1] *= a[idiag];
    }
    return;
}


void iluredu(a, u, na, numcol ,jdiag, neq)
int *na, *numcol, *jdiag, neq;
double *a, *u;
{
    int i,j,n0,n1,idiag;
    for(i=1; i<=neq; ++i)
    {
        n0 = numcol[i-1]+1;
        idiag=jdiag[i-1];
        for(j=n0; j<=idiag-1; ++j) u[i] -= a[j]*u[na[j]];
    }
    for(i=1; i<=neq; ++i)
    {
        n1 = numcol[neq-i+1];
        idiag=jdiag[neq-i];
        for(j=idiag+1; j<=n1; ++j) u[neq-i+1] -= a[j]*u[na[j]];
        u[neq-i+1] *= a[idiag];
    }

    return;
}
