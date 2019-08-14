/*
1, Compute equation number of very degree of fredom;
2, Estimate the non-zero elements of the global system matrix, and get the matrix structure: 
   compressed sparse row (CSR) format;
3, Get array *na and *numcol in order to access the global matrix.
*/ 

#include "fsi.h"
void order(int,int *);
int aclh(int,int *,int *,int,int *,int);
void bclh(int,int *,int *,int *,int *,int *,int);
/* subroutine */
void startf(coor1,dof,nodvar,elem,matrix,f)
int dof,*nodvar;
double **f;
struct coordinates coor1;
struct element elem;
struct matrice *matrix;
{
    /*
    nelem:      number of element
    nnode£º     nodes per element + 1(including material number)
    neq£º       equation number
    maxcol£º    maximal columns of the global matrix
    maxa:       maximal non-zero elements of the global matrix
    kvar:       number of the total degrees of freedom
    dim£º       dimensions
    knode£º     number of all the nodes
    dof£º       degrees of freedom of every node
    ntype£º     element type
    *coor£º     coordinates
    *nodvar£º   equation number of all the degrees of freedom, -1 means constraint
    *numcol(i)£ºthe start postion (in all the non-zero elments) of very row i
    *na(n)£º    the column number of the non-zero element n
    */
    FILE *fp_ptr;
    int nelem,nnode,neq,ngaus;
    int *numcol,*na,*mht;
    int i,j,l,n,nn,ne,nne,inod,nodi,numel,idof,maxcol,ityp,inv,maxa,kvar;
    int dim,knode,lm[500],node[500];
    double *coor,xx,yy,zz,rr;
    const double r0=5.e-2;
    dim   = coor1.dim;
    knode = coor1.knode;
    coor  = coor1.coor;
    kvar  = knode*dof;

/////////////////////////////////////////////////////////////
    /*
            for(j=1; j<=knode; ++j)
    //        {
    //            xx=coor[(1-1)*knode+j-1];
    //            yy=coor[(2-1)*knode+j-1];
    //
    //   	rr=sqrt((xx-0.2)*(xx-0.2)+(yy-0.2)*(yy-0.2));
    //            if(abs(rr-r0) < 1.e-6)
    //			{
                    i=1;
    				coor[(i-1)*knode+j-1] += 0.005;
    //			}
    //		}
    */
    coor1_bak.dim   = dim;
    coor1_bak.knode = knode;
    coor1_bak.coor = (double *) calloc(knode*dim,sizeof(double));
    for(j=1; j<=knode; ++j)
        for(i=1; i<=dim; ++i)
            coor1_bak.coor[(i-1)*knode+j-1] = coor[(i-1)*knode+j-1];

    nelem=elem.nelem[1];
    ngaus=3;
    gstr = (double *) calloc(nelem*ngaus*3+1,sizeof(double));
    unods = (double *) calloc(knode*dim,sizeof(double));


    if (fp_ptr = fopen("gstr","r"))
    {
        for (j=1; j<=nelem*ngaus*3+1; ++j)
            fscanf(fp_ptr," %lf",&gstr[j]);
        fclose(fp_ptr);
    }

    if (fp_ptr = fopen("unods","r"))
    {
        for (j=1; j<=knode; ++j)
        {
            fscanf(fp_ptr," %lf",&unods[0*knode+j-1]);
            fscanf(fp_ptr," %lf",&unods[1*knode+j-1]);
        }
        fclose(fp_ptr);
    }

    for(j=1; j<=knode; ++j)
        for(i=1; i<=dim; ++i)
            coor[(i-1)*knode+j-1] = coor1_bak.coor[(i-1)*knode+j-1]+unods[(i-1)*knode+j-1];
/////////////////////////////////////////////////////////////////////////////////////////////


    neq=0;
    /*  loop for all the degrees of freedom and get the all equation numbers  */
    for (j=1; j<=knode; ++j)
        for (i=1; i<=dof; ++i)
            if (nodvar[(i-1)*(knode)+j-1] == 1)
                nodvar[(i-1)*(knode)+j-1] = ++neq;
    /*  cope with master-slaver relation of nodes: can be used to enforce periodic boudary condition.  */
    for (j=1; j<=knode; ++j)
        for (i=1; i<=dof; ++i)
            if (nodvar[(i-1)*(knode)+j-1] < -1)
            {
                n = -nodvar[(i-1)*(knode)+j-1]-1;
                nodvar[(i-1)*(knode)+j-1] = nodvar[(i-1)*(knode)+n-1];
            }
    if (neq>0)
    {
        maxcol=maxt/neq;
    }
    else
    {
        printf("warning! there isn't any unknown variable on nodes!%c",endl);
        maxcol=1;
    }
    na = (int *) calloc(maxt,sizeof(int));
    (*matrix).jdiag=(int *) calloc(neq+1,sizeof(int));
    mht = na;
    numcol = (int *) calloc(neq+1,sizeof(int));
    for (i=0; i<=neq; ++i)
        numcol[i] = 0;
    numel = 0;
    nn = 0;
    /*  loop for all the elements, and find the position of local elment matrix in the global matrix  */
    for (ityp=1; ityp<=elem.ntype; ++ityp)
    {
        nelem = elem.nelem[ityp];
        nnode = elem.nnode[ityp];
        for (i=1; i<=nelem; ++i)
        {
            for (j=1; j<=nnode; ++j)
                node[j] = elem.node[++nn];
            nne = nnode-1;
            {
                l = 0;
                /*  l is the total number of equations in the current element */
				/*	lm[i]=global equation number for ith local equation  */
                for (inod=1; inod<=nne; ++inod)
                {
                    nodi = node[inod];
                    for (idof=1; idof<=dof; ++idof)
                    {
                        inv = nodvar[(idof-1)*(knode)+nodi-1];
                        if (inv>0)
                        {
                            l++;
                            lm[l] = inv;
                        }
                    }
                }
                numel++;
                /*  aclh()£ºget the position of the non-zero elements in the global matrix(*mht);
                            get the number of non-zero elments in every row (*numcol)  */
                if (l>0)
                    aclh(neq,numcol,mht,l,lm,maxcol);
            }
        }
    }
    /*  bclh()£ºordering elements in *mht, stored in na().
                numcol(i)=The first postion (of all the non-zero elments) of very row i */
    bclh(neq,numcol,mht,na,(*matrix).jdiag,lm,maxcol);
    /*  all the matrix information goes to structure *matrix  */
    maxa=numcol[neq];
    (*matrix).maxa = maxa;
    (*matrix).neq = neq;
    (*matrix).na = (int *)   calloc(maxa+1,sizeof(int));
    (*matrix).a = (double *) calloc(maxa+1,sizeof(double));
    (*matrix).numcol = (int *)  calloc(neq+1,sizeof(int));
    (*f) = (double *) calloc(neq+1,sizeof(double));
    for (n=0; n<=neq; ++n) (*matrix).numcol[n] = numcol[n];
    for (n=0; n<maxa; ++n) (*matrix).na[n+1]   = na[n];
    free(numcol);
    free(na);
    return;
}
