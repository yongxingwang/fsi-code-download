#include "fsi.h"
double nx,ny,nz;
int nnode,ngaus,ndisp,nrefc,ncoor,nvar;
double vol,det,weigh,stif,fact,shear,r0;
int nvard[4],kdord[4],kvord[27];
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
double coefr[6];
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
static void shap_sxx(double *,double *);
static double fshap_sxx(double *,int);
static void shap_syy(double *,double *);
static double fshap_syy(double *,int);
static void shap_sxy(double *,double *);
static double fshap_sxy(double *,int);
static void coef_shap(double *,double *,double *,double *);
static double fcoef_shap(double *,int);
void shapn(int,int,int,double *,double *,double *,int,int,int);
void shapc(int,int,int,double *,double *,double *,int,int,int);
/* subroutine */
void eet3(coora,coefa,prmt,estif,emass,edamp,eload,num)
double coora[6],coefa[6],*prmt,estif[81],*emass,*edamp,*eload;
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
    double elump[10];
    static double rsxx[27],rsyy[27],rsxy[27],csxx[9],csyy[9],csxy[9];
    /* .... store shape functions and their partial derivatives
         .... for all integral points */
    int i,j,igaus;
    int ig_sxx,ig_syy,ig_sxy,iv,jv;
    double fxx,fxy,fyx,fyy;
    double enxx,enxy,enyx,enyy;
    double snxx,snxy,snyx,snyy;
    double egr;
    egr=prmt[1];
// .... initialize the basic data
    if (num==1) initial();
    for (i=1; i<=2; ++i)
        for (j=1; j<=3; ++j)
            coorr[(i-1)*(3)+j-1]=coora[(i-1)*(3)+j-1];
    for (i=1; i<=2; ++i)
        for (j=1; j<=3; ++j)
            coefr[(i-1)*(3)+j-1]=coefa[(i-1)*(3)+j-1];
    for (i=1; i<=9; ++i)
    {
        emass[i]=0.0;
        elump[i]=0.0;
        eload[i]=0.0;
        for (j=1; j<=9; ++j)
        {
            estif[(i-1)*(9)+j-1]=0.0;
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
        coef_shap(refcoor,coef,coefr,coefd);
// .... compute coef functions and their partial derivatives
        un=coef[1];
        vn=coef[2];
        ig_sxx=(igaus-1)*3*3;
        ig_syy=(igaus-1)*3*3;
        ig_sxy=(igaus-1)*3*3;
        if (num>1) goto l2;
// .... the following is the shape function caculation
        shap_sxx(refcoor,&rsxx[ig_sxx]);
        shap_syy(refcoor,&rsyy[ig_syy]);
        shap_sxy(refcoor,&rsxy[ig_sxy]);
l2:
        /* .... the following is the shape function transformation
          .... from reference coordinates to original coordinates */
        shapn(nrefc,ncoor,3,&rsxx[ig_sxx],csxx,crtr,1,3,3);
        shapn(nrefc,ncoor,3,&rsyy[ig_syy],csyy,crtr,1,3,3);
        shapn(nrefc,ncoor,3,&rsxy[ig_sxy],csxy,crtr,1,3,3);
        /* .... the coef function transformation
          .... from reference coordinates to original coordinates */
        shapc(nrefc,ncoor,2,coefd,coefc,crtr,2,5,5);
        weigh=det*gaus[igaus];
        fxx=+coefc[(1-1)*(5)+1-1];
        fxy=+coefc[(1-1)*(5)+2-1];
        fyx=+coefc[(2-1)*(5)+1-1];
        fyy=+coefc[(2-1)*(5)+2-1];
        fxx=+fxx+1;
        fyy=+fyy+1;
        enxx=+fxx*fxx+fxy*fxy;
        enxy=+fxx*fyx+fxy*fyy;
        enyx=+fyx*fxx+fyy*fxy;
        enyy=+fyx*fyx+fyy*fyy;
        enxx=+enxx-1;
        enyy=+enyy-1;
        snxx=+enxx*egr;
        snxy=+enxy*egr;
        snyx=+enyx*egr;
        snyy=+enyy*egr;
        gstr[(num-1)*(3*ngaus)+(igaus-1)*3+1]=snxx;
        gstr[(num-1)*(3*ngaus)+(igaus-1)*3+2]=snyy;
        gstr[(num-1)*(3*ngaus)+(igaus-1)*3+3]=snxy;
// .... the following is the stiffness computation
        for (i=1; i<=3; ++i)
        {
            iv=kvord[(i-1)*(3)+1-1];
            for (j=1; j<=3; ++j)
            {
                jv=kvord[(j-1)*(3)+1-1];
                stif=+csxx[(i-1)*(3)+1-1]*csxx[(j-1)*(3)+1-1]*0.0;
                estif[(iv-1)*(9)+jv-1]+=stif*weigh;
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
        elump[2]=stif*weigh;
        stif=1.0;
        elump[5]=stif*weigh;
        stif=1.0;
        elump[8]=stif*weigh;
        stif=1.0;
        elump[3]=stif*weigh;
        stif=1.0;
        elump[6]=stif*weigh;
        stif=1.0;
        elump[9]=stif*weigh;
        for (i=1; i<=nvard[1]; ++i)
        {
            iv = kvord[(i-1)*(3)+1-1];
            emass[iv]+=elump[iv]*csxx[(i-1)*(3)+1-1];
        }
        for (i=1; i<=nvard[2]; ++i)
        {
            iv = kvord[(i-1)*(3)+2-1];
            emass[iv]+=elump[iv]*csyy[(i-1)*(3)+1-1];
        }
        for (i=1; i<=nvard[3]; ++i)
        {
            iv = kvord[(i-1)*(3)+3-1];
            emass[iv]+=elump[iv]*csxy[(i-1)*(3)+1-1];
        }
// .... the following is the load vector computation
        for (i=1; i<=3; ++i)
        {
            iv=kvord[(i-1)*(3)+1-1];
            stif=+csxx[(i-1)*(3)+1-1]*snxx;
            eload[iv]+=stif*weigh;
        }
        for (i=1; i<=3; ++i)
        {
            iv=kvord[(i-1)*(3)+2-1];
            stif=+csyy[(i-1)*(3)+1-1]*snyy;
            eload[iv]+=stif*weigh;
        }
        for (i=1; i<=3; ++i)
        {
            iv=kvord[(i-1)*(3)+3-1];
            stif=+csxy[(i-1)*(3)+1-1]*snxy;
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
    ndisp=  3;
    nrefc=  2;
    ncoor=  2;
    nvar =  9;
    nnode=  3;
    kdord[1]=1;
    nvard[1]=3;
    kvord[(1-1)*(3)+1-1]=1;
    kvord[(2-1)*(3)+1-1]=4;
    kvord[(3-1)*(3)+1-1]=7;
    kdord[2]=1;
    nvard[2]=3;
    kvord[(1-1)*(3)+2-1]=2;
    kvord[(2-1)*(3)+2-1]=5;
    kvord[(3-1)*(3)+2-1]=8;
    kdord[3]=1;
    nvard[3]=3;
    kvord[(1-1)*(3)+3-1]=3;
    kvord[(2-1)*(3)+3-1]=6;
    kvord[(3-1)*(3)+3-1]=9;
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
static void shap_sxx(refc,shpr)
double *refc,shpr[9];
/* compute shape functions and their partial derivatives
 shapr ---- store shape functions and their partial derivatives */
{
    double (*shap)(double *,int)=&fshap_sxx;
// extern void dshap(shap,double *,double *,int,int,int);
    dshap(shap,refc,shpr,2,3,1);
    /* shape function and their derivatives computation
     compute partial derivatives by centered difference
     which is in the file cshap.c of felac library */
    return;
}

static double fshap_sxx(double *refc,int n)
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
static void shap_syy(refc,shpr)
double *refc,shpr[9];
/* compute shape functions and their partial derivatives
 shapr ---- store shape functions and their partial derivatives */
{
    double (*shap)(double *,int)=&fshap_syy;
// extern void dshap(shap,double *,double *,int,int,int);
    dshap(shap,refc,shpr,2,3,1);
    /* shape function and their derivatives computation
     compute partial derivatives by centered difference
     which is in the file cshap.c of felac library */
    return;
}

static double fshap_syy(double *refc,int n)
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
static void shap_sxy(refc,shpr)
double *refc,shpr[9];
/* compute shape functions and their partial derivatives
 shapr ---- store shape functions and their partial derivatives */
{
    double (*shap)(double *,int)=&fshap_sxy;
// extern void dshap(shap,double *,double *,int,int,int);
    dshap(shap,refc,shpr,2,3,1);
    /* shape function and their derivatives computation
     compute partial derivatives by centered difference
     which is in the file cshap.c of felac library */
    return;
}

static double fshap_sxy(double *refc,int n)
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
    double un[4],vn[4];
    int j;
    for (j=1; j<=3; ++j)
    {
        un[j]=coefr[(1-1)*(3)+j-1];
        vn[j]=coefr[(2-1)*(3)+j-1];
    }
    x=coor[1];
    y=coor[2];
    rx=refc[1];
    ry=refc[2];
    switch (n)
    {
    case 1:
        fval=
            +(+rx)*un[1]
            +(+ry)*un[2]
            +(+(+1.-rx-ry))*un[3];
        break;
    case 2:
        fval=
            +(+rx)*vn[1]
            +(+ry)*vn[2]
            +(+(+1.-rx-ry))*vn[3];
        break;
        //default:
    }
    return fval;
}

