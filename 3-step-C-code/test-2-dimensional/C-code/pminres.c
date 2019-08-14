// Use matrix p as a preconditiner for MinRes algorithm to solve  matrix * u = f.

#include "fsi.h"
void illredu(double*,double*,int*,int*,int*,int);

void pminres(matrix,f,u0,nodvar,dof)
double *f, *u0;
struct matrice matrix;
int *nodvar, dof;
{
    int *jdiag,*na,*numcol,neq,i,j,n0,n1,naj,iter,loop,jj,knode;
    double tol_1,tol_2,gam0,gam1,gam2,eta,s0,s1,s2,c0,c1,c2,err,delta,rr0,rr1,rr2,rr3;
    double *a,*p,*u,*v0,*v1,*v2,*w0,*w1,*w2,*z1;

    p = matrix.p;

    a = matrix.a;
    na = matrix.na;
    neq = matrix.neq;
    jdiag = matrix.jdiag;
    numcol = matrix.numcol;

    knode=coor0.knode;

    u = (double *) calloc(neq+1,sizeof(double));
    v0 = (double *) calloc(neq+1,sizeof(double));
    v1 = (double *) calloc(neq+1,sizeof(double));
    v2 = (double *) calloc(neq+1,sizeof(double));
    w0 = (double *) calloc(neq+1,sizeof(double));
    w1 = (double *) calloc(neq+1,sizeof(double));
    w2 = (double *) calloc(neq+1,sizeof(double));
    z1 = (double *) calloc(neq+1,sizeof(double));

    for (j=1; j<=dof; ++j)
        for (i=1; i<=knode; ++i)
        {
            jj=nodvar[(j-1)*knode+i-1];
            if(jj > 0) u[jj] = u0[(j-1)*knode+i-1];
        }

// ----  compute the product a*u
    tol_1=0.0;
    tol_2=0.0;
    for (i=1; i<=neq; ++i)
    {
        n0 = numcol[i-1]+1;
        n1 = numcol[i];
        for (j=n0; j<=n1; ++j)
        {
            naj=na[j];
            v1[i] +=  a[j]*u[naj];
        }
        v1[i] = f[i]-v1[i];  //v1 = f - (A+D^tBD) u
        tol_1 += f[i]*f[i];
        tol_2 += v1[i]*v1[i];
        z1[i]=v1[i];
    }
    tol_1 = sqrt(tol_1)*tolerance;
    tol_2 = sqrt(tol_2)*tolerance;


//.....compute m^{-1}*z1, m is a preconditioner
    illredu(p, z1, na, numcol, jdiag, neq);

    gam1 = 0.0;
    for(i=1; i<=neq; ++i)  gam1+=z1[i]*v1[i];

    gam1=sqrt(gam1);

    gam0=1.0;
    eta=gam1;
    s0=0.0;
    s1=0.0;
    c0=1.0;
    c1=1.0;

//.....loop
    iter = 1;
    loop=1;
    while (loop)
    {
        for(i=1; i<=neq; ++i)
        {
            z1[i]=z1[i]/gam1;
            v2[i]=0.0;
            w2[i]=0.0;
        }

        err = 0.0;
        delta=0.0;
        for (i=1; i<=neq; ++i)
        {
            n0 = numcol[i-1]+1;
            n1 = numcol[i];
            for (j=n0; j<=n1; ++j)
            {
                naj=na[j];
                v2[i] +=  a[j]*z1[naj];
                w2[i] +=  a[j]*u[naj];
            }
            delta += v2[i]*z1[i];
            w2[i] = f[i]-w2[i];  //w2 = f - (A+D^tBD) u
            err += w2[i]*w2[i];
        }
        err = sqrt(err);

        for(i=1; i<=neq; ++i)
        {
            v2[i] -= v1[i]*delta/gam1 + v0[i]*gam1/gam0;
            v0[i] = v2[i];
        }

        illredu(p, v0, na, numcol, jdiag, neq);

        gam2 = 0.0;
        for(i=1; i<=neq; ++i) gam2 += v0[i]*v2[i];
        gam2=sqrt(gam2);

        rr0=c1*delta-c0*s1*gam1;
        rr1=sqrt(rr0*rr0+gam2*gam2);
        rr2=s1*delta+c0*c1*gam1;
        rr3=s0*gam1;
        c2=rr0/rr1;
        s2=gam2/rr1;

        for(i=1; i<=neq; ++i)
        {
            w2[i]=( z1[i] - rr3*w0[i] - rr2*w1[i] ) / rr1;
            u[i] += c2*eta*w2[i];
        }
        eta=-s2*eta;

//        printf("iter,err = %d %e\n", iter,err);
        if(err < tol_1 || err < tol_2 || err < 1.e-16 || iter > 10000)
        {
            loop=0;
            printf("iluMinRes: iter, the residue f-a*u = %d %e \n", iter,err);
        }
//.........................reset for loop
        iter += 1;

        for(i=1; i<=neq; ++i)
        {
            z1[i] = v0[i];
            v0[i] = v1[i];
            v1[i] = v2[i];
            w0[i] = w1[i];
            w1[i] = w2[i];
        }

        gam0 = gam1;
        gam1 = gam2;
        c0=c1;
        c1=c2;
        s0=s1;
        s1=s2;
    }

    //store the result in global vector fc
    for (i=1; i<=neq; ++i) f[i]=u[i];

    free(u);
    free(v0);
    free(v1);
    free(v2);
    free(w0);
    free(w1);
    free(w2);
    free(z1);

    return;
}
