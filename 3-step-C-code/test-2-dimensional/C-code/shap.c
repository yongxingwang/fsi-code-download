#include<math.h>

void shapn(nrefc,ncoor,nvar,shpr,shpc,cr,dord,tolc,tolr)
int nrefc,ncoor,nvar,dord,tolc,tolr;
double *shpr,*shpc,*cr;
{
    int i,j,j1,j2,k,k1,k2,lr,lc;
    double c;
    for (i=1; i<=nvar; ++i)
    {
        lr = 1;
        lc = 1;
        shpc[(i-1)*(tolc)+lc-1] = shpr[(i-1)*(tolr)+lr-1];
        for (j=1; j<=ncoor; ++j)
        {
            c = 0.0;
            for (k=1; k<=nrefc; ++k)
            {
                c = c + shpr[(i-1)*(tolr)+lr+k-1]*cr[(k-1)*(ncoor)+j-1];
            }
            shpc[(i-1)*(tolc)+lc+j-1] = c;
        }
        lc = lc + ncoor;
        lr = lr + nrefc;
        if (dord==1) goto l100;
        for (j1=1; j1<=ncoor; ++j1)
        {
            for (j2=j1; j2<=ncoor; ++j2)
            {
                j = (2*ncoor-j1)*(j1-1)/2+j2;
                c = 0.0;
                for (k1=1; k1<=nrefc; ++k1)
                {
                    for (k2=k1; k2<=nrefc; ++k2)
                    {
                        k = (2*nrefc-k1)*(k1-1)/2+k2;
                        c = c + shpr[(i-1)*(tolr)+lr+k-1]*cr[(k1-1)*(ncoor)+j1-1]*cr[(k2-1)*(ncoor)+j2-1];
                        if (k1<k2) c = c + shpr[(i-1)*(tolr)+lr+k-1]*cr[(k2-1)*(ncoor)+j1-1]*cr[(k1-1)*(ncoor)+j2-1];
                    }
                }
                shpc[(i-1)*(tolc)+lc+j-1] = c;
            }
        }
l100:
        continue;
    }
    return;
}

void shapc(nrefc,ncoor,nvar,shpr,shpc,cr,dord,tolr,tolc)
int nrefc,ncoor,nvar,dord,tolc,tolr;
double *shpr,*shpc,*cr;
{
    int i,j,j1,j2,k,k1,k2,lr,lc;
    double c;
    for (i=1; i<=nvar; ++i)
    {
        lr = 0;
        lc = 0;
        for (j=1; j<=ncoor; ++j)
        {
            c = 0.0;
            for (k=1; k<=nrefc; ++k)
            {
                c = c + shpr[(i-1)*(tolr)+lr+k-1]*cr[(k-1)*(ncoor)+j-1];
            }
            shpc[(i-1)*(tolc)+lc+j-1] = c;
        }
        lc = lc + ncoor;
        lr = lr + nrefc;
        if (dord==1) goto l100;
        for (j1=1; j1<=ncoor; ++j1)
        {
            for (j2=j1; j2<=ncoor; ++j2)
            {
                j = (2*ncoor-j1)*(j1-1)/2+j2;
                c = 0.0;
                for (k1=1; k1<=nrefc; ++k1)
                {
                    for (k2=k1; k2<=nrefc; ++k2)
                    {
                        k = (2*nrefc-k1)*(k1-1)/2+k2;
                        c = c + shpr[(i-1)*(tolr)+lr+k-1]*cr[(k1-1)*(ncoor)+j1-1]*cr[(k2-1)*(ncoor)+j2-1];
                        if (k1<k2) c = c + shpr[(i-1)*(tolr)+lr+k-1]*cr[(k2-1)*(ncoor)+j1-1]*cr[(k1-1)*(ncoor)+j2-1];
                    }
                }
                shpc[(i-1)*(tolc)+lc+j-1] = c;
            }
        }
l100:
        continue;
    }
    return;
}

void  mstress6(kdgof,estr,emstr)
int kdgof;
double *estr,*emstr;
{
    double a1,a2,a3,aa,p,q,ang,pi,dd,etemp;
    a1=estr[1]+estr[2]+estr[3];
    a2=estr[1]*estr[2]+estr[2]*estr[3]+estr[3]*estr[1];
    a2=a2-estr[4]*estr[4]-estr[5]*estr[5]-estr[6]*estr[6];
    a3=estr[1]*estr[2]*estr[3];
    a3=a3+2*estr[4]*estr[5]*estr[6];
    a3=a3-estr[1]*estr[4]*estr[4]-estr[2]*estr[5]*estr[5];
    a3=a3-estr[3]*estr[6]*estr[6];
    emstr[1]=a1;
    emstr[2]=a2;
    emstr[3]=a3;
    pi=4*atan(1.e000);
    p=a2-a1*a1/3;
    q=a1*a2/3.-2.*a1*a1*a1/27.-a3;
    dd=(q*0.5)*(q*0.5)+(p/3.)*(p/3.)*(p/3.);
    if (dd>0)  dd=-dd;
    if (q==0)
    {
        ang=pi/2;
    }
    else
    {
        ang=atan2(2.*sqrt(-dd),-q);
    }
    if (p>0)  p=-p;
    aa=2.*sqrt(-p/3.);
    emstr[4]=aa*cos(ang/3.);
    emstr[5]=aa*cos((2*pi+ang)/3.);
    emstr[6]=aa*cos((2*pi-ang)/3.);
    emstr[4]=emstr[4]+a1/3;
    emstr[5]=emstr[5]+a1/3;
    emstr[6]=emstr[6]+a1/3;
    if (emstr[4]<emstr[5])
    {
        etemp=emstr[4];
        emstr[4]=emstr[5];
        emstr[5]=etemp;
    }
    if (emstr[5]<emstr[6])
    {
        etemp=emstr[5];
        emstr[5]=emstr[6];
        emstr[6]=etemp;
    }
    if (emstr[4]<emstr[5])
    {
        etemp=emstr[4];
        emstr[4]=emstr[5];
        emstr[5]=etemp;
    }
    return;
}
void  mstress3(kdgof,estr,emstr)
int kdgof;
double *estr,*emstr;
{
    double coefb,coefc,etemp;
    coefb=-estr[1]-estr[2];
    coefc=estr[1]*estr[2]-estr[3]*estr[3];
    emstr[2]=((-coefb)+sqrt(coefb*coefb-4*coefc))/2;
    emstr[3]=((-coefb)-sqrt(coefb*coefb-4*coefc))/2;
    if (emstr[2]<emstr[3])
    {
        etemp=emstr[2];
        emstr[2]=emstr[3];
        emstr[3]=etemp;
    }
    return;
}
void  mstress4(kdgof,estr,emstr)
int kdgof;
double *estr,*emstr;
{
    double coefb,coefc,etemp;
    emstr[2]=estr[2];
    coefb=-estr[1]-estr[3];
    coefc=estr[1]*estr[3]-estr[4]*estr[4];
    emstr[3]=((-coefb)+sqrt(coefb*coefb-4*coefc))/2;
    emstr[4]=((-coefb)-sqrt(coefb*coefb-4*coefc))/2;
    if (emstr[2]<emstr[3])
    {
        etemp=emstr[2];
        emstr[2]=emstr[3];
        emstr[3]=etemp;
    }
    if (emstr[3]<emstr[4])
    {
        etemp=emstr[3];
        emstr[3]=emstr[4];
        emstr[4]=etemp;
    }
    if (emstr[2]<emstr[3])
    {
        etemp=emstr[2];
        emstr[2]=emstr[3];
        emstr[3]=etemp;
    }
    return;
}
