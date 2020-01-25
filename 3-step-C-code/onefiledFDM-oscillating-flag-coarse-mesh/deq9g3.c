#include "fsi.h"
double nx,ny,nz;
int nnode,ngaus,ndisp,nrefc,ncoor,nvar;
double vol,det,weigh,stif,fact,shear,r0;
int nvard[4],kdord[4],kvord[66];
double refc[18],gaus[10];
/* .... nnode ---- the number of nodes
   .... ngaus ---- the number of numerical integral points
   .... ndisp ---- the number of unknown functions
   .... nrefc ---- the number of reference coordinates
   .... nvar ---- the number of unknown varibles var
   .... refc ---- reference coordinates at integral points
   .... gaus ---- weight number at integral points
   .... nvard ---- the number of var for each unknown
   .... kdord ---- the highest differential order for each unknown
   .... kvord ---- var number at integral points for each unknown */
double coor[3];
double coorr[18];
double rctr[4],crtr[4];
/*   .... rctr ---- jacobi's matrix
     .... crtr ---- inverse matrix of jacobi's matrix */
void dshap(double (*shap)(double *,int),
           double *,double *,int,int,int);
void dcoor(double (*shap)(double *,int),
           double *,double *,double *,int,int,int);
double invm(int,double *,double *);
double inver_rc(int,int,double *,double *);
void dcoef(double (*shap)(double *,int),
           double *,double *, double *,int,int,int);
static void initial();
static void tran_coor(double *,double *,double *,double *);
static double ftran_coor(double *,int);
static void shap_u(double *,double *);
static double fshap_u(double *,int);
static void shap_v(double *,double *);
static double fshap_v(double *,int);
static void shap_p(double *,double *);
static double fshap_p(double *,int);
void shapn(int,int,int,double *,double *,double *,int,int,int);
void shapc(int,int,int,double *,double *,double *,int,int,int);
/* subroutine */
void deq9g3(coora,coefa,prmt,estif,emass,edamp,eload,num)
double coora[18],*coefa,*prmt,estif[484],*emass,*edamp,*eload;
int num;
/* .... coora ---- nodal coordinate value
   .... coefa ---- nodal coef value
   .... estif ---- element stiffness
   .... emass ---- element mass matrix
   .... edamp ---- element damping matrix
   .... eload ---- element load vector
   .... num   ---- element no. */
{
    double refcoor[4]= {0.0,0.0,0.0,0.0};
    double x,y,rx,ry;
    double elump[23];
    static double ru[243],rv[243],rp[108],cu[27],cv[27],cp[12];
    /* .... store shape functions and their partial derivatives
         .... for all integral points */
    int i,j,igaus;
    int ig_u,ig_v,ig_p,iv,jv;
    double re,fr;
    re=prmt[1];
    fr=prmt[2];
// .... initialize the basic data
    if (num==1) initial();
    for (i=1; i<=2; ++i)
        for (j=1; j<=9; ++j)
            coorr[(i-1)*(9)+j-1]=coora[(i-1)*(9)+j-1];
    for (i=1; i<=22; ++i)
    {
        emass[i]=0.0;
        elump[i]=0.0;
        eload[i]=0.0;
        for (j=1; j<=22; ++j)
        {
            estif[(i-1)*(22)+j-1]=0.0;
        }
    }
    for (igaus=1; igaus<=ngaus; ++igaus)
    {
        for (i=1; i<=nrefc; ++i) refcoor[i]=refc[(i-1)*(9)+igaus-1];
        tran_coor(refcoor,coor,coorr,rctr);
// .... coordinate caculation by reference coordinates
// det = invm(ncoor,rctr,crtr);
        det = inver_rc(nrefc,ncoor,rctr,crtr);
        /* .... coordinate transfer from reference to original system
           .... rctr ---- jacobi's matrix
           .... crtr ---- inverse matrix of jacobi's matrix */
        x=coor[1];
        y=coor[2];
        rx=refcoor[1];
        ry=refcoor[2];
        ig_u=(igaus-1)*9*3;
        ig_v=(igaus-1)*9*3;
        ig_p=(igaus-1)*4*3;
        if (num>1) goto l2;
// .... the following is the shape function caculation
        shap_u(refcoor,&ru[ig_u]);
        shap_v(refcoor,&rv[ig_v]);
        shap_p(refcoor,&rp[ig_p]);
l2:
        /* .... the following is the shape function transformation
          .... from reference coordinates to original coordinates */
        shapn(nrefc,ncoor,9,&ru[ig_u],cu,crtr,1,3,3);
        shapn(nrefc,ncoor,9,&rv[ig_v],cv,crtr,1,3,3);
        shapn(nrefc,ncoor,4,&rp[ig_p],cp,crtr,1,3,3);
        weigh=det*gaus[igaus];
// .... the following is the stiffness computation
        for (i=1; i<=4; ++i)
        {
            iv=kvord[(i-1)*(3)+3-1];
            for (j=1; j<=4; ++j)
            {
                jv=kvord[(j-1)*(3)+3-1];
                stif=+cp[(i-1)*(3)+2-1]*cp[(j-1)*(3)+2-1]
                     +cp[(i-1)*(3)+3-1]*cp[(j-1)*(3)+3-1] ;
                estif[(iv-1)*(22)+jv-1]+=stif*weigh;
            }
        }
// .... the following is the mass matrix computation
        stif=1.0;
        elump[1]=stif*weigh;
        stif=1.0;
        elump[4]=stif*weigh;
        stif=1.0;
        elump[7]=stif*weigh;
        stif=1.0;
        elump[10]=stif*weigh;
        stif=1.0;
        elump[13]=stif*weigh;
        stif=1.0;
        elump[15]=stif*weigh;
        stif=1.0;
        elump[17]=stif*weigh;
        stif=1.0;
        elump[19]=stif*weigh;
        stif=1.0;
        elump[21]=stif*weigh;
        stif=1.0;
        elump[2]=stif*weigh;
        stif=1.0;
        elump[5]=stif*weigh;
        stif=1.0;
        elump[8]=stif*weigh;
        stif=1.0;
        elump[11]=stif*weigh;
        stif=1.0;
        elump[14]=stif*weigh;
        stif=1.0;
        elump[16]=stif*weigh;
        stif=1.0;
        elump[18]=stif*weigh;
        stif=1.0;
        elump[20]=stif*weigh;
        stif=1.0;
        elump[22]=stif*weigh;
        for (i=1; i<=nvard[1]; ++i)
        {
            iv = kvord[(i-1)*(3)+1-1];
            emass[iv]+=elump[iv]*cu[(i-1)*(3)+1-1];
        }
        for (i=1; i<=nvard[2]; ++i)
        {
            iv = kvord[(i-1)*(3)+2-1];
            emass[iv]+=elump[iv]*cv[(i-1)*(3)+1-1];
        }
        for (i=1; i<=nvard[3]; ++i)
        {
            iv = kvord[(i-1)*(3)+3-1];
            emass[iv]+=elump[iv]*cp[(i-1)*(3)+1-1];
        }
// .... the following is the load vector computation
        for (i=1; i<=9; ++i)
        {
            iv=kvord[(i-1)*(3)+2-1];
            stif=-cv[(i-1)*(3)+1-1]*0.0;
            eload[iv]+=stif*weigh;
        }
    }
l999:
    return;
}

static void initial()
{
// .... initial data
// .... refc ---- reference coordinates at integral points
// .... gaus ---- weight number at integral points
// .... nvard ---- the number of var for each unknown
// .... kdord ---- the highest differential order for each unknown
// .... kvord ---- var number at integral points for each unknown
    ngaus=  9;
    ndisp=  3;
    nrefc=  2;
    ncoor=  2;
    nvar = 22;
    nnode=  9;
    kdord[1]=1;
    nvard[1]=9;
    kvord[(1-1)*(3)+1-1]=1;
    kvord[(2-1)*(3)+1-1]=13;
    kvord[(3-1)*(3)+1-1]=4;
    kvord[(4-1)*(3)+1-1]=19;
    kvord[(5-1)*(3)+1-1]=21;
    kvord[(6-1)*(3)+1-1]=15;
    kvord[(7-1)*(3)+1-1]=10;
    kvord[(8-1)*(3)+1-1]=17;
    kvord[(9-1)*(3)+1-1]=7;
    kdord[2]=1;
    nvard[2]=9;
    kvord[(1-1)*(3)+2-1]=2;
    kvord[(2-1)*(3)+2-1]=14;
    kvord[(3-1)*(3)+2-1]=5;
    kvord[(4-1)*(3)+2-1]=20;
    kvord[(5-1)*(3)+2-1]=22;
    kvord[(6-1)*(3)+2-1]=16;
    kvord[(7-1)*(3)+2-1]=11;
    kvord[(8-1)*(3)+2-1]=18;
    kvord[(9-1)*(3)+2-1]=8;
    kdord[3]=1;
    nvard[3]=4;
    kvord[(1-1)*(3)+3-1]=3;
    kvord[(2-1)*(3)+3-1]=6;
    kvord[(3-1)*(3)+3-1]=9;
    kvord[(4-1)*(3)+3-1]=12;
    refc[(1-1)*(9)+1-1]=7.745966692e-001;
    refc[(2-1)*(9)+1-1]=7.745966692e-001;
    gaus[1]=3.086419753e-001;
    refc[(1-1)*(9)+2-1]=7.745966692e-001;
    refc[(2-1)*(9)+2-1]=0.000000000e+000;
    gaus[2]=4.938271605e-001;
    refc[(1-1)*(9)+3-1]=7.745966692e-001;
    refc[(2-1)*(9)+3-1]=-7.745966692e-001;
    gaus[3]=3.086419753e-001;
    refc[(1-1)*(9)+4-1]=0.000000000e+000;
    refc[(2-1)*(9)+4-1]=7.745966692e-001;
    gaus[4]=4.938271605e-001;
    refc[(1-1)*(9)+5-1]=0.000000000e+000;
    refc[(2-1)*(9)+5-1]=0.000000000e+000;
    gaus[5]=7.901234568e-001;
    refc[(1-1)*(9)+6-1]=0.000000000e+000;
    refc[(2-1)*(9)+6-1]=-7.745966692e-001;
    gaus[6]=4.938271605e-001;
    refc[(1-1)*(9)+7-1]=-7.745966692e-001;
    refc[(2-1)*(9)+7-1]=7.745966692e-001;
    gaus[7]=3.086419753e-001;
    refc[(1-1)*(9)+8-1]=-7.745966692e-001;
    refc[(2-1)*(9)+8-1]=0.000000000e+000;
    gaus[8]=4.938271605e-001;
    refc[(1-1)*(9)+9-1]=-7.745966692e-001;
    refc[(2-1)*(9)+9-1]=-7.745966692e-001;
    gaus[9]=3.086419753e-001;
    return;
}


// void dshap(double (*shap)(double *,double *,int),double *,^shpr[][9],int,int,int);
static void shap_u(refc,shpr)
double *refc,shpr[27];
/* compute shape functions and their partial derivatives
 shapr ---- store shape functions and their partial derivatives */
{
    double (*shap)(double *,int)=&fshap_u;
// extern void dshap(shap,double *,double *,int,int,int);
    dshap(shap,refc,shpr,2,9,1);
    /* shape function and their derivatives computation
     compute partial derivatives by centered difference
     which is in the file cshap.c of felac library */
    return;
}

static double fshap_u(double *refc,int n)
// shape function caculation
{
// extern double *coor;
    double rx,ry;
    double x,y,fval;
    x=coor[1];
    y=coor[2];
    rx=refc[1];
    ry=refc[2];
    switch (n)
    {
    case 1:
        fval=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.;
        break;
    case 2:
        fval=+(+1.-rx*rx)*ry*(+ry-1.)/2.;
        break;
    case 3:
        fval=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.;
        break;
    case 4:
        fval=+rx*(+rx-1.)/2.*(+1.-ry*ry);
        break;
    case 5:
        fval=+(+1.-rx*rx)*(+1.-ry*ry);
        break;
    case 6:
        fval=+rx*(+1.+rx)/2.*(+1.-ry*ry);
        break;
    case 7:
        fval=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.;
        break;
    case 8:
        fval=+(+1.-rx*rx)*ry*(+1.+ry)/2.;
        break;
    case 9:
        fval=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.;
        break;
//   default:
    }
    return fval;
}
static void shap_v(refc,shpr)
double *refc,shpr[27];
/* compute shape functions and their partial derivatives
 shapr ---- store shape functions and their partial derivatives */
{
    double (*shap)(double *,int)=&fshap_v;
// extern void dshap(shap,double *,double *,int,int,int);
    dshap(shap,refc,shpr,2,9,1);
    /* shape function and their derivatives computation
     compute partial derivatives by centered difference
     which is in the file cshap.c of felac library */
    return;
}

static double fshap_v(double *refc,int n)
// shape function caculation
{
// extern double *coor;
    double rx,ry;
    double x,y,fval;
    x=coor[1];
    y=coor[2];
    rx=refc[1];
    ry=refc[2];
    switch (n)
    {
    case 1:
        fval=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.;
        break;
    case 2:
        fval=+(+1.-rx*rx)*ry*(+ry-1.)/2.;
        break;
    case 3:
        fval=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.;
        break;
    case 4:
        fval=+rx*(+rx-1.)/2.*(+1.-ry*ry);
        break;
    case 5:
        fval=+(+1.-rx*rx)*(+1.-ry*ry);
        break;
    case 6:
        fval=+rx*(+1.+rx)/2.*(+1.-ry*ry);
        break;
    case 7:
        fval=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.;
        break;
    case 8:
        fval=+(+1.-rx*rx)*ry*(+1.+ry)/2.;
        break;
    case 9:
        fval=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.;
        break;
//   default:
    }
    return fval;
}
static void shap_p(refc,shpr)
double *refc,shpr[27];
/* compute shape functions and their partial derivatives
 shapr ---- store shape functions and their partial derivatives */
{
    double (*shap)(double *,int)=&fshap_p;
// extern void dshap(shap,double *,double *,int,int,int);
    dshap(shap,refc,shpr,2,4,1);
    /* shape function and their derivatives computation
     compute partial derivatives by centered difference
     which is in the file cshap.c of felac library */
    return;
}

static double fshap_p(double *refc,int n)
// shape function caculation
{
// extern double *coor;
    double rx,ry;
    double x,y,fval;
    x=coor[1];
    y=coor[2];
    rx=refc[1];
    ry=refc[2];
    switch (n)
    {
    case 1:
        fval=+(+1.-rx)/2.*(+1.-ry)/2.;
        break;
    case 2:
        fval=+(+1.+rx)/2.*(+1.-ry)/2.;
        break;
    case 3:
        fval=+(+1.+rx)/2.*(+1.+ry)/2.;
        break;
    case 4:
        fval=+(+1.-rx)/2.*(+1.+ry)/2.;
        break;
//   default:
    }
    return fval;
}
static void tran_coor(double *refc,double *coor,double *coorr,double *rc)
/* compute coordinate value and jacobi's matrix rc
 by reference coordinate value */
{
    double (*shap)(double *,int)=&ftran_coor;
// extern void dcoor(shap,double *,double *,double *,
//  int,int,int);
    dcoor(shap,refc,coor,rc,2,2,1);
    /* coordinate value and their partial derivatives caculation
     compute partial derivatives by centered difference
     which is in the file cshap.c of felac library */
    return;
}

static double ftran_coor(double *refc,int n)
/* coordinate transfer function caculation */
{
    double rx,ry,fval;
    double x[10],y[10];
    int j;
    for (j=1; j<=9; ++j)
    {
        x[j]=coorr[(1-1)*(9)+j-1];
        y[j]=coorr[(2-1)*(9)+j-1];
    }
    rx=refc[1];
    ry=refc[2];
    switch (n)
    {
    case 1:
        fval=
            +(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*x[1]
            +(+(+1.-rx*rx)*ry*(+ry-1.)/2.)*x[5]
            +(+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.)*x[2]
            +(+rx*(+rx-1.)/2.*(+1.-ry*ry))*x[8]
            +(+(+1.-rx*rx)*(+1.-ry*ry))*x[9]
            +(+rx*(+1.+rx)/2.*(+1.-ry*ry))*x[6]
            +(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*x[4]
            +(+(+1.-rx*rx)*ry*(+1.+ry)/2.)*x[7]
            +(+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.)*x[3];
        break;
    case 2:
        fval=
            +(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*y[1]
            +(+(+1.-rx*rx)*ry*(+ry-1.)/2.)*y[5]
            +(+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.)*y[2]
            +(+rx*(+rx-1.)/2.*(+1.-ry*ry))*y[8]
            +(+(+1.-rx*rx)*(+1.-ry*ry))*y[9]
            +(+rx*(+1.+rx)/2.*(+1.-ry*ry))*y[6]
            +(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*y[4]
            +(+(+1.-rx*rx)*ry*(+1.+ry)/2.)*y[7]
            +(+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.)*y[3];
        break;
        //default:
    }
    return fval;
}

