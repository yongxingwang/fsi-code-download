#include "fsi.h"
double nx,ny,nz;
int nnode,ngaus,ndisp,nrefc,ncoor,nvar;
double vol,det,weigh,stif,fact,shear,r0;
int nvard[3],kdord[3],kvord[12];
double refc[6],gaus[4];
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
double coorr[6];
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
void shapn(int,int,int,double *,double *,double *,int,int,int);
void shapc(int,int,int,double *,double *,double *,int,int,int);
/* subroutine */
void fet3(coora,coefa,prmt,estif,emass,edamp,eload,num)
double coora[6],*coefa,*prmt,estif[36],*emass,*edamp,*eload;
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
    double elump[7];
    static double ru[27],rv[27],cu[9],cv[9];
    /* .... store shape functions and their partial derivatives
         .... for all integral points */
    int i,j,igaus;
    int ig_u,ig_v,iv,jv;
    double egr,re,rour,emur,fr,sxx,syy,sxy;
    double rour1,emur1,ek;
    egr=prmt[1];
    re=prmt[2];
    rour=prmt[3];
    emur=prmt[4];
    fr=prmt[5];
    rour1=rour-1.0;
    emur1=emur-1.0;
    ek=egr*dt+emur1/re;
// .... initialize the basic data
    if (num==1) initial();
    for (i=1; i<=2; ++i)
        for (j=1; j<=3; ++j)
            coorr[(i-1)*(3)+j-1]=coora[(i-1)*(3)+j-1];
    for (i=1; i<=6; ++i)
    {
        emass[i]=0.0;
        elump[i]=0.0;
        eload[i]=0.0;
        for (j=1; j<=6; ++j)
        {
            estif[(i-1)*(6)+j-1]=0.0;
        }
    }
    for (igaus=1; igaus<=ngaus; ++igaus)
    {
        for (i=1; i<=nrefc; ++i) refcoor[i]=refc[(i-1)*(3)+igaus-1];
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
        ig_u=(igaus-1)*3*3;
        ig_v=(igaus-1)*3*3;
        if (num>1) goto l2;
// .... the following is the shape function caculation
        shap_u(refcoor,&ru[ig_u]);
        shap_v(refcoor,&rv[ig_v]);
l2:
        /* .... the following is the shape function transformation
          .... from reference coordinates to original coordinates */
        shapn(nrefc,ncoor,3,&ru[ig_u],cu,crtr,1,3,3);
        shapn(nrefc,ncoor,3,&rv[ig_v],cv,crtr,1,3,3);
        weigh=det*gaus[igaus];
        sxx=gstr[(num-1)*(3*ngaus)+(igaus-1)*3+1];
        syy=gstr[(num-1)*(3*ngaus)+(igaus-1)*3+2];
        sxy=gstr[(num-1)*(3*ngaus)+(igaus-1)*3+3];
// .... the following is the stiffness computation
        for (i=1; i<=3; ++i)
        {
            iv=kvord[(i-1)*(2)+1-1];
            for (j=1; j<=3; ++j)
            {
                jv=kvord[(j-1)*(2)+1-1];
                stif=+cu[(i-1)*(3)+2-1]*cu[(j-1)*(3)+2-1]*ek
                     +cu[(i-1)*(3)+2-1]*cu[(j-1)*(3)+2-1]*ek
                     +cu[(i-1)*(3)+3-1]*cu[(j-1)*(3)+3-1]*ek
                     +cu[(i-1)*(3)+2-1]*cu[(j-1)*(3)+2-1]*sxx*dt
                     +cu[(i-1)*(3)+2-1]*cu[(j-1)*(3)+3-1]*sxy*dt
                     +cu[(i-1)*(3)+2-1]*cu[(j-1)*(3)+2-1]*sxx*dt
                     +cu[(i-1)*(3)+2-1]*cu[(j-1)*(3)+3-1]*sxy*dt
                     +cu[(i-1)*(3)+3-1]*cu[(j-1)*(3)+2-1]*sxy*dt
                     +cu[(i-1)*(3)+3-1]*cu[(j-1)*(3)+3-1]*syy*dt;
                estif[(iv-1)*(6)+jv-1]+=stif*weigh;
            }
        }
        for (i=1; i<=3; ++i)
        {
            iv=kvord[(i-1)*(2)+1-1];
            for (j=1; j<=3; ++j)
            {
                jv=kvord[(j-1)*(2)+2-1];
                stif=+cu[(i-1)*(3)+3-1]*cv[(j-1)*(3)+2-1]*ek
                     +cu[(i-1)*(3)+3-1]*cv[(j-1)*(3)+2-1]*sxx*dt
                     +cu[(i-1)*(3)+3-1]*cv[(j-1)*(3)+3-1]*sxy*dt;
                estif[(iv-1)*(6)+jv-1]+=stif*weigh;
            }
        }
        for (i=1; i<=3; ++i)
        {
            iv=kvord[(i-1)*(2)+2-1];
            for (j=1; j<=3; ++j)
            {
                jv=kvord[(j-1)*(2)+1-1];
                stif=+cv[(i-1)*(3)+2-1]*cu[(j-1)*(3)+3-1]*ek
                     +cv[(i-1)*(3)+2-1]*cu[(j-1)*(3)+2-1]*sxy*dt
                     +cv[(i-1)*(3)+2-1]*cu[(j-1)*(3)+3-1]*syy*dt;
                estif[(iv-1)*(6)+jv-1]+=stif*weigh;
            }
        }
        for (i=1; i<=3; ++i)
        {
            iv=kvord[(i-1)*(2)+2-1];
            for (j=1; j<=3; ++j)
            {
                jv=kvord[(j-1)*(2)+2-1];
                stif=+cv[(i-1)*(3)+3-1]*cv[(j-1)*(3)+3-1]*ek
                     +cv[(i-1)*(3)+2-1]*cv[(j-1)*(3)+2-1]*ek
                     +cv[(i-1)*(3)+3-1]*cv[(j-1)*(3)+3-1]*ek
                     +cv[(i-1)*(3)+3-1]*cv[(j-1)*(3)+2-1]*sxy*dt
                     +cv[(i-1)*(3)+3-1]*cv[(j-1)*(3)+3-1]*syy*dt
                     +cv[(i-1)*(3)+2-1]*cv[(j-1)*(3)+2-1]*sxx*dt
                     +cv[(i-1)*(3)+2-1]*cv[(j-1)*(3)+3-1]*sxy*dt
                     +cv[(i-1)*(3)+3-1]*cv[(j-1)*(3)+2-1]*sxy*dt
                     +cv[(i-1)*(3)+3-1]*cv[(j-1)*(3)+3-1]*syy*dt;
                estif[(iv-1)*(6)+jv-1]+=stif*weigh;
            }
        }
// .... the following is the mass matrix computation
        stif=rour1;
        elump[1]=stif*weigh;
        stif=rour1;
        elump[3]=stif*weigh;
        stif=rour1;
        elump[5]=stif*weigh;
        stif=rour1;
        elump[2]=stif*weigh;
        stif=rour1;
        elump[4]=stif*weigh;
        stif=rour1;
        elump[6]=stif*weigh;
        for (i=1; i<=nvard[1]; ++i)
        {
            iv = kvord[(i-1)*(2)+1-1];
            emass[iv]+=elump[iv]*cu[(i-1)*(3)+1-1];
        }
        for (i=1; i<=nvard[2]; ++i)
        {
            iv = kvord[(i-1)*(2)+2-1];
            emass[iv]+=elump[iv]*cv[(i-1)*(3)+1-1];
        }
// .... the following is the load vector computation
        for (i=1; i<=3; ++i)
        {
            iv=kvord[(i-1)*(2)+1-1];
            stif=-cu[(i-1)*(3)+2-1]*sxx-cu[(i-1)*(3)+3-1]*sxy;
            eload[iv]+=stif*weigh;
        }
        for (i=1; i<=3; ++i)
        {
            iv=kvord[(i-1)*(2)+2-1];
            stif=-cv[(i-1)*(3)+1-1]*fr*rour1-cv[(i-1)*(3)+2-1]*sxy-cv[(i-1)*(3)+3-1]*syy;
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
    ngaus=  3;
    ndisp=  2;
    nrefc=  2;
    ncoor=  2;
    nvar =  6;
    nnode=  3;
    kdord[1]=1;
    nvard[1]=3;
    kvord[(1-1)*(2)+1-1]=1;
    kvord[(2-1)*(2)+1-1]=3;
    kvord[(3-1)*(2)+1-1]=5;
    kdord[2]=1;
    nvard[2]=3;
    kvord[(1-1)*(2)+2-1]=2;
    kvord[(2-1)*(2)+2-1]=4;
    kvord[(3-1)*(2)+2-1]=6;
    refc[(1-1)*(3)+1-1]=1.;
    refc[(2-1)*(3)+1-1]=0.;
    gaus[1]=1./6.;
    refc[(1-1)*(3)+2-1]=0.;
    refc[(2-1)*(3)+2-1]=1.;
    gaus[2]=1./6.;
    refc[(1-1)*(3)+3-1]=0.;
    refc[(2-1)*(3)+3-1]=0.;
    gaus[3]=1./6.;
    return;
}


// void dshap(double (*shap)(double *,double *,int),double *,^shpr[][3],int,int,int);
static void shap_u(refc,shpr)
double *refc,shpr[9];
/* compute shape functions and their partial derivatives
 shapr ---- store shape functions and their partial derivatives */
{
    double (*shap)(double *,int)=&fshap_u;
// extern void dshap(shap,double *,double *,int,int,int);
    dshap(shap,refc,shpr,2,3,1);
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
        fval=+rx;
        break;
    case 2:
        fval=+ry;
        break;
    case 3:
        fval=+(+1.-rx-ry);
        break;
//   default:
    }
    return fval;
}
static void shap_v(refc,shpr)
double *refc,shpr[9];
/* compute shape functions and their partial derivatives
 shapr ---- store shape functions and their partial derivatives */
{
    double (*shap)(double *,int)=&fshap_v;
// extern void dshap(shap,double *,double *,int,int,int);
    dshap(shap,refc,shpr,2,3,1);
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
        fval=+rx;
        break;
    case 2:
        fval=+ry;
        break;
    case 3:
        fval=+(+1.-rx-ry);
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
    double x[4],y[4];
    int j;
    for (j=1; j<=3; ++j)
    {
        x[j]=coorr[(1-1)*(3)+j-1];
        y[j]=coorr[(2-1)*(3)+j-1];
    }
    rx=refc[1];
    ry=refc[2];
    switch (n)
    {
    case 1:
        fval=
            +(+rx)*x[1]
            +(+ry)*x[2]
            +(+(+1.-rx-ry))*x[3];
        break;
    case 2:
        fval=
            +(+rx)*y[1]
            +(+ry)*y[2]
            +(+(+1.-rx-ry))*y[3];
        break;
        //default:
    }
    return fval;
}

