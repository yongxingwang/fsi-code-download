#include<math.h>
static double coor[4],coora[81];

void dshap(f,x,shap,nrefc,nvar,ndord)
double (*f)(),*x,*shap;
int nrefc,nvar,ndord;
{
    extern int sdfdx();
    double dfdx[11];
    int i,n,m;
    for (n=1; n<=nvar; ++n)
    {
        m=sdfdx(f,x,nrefc,dfdx,ndord,n);
        for (i=1; i<=m; ++i)
        {
            shap[(n-1)*(m)+i-1] = dfdx[i];
        }
    }
    return;
}

void dcoef(f,x,cc,dc,nrefc,nvar,ndord)
double (*f)(),*x,*cc,*dc;
int nrefc,nvar,ndord;
{
    extern int sdfdx();
    double dfdx[11];
    int i,n,m;
    for (n=1; n<=nvar; ++n)
    {
        m=sdfdx(f,x,nrefc,dfdx,ndord,n);
        cc[n] = dfdx[1];
        for (i=1; i<=m-1; ++i)
        {
            dc[(n-1)*((m-1))+i-1] = dfdx[i+1];
        }
    }
    return;
}

int sdfdx(f,x,n,dfdx,ndord,iv)
double (*f)(),*x,*dfdx;
int n,ndord,iv;
{
    double y[4],fx[27],h,h2;
    int i,j,k,l,kk,mm,i1,j1,m;
    h = 0.001;
    h2 = h*2;
    m = 0;
    for (i=-1; i<=1; ++i)
    {
        y[3] = x[3]+h*i;
        for (j=-1; j<=1; ++j)
        {
            y[2] = x[2]+h*j;
            for (k=-1; k<=1; ++k)
            {
                y[1] = x[1]+h*k;
                m = m+1;
                if ((n==1) && (i*j != 0)) goto l100;
                if ((n==2) && (i != 0)) goto l100;
                if (ndord==1)
                {
                    kk = k*k+j*j+i*i;
                    if (kk>1) goto l100;
                }
                for (l=1; l<=3; ++l)
                {
                    coor[l]=coora[(l-1)*(27)+m-1];
                }
                fx[m-1] = (*f)(y,iv);
l100:
                continue;
            }
        }
    }
    mm = m/2+1;
    dfdx[1] = fx[mm-1];
    m = n+1;
    for (i=1; i<=n; ++i)
    {
        j = pow(3,i-1);
        dfdx[i+1] = (fx[mm+j-1]-fx[mm-j-1])/h2;
    }
    if (ndord==1) return m;
    for (i=1; i<=n; ++i)
    {
        for (j=i; j<=n; ++j)
        {
            i1 = pow(3,i-1);
            j1 = pow(3,j-1);
            m = m+1;
            if (i==j)
            {
                dfdx[m] = (fx[mm+i1-1]+fx[mm-i1-1]-fx[mm-1]*2)/h/h;
            }
            else
            {
                dfdx[m] = (fx[mm+j1+i1-1]+fx[mm-j1-i1-1]-fx[mm+j1-1-1]-fx[mm-i1-1-1])/h2/h2;
            }
        }
    }
    return m;
}

void dcoor(f,x,cc,dc,nrefc,nvar,ndord)
double (*f)(),*x,*cc,*dc;
int nrefc,nvar,ndord;
{
    extern int sdcdx();
    double dfdx[11];
    int i,n,m;
    for (n=1; n<=nvar; ++n)
    {
        m=sdcdx(f,x,nrefc,dfdx,&coora[(n-1)*(27)+1-1],ndord,n);
        cc[n] = dfdx[1];
        for (i=1; i<=m-1; ++i)
        {
            dc[(n-1)*((m-1))+i-1] = dfdx[i+1];
        }
    }
    return;
}

int sdcdx(f,x,n,dfdx,fx,ndord,iv)
double (*f)(),*x,*dfdx,fx[27];
int n,ndord,iv;
{
    double y[4],h,h2;
    int i,j,k,kk,mm,i1,j1,m;
    h = 0.001;
    h2 = h*2;
    m = 0;
    for (i=-1; i<=1; ++i)
    {
        y[3] = x[3]+h*i;
        for (j=-1; j<=1; ++j)
        {
            y[2] = x[2]+h*j;
            for (k=-1; k<=1; ++k)
            {
                y[1] = x[1]+h*k;
                m = m+1;
                if ((n==1) && (i*j != 0)) goto l100;
                if ((n==2) && (i != 0)) goto l100;
                if (ndord==1)
                {
                    kk = k*k+j*j+i*i;
                    if (kk>1) goto l100;
                }
                fx[m-1] = (*f)(y,iv);
l100:
                continue;
            }
        }
    }
    mm = m/2+1;
    dfdx[1] = fx[mm-1];
    m = n+1;
    for (i=1; i<=n; ++i)
    {
        j = pow(3,i-1);
        dfdx[i+1] = (fx[mm+j-1]-fx[mm-j-1])/h2;
    }
    if (ndord==1) return m;
    for (i=1; i<=n; ++i)
    {
        for (j=i; j<=n; ++j)
        {
            i1 = pow(3,i-1);
            j1 = pow(3,j-1);
            m = m+1;
            if (i==j)
            {
                dfdx[m] = (fx[mm+i1-1]+fx[mm-i1-1]-fx[mm-1]*2)/h/h;
            }
            else
            {
                dfdx[m] = (fx[mm+j1+i1-1]+fx[mm-j1-i1-1]-fx[mm+j1-1-1]-fx[mm-i1-1-1])/h2/h2;
            }
        }
    }
    return m;
}
