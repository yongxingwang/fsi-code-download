/*
1,Loop for all elements, compute element stiffness (ek), mass (em) and damping (ec) matrices, and load vector (ef)
2,Assemble the element mtrices and load vector into the global matrix and global vector respectively
3,Cope with the Drichlet boundary condition
*/
#include "fsi.h"
void deq9g3(double *,double *,double *,double *,double *,double *,double *,int);
/*  adda(): assembly for global matrix  */
void adda(int *,double *,int *,int,int *,double *,int,int);
void efsid(coor0,dof,nodvar,ubf,elem,matrix,f)
int dof,*nodvar;
double *ubf,*f;
struct coordinates coor0;
struct element elem;
struct matrice matrix;
{
    /*
    dof£º       degrees of freedom of every node
    ntype£º     element type
    nnode:      nodes per element + 1(including material number)
    kvar:       number of the total degrees of freedom
    nne£º       nnode-1
    dim£º       dimensions
    knode£º     number of all the nodes
    neq£º       equation number
    maxa£º      maximal non-zero elements of the global matrix
    ubf£º       array storing boundary values
    nmate£º     number of materials
    nprmt£º     parameters of a material
    nelem£º     number of element
    mate[]£º    storing values of materials
    prmt[]:     first nprmt storing parameters of a material, and the last nne storing the global NO. of nodes
    coef[]:     coupling data
    node[]£º    element connections
    lm[]:       lm[i]=global equation number for ith local equation
    *nodvar£º   equation number of all the degrees of freedom, -1 means constraint
    *numcol(i)£ºthe start postion (in all the non-zero elments) of very row i
    *na(n)£º    the column number of the non-zero element n
    *coor£º     coordinates
    *r:         coordinates of one element
    *a£º        global matrix
    *es£º       element stiffness matrix
    *em£º       element mass matrix
    *ec£º       element damping matrix
    *ef£º       element load vector
    */
    int ntype,nnode,kvar;
    int i,j,k,l,m,kk,ij,nn,mm,nr,nrw,ne,nne,numel,idof,jdof,
        inod,jnod,nodi,nodj,inv,jnv;
    int dim,knode,neq,*numcol,maxa,*na,node[500],lm[500];
    double *a,mate[500],prmt[500],coef[500],*u;
    double *coor,*r;
    double *estifn;
    double *es,*em,*ec,*ef;
    dim   = coor0.dim;
    knode = coor0.knode;
    coor  = coor0.coor;
    kvar  = knode*dof;
    a = matrix.a;
    na = matrix.na;
    neq = matrix.neq;
    maxa = matrix.maxa;
    numcol = matrix.numcol;
    for(i=1; i<=maxa; ++i)
    {
        a[i] = 0.0;
    }
    u = (double *) calloc(kvar,sizeof(double));
    r = (double *) calloc(500,sizeof(double));
    for(i=0; i<kvar; ++i)
    {
        u[i]=ubf[i];
    }
    numel = 0;
    nn = 0;
    mm = 0;

    ntype = elem.ntype;
    /*  compute global matrix and cope with boundary condition  */
    for (ityp=1; ityp<=ntype; ++ityp)
    {
        nmate = elem.nmate[ityp];
        nprmt = elem.nprmt[ityp];
	
        /*  material paramters goes to mate[] for a particular type of element */
        for (i=1; i<=nmate; ++i)
            for(j=1; j<=nprmt; ++j)
                mate[(i-1)*nprmt+j] = elem.mate[++mm];
        nelem = elem.nelem[ityp];
        nnode = elem.nnode[ityp];
        nne   = nnode-1;
        for(ne=1; ne<=nelem; ++ne)
        {
            /*  For a particular element cell, node topology goes to node[]  */
            for (j=1; j<=nnode; ++j)
                node[j] = elem.node[++nn];
            /*  Using the first element to determine the size of stiffness and maass mtrices  */
            if  (ne==1)
            {
                k=0;
                for(j=1; j<=nne; ++j)
                {
                    jnod = node[j];
                    if(jnod>0)
                        for(l=1; l<=dof; ++l)
                            if(nodvar[(l-1)*(knode)+jnod-1] !=0 )
                                k++;
                }
                kk = k*k;
                es = (double *) calloc(kk,sizeof(double));
                em = (double *) calloc(k+1,sizeof(double));
                ec = (double *) calloc(k+1,sizeof(double));
                ef = (double *) calloc(k+1,sizeof(double));
                estifn = (double *) calloc(kk+1,sizeof(double));
            }
            /*  Information for a particular element cell  */
            for (j=1; j<=nne; ++j)
            {
                jnod=node[j];
                if(jnod<0)
                    jnod = -jnod;
                prmt[nprmt+j] = jnod;
                for(i=1; i<=dim; ++i)
                    r[(i-1)*(nne)+j-1] = coor[(i-1)*(knode)+jnod-1];
            }
            /*  material parameters for a particular element cell  */
            imate = node[nnode];
            for (j=1; j<=nprmt; ++j)
                prmt[j] = mate[(imate-1)*nprmt+j];
            /*  call the element subroutine, compute element stiffness, mass, damping matrices, and load vector.  */
            switch (ityp)
            {
            case 1 :
                deq9g3(r,coef,prmt,es,em,ec,ef,ne);
                break;
            }
            /*  A ssembling element stiffness, mass, damping matrices.  */
            for (i=1; i<=k; ++i)
                for (j=1; j<=k; ++j)
                    estifn[(i-1)*k+j-1]=0.0;
            for (i=1; i<=k; ++i)
            {
                for (j=1; j<=k; ++j)
                {
                    estifn[(i-1)*k+j-1] += es[(i-1)*k+j-1];
                }
                estifn[(i-1)*k+i-1] += em[i]/dt;			  
            }
            i=0;
            /*  Cope with the boundary conditions */
            for (inod=1; inod<=nne; ++inod)
            {
                nodi = node[inod];
                for (idof=1; idof<=dof; ++idof)
                {
                    inv = nodvar[(idof-1)*knode+nodi-1];
                    if (inv==0)
                        goto l600;
                    /*  i=number of non-zero degrees of freedom  */
                    i++;
                    /*  lm[i]=-1, or equation number  */
                    lm[i] = inv;
                    /*  Assemble the right-hand side of the load vector  */
                    if  (inv>0)
                    {
                        u[(idof-1)*knode+nodi-1] += ef[i];
                    }
                    /*  Cope with the Drichlet boundaries  */
                    j = 0;
                    for (jnod=1; jnod<=nne; ++jnod)
                    {
                        nodj = node[jnod];
                        for(jdof=1; jdof<=dof; ++jdof)
                        {
                            jnv = nodvar[(jdof-1)*knode+nodj-1];
                            if (jnv==0)
                                goto l400;
                            j++;
                            if(jnv>0)
                            {
								/*  Cope with the Drichlet boundaries  */
                                if  (inv<0)
                                    u[(jdof-1)*knode+nodj-1] -= estifn[(i-1)*(k)+j-1]*u[(idof-1)*knode+nodi-1];
                            }
l400:
                            continue;
                        }
                    }
l600:
                    continue;
                }
            }
            /*  Assembling global matrix  */
            adda(na,a,numcol,k,lm,estifn,neq,maxa);
l1000:
            continue;
            if(ne==nelem)
            {
                free(es);
                free(em);
                free(ec);
                free(ef);
                free(estifn);
            }
        }
        numel += nelem;
    }
    free(r);
    /*  get the global right-hand side vector  */
    for (ij=1; ij<=neq; ++ij)
    {
        f[ij] = 0.0;
    }
    for (i=1; i<=dof; ++i)
    {
        for (j=1; j<=knode; ++j)
        {
            ij = nodvar[(i-1)*(knode)+j-1];
            if  (ij>0)
                f[ij] += u[(i-1)*(knode)+j-1];
        }
    }
    free(u);
    return;
}
