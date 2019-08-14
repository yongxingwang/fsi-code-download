/*
1, Compute equation number of very degree of fredom;
2, Estimate the non-zero elements of the global system matrix, and get the matrix structure: 
   compressed sparse row (CSR) format;
3, Get array *na and *numcol in order to access the global matrix.
*/ 
#include "fsi.h"

void startb(coor0,dof,nodvar,elem,matrix,matrix0)
int dof,*nodvar;
struct coordinates coor0;
struct element elem;
struct matrice *matrix,matrix0;
{

    int maxa,neq,n;

    neq=matrix0.neq;
    maxa=matrix0.maxa;

    (*matrix).maxa = maxa;
    (*matrix).neq = neq;
    (*matrix).jdiag=(int *) calloc(neq+1,sizeof(int));
    (*matrix).na = (int *)   calloc(maxa+1,sizeof(int));
    (*matrix).a = (double *) calloc(maxa+1,sizeof(double));
    (*matrix).numcol = (int *)  calloc(neq+1,sizeof(int));
    (*matrix).p = (double *) calloc(maxa+1,sizeof(double));

    for (n=0; n<=neq; ++n) (*matrix).jdiag[n] = matrix0.jdiag[n];
    for (n=0; n<=neq; ++n) (*matrix).numcol[n] = matrix0.numcol[n];
    for (n=0; n<maxa; ++n) (*matrix).na[n+1]   = matrix0.na[n+1];

    /*
    	for(n=1;n<=100;++n)
    		printf("\n%d",matrix0.jdiag[n]);
    	scanf("%d", &n);
    	for(n=1;n<=100;++n)
    		printf("\n%d",matrix0.numcol[n]);
    	scanf("%d", &n);
    	for(n=1;n<=100;++n)
    		printf("\n%d",matrix0.na[n]);
    	scanf("%d", &n);
    */
    return;
}
