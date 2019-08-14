#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <math.h>
#define maxtype 10
#define maxnode 100000000
#define maxt 100000000
#define endl '\n'
//#define time time_now
struct coordinates
{
    int dim,knode;
    double *coor;
};
struct matrice
{
    int neq,maxa,*numcol,*na,*jdiag;
    double *a,*p;
};
struct element
{
    int ntype,nelem[maxtype],nmate[maxtype],nnode[maxtype],nprmt[maxtype];
    int *node;
    double *mate;
};
struct ddmatrice
{
    int nr,nc,*jd;
    double *dd;
};
int nbdetype,end,stop,it,itn,nstep,itnmax,imate,nmate,nprmt,nelem,ityp,inod,idof;
double tolerance,dampalfa,dampbeta;
double dt,time_now,tmax;
struct coordinates coor0, coor1, coor1_bak;

int dofa,dofb,dofc,dofd,dofe,doff,dim;
int *ida,*idc,*idf;
double *unodc,*unode,*unodf;
double *ubfa,*ubfc,*ubff;
double *fa,*fc,*ff;
double *esa,*ema,*esc,*emc,*esb;
struct element elem0,elem1;
struct matrice matrixa,matrixb,matrixc,matrixf;

struct ddmatrice ddjd;
double *gstr,*unods;
int *node_jd, nelm_jd;
