/*
1, Compute equation number of very degree of fredom;
2, Estimate the non-zero elements of the global system matrix, and get the matrix structure: 
   compressed sparse row (CSR) format;
3, Get array *na and *numcol in order to access the global matrix.
*/ 
#include "fsi.h"
void order(int,int *);
int  aclh (int,int *,int *,int,int *,int);
void bclh (int,int *,int *,int *,int *,int *,int);
void startc(coor0,dof,nodvar,elem,matrix,f)
int  dof,*nodvar;
double **f;
struct coordinates coor0;
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
    const int maxtc=200000000;
    int es_count=0;
    int nelem,nnode,neq;
    int *numcol,*na,*mht;
    int i,j,l,n,n0,nn,ne,nne,inod,nodi,numel,idof,maxcol,ityp,inv,maxa,kvar;
    int lm[500],node[500];
    int dim,knode;
    double *coor,memory_appy;
    dim   = coor0.dim;
    knode = coor0.knode;
    coor  = coor0.coor;
    kvar  = knode*dof;
    numel = 0;
    nn = 0;
	
    /*  For minxed element, turn off the degree of freedom: nodvar[]=0  */
    for (ityp=1; ityp<=elem.ntype; ++ityp)
    {
        nelem=elem.nelem[ityp];
        nnode=elem.nnode[ityp];
        nne = nnode-1;
        n0=nne;
        /*  t6 --> t3,   q9 --> q4£»
            w10 --> w4,  c27 --> c8  */
        if (nne == 6)  n0 = 3; 
        if (nne == 9)  n0 = 4;
        if (nne == 10) n0 = 4;
        if (nne == 27) n0 = 8;
        if (n0 != nne)
        {
            for (i=1; i<=nelem; ++i)
            {
                for (j=1; j<=nnode; ++j)
                    node[j] = elem.node[++nn];
                for (inod=n0+1; inod<=nne; ++inod)
                {
                    nodi = node[inod];
                    nodvar[(dof-1)*(knode)+nodi-1] = 0;
                }
            }
        }
    }
    neq=0;
    /*  loop for all the degrees of freedom and get the all equation numbers  */
    for (j=1; j<=knode; ++j)
        for (i=1; i<=dof; ++i)
        {
            if (nodvar[(i-1)*(knode)+j-1] == 1)
                nodvar[(i-1)*(knode)+j-1] = ++neq;
        }
    /*  cope with master-slaver relation of nodes: can be used to enforce periodic boudary condition.  */
    for (j=1; j<=knode; ++j)
        for (i=1; i<=dof; ++i)
        {
            if (nodvar[(i-1)*(knode)+j-1] < -1)
            {
                n = -nodvar[(i-1)*(knode)+j-1]-1;
                nodvar[(i-1)*(knode)+j-1] = nodvar[(i-1)*(knode)+n-1];
            }
        }
    if (neq>0)
    {
        maxcol=maxtc/neq;
    }
    else
    {
        printf("warning! there isn't any unknown variable on nodes!%c",endl);
        maxcol=1;
    }
    na = (int *) calloc(maxtc,sizeof(int));
    if(na == 0)
    {
        free(na);
        printf("Ran out of memory...na in startc()\n");
        exit(0);
    }


    (*matrix).jdiag = (int *) calloc(neq+1,sizeof(int));
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
        nne = nnode-1;
        for (i=1; i<=nelem; ++i)
        {
            for (j=1; j<=nnode; ++j)
                node[j] = elem.node[++nn];


////////////////////////////////////////////////////////////////////
//store the element stiff matrix in ordr to treat constraint
            for (inod=1; inod<=nne; ++inod)
            {
                nodi = node[inod];
                for (idof=1; idof<=dof; ++idof)
                {
                    inv = nodvar[(idof-1)*knode+nodi-1];
                    if(inv<0)
                    {
                        es_count += 1;
                        goto stored;
                    }
                }
            }
stored:
////////////////////////////////////////////////////////////////////////



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

    printf("%s%d\n","number of constraint elmenets:",es_count);
    /*  bclh()£ºordering elements in *mht, stored in na().
                numcol(i)=The first postion (of all the non-zero elments) of very row i */
    bclh(neq,numcol,mht,na,(*matrix).jdiag,lm,maxcol);
    /*  all the matrix information goes to structure *matrix  */
    maxa=numcol[neq];
////////////////////////////////////////////////////////
//    na = (int *) realloc(na,(maxa+1)*sizeof(int));

    (*matrix).na = (int *)   calloc(maxa+1,sizeof(int));
    for (n=0; n<maxa; ++n) (*matrix).na[n+1]   = na[n];
    free(na);

//////////////////////////////////////////////////////////
    (*matrix).maxa = maxa;
    (*matrix).neq = neq;
//    (*matrix).na = --na;
    (*matrix).a = (double *) calloc(maxa+1,sizeof(double));
    if((*matrix).a == 0)
    {
        memory_appy=(maxa+1)*sizeof(double)/1024./1024./1024.;
        printf("%s%f%s\n","Requesting ",memory_appy," Gigabyte");
        printf("Ran out of memory...(*matrix).a in startc() \n");
        exit(0);
    }
//////////////////////////////////////////////////////////////////////
    (*matrix).p = (double *) calloc(maxa+1,sizeof(double));
    if((*matrix).p == 0)
    {
        printf("Ran out of memory...(*matrix).p in startc.c\n");
        exit(0);
    }
    esc = (double *) calloc(es_count*89*89+1,sizeof(double));
    if(esc == 0)
    {
        memory_appy=(es_count*89*89+1)*sizeof(double)/1024./1024./1024.;
        printf("%s%f%s\n","Requesting ",memory_appy," Gigabyte");
        printf("Ran out of memory...esc\n");
        exit(0);
    }
    emc = (double *) calloc(kvar+1,sizeof(double));
    if(emc == 0)
    {
        memory_appy=(kvar+1)*sizeof(double)/1024./1024./1024.;
        printf("%s%f%s\n","Requesting ",memory_appy," Gigabyte");
        printf("Ran out of memory...emc\n");
        exit(0);
    }
/////////////////////////////////////////////////////////////////////
    (*matrix).numcol = numcol;
    (*f) = (double *) calloc(neq+1,sizeof(double));

    return;
}
