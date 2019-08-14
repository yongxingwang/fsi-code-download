#include "fsi.h"
double nx,ny,nz;
int nnode,ngaus,ndisp,nrefc,ncoor,nvar;
double vol,det,weigh,stif,fact,shear,r0;
int nvard[3],kdord[3],kvord[36];
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
double coefr[18];
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
static void coef_shap(double *,double *,double *,double *);
static double fcoef_shap(double *,int);
void shapn(int,int,int,double *,double *,double *,int,int,int);
void shapc(int,int,int,double *,double *,double *,int,int,int);
/* subroutine */
void b0eq9g3(coora,coefa,prmt,estif,emass,edamp,eload,num)
double coora[18],coefa[18],*prmt,estif[324],*emass,*edamp,*eload;
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
    double coef[3];
    double un,vn;
    double coefd[10],coefc[10];
    double x,y,rx,ry;
    double elump[19];
    static double ru[243],rv[243],cu[27],cv[27];
    /* .... store shape functions and their partial derivatives
         .... for all integral points */
    int i,j,igaus;
    int ig_u,ig_v,iv,jv;
    double re,fr,fx,fy,gx,gy;
    re=prmt[1];
    fr=prmt[2];
// .... initialize the basic data
    if (num==1) initial();
    for (i=1; i<=2; ++i)
        for (j=1; j<=9; ++j)
            coorr[(i-1)*(9)+j-1]=coora[(i-1)*(9)+j-1];
    for (i=1; i<=2; ++i)
        for (j=1; j<=9; ++j)
            coefr[(i-1)*(9)+j-1]=coefa[(i-1)*(9)+j-1];
    for (i=1; i<=18; ++i)
    {
        eload[i]=0.0;
        for (j=1; j<=18; ++j)
        {
            estif[(i-1)*(18)+j-1]=0.0;
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
        coef_shap(refcoor,coef,coefr,coefd);
// .... compute coef functions and their partial derivatives
        un=coef[1];
        vn=coef[2];
        ig_u=(igaus-1)*9*3;
        ig_v=(igaus-1)*9*3;
        if (num>1) goto l2;
// .... the following is the shape function caculation
        shap_u(refcoor,&ru[ig_u]);
        shap_v(refcoor,&rv[ig_v]);
l2:
        /* .... the following is the shape function transformation
          .... from reference coordinates to original coordinates */
        shapn(nrefc,ncoor,9,&ru[ig_u],cu,crtr,1,3,3);
        shapn(nrefc,ncoor,9,&rv[ig_v],cv,crtr,1,3,3);
        /* .... the coef function transformation
          .... from reference coordinates to original coordinates */
        shapc(nrefc,ncoor,2,coefd,coefc,crtr,2,5,5);
        weigh=det*gaus[igaus];
        fx=+coefc[(1-1)*(5)+1-1]*un*dt+coefc[(1-1)*(5)+2-1]
           *vn*dt;
        fy=+coefc[(2-1)*(5)+1-1]*un*dt+coefc[(2-1)*(5)+2-1]
           *vn*dt;
        gx=+coefc[(1-1)*(5)+1-1]*un*dt*dt/2.0+coefc[(1-1)*(5)+2-1]
           *vn*dt*dt/2.0;
        gy=+coefc[(2-1)*(5)+1-1]*un*dt*dt/2.0+coefc[(2-1)*(5)+2-1]
           *vn*dt*dt/2.0;
// .... the following is the stiffness computation
        for (i=1; i<=9; ++i)
        {
            iv=kvord[(i-1)*(2)+1-1];
            for (j=1; j<=9; ++j)
            {
                jv=kvord[(j-1)*(2)+1-1];
                stif=+cu[(i-1)*(3)+1-1]*cu[(j-1)*(3)+1-1] ;
                estif[(iv-1)*(18)+jv-1]+=stif*weigh;
            }
        }
        for (i=1; i<=9; ++i)
        {
            iv=kvord[(i-1)*(2)+2-1];
            for (j=1; j<=9; ++j)
            {
                jv=kvord[(j-1)*(2)+2-1];
                stif=+cv[(i-1)*(3)+1-1]*cv[(j-1)*(3)+1-1] ;
                estif[(iv-1)*(18)+jv-1]+=stif*weigh;
            }
        }
// .... the following is the load vector computation
        for (i=1; i<=9; ++i)
        {
            iv=kvord[(i-1)*(2)+1-1];
            stif=-cu[(i-1)*(3)+1-1]*fx-cu[(i-1)*(3)+2-1]*un*gx-cu[(i-1)*(3)+3-1]*vn*gx+cu[(i-1)*(3)+1-1]*un+cu[(i-1)*(3)+1-1]*coefc[(1-1)*(5)+1-1]*gx+cu[(i-1)*(3)+1-1]*coefc[(1-1)*(5)+2-1]*gy;
            eload[iv]+=stif*weigh;
        }
        for (i=1; i<=9; ++i)
        {
            iv=kvord[(i-1)*(2)+2-1];
            stif=-cv[(i-1)*(3)+1-1]*fy-cv[(i-1)*(3)+2-1]*un*gy-cv[(i-1)*(3)+3-1]*vn*gy+cv[(i-1)*(3)+1-1]*vn+cv[(i-1)*(3)+1-1]*coefc[(2-1)*(5)+1-1]*gx+cv[(i-1)*(3)+1-1]*coefc[(2-1)*(5)+2-1]*gy;
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
    ndisp=  2;
    nrefc=  2;
    ncoor=  2;
    nvar = 18;
    nnode=  9;
    kdord[1]=1;
    nvard[1]=9;
    kvord[(1-1)*(2)+1-1]=1;
    kvord[(2-1)*(2)+1-1]=9;
    kvord[(3-1)*(2)+1-1]=3;
    kvord[(4-1)*(2)+1-1]=15;
    kvord[(5-1)*(2)+1-1]=17;
    kvord[(6-1)*(2)+1-1]=11;
    kvord[(7-1)*(2)+1-1]=7;
    kvord[(8-1)*(2)+1-1]=13;
    kvord[(9-1)*(2)+1-1]=5;
    kdord[2]=1;
    nvard[2]=9;
    kvord[(1-1)*(2)+2-1]=2;
    kvord[(2-1)*(2)+2-1]=10;
    kvord[(3-1)*(2)+2-1]=4;
    kvord[(4-1)*(2)+2-1]=16;
    kvord[(5-1)*(2)+2-1]=18;
    kvord[(6-1)*(2)+2-1]=12;
    kvord[(7-1)*(2)+2-1]=8;
    kvord[(8-1)*(2)+2-1]=14;
    kvord[(9-1)*(2)+2-1]=6;
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

static void coef_shap(double *refc,double *coef,double *coefr,double *coefd)
/* compute coef value and their partial derivatives
by reference coordinate value */
{
    double (*shap)(double *,int)=&fcoef_shap;
// extern void dcoef(shap,double *,double *,double *,
//  int,int,int);
    dcoef(shap,refc,coef,coefd,2,2,2);
    /* coef value and their partial derivatives caculation
     compute partial derivatives by centered difference
     which is in the file cshap.c of felac library */
    return;
}

static double fcoef_shap(double *refc,int n)
/* coef function caculation */
{
    double rx,ry;
    double x,y,fval;
    double un[10],vn[10];
    int j;
    for (j=1; j<=9; ++j)
    {
        un[j]=coefr[(1-1)*(9)+j-1];
        vn[j]=coefr[(2-1)*(9)+j-1];
    }
    x=coor[1];
    y=coor[2];
    rx=refc[1];
    ry=refc[2];
    switch (n)
    {
    case 1:
        fval=
            +(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*un[1]
            +(+(+1.-rx*rx)*ry*(+ry-1.)/2.)*un[5]
            +(+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.)*un[2]
            +(+rx*(+rx-1.)/2.*(+1.-ry*ry))*un[8]
            +(+(+1.-rx*rx)*(+1.-ry*ry))*un[9]
            +(+rx*(+1.+rx)/2.*(+1.-ry*ry))*un[6]
            +(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*un[4]
            +(+(+1.-rx*rx)*ry*(+1.+ry)/2.)*un[7]
            +(+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.)*un[3];
        break;
    case 2:
        fval=
            +(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*vn[1]
            +(+(+1.-rx*rx)*ry*(+ry-1.)/2.)*vn[5]
            +(+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.)*vn[2]
            +(+rx*(+rx-1.)/2.*(+1.-ry*ry))*vn[8]
            +(+(+1.-rx*rx)*(+1.-ry*ry))*vn[9]
            +(+rx*(+1.+rx)/2.*(+1.-ry*ry))*vn[6]
            +(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*vn[4]
            +(+(+1.-rx*rx)*ry*(+1.+ry)/2.)*vn[7]
            +(+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.)*vn[3];
        break;
        //default:
    }
    return fval;
}

