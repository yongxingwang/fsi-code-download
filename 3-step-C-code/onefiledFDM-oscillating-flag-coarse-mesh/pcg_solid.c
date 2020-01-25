// Use matrix p as a preconditiner for Conjugate Gradient algorithm to solve  matrix * u = f.

#include "fsi.h"
//void iluredu(double*,double*,int*,int*,int*,int);
void illredu(double*,double*,int*,int*,int*,int);
void dtbdx_add_y(double*,double*,int*,double*,int*,int*,int*,double*,double*,double*,
                 int,int,int,int,int);

void pcg_solid(matrix,f,matrix_solid,g,ddjd,nodvar,u0,dof)
double *f, *g, *u0;
struct matrice matrix, matrix_solid;
struct ddmatrice ddjd;
int *nodvar, dof;
{
    int *jdiag,*na,*numcol,neq,n0,n1,naj,iter,loop;
    double tol,rr0,rr1,pp,alpha,beta,err;
    double *a,*p,*u,*x,*w,*r,*d,*q;

    int *nb,*numcb,*jd,knode1,nnode,neqb,knode,ns,i,j,k,ii,jj;
    double *b,*dd,*tg,*g1,*tg1;

    p = matrix.p;
    a = matrix.a;
    na = matrix.na;
    neq = matrix.neq;
    jdiag = matrix.jdiag;
    numcol = matrix.numcol;
    b = matrix_solid.a;
    nb = matrix_solid.na;
    neqb = matrix_solid.neq;
    numcb = matrix_solid.numcol;
    nnode=ddjd.nr;
    knode1=ddjd.nc;
    jd = ddjd.jd;
    dd = ddjd.dd;
    knode=coor0.knode;


//.....compute D^t *g  + f, nfb=knf (all nodes of the solid)
    ns=0;
    for(i=1; i<=knode1; ++i)
        for(j=1; j<=dof; ++j)
        {
            ns += 1;
            for(k=1; k<=nnode; ++k)
            {
                ii=jd[(i-1)*nnode+k-1];
                jj=nodvar[(j-1)*knode+ii-1];
                if(jj > 0) f[jj] += dd[(i-1)*nnode+k-1]*g[ns];
            }
        }


    u = (double *) calloc(neq+1,sizeof(double));
    x = (double *) calloc(neq+1,sizeof(double));
    w = (double *) calloc(neq+1,sizeof(double));
    r = (double *) calloc(neq+1,sizeof(double));
    d = (double *) calloc(neq+1,sizeof(double));
    q = (double *) calloc(neq+1,sizeof(double));

    tg = (double *) calloc(neqb+1,sizeof(double));
    g1 = (double *) calloc(neqb+1,sizeof(double));
    tg1 = (double *) calloc(neqb+1,sizeof(double));




    for (j=1; j<=dof; ++j)
        for (i=1; i<=knode; ++i)
        {
            jj=nodvar[(j-1)*knode+i-1];
            if(jj > 0) x[jj] = u0[(j-1)*knode+i-1];
        }

//---  computing the product a*x = w
    tol=0.0;
    for(i=1; i<=neq; ++i)
    {
        n0 = numcol[i-1]+1;
        n1 = numcol[i];
        w[i] = 0.0;
        for(j=n0; j<=n1; ++j)
        {
            naj = na[j];
            w[i] += a[j]*x[naj];
        }
        tol += f[i]*f[i];
    }
    tol=sqrt(tol)*tolerance;
// ----  computing the product D^t *B * D * x + w	->  w
    dtbdx_add_y(w,x,nodvar,b,nb,numcb,jd,dd,g,tg,
                dof,neqb,nnode,knode1,knode);

    for(i=1; i<=neq; ++i)
    {
        r[i] = w[i]-f[i];
        d[i]=-r[i];
    }

//.....compute p^{-1}*d, p is a preconditioner
//    iluredu(p, d, na, numcol, jdiag, neq);
    illredu(p, d, na, numcol, jdiag, neq);

    rr0 = 0.0;
    for(i=1; i<=neq; ++i)
    {
        q[i] =d[i];
        rr0 -= r[i]*d[i]; //r(i)^t * a^{-1} * r(i)
        u[i] = x[i];
    }

//.....loop
    iter = 1;
    loop=1;
    while (loop)
    {
        for (i=1; i<=neq; ++i)
        {
            n0 = numcol[i-1]+1;
            n1 = numcol[i];
            w[i]=0.0;
            for (j=n0; j<=n1; ++j)
            {
                naj=na[j];
                w[i] +=  a[j]*q[naj];
            }
        }

// ----  computing the product D^t *B * D * q + w	->  w
        dtbdx_add_y(w,q,nodvar,b,nb,numcb,jd,dd,g,tg,
                    dof,neqb,nnode,knode1,knode);
        pp=0.0;
        for(i=1; i<=neq; ++i)
        {
            pp += q[i]*w[i];  //d(i)^t * a * d(i)
        }


//       write(*,*) 'r,======='
//       write(*,*) (r(i),i=1,neq)
//       write(*,*) 'w(i)======='
//       write(*,*) (w(i),i=1,neq)
        alpha = rr0/(pp + 1.0e-40);
        for(i=1; i<=neq; ++i)
        {
            u[i] += alpha*q[i]; //x[i+1] = x[i] + alpha*d[i]
            r[i] += alpha*w[i]; //r[i+1] = r[i] + alpha*a*d[i]
            d[i]=-r[i];
        }
//.....compute p^{-1}*d, p is a preconditione
//        iluredu(p, d, na, numcol, jdiag, neq);
        illredu(p, d, na, numcol, jdiag, neq);

        rr1 = 0.0;
        err=0.0;
        for(i=1; i<=neq; ++i)
        {
            rr1 -= r[i]*d[i]; //r[i+1]^t * a^{-1} * r[i+1]
            err += r[i]*r[i];
        }
        err=sqrt(err);

//        printf("iter,err = %d %e \n", iter,err);
        if(err < tol || err < 1.e-16 || iter > 100000)
        {
            loop=0;
            printf("iluCG: iter, the residue f-a*u = %d %e \n", iter,err);
        }
//.........................reset for loop
        iter += 1;
        beta = rr1/(rr0 + 1.0e-40);

        for(i=1; i<=neq; ++i)
        {
            q[i] = d[i] + beta*q[i];
        }

        rr0 = rr1;
    }

    //store the result in global vector fa
    for (i=1; i<=neq; ++i) f[i]=u[i];

    free(u);
    free(x);
    free(w);
    free(r);
    free(d);
    free(q);
    free(tg);
    free(g1);
    free(tg1);

    return;
}

void dtbdx_add_y(y,x,nodvar,b,nb,numcb,jd,dd,g,tg,
                 dof,neqb,nnode,knode1,knode)
double *y, *x, *b, *dd, *g, *tg;
int *nb,*numcb, *jd, *nodvar, dof, neqb, nnode,knode1,knode;
{
    int ns,i,j,k,ii,jj,n0,n1,nbj;
//----  computing the product D^t *B * D * q + w	->  w
//...D * x = g

    ns=0;
    for(i=1; i<=knode1; ++i)
        for(j=1; j<=dof; ++j)
        {
            ns += 1;
            g[ns]=0.0;
            for(k=1; k<=nnode; ++k)
            {
                ii=jd[(i-1)*nnode+k-1];
                jj=nodvar[(j-1)*knode+ii-1];
                if (jj > 0) g[ns] += dd[(i-1)*nnode+k-1]*x[jj];
            }
        }
//...B * g = tg
    for(i=1; i<=neqb; ++i)
    {
        n0 = numcb[i-1]+1;
        n1 = numcb[i];
        tg[i]=0.0;
        for (j=n0; j<=n1; ++j)
        {
            nbj = nb[j];
            tg[i] += b[j]*g[nbj];
        }
    }

//...D^t * tg + y  ->  y
    ns=0;
    for(i=1; i<=knode1; ++i)
        for(j=1; j<=dof; ++j)
        {
            ns += 1;
            for(k=1; k<=nnode; ++k)
            {
                ii=jd[(i-1)*nnode+k-1];
                jj=nodvar[(j-1)*knode+ii-1];
                if(jj > 0) y[jj] += dd[(i-1)*nnode+k-1]*tg[ns];
            }
        }

    return;
}

