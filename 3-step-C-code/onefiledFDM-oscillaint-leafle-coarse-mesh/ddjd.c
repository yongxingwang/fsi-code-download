#include "fsi.h"

extern double coorr[90];
int getdd(FILE*, int,int,int,double *,int,double *,int,int,int *,int *,double *);
int nin(int,int,double *,double *,double);
void calculp(int,int,int,double *,double *);
void dqtcw(int,double *,double *);

void getjd(ddjd,elem,coor0,coor1)
struct ddmatrice *ddjd;
struct element elem;
struct coordinates coor0,coor1;
{
    FILE *fp;
    int *node,*jd,iqtcw,dim,nc,nf,np,nelm,k,i,nfn;
    double *dd,*xc,*xf;
    /*
    np: nnode
    nf: number of solid nodes
    nc: number of fluid nodes
    *xf: coordinates of solid mesh
    *xc: coordinates of fluid mesh
    dim: dimensions
    nelm: number of elements
    *node: element cells
    structure *ddjd: output interplation matrix
    */

    dim=coor0.dim;
    xc=coor0.coor;
    nc=coor0.knode;
    xf=coor1.coor;
    nf=coor1.knode;
    np=elem.nnode[1]-1;
    nelm=elem.nelem[1];
    node=elem.node;

//    nelm=nelm_jd;
//    node=node_jd;
//      dd -- d matrix

    (*ddjd).nr = np;
    (*ddjd).nc = nf;
    jd = (*ddjd).jd;
    dd = (*ddjd).dd;

    if (dim==3)
    {
        if (np==8)  iqtcw = 3;
        if (np==4)  iqtcw = 4;
        if (np==6)  iqtcw = 5;
        if (np==10)  iqtcw = 9;
        if (np==27)  iqtcw = 8;
    }
    if (dim==2)
    {
        if (np==4)  iqtcw = 1;
        if (np==3)  iqtcw = 2;
        if (np==6)  iqtcw = 7;
        if (np==9)  iqtcw = 6;
    }
    if (dim==1)
    {
        if (np==2)  iqtcw = 10;
        if (np==3)  iqtcw = 11;
    }
// .....start to compute jd and dd matrix ....
//externnp, void getdd(int,int,int,int *,int,double *,int,double *,int,int,int *,int *,double *);
    if ((fp = fopen("ddjd.txt","w"))==NULL)
    {
        printf("cannot open %s\n", "ddjd.txt");
    }
    else
    {
        fclose(fp);
    }

    if ((fp = fopen("ddjd.txt","a"))==NULL)
    {
        printf("cat:cannot open %s\n", "ddjd.txt");
        exit(1);
    }


    nfn=getdd(fp,iqtcw,dim,nf,xf,nc,xc,np,nelm,node,jd,dd);

    fprintf(fp,"%d%s%d\n",nfn,"=?",nf);

/*
    for(i=1; i<=nf; ++i)
    {
        fprintf(fp,"%s,%d\n","node:",i);

        for (k=1; k<=np; ++k)
            fprintf(fp,"%d%s",jd[(i-1)*np+k-1]," ");

        fprintf(fp,"\n");

        for (k=1; k<=np; ++k)
            fprintf(fp,"%lf%s",dd[(i-1)*np+k-1]," ");

        fprintf(fp,"\n");
    }
*/

    fclose(fp);

//	for(k=1; k<=3; ++k)
//		printf("%f\n",xf[(k-1)*nf+41-1]);
//	scanf("%d",&k);
//////////////////////////////////////////
    return;
}

int getdd(fp,iqtcw,nd,nf,xf,nc,xc,np,nelm,node,jd,dd)
int iqtcw,nd,np,nc,nelm,*node,nf,*jd;
double *xc,*xf,*dd;
FILE *fp;
{
    int nfn=0,nfnc=0;
    int nne,inn,jel,i,j,k,l,m;
    double p[4],r[4],e,d[30];
    const double e0=1.e-6;

    nne = np+1;
//    for (i=1; i<=nf; ++i) /* 2111 */
    i=1;
    e=e0;
    while(i <= nf)
    {
//        inde[i]=0;
        for (k=1; k<=nd; ++k)
        {
            r[k]=xf[(k-1)*nf+i-1];
        }
// .... j denote the coarse element no.
        for (j=1; j<=nelm; ++j) /* 2110 */
        {
            for (l=1; l<=np; ++l)
            {
                jel=node[(j-1)*nne+l];
                for (k=1; k<=nd; ++k) coorr[(k-1)*np+l-1]=xc[(k-1)*nc+jel-1];
//				printf("\n%lf,%lf",coorr[l-1],coorr[np+l-1]);
            }

//...... inn = 1 denotes that r sits in the coarse element j
//extern int nin(int,int,double *,double *);
            inn=nin(nd,np,r,coorr,e);
            if (inn!=1) goto l2110;
//           	 printf("after nin() %d,%d,%d\n",i,j,nf);
//			exit(0);
//extern void calculp(int,int,int,double *,double *,double *,double *);
//                printf("before calculp:%d,%d\n",i,j);
            calculp(iqtcw,np,nd,r,p);
            /*
            	if (i == 41){
            		  printf("after calculp:%e,%e,%e\n",p[1],p[2],p[3]);
            		scanf("%d",&k);
            	}
            */
//           e = 1.e-6;
            m = 1;
            for (k=1; k<=nd; ++k)
            {
                if (p[k]<-1.0-e || p[k]>1.0+e) m = 0;
            }
            if (iqtcw==2 || iqtcw==5 || iqtcw==7)
            {
                if (p[1]<-e || p[2]<-e || p[1]+p[2]>1.0+e) m = 0;
            }
            if (iqtcw==4 || iqtcw==9)
            {
                if (p[1]<-e || p[2]<-e || p[3]<-e ||
                        p[1]+p[2]+p[3]>1.0+e) m = 0;
            }
            if (m==0) goto l2110;
//            inde[i]=j;
//		printf("point,element: %d,%d\n",i,j);
            nfn++;
            nfnc++;

            dqtcw(iqtcw,p,d);
            for (k=1; k<=np; ++k)
            {
                dd[(i-1)*np+k-1]=d[k];
                jd[(i-1)*np+k-1]=node[(j-1)*nne+k];
            }
            goto l2111;
l2110:
            continue;
        }
l2111:
        if(nfnc == i)
        {
            i++;
            e=e0;
        }
        else
        {
            e=e*2.;
            fprintf(fp,"%d,%f \n",i,e);
            if(e > 0.01) exit(1);
        }

    }
    return nfn;
}
//       implicit real*8 (a-h,o-z)
int nin(nd,np,po,p,e)
int nd,np;
double *po,*p,e;
{
//c...... calculate fine node po is in the coarse element cube or not
//c .....  nin=1 if po in the element cube
    int k,i,in;
    double xmin[4],xmax[4],er;
    for (k=1; k<=nd; ++k)
    {
        xmax[k]=p[(k-1)*np+1-1];
        xmin[k]=p[(k-1)*np+1-1];
        for (i=2; i<=np; ++i)
        {
            if (p[(k-1)*np+i-1]>xmax[k])  xmax[k]=p[(k-1)*np+i-1];
            if (p[(k-1)*np+i-1]<xmin[k])  xmin[k]=p[(k-1)*np+i-1];
        }
    }
    for (k=1; k<=nd; ++k)
    {
        er = (xmax[k]-xmin[k])*e;
        xmax[k]=xmax[k]+er;
        xmin[k]=xmin[k]-er;
    }
    in=1;
    for (k=1; k<=nd; ++k)
    {
        if (po[k]<xmin[k] || po[k]>xmax[k]) in=0;
    }
    return in;
}
void calculp(iqtcw,nnode,nd,r0,p)
int iqtcw,nnode,nd;
double *r0,*p;
{
    /*
    c ........................................................
    c .... calculate p by r0 using newton iteration
    c .... f(p) = r(p) - r0
    c .... f(p+dp) = f(p) + f'(p)*dp = r(p)-r0 + {r/p}*dp = 0
    c .... dp = - {p/r}*(r(p)-r0)
    c .... p+dp = p - {p/r}*(r(p)-r0)
    c .... p+dp = p - cr*( r(p) - r0 )
    c ........................................................
    */
    extern double rccr(int,int,double *,double *,double *,double *);
    int it,itmax,i,j;
    double r[4],dr[4],dp[4],err,errmax,det,rc[10],cr[10];
    errmax = 1.e-8/nnode;
    itmax = 10;
    it = 0;
// ..... calculate r rc & cr by p & rnod
// ..... p denote the reference coordinates
// ..... r denote the global coordinates
// ..... rnod denote the nodal coordinates of the coarse element
// ..... rc denote the jacobi matrix
// ..... cr denote the inverse matrix of rc
    for (i=1; i<=nd; ++i)
    {
        p[i] = 0.0; //iterate from the origin,which is a reasonable guess
    }
//	for (i=1; i<=nnode; ++i) printf("\n%lf,%lf",coorr[i-1],coorr[nnode+i-1]);
//	for (i=1; i<=nd; ++i) printf("\n%lf",r0[i]);


l1:
    det = rccr(iqtcw,nd,p,r,rc,cr); // r=r(p)
    for (i=1; i<=nd; ++i)
    {
        dr[i] = r[i] - r0[i];
    }
    err = 0.0;
    for (i=1; i<=nd; ++i)
    {
        dp[i] = 0.0;
        for (j=1; j<=nd; ++j)
        {
            dp[i] += cr[(i-1)*nd+j-1]*dr[j];
        }
        p[i] -= dp[i];
        err += dp[i]*dp[i];
    }
    it = it+1;
    if (err>errmax && it<itmax) goto l1;
    return;

}
//extern double coorr[90];
void dcoor(double (*shap)(double *,int),
           double *,double *,double *,int,int,int);
double invm(int,double *,double *);
void q4(double *,double *,double *);
void t3(double *,double *,double *);
void c8(double *,double *,double *);
void w4(double *,double *,double *);
void w6(double *,double *,double *);
void q9(double *,double *,double *);
void t6(double *,double *,double *);
void c27(double *,double *,double *);
void w10(double *,double *,double *);
void l2(double *,double *,double *);
void l3(double *,double *,double *);

double rccr(iqtcw,ncoor,refc,coor,rc,cr)
int iqtcw,ncoor;
double *refc,*coor,*rc,*cr;
{
    double det;
    switch (iqtcw)
    {

    case 1:
        q4(refc,coor,rc);
        det = invm(ncoor,rc,cr);
        break;

    case 2:
        t3(refc,coor,rc);
        det = invm(ncoor,rc,cr);
        break;

    case 3:
        c8(refc,coor,rc);
        det = invm(ncoor,rc,cr);
        break;

    case 4:
        w4(refc,coor,rc);
        det = invm(ncoor,rc,cr);
        break;

    case 6:
        q9(refc,coor,rc);
        det = invm(ncoor,rc,cr);
        break;

    case 7:
        t6(refc,coor,rc);
        det = invm(ncoor,rc,cr);
        break;

    case 8:
        c27(refc,coor,rc);
        det = invm(ncoor,rc,cr);
        break;

    case 9:
        w10(refc,coor,rc);
        det = invm(ncoor,rc,cr);
        break;

    case 10:
        l2(refc,coor,rc);
        det = invm(ncoor,rc,cr);
        break;

    case 11:
        l3(refc,coor,rc);
        det = invm(ncoor,rc,cr);
        break;

    }

    return det;
}
void shap_fq4(double *,double *);
void shap_ft3(double *,double *);
void shap_fc8(double *,double *);
void shap_fw4(double *,double *);
void shap_fw6(double *,double *);
void shap_fq9(double *,double *);
void shap_ft6(double *,double *);
void shap_fc27(double *,double *);
void shap_fw10(double *,double *);
void shap_fl2(double *,double *);
void shap_fl3(double *,double *);

void dqtcw(iqtcw,refc,d)
int iqtcw;
double *refc,*d;
{
    switch (iqtcw)
    {
    case 1:
        shap_fq4(refc,d);
        break;

    case 2:
        shap_ft3(refc,d);
        break;

    case 3:
        shap_fc8(refc,d);
        break;

    case 4:
        shap_fw4(refc,d);
        break;

    case 5:
        shap_fw6(refc,d);
        break;

    case 6:
        shap_fq9(refc,d);
        break;

    case 7:
        shap_ft6(refc,d);
        break;

    case 8:
        shap_fc27(refc,d);
        break;

    case 9:
        shap_fw10(refc,d);
        break;

    case 10:
        shap_fl2(refc,d);
        break;

    case 11:
        shap_fl3(refc,d);
        break;
    }

    return;
}

void shap_fq4(double *refc,double *d)
{
    double rx,ry;
    rx=refc[1];
    ry=refc[2];
    d[1]=+(+1.-rx)/2.*(+1.-ry)/2. ;
    d[2]=+(+1.+rx)/2.*(+1.-ry)/2. ;
    d[3]=+(+1.+rx)/2.*(+1.+ry)/2. ;
    d[4]=+(+1.-rx)/2.*(+1.+ry)/2. ;
    return;
}


void shap_ft3(double *refc,double *d)
{
    double rx,ry;
    rx=refc[1];
    ry=refc[2];
    d[1]=+rx ;
    d[2]=+ry ;
    d[3]=+(+1.-rx-ry) ;
    return;
}

void shap_fc8(double *refc,double *d)
{
    double rx,ry,rz;
    rx=refc[1];
    ry=refc[2];
    rz=refc[3];
    d[1] =+(+1.-rx)/2.*(+1.-ry)/2.*(+1.-rz)/2. ;
    d[2] =+(+1.+rx)/2.*(+1.-ry)/2.*(+1.-rz)/2. ;
    d[3] =+(+1.+rx)/2.*(+1.+ry)/2.*(+1.-rz)/2. ;
    d[4] =+(+1.-rx)/2.*(+1.+ry)/2.*(+1.-rz)/2. ;
    d[5] =+(+1.-rx)/2.*(+1.-ry)/2.*(+1.+rz)/2. ;
    d[6] =+(+1.+rx)/2.*(+1.-ry)/2.*(+1.+rz)/2. ;
    d[7] =+(+1.+rx)/2.*(+1.+ry)/2.*(+1.+rz)/2. ;
    d[8] =+(+1.-rx)/2.*(+1.+ry)/2.*(+1.+rz)/2. ;
    return;
}

void shap_fw4(double *refc,double *d)
{
    double rx,ry,rz;
    rx=refc[1];
    ry=refc[2];
    rz=refc[3];
    d[1] =+rx ;
    d[2] =+ry ;
    d[3] =+rz ;
    d[4] =+(+1.-rx-ry-rz) ;
    return;
}

void shap_fw6(double *refc,double *d)
{
    double rx,ry,rz;
    rx=refc[1];
    ry=refc[2];
    rz=refc[3];
    d[1] =+rx*(+1.-rz)/2. ;
    d[2] =+ry*(+1.-rz)/2. ;
    d[3] =+(+1.-rx-ry)*(+1.-rz)/2. ;
    d[4] =+rx*(+1.+rz)/2. ;
    d[5] =+ry*(+1.+rz)/2. ;
    d[6] =+(+1.-rx-ry)*(+1.+rz)/2. ;
    return;
}

void shap_ft6(double *refc,double *d)
{
    double rx,ry;
    rx=refc[1];
    ry=refc[2];
    d[1] =+rx*(+2.*rx-1.) ;
    d[4] =+rx*ry*4. ;
    d[2] =+ry*(+2.*ry-1.) ;
    d[5] =+ry*(+1.-rx-ry)*4. ;
    d[3] =+(+1.-2.*rx-2.*ry)*(+1.-rx-ry);
    d[6] =+rx*(+1.-rx-ry)*4. ;
    return;
}

void shap_fw10(double *refc,double *d)
{
    double rx,ry,rz;
    rx=refc[1];
    ry=refc[2];
    rz=refc[3];
    d[1] =+rx*(+2.*rx-1.) ;
    d[5] =+rx*ry*4. ;
    d[2] =+ry*(+2.*ry-1.) ;
    d[6] =+ry*rz*4. ;
    d[3] =+rz*(+2.*rz-1.) ;
    d[7] =+rx*rz*4. ;
    d[8] =+rx*(+1.-rx-ry-rz)*4. ;
    d[9] =+ry*(+1.-rx-ry-rz)*4. ;
    d[10] =+rz*(+1.-rx-ry-rz)*4. ;
    d[4] =+(+1.-2.*rx-2.*ry-2.*rz)*(+1.-rx-ry-rz) ;
    return;
}


void shap_fq9(double *refc,double *d)
{
    double rx,ry;
    rx=refc[1];
    ry=refc[2];
    d[1]= +rx*(+rx-1.)/2.*ry*(+ry-1.)/2. ;
    d[5]= +(+1.-rx*rx)*ry*(+ry-1.)/2. ;
    d[2]= +rx*(+1.+rx)/2.*ry*(+ry-1.)/2. ;
    d[8]= +rx*(+rx-1.)/2.*(+1.-ry*ry) ;
    d[9]= +(+1.-rx*rx)*(+1.-ry*ry) ;
    d[6]= +rx*(+1.+rx)/2.*(+1.-ry*ry) ;
    d[4]= +rx*(+rx-1.)/2.*ry*(+1.+ry)/2. ;
    d[7]= +(+1.-rx*rx)*ry*(+1.+ry)/2. ;
    d[3]= +rx*(+1.+rx)/2.*ry*(+1.+ry)/2. ;
    return;
}

void shap_fc27(double *refc,double *d)
{
    double rx,ry,rz;
    rx=refc[1];
    ry=refc[2];
    rz=refc[3];
    d[1] = rx*(rx-1.)/2.*ry*(ry-1.)/2.*rz*(rz-1.)/2. ;
    d[9] = (1.-rx*rx)*ry*(ry-1.)/2.*rz*(rz-1.)/2. ;
    d[2] = rx*(1.+rx)/2.*ry*(ry-1.)/2.*rz*(rz-1.)/2. ;
    d[12] = rx*(rx-1.)/2.*(1.-ry*ry)*rz*(rz-1.)/2. ;
    d[21] = (1.-rx*rx)*(1.-ry*ry)*rz*(rz-1.)/2. ;
    d[10] = rx*(1.+rx)/2.*(1.-ry*ry)*rz*(rz-1.)/2. ;
    d[4] = rx*(rx-1.)/2.*ry*(1.+ry)/2.*rz*(rz-1.)/2. ;
    d[11] = (1.-rx*rx)*ry*(1.+ry)/2.*rz*(rz-1.)/2. ;
    d[3] = rx*(1.+rx)/2.*ry*(1.+ry)/2.*rz*(rz-1.)/2. ;
    d[13] = rx*(rx-1.)/2.*ry*(ry-1.)/2.*(1.-rz*rz);
    d[22] =(1.-rx*rx)*ry*(ry-1.)/2.*(1.-rz*rz);
    d[14] = rx*(1.+rx)/2.*ry*(ry-1.)/2.*(1.-rz*rz);
    d[25] = rx*(rx-1.)/2.*(1.-ry*ry)*(1.-rz*rz);
    d[27] = (1.-rx*rx)*(1.-ry*ry)*(1.-rz*rz);
    d[23] = rx*(1.+rx)/2.*(1.-ry*ry)*(1.-rz*rz);
    d[16] = rx*(rx-1.)/2.*ry*(1.+ry)/2.*(1.-rz*rz);
    d[24] = (1.-rx*rx)*ry*(1.+ry)/2.*(+1.-rz*rz);
    d[15] = rx*(1.+rx)/2.*ry*(1.+ry)/2.*(1.-rz*rz);
    d[5] = rx*(rx-1.)/2.*ry*(ry-1.)/2.*rz*(1.+rz)/2. ;
    d[17] = (1.-rx*rx)*ry*(ry-1.)/2.*rz*(1.+rz)/2. ;
    d[6] = rx*(1.+rx)/2.*ry*(ry-1.)/2.*rz*(1.+rz)/2. ;
    d[20] = rx*(rx-1.)/2.*(1.-ry*ry)*rz*(1.+rz)/2. ;
    d[26] = (1.-rx*rx)*(1.-ry*ry)*rz*(1.+rz)/2. ;
    d[18] = rx*(1.+rx)/2.*(1.-ry*ry)*rz*(1.+rz)/2. ;
    d[8] = rx*(rx-1.)/2.*ry*(1.+ry)/2.*rz*(1.+rz)/2. ;
    d[19] = (1.-rx*rx)*ry*(1.+ry)/2.*rz*(+1.+rz)/2. ;
    d[7] = rx*(1.+rx)/2.*ry*(1.+ry)/2.*rz*(1.+rz)/2. ;
    return;
}

void shap_fl3(double *refc,double *d)
{
    double rx;
    rx=refc[1];
    d[1] =rx*(rx-1.)/2. ;
    d[2] =1.-rx*rx ;
    d[3] =rx*(1.+rx)/2. ;
    return;
}

void shap_fl2(double *refc,double *d)
{
    double rx;
    rx=refc[1];
    d[1]= (1.-rx)/2. ;
    d[2]= (1.+rx)/2. ;
    return;
}
