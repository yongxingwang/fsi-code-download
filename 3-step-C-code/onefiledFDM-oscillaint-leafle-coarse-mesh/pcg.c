// Use matrix p as a preconditiner for Conjugate Gradient algorithm to solve  matrix * u = f.

#include "fsi.h"
//void iluredu(double*,double*,int*,int*,int*,int);
void illredu(double*,double*,int*,int*,int*,int);

void pcg(matrix,f)
double *f;
struct matrice matrix;
{
    int *jdiag,*na,*numcol,neq,i,j,n0,n1,naj,iter,loop;
    double tol,rr0,rr1,pp,alpha,beta,err;
    double *a,*p,*u,*x,*w,*r,*d,*q;

    p = matrix.p;

    a = matrix.a;
    na = matrix.na;
    neq = matrix.neq;
    jdiag = matrix.jdiag;
    numcol = matrix.numcol;

/*
        for(i=neq-100; i<=neq; ++i)
            printf("\n%d",jdiag[i]);
        scanf("%d", &i);
        for(i=neq-100; i<=neq; ++i)
            printf("\n%d",numcol[i]);
        scanf("%d", &i);
*/

/*
        for(i=neq-100; i<=neq; ++i)
            printf("%e\n",f[i]);
        scanf("%d", &i);
        for(i=1; i<=100; ++i)
            printf("%e\n",a[i]);
        scanf("%d", &i);
*/


    u = (double *) calloc(neq+1,sizeof(double));
    x = (double *) calloc(neq+1,sizeof(double));
    w = (double *) calloc(neq+1,sizeof(double));
    r = (double *) calloc(neq+1,sizeof(double));
    d = (double *) calloc(neq+1,sizeof(double));
    q = (double *) calloc(neq+1,sizeof(double));

    tol=0.0;
    for (i=1; i<=neq; ++i)
    {
        x[i]=0.0; //global variable fa, initial value for iteration.
        tol += f[i]*f[i];
    }
    tol=sqrt(tol)*tolerance;

//---  computing the product a*x = w
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
    }

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

        pp=0.0;
        for(i=1; i<=neq; ++i)
        {
            pp += q[i]*w[i];  //d(i)^t * a * d(i)
        }

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
            printf("iluCG: iter, the residue f-a*u = %d %e\n", iter,err);
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

    return;
}

