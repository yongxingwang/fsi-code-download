#include<math.h>

int smit(k,n,m,r,y,z,nc)
/* k : number of dimension in global space
   n : number of dimension in local space
   m : number of nodes
   r : coordinate values of nodes in global coordinates
   z : new coordinate axes for the global space obtained by schmidt's orthogonalization method
   y : coordinate values of nodes in local coordinates obtained by projecting r into z
   y = z(t)*r i.e. y(j,i) = z(l,j)*r(l,i)  (l=1,k)  (j=1,n & i=1,m) */
int k,n,m,*nc;
double *r,*y,*z;
{
    double r1[4],c,zij;
    int i,j,l,nk,i1;
    if (m<=1)
    {
        return 0;
    }
    for (i=1; i<=k; ++i)
    {
        l=nc[1];
        r1[i]=r[(i-1)*(m)+l-1];
    }
    for (j=1; j<=m; ++j)
    {
        for (i=1; i<=k; ++i)
        {
            r[(i-1)*(m)+j-1]=r[(i-1)*(m)+j-1]-r1[i];
        }
    }
    nk=m-1;
    if (nk>k-1) nk=k-1;
    for (i=1; i<=nk; ++i)
    {
        i1=nc[i+1];
        for (l=1; l<=k; ++l)
        {
            z[(l-1)*(k)+i-1]=r[(l-1)*(m)+i1-1];
        }
        for (j=1; j<=i-1; ++j)
        {
            c=0.0;
            for (l=1; l<=k; ++l)
            {
                c=c+r[(l-1)*(m)+i1-1]*z[(l-1)*(k)+j-1];
            }
            for (l=1; l<=k; ++l)
            {
                z[(l-1)*(k)+i-1]=z[(l-1)*(k)+i-1]-c*z[(l-1)*(k)+j-1];
            }
        }
        c=0.0;
        for (l=1; l<=k; ++l)
        {
            c=c+z[(l-1)*(k)+i-1]*z[(l-1)*(k)+i-1];
        }
        c=sqrt(c);
        for (l=1; l<=k; ++l)
        {
            z[(l-1)*(k)+i-1]=z[(l-1)*(k)+i-1]/c;
        }
    }
    if ((nk==1) && (k==2))
    {
        z[(1-1)*(k)+2-1] = -z[(2-1)*(k)+1-1];
        z[(2-1)*(k)+2-1] = z[(1-1)*(k)+1-1];
        goto l60;
    }
    if ((nk==1) && (k==3))
    {
        if (z[(2-1)*(k)+1-1]*z[(2-1)*(k)+1-1]>0.4)
        {
            z[(1-1)*(k)+2-1] = -z[(2-1)*(k)+1-1];
            z[(2-1)*(k)+2-1] = z[(1-1)*(k)+1-1];
            z[(3-1)*(k)+2-1] = 0.0;
        }
        else
        {
            z[(1-1)*(k)+2-1] = -z[(3-1)*(k)+1-1];
            z[(2-1)*(k)+2-1] = 0.0;
            z[(3-1)*(k)+2-1] = z[(1-1)*(k)+1-1];
        }
        c = 0.0;
        for (i=1; i<=k; ++i)
        {
            c = c+z[(i-1)*(k)+2-1]*z[(i-1)*(k)+2-1];
        }
        c=sqrt(c);
        for (i=1; i<=k; ++i)
        {
            z[(i-1)*(k)+2-1] = z[(i-1)*(k)+2-1]/c;
        }
    }
    z[(1-1)*(k)+3-1] = z[(2-1)*(k)+1-1]*z[(3-1)*(k)+2-1]-z[(3-1)*(k)+1-1]*z[(2-1)*(k)+2-1];
    z[(2-1)*(k)+3-1] = z[(3-1)*(k)+1-1]*z[(1-1)*(k)+2-1]-z[(1-1)*(k)+1-1]*z[(3-1)*(k)+2-1];
    z[(3-1)*(k)+3-1] = z[(1-1)*(k)+1-1]*z[(2-1)*(k)+2-1]-z[(2-1)*(k)+1-1]*z[(1-1)*(k)+2-1];
l60:
    for (i=1; i<=m; ++i)
    {
        for (j=1; j<=n; ++j)
        {
            c=0.0;
            for (l=1; l<=k; ++l)
            {
                c=c+r[(l-1)*(m)+i-1]*z[(l-1)*(k)+j-1];
            }
            y[(j-1)*(m)+i-1]=c;
        }
    }
    for (i=1; i<=k; ++i)
    {
        for (j=1; j<=i-1; ++j)
        {
            zij = z[(i-1)*(k)+j-1];
            z[(i-1)*(k)+j-1] = z[(j-1)*(k)+i-1];
            z[(j-1)*(k)+i-1] = zij;
        }
    }
    return 1;
}

double invm(n,rc,cr)
int n;
double *rc,*cr;
{
    int i,j,k,l,m;
    double a[200],c,q,det,amax;
    m = n*2;
    det = 1.0;
    for (i=1; i<=n; ++i)
    {
        for (j=1; j<=n; ++j)
        {
            a[(i-1)*(20)+j-1] = rc[(i-1)*(n)+j-1];
            a[(i-1)*(20)+n+j-1]=0.0;
            if (i==j) a[(i-1)*(20)+n+i-1] = 1.0;
        }
    }
    for (i=1; i<=n; ++i)
    {
        amax = 0.0;
        l = 0;
        for (j=i; j<=n; ++j)
        {
            c = a[(j-1)*(20)+i-1];
            if (c<0.0) c = -c;
            if (c<=amax) goto l50;
            amax = c;
            l = j;
l50:
            continue;
        }
        for (k=1; k<=m; ++k)
        {
            c = a[(l-1)*(20)+k-1];
            a[(l-1)*(20)+k-1] = a[(i-1)*(20)+k-1];
            a[(i-1)*(20)+k-1] = c;
        }
        c = a[(i-1)*(20)+i-1];
        det = c*det;
        for (k=i+1; k<=m; ++k)
        {
            a[(i-1)*(20)+k-1] = a[(i-1)*(20)+k-1]/c;
        }
        for (j=1; j<=n; ++j)
        {
            if (i==j) goto l300;
            for (k=i+1; k<=m; ++k)
            {
                a[(j-1)*(20)+k-1] = a[(j-1)*(20)+k-1]-a[(i-1)*(20)+k-1]*a[(j-1)*(20)+i-1];
            }
l300:
            continue;
        }
    }
    for (i=1; i<=n; ++i)
    {
        for (j=1; j<=n; ++j)
        {
            cr[(i-1)*(n)+j-1] = a[(i-1)*(20)+n+j-1];
        }
    }
    return fabs(det);
}

double inver_rc(n,n_,rc,cr)
int n,n_;
double *rc,*cr;
{
    int i,j,k,l,m;
    double a[200],c,q,det,amax;
    m = n*2;
    det = 1.0;
    for (i=1; i<=n; ++i)
    {
        for (j=1; j<=n; ++j)
        {
            if (i<=n_) a[(i-1)*(20)+j-1] = rc[(i-1)*(n)+j-1];
            if (i>n_) a[(i-1)*(20)+j-1] = 1.0;
            a[(i-1)*(20)+n+j-1]=0.0;
            if (i==j) a[(i-1)*(20)+n+i-1] = 1.0;
        }
    }
    for (i=1; i<=n; ++i)
    {
        amax = 0.0;
        l = 0;
        for (j=i; j<=n; ++j)
        {
            c = a[(j-1)*(20)+i-1];
            if (c<0.0) c = -c;
            if (c<=amax) goto l50;
            amax = c;
            l = j;
l50:
            continue;
        }
        for (k=1; k<=m; ++k)
        {
            c = a[(l-1)*(20)+k-1];
            a[(l-1)*(20)+k-1] = a[(i-1)*(20)+k-1];
            a[(i-1)*(20)+k-1] = c;
        }
        c = a[(i-1)*(20)+i-1];
        det = c*det;
        for (k=i+1; k<=m; ++k)
        {
            a[(i-1)*(20)+k-1] = a[(i-1)*(20)+k-1]/c;
        }
        for (j=1; j<=n; ++j)
        {
            if (i==j) goto l300;
            for (k=i+1; k<=m; ++k)
            {
                a[(j-1)*(20)+k-1] = a[(j-1)*(20)+k-1]-a[(i-1)*(20)+k-1]*a[(j-1)*(20)+i-1];
            }
l300:
            continue;
        }
    }
    for (i=1; i<=n; ++i)
    {
        for (j=1; j<=n_; ++j)
        {
            cr[(i-1)*(n_)+j-1] = a[(i-1)*(20)+n+j-1];
        }
    }
    return fabs(det);
}

void tkt(nt,na,t,a,tat)
/* compute tat = t(t)*a*t */
int nt,na;
double *t,*a,*tat;
{
    double ta[50],cc,dd;
    int i,j,k,l;
    for (i=1; i<=nt; ++i)
    {
        for (k=1; k<=na; ++k)
        {
            cc = 0.0;
            for (l=1; l<=na; ++l)
            {
                cc = cc+t[(l-1)*(nt)+i-1]*a[(l-1)*(na)+k-1];
            }
            ta[k] = cc;
        }
        for (j=1; j<=nt; ++j)
        {
            dd = 0.0;
            for (k=1; k<=na; ++k)
            {
                dd = dd + ta[k]*t[(k-1)*(nt)+j-1];
            }
            tat[(i-1)*(nt)+j-1] = dd;
        }
    }
    return;
}

void ntkt(nt,na,t,a,tat)
/* compute tat = t(t)*a*t */
int nt,na;
double *t,*a,*tat;
{
    int i,k;
    for (i=1; i<=nt; ++i)
    {
        for (k=1; k<=na; ++k)
        {
            tat[(i-1)*(nt)+k-1] = a[(i-1)*(na)+k-1];
        }
    }
    return;
}

void tmt(nt,na,t,f,tf)
/* cumpute tf = t(t)*f*t */
int nt,na;
double *t,*f,*tf;
{
    int i,j,l;
    double cc;
    for (i=1; i<=nt; ++i)
    {
        tf[i] = 0.0;
        for (j=1; j<=nt; ++j)
        {
            cc = 0.0;
            for (l=1; l<=na; ++l)
            {
                cc = cc+t[(l-1)*(nt)+i-1]*f[l]*t[(l-1)*(nt)+j-1];
            }
            tf[i] = tf[i]+cc;
        }
    }
    return;
}

void ntmt (nt,na,t,f,tf)
/* cumpute tf = f */
int nt,na;
double *t,*f,*tf;
{
    int l;
    for (l=1; l<=na; ++l)
    {
        tf[l] = f[l];
    }
    return;
}

void tl(nt,na,t,f,tf)
/* cumpute tf = t(t)*f */
int nt,na;
double *t,*f,*tf;
{
    int i,l;
    double cc;
    for (i=1; i<=nt; ++i)
    {
        cc = 0.0;
        for (l=1; l<=na; ++l)
        {
            cc = cc+t[(l-1)*(nt)+i-1]*f[l];
        }
        tf[i] = cc;
    }
    return;
}

void ntl(nt,na,t,f,tf)
/* cumpute tf = f */
int nt,na;
double *t,*f,*tf;
{
    int l;
    for (l=1; l<=na; ++l)
    {
        tf[l] = f[l];
    }
    return;
}

void  zlg (nt,t,f)
/* cumpute tf = t(t)*f */
int nt;
double *t,*f;
{
    double tf[4],cc;
    int i,l;
    for (i=1; i<=nt; ++i)
    {
        cc = 0.0;
        for (l=1; l<=nt; ++l)
        {
            cc = cc+t[(l-1)*(nt)+i-1]*f[l];
        }
        tf[i] = cc;
    }
    for (l=1; l<=nt; ++l)
    {
        f[l] = tf[l];
    }
    return;
}

void  zgl (nt,t,f)
/* cumpute tf = t(t)*f */
int nt;
double *t,*f;
{
    double tf[4],cc;
    int i,l;
    for (i=1; i<=nt; ++i)
    {
        cc = 0.0;
        for (l=1; l<=nt; ++l)
        {
            cc = cc+t[(i-1)*(nt)+l-1]*f[l];
        }
        tf[i] = cc;
    }
    for (l=1; l<=nt; ++l)
    {
        f[l] = tf[l];
    }
    return;
}
void  ttt(etr,emtr)
/* etr  l(1), m(1), n(1)
   l(2), m(2), n(2)
   l(3), m(3), n(3)
   x'=etr*x
   ...emtr
   ...1-3,1-6
   l(1)*l(1)  m(1)*m(1)  n(1)*n(1)  2*m(1)*n(1) 2*n(1)*l(1) 2*l(1)*m(1)
   l(2)*l(2)  m(2)*m(2)  n(2)*n(2)  2*m(2)*n(2) 2*n(2)*l(2) 2*l(2)*m(2)
   l(3)*l(3)  m(3)*m(3)  n(3)*n(3)  2*m(3)*n(3) 2*n(3)*l(3) 2*l(3)*m(3)
   ...4-6,1-3
   l(2)*l(3)  m(2)*m(3) n(2)*n(3)
   l(3)*l(1)  m(3)*m(1) n(3)*n(1)
   l(1)*l(2)  m(1)*m(2) n(1)*n(2)
   ...4-6,4-6
   m(2)*n(3)+m(3)*n(2)  n(2)*l(3)+n(3)*l(2) l(2)*m(3)+l(3)*m(2)
   m(3)*n(1)+m(1)*n(3)  n(3)*l(1)+n(1)*l(3) l(3)*m(1)+l(1)*m(3)
   m(1)*n(2)+m(2)*n(1)  n(1)*l(2)+n(2)*l(1) l(1)*m(2)+l(2)*m(1)
   tao'=emtr*tao */
double etr[9],emtr[36];
{
    int i,j;
    for (i=1; i<=3; ++i)
    {
        for (j=1; j<=3; ++j)
        {
            emtr[(j-1)*(6)+i-1]=etr[(j-1)*(3)+i-1]*etr[(j-1)*(3)+i-1];
        }
    }
    for (j=1; j<=3; ++j)
    {
        emtr[(j-1)*(6)+4-1]=2.0*etr[(j-1)*(3)+2-1]*etr[(j-1)*(3)+3-1];
        emtr[(j-1)*(6)+5-1]=2.0*etr[(j-1)*(3)+3-1]*etr[(j-1)*(3)+1-1];
        emtr[(j-1)*(6)+6-1]=2.0*etr[(j-1)*(3)+1-1]*etr[(j-1)*(3)+2-1];
        emtr[(4-1)*(6)+j-1]=etr[(2-1)*(3)+j-1]*etr[(3-1)*(3)+j-1];
        emtr[(5-1)*(6)+j-1]=etr[(3-1)*(3)+j-1]*etr[(1-1)*(3)+j-1];
        emtr[(6-1)*(6)+j-1]=etr[(1-1)*(3)+j-1]*etr[(2-1)*(3)+j-1];
    }

    emtr[(4-1)*(6)+4-1]=etr[(2-1)*(3)+2-1]*etr[(3-1)*(3)+3-1]+etr[(3-1)*(3)+2-1]*etr[(2-1)*(3)+3-1];
    emtr[(4-1)*(6)+5-1]=etr[(2-1)*(3)+3-1]*etr[(3-1)*(3)+1-1]+etr[(3-1)*(3)+3-1]*etr[(2-1)*(3)+1-1];
    emtr[(4-1)*(6)+6-1]=etr[(2-1)*(3)+1-1]*etr[(3-1)*(3)+2-1]+etr[(3-1)*(3)+1-1]*etr[(2-1)*(3)+2-1];
    emtr[(5-1)*(6)+4-1]=etr[(3-1)*(3)+2-1]*etr[(1-1)*(3)+3-1]+etr[(1-1)*(3)+2-1]*etr[(3-1)*(3)+3-1];
    emtr[(5-1)*(6)+5-1]=etr[(3-1)*(3)+3-1]*etr[(1-1)*(3)+1-1]+etr[(1-1)*(3)+3-1]*etr[(3-1)*(3)+1-1];
    emtr[(5-1)*(6)+6-1]=etr[(3-1)*(3)+1-1]*etr[(1-1)*(3)+2-1]+etr[(1-1)*(3)+1-1]*etr[(3-1)*(3)+2-1];
    emtr[(6-1)*(6)+4-1]=etr[(1-1)*(3)+2-1]*etr[(2-1)*(3)+3-1]+etr[(2-1)*(3)+2-1]*etr[(1-1)*(3)+3-1];
    emtr[(6-1)*(6)+5-1]=etr[(1-1)*(3)+3-1]*etr[(2-1)*(3)+1-1]+etr[(2-1)*(3)+3-1]*etr[(1-1)*(3)+1-1];
    emtr[(6-1)*(6)+6-1]=etr[(1-1)*(3)+1-1]*etr[(2-1)*(3)+2-1]+etr[(2-1)*(3)+1-1]*etr[(1-1)*(3)+2-1];

    return;
}

void  gettm(t)
/* t(i,1) (i=1,3) are given */
double t[9];
{
    int i,j,l;
    double s1,s2,s3,s,sk,smin,c,c1,c2,det;
    double inv_t[9];
    s1=0.0;
    smin=1.e010;
    s2=0.0;
    for (i=1; i<=3; ++i)
    {
        s = t[(i-1)*(3)+1-1]*t[(i-1)*(3)+1-1];
        s1 = s1 + s;
        if (s<smin)
        {
            j = i;
            smin = s;
        }
        s2 = s2+t[(i-1)*(3)+2-1]*t[(i-1)*(3)+2-1];
    }
    sk = s2;

    s1 = sqrt(s1);
    for (i=1; i<=3; ++i)
    {
        t[(i-1)*(3)+1-1] = t[(i-1)*(3)+1-1]/s1;
    }
    if (sk<1.e-020)
    {
        for (i=1; i<=3; ++i)
        {
            t[(i-1)*(3)+2-1] = 0.0;
        }
        t[(j-1)*(3)+2-1] = 1.0;
    }

    c1 = 0.0;
    for (i=1; i<=3; ++i)
    {
        c1 = c1+t[(i-1)*(3)+2-1]*t[(i-1)*(3)+1-1];
    }
    for (i=1; i<=3; ++i)
    {
        t[(i-1)*(3)+2-1] = t[(i-1)*(3)+2-1] - c1*t[(i-1)*(3)+1-1];
    }
    s2=0.0;
    for (i=1; i<=3; ++i)
    {
        s2=s2+t[(i-1)*(3)+2-1]*t[(i-1)*(3)+2-1];
    }
    s2 = sqrt(s2);
    for (i=1; i<=3; ++i)
    {
        t[(i-1)*(3)+2-1] = t[(i-1)*(3)+2-1]/s2;
    }

    smin = 1.0e010;
    for (i=1; i<=3; ++i)
    {
        t[(i-1)*(3)+3-1] = 0.0;
        s=t[(i-1)*(3)+1-1]*t[(i-1)*(3)+1-1]+t[(i-1)*(3)+2-1]*t[(i-1)*(3)+2-1];
        if (s<smin)
        {
            smin = s;
            j = i;
        }
    }
    t[(j-1)*(3)+3-1] = 1.0;

    c1 = 0.0;
    c2 = 0.0;
    for (i=1; i<=3; ++i)
    {
        c1 = c1+t[(i-1)*(3)+3-1]*t[(i-1)*(3)+1-1];
        c2 = c2+t[(i-1)*(3)+3-1]*t[(i-1)*(3)+2-1];
    }
    for (i=1; i<=3; ++i)
    {
        t[(i-1)*(3)+3-1] = t[(i-1)*(3)+3-1]-c1*t[(i-1)*(3)+1-1]-c2*t[(i-1)*(3)+2-1];
    }
    s3=0.0;
    for (i=1; i<=3; ++i)
    {
        s3=s3+t[(i-1)*(3)+3-1]*t[(i-1)*(3)+3-1];
    }
    s3 = sqrt(s3);
    for (i=1; i<=3; ++i)
    {
        t[(i-1)*(3)+3-1] = t[(i-1)*(3)+3-1]/s3;
    }

    if (sk<1.e-020)
    {
        for (i=1; i<=3; ++i)
        {
            c = t[(i-1)*(3)+1-1];
            t[(i-1)*(3)+1-1] = t[(i-1)*(3)+3-1];
            t[(i-1)*(3)+3-1] = c;
        }
    }

    det = -1.0;
    det = invm(3,t,inv_t);
    for(i=1; i<=3; i++)
        for(j=1; j<=3; j++)
            t[(i-1)*(3)+j-1]=inv_t[(i-1)*(3)+j-1];
    if (det<0.0)
    {
        for (i=1; i<=3; ++i)
        {
            t[(i-1)*(3)+2-1] = -t[(i-1)*(3)+2-1];
        }
    }
    return;
}
