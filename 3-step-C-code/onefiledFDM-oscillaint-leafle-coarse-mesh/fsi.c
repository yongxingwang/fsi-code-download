#include "fsi.h"
#include <time.h>
int gidpre(void);
int gidpre1(void);
int gidmsh(struct coordinates,struct element);
int gidmsh1(struct coordinates,struct element);
int gidres(struct coordinates);
int gidres1(struct coordinates);
int vtkres(struct coordinates,struct element);
int vtkres1(struct coordinates,struct element);

void starta(struct coordinates,int,int *,struct element, struct matrice *, double **);
void startb(struct coordinates,int,int *,struct element, struct matrice *, struct matrice);
void startc(struct coordinates,int,int *,struct element, struct matrice *, double **);
void startf(struct coordinates,int,int *,struct element, struct matrice *, double **);

void efsid(struct coordinates,int,int *,double *,struct element,struct matrice,double *);

void bft(void);
void restart(void);

void efsib(struct coordinates,int,int *,double *,struct element,struct matrice,double *);
void ufsib(struct coordinates,int,int *,double *,double *);

void efsif(struct coordinates,int,int *,double *,struct element,struct matrice,double *);

void efsia0(struct coordinates,int,int *,double *,struct element,struct matrice,double *);
void efsia(struct coordinates,int,int *,double *,struct element,struct matrice,double *);
void ufsia(struct coordinates,int,int *,double *,double *);

void efsic0(struct coordinates,int,int *,double *,struct element,struct matrice,double *);
void efsic(struct coordinates,int,int *,double *,struct element,struct matrice,double *);
void ufsic(struct coordinates,int,int *,double *,double *);

void efsie(struct coordinates,int,struct element);

void upcoor(struct coordinates,double *,double *,int);

void cholesky(struct matrice);

void pminres(struct matrice,double *, double *, int*, int);
void pcg(struct matrice,double *);
void pcg_solid(struct matrice,double *,struct matrice,double *,struct ddmatrice, int *, double *, int);

void getjd(struct ddmatrice *, struct element, struct coordinates,struct coordinates);
void ddtv(struct ddmatrice,double *,double *,int);

int main ()
{
    FILE *fp ;
    clock_t start_time, end_time;
    double cpu_time;
    int i,nf,np;

    start_time = clock();

    printf("%s\n","gidpre()...");
    gidpre();

    printf("%s\n","gidpre1()...");
    gidpre1();

    printf("%s\n","gidmsh()...");
    gidmsh(coor0,elem0);

    printf("%s\n","gidmsh1()...");
    gidmsh1(coor1,elem1);

    printf("%s\n","starta()...");
    starta(coor0,dofa,ida,elem0,&matrixa,&fa);

    printf("%s\n","startb()...");
    startb(coor0,dofa,ida,elem0,&matrixb,matrixa);

    printf("%s\n","startc()...");
    startc(coor0,dofc,idc,elem0,&matrixc,&fc);

    printf("%s\n","startf()...");
    startf(coor1,doff,idf,elem1,&matrixf,&ff);

    printf("%s\n","preconditioner for pressure step:");
    printf("%s\n","efsid()...matrixc assembly");
    efsid(coor0,dofc,idc,ubfc,elem0,matrixc,fc);
    for (i=1; i<=matrixc.maxa; ++i) (matrixc.p)[i]=(matrixc.a)[i];

    printf("%s\n","cholesky(matrixc)...");
    cholesky(matrixc);

    printf("%s\n","efsia0()...preconditioner for diffusoin step:");
    printf("%s\n","efsia0()...matrixa assembly");
    efsia0(coor0,dofa,ida,ubfa,elem0,matrixa,fa);
    for (i=1; i<=matrixa.maxa; ++i) (matrixa.p)[i]=(matrixa.a)[i];

    printf("%s\n","cholesky(matrixa)...");
    cholesky(matrixa);

    printf("%s\n","Allocate memory for ddjd (interpolation)...");
    nf=coor1.knode;
    np=elem0.nnode[1]-1;
    ddjd.jd = (int *) calloc(np*nf,sizeof(int));
    ddjd.dd = (double *) calloc(np*nf,sizeof(double));
    printf("%s,%d,%d\n","ddjd: nf,nnode=",nf,np);

    printf("%s\n","efsic0()...only assemble once");
    efsic0(coor0,dofc,idc,ubfc,elem0,matrixc,fc);
	
	
	
timeloop:
    printf("\n%s\n","bft()...");
    bft();

    printf("\n%s\n","compute ddjd...");
    getjd(&ddjd,elem0,coor0,coor1);

    printf("\n%s\n","convection step...");
    efsib(coor0,dofa,ida,ubfa,elem0,matrixb,fa);
    for (i=1; i<=matrixb.maxa; ++i) (matrixb.p)[i]=(matrixb.a)[i];
    cholesky(matrixb);
    pcg(matrixb,fa);
    ufsib(coor0,dofa,ida,ubfa,fa);

    printf("\n%s\n","solid assembly...");
    efsif(coor1,doff,idf,ubff,elem1,matrixf,ff);

    printf("\n%s\n","diffusion step...");
    efsia(coor0,dofa,ida,ubfa,elem0,matrixa,fa);
    pcg_solid(matrixa,fa,matrixf,ff,ddjd,ida,unodc,dofa);
    ufsia(coor0,dofa,ida,ubfa,fa);


    printf("\n%s\n","pressure step...");
    efsic(coor0,dofc,idc,ubfc,elem0,matrixc,fc);
    pminres(matrixc,fc,unodc,idc,dofc);
    ufsic(coor0,dofc,idc,ubfc,fc);

    printf("\n%s\n","interpolation...");
    ddtv(ddjd,unodc,unodf,doff);

    printf("\n%s\n","update coor1...");
    upcoor(coor1,unods,unodf,doff);

    printf("\n%s\n","stress...");
    efsie(coor1_bak,dofe,elem1);

    printf("\n%s\n","print result...");
    gidres(coor0);
    gidres1(coor1);
	vtkres(coor0,elem0);
	vtkres1(coor1,elem1);

//	scanf("%d",&stop);
	
    if (stop==0) goto timeloop;
	
    end_time = clock();
    cpu_time = ((double) (end_time - start_time)) / CLOCKS_PER_SEC / 60.;
    printf("%f seconds are used \n", cpu_time);	
	
}
