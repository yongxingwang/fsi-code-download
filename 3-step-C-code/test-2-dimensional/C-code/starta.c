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
void starta(coor0,dof,nodvar,elem,matrix,f)
int dof,*nodvar;
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
    FILE *fp;
    const int maxta=200000000;
    int es_count=0;
    int nelem,nnode,neq;
    int *numcol,*na,*mht;
    int i,j,l,n,nn,mm,ne,nne,inod,nodi,numel,idof,maxcol,ityp,inv,maxa,kvar;
    int dim,knode,lm[500],node[500];
    double *coor,x,y,z,x0,y0,z0,x1,y1,z1,memory_appy;
    dim   = coor0.dim;
    knode = coor0.knode;
    coor  = coor0.coor;
    kvar  = knode*dof;
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
        maxcol=maxta/neq;
    }
    else
    {
        printf("warning! there isn't any unknown variable on nodes!%c",endl);
        maxcol=1;
    }

    na = (int *) calloc(maxta,sizeof(int));
    if(na == 0)
    {
        free(na);
        printf("Ran out of memory...na in starta()\n");
        exit(0);
    }


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

    printf("%s%d\n","number of constraint elmenets:",es_count);
    /*  bclh()£ºordering elements in *mht, stored in na().
                numcol(i)=The first postion (of all the non-zero elments) of very row i */
    bclh(neq,numcol,mht,na,(*matrix).jdiag,lm,maxcol);
    /*  all the matrix information goes to structure *matrix  */
    /*
        for(n=0; n<=100; ++n)
            printf("\n%d",numcol[n]);
        scanf("%d", &n);
    */
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
    (*matrix).numcol =numcol;

    (*f) = (double *) calloc(neq+1,sizeof(double));
    (*matrix).a = (double *) calloc(maxa+1,sizeof(double));
    if((*matrix).a == 0)
    {
        memory_appy=(maxa+1)*sizeof(double)/1024./1024./1024.;
        printf("%s%f%s\n","Requesting ",memory_appy," Gigabyte");
        printf("Ran out of memory...(*matrix).a in starta()\n");
        exit(0);
    }
//////////////////////////////////////////////////////////////////////
    (*matrix).p = (double *) calloc(maxa+1,sizeof(double));
    if((*matrix).p == 0)
    {
        free(matrix -> p);
        printf("Ran out of memory...(*matrix).p in starta.c\n");
        exit(0);
    }
    esa = (double *) calloc(es_count*81*81+1,sizeof(double));
    if(esa == 0)
    {
        memory_appy=(es_count*81*81+1)*sizeof(double)/1024./1024./1024.;
        printf("%s%f%s\n","Requesting ",memory_appy," Gigabyte");
        printf("Ran out of memory...esa\n");
        exit(0);
    }
    esb = (double *) calloc(es_count*81*81+1,sizeof(double));
    if(esb == 0)
    {
        memory_appy=(es_count*81*81+1)*sizeof(double)/1024./1024./1024.;
        printf("%s%f%s\n","Requesting ",memory_appy," Gigabyte");
        printf("Ran out of memory...esb\n");
        exit(0);
    }
    ema = (double *) calloc(kvar+1,sizeof(double));
    if(ema == 0)
    {
        memory_appy=(kvar+1)*sizeof(double)/1024./1024./1024.;
        printf("%s%f%s\n","Requesting ",memory_appy," Gigabyte");
        printf("Ran out of memory...ema\n");
        exit(0);
    }
////////////////////////////////////////////////////////
    /*
        x0=0.5;
        x1=2.5;
        y0=0.07;
        y1=0.43;
    //    z0=-0.1;
        z1=0.84;

        nelem = elema.nelem[1];
        nnode = elema.nnode[1];
        nne   = nnode-1;

        node_jd = (int *) calloc(nelem*nnode+1,sizeof(int));
        if(node_jd == 0)
        {
            memory_appy=(nelem*nnode+1)*sizeof(double)/1024./1024./1024.;
            printf("%s%f%s\n","Requesting ",memory_appy," Gigabyte");
            printf("Ran out of memory...node_jd\n");
            exit(0);
        }


        nelm_jd=0;
        nn = 0;
        mm = 0;
        for (i=1; i<=nelem; ++i)
        {
            for (j=1; j<=nnode; ++j)
                node[j] = elem.node[++nn];
            for (inod=1; inod<=nne; ++inod)
            {
                nodi = node[inod];
                x=coor[0*knode+nodi-1];
                y=coor[1*knode+nodi-1];
                z=coor[2*knode+nodi-1];

                if (x>x0 && x<x1 && y>y0 && y<y1 && z<z1)
                {
                    nelm_jd++;
                    for (j=1; j<=nnode; ++j)
                        node_jd[++mm] = node[j];
                    break;
                }
            }
        }

        node_jd = (int *) realloc(node_jd,(nelm_jd*nnode+1)*sizeof(int));

        printf("%s%d,%d\n","nelem and nelm_jd:",nelem,nelm_jd);
    */
//////////////////////////////////////////////////////
    return;
}
