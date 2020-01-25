/*
The Least-squares method to compute stress
There is no start() function for Least-squares method
*/
#include "fsi.h"
void eet3(double *,double *,double *,double *,double *,double *,double *,int);
void efsie(coor0,dof,elem)
int dof;
struct coordinates coor0;
struct element elem;
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
    int i,j,k,l,m,n,kk,ij,nn,mm,nr,nrw,ne,nne,numel,idof,jdof,
        inod,jnod,nodi,nodj,inv,jnv;
    int neq,node[500],*nodvar;
    double *coor,mate[5000],*r,prmt[500],coef[500];
    double emmax,emmin,*emass;
    int dim,knode;
    int init=0;
    double *es,*em,*ec,*ef;
    double *vectw;
    double *varun,*varvn,*varf1,*varf2;
    dim   = coor0.dim;
    knode = coor0.knode;
    coor  = coor0.coor;
    kvar  = knode*dof;
    vectw = (double *) calloc(kvar,sizeof(double));
    varun = (double *) calloc(knode+1,sizeof(double));
    varvn = (double *) calloc(knode+1,sizeof(double));
    varf1 = (double *) calloc(knode+1,sizeof(double));
    varf2 = (double *) calloc(knode+1,sizeof(double));
    nodvar = (int *) calloc(kvar,sizeof(int));
    neq = 0;
    /*  loop to compute equation numbers  */
    for (j=1; j<=knode; ++j)
        for (i=1; i<=dof; ++i)
            nodvar[(i-1)*(knode)+j-1] = ++neq;
    r = (double *) calloc(500,sizeof(double));
    emass = (double *) calloc(kvar+1,sizeof(double));
    for (n=1; n<=neq; ++n)
        emass[n] = 0.0;
    nrw = 0*dof;
    for (i=1; i<=knode; ++i)
        varf1[i] = unodf[nrw*knode+i-1];
    nrw++ ;
    for (i=1; i<=knode; ++i)
        varf2[i] = unodf[nrw*knode+i-1];
    nrw++ ;
    nrw = 0*dof;
    for (i=1; i<=knode; ++i)
        varun[i] = unods[nrw*knode+i-1];
    nrw++ ;
    for (i=1; i<=knode; ++i)
        varvn[i] = unods[nrw*knode+i-1];
    nrw++ ;
    numel = 0;
    nn = 0;
    mm = 0;
    ntype = nbdetype;
    /* compute load vector and mass matrix */
    for (ityp=1; ityp<=ntype; ++ityp)
    {
        /*  get the element connections, and material parameters.  */
        nmate = elem.nmate[ityp];
        nprmt = elem.nprmt[ityp];
        for (i=1; i<=nmate; ++i)
            for (j=1; j<=nprmt; ++j)
                mate[(i-1)*nprmt+j] = elem.mate[++mm];
        nelem = elem.nelem[ityp];
        nnode = elem.nnode[ityp];
        nne = nnode-1;
        for (ne=1; ne<=nelem; ++ne)
        {
            for (j=1; j<=nnode; ++j)
                node[j] = elem.node[++nn];
            /*  Using the first element to determine the size of stiffness and maass mtrices  */
            if (ne==1)
            {
                k=0;
                for (j=1; j<=nne; ++j)
                {
                    jnod = node[j];
                    if (jnod>0)
                        for (l=1; l<=dof; ++l)
                            if (nodvar[(l-1)*(knode)+jnod-1] !=0 )
                                k++;
                }
                kk = k*k;
                es = (double *) calloc(kk,sizeof(double));
                em = (double *) calloc(k+1,sizeof(double));
                ec = (double *) calloc(k+1,sizeof(double));
                ef = (double *) calloc(k+1,sizeof(double));
            }
            /*  Information for a particular element cell  */
            for (j=1; j<=nne; ++j)
            {
                jnod=node[j];
                if (jnod<0) jnod = -jnod;
                prmt[nprmt+j] = jnod;
                i=0;
                coef[j-1+i*nne]=varun[jnod];
                i++;
                coef[j-1+i*nne]=varvn[jnod];
                i++;
                coef[j-1+i*nne]=varf1[jnod];
                i++;
                coef[j-1+i*nne]=varf2[jnod];
                i++;
                for (i=1; i<=dim; ++i)
                    r[(i-1)*(nne)+j-1] = coor[(i-1)*(knode)+jnod-1];
            }
            imate = node[nnode];
            for (j=1; j<=nprmt; ++j)
                prmt[j] = mate[(imate-1)*nprmt+j];
            switch (ityp)
            {
            case 1 :
                eet3(r,coef,prmt,es,em,ec,ef,ne);
                break;
            }
            i=0;
            for (inod=1; inod<=nne; ++inod)
            {
                nodi=node[inod];
                for (idof=1; idof<=dof; ++idof)
                {
                    inv = nodvar[(idof-1)*knode+nodi-1];
                    if (inv==0) goto l600;
                    i++;
                    /* right-hand side vector and mass matrix */
                    if (inv>0)
                    {
                        vectw[(idof-1)*knode+nodi-1] += ef[i];
                        emass[inv] += em[i];
                    }
l600:
                    continue;
                }
            }
            if (ne==nelem)
            {
                free(es);
                free(em);
                free(ec);
                free(ef);
            }
        }
        numel += nelem;
    }
    free(r);
    /*  mass matrix cannot be zero  */
    emmax = 0.0;
    for (i=1; i<=neq; ++i)
        if (emmax<emass[i])
            emmax=emass[i];
    emmin = emmax/1.e008;
    for (i=1; i<=neq; ++i)
        if (fabs(emass[i])<emmin)
            emass[i]=emmin;
    /*  compute maass matrix explictly  */
    for (i=1; i<=dof; ++i)
        for (j=1; j<=knode; ++j)
        {
            ij = nodvar[(i-1)*(knode)+j-1];
            vectw[(i-1)*(knode)+j-1] /= emass[ij];
        }

    if (init == 0) init = 1;
    free(unode);
    n=0;
    n=n+dof;
    unode = (double *) calloc(n*knode,sizeof(double));
    nrw = 0*dof;
    for (j=1; j<=dof; ++j)
        for (i=1; i<=knode; ++i)
            unode[(nrw+j-1)*knode+i-1] = vectw[(j-1)*knode+i-1];
    nrw += dof;
    free(emass);
    free(vectw);
    free(varun);
    free(varvn);
    free(varf1);
    free(varf2);
    free(nodvar);
    return;
}
