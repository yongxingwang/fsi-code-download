#include "fsi.h"
void interppressure(double*,double*,int*,int,int,int);
int vtkres(coor0,elem)
struct coordinates coor0;
struct element elem;
{
    FILE *fp;
    int i,j,dim,knode,ik;
    int *node,*nnode,*nelem;
    double *coor;
    char fnm[100];
    knode = coor0.knode;
    dim = coor0.dim;
    coor = coor0.coor;
    node = elem.node;
    nnode = elem.nnode;
    nelem = elem.nelem;

    int cell_type = 28; // 28 is the cell type VTK_BIQUADRATIC_QUAD, see documentation
/*
enum  	VTKCellType {
  VTK_EMPTY_CELL = 0, VTK_VERTEX = 1, VTK_POLY_VERTEX = 2, VTK_LINE = 3,
  VTK_POLY_LINE = 4, VTK_TRIANGLE = 5, VTK_TRIANGLE_STRIP = 6, VTK_POLYGON = 7,
  VTK_PIXEL = 8, VTK_QUAD = 9, VTK_TETRA = 10, VTK_VOXEL = 11,
  VTK_HEXAHEDRON = 12, VTK_WEDGE = 13, VTK_PYRAMID = 14, VTK_PENTAGONAL_PRISM = 15,
  VTK_HEXAGONAL_PRISM = 16, VTK_QUADRATIC_EDGE = 21, VTK_QUADRATIC_TRIANGLE = 22, VTK_QUADRATIC_QUAD = 23,
  VTK_QUADRATIC_POLYGON = 36, VTK_QUADRATIC_TETRA = 24, VTK_QUADRATIC_HEXAHEDRON = 25, VTK_QUADRATIC_WEDGE = 26,
  VTK_QUADRATIC_PYRAMID = 27, VTK_BIQUADRATIC_QUAD = 28, VTK_TRIQUADRATIC_HEXAHEDRON = 29, VTK_QUADRATIC_LINEAR_QUAD = 30,
  VTK_QUADRATIC_LINEAR_WEDGE = 31, VTK_BIQUADRATIC_QUADRATIC_WEDGE = 32, VTK_BIQUADRATIC_QUADRATIC_HEXAHEDRON = 33, VTK_BIQUADRATIC_TRIANGLE = 34,
  VTK_CUBIC_LINE = 35, VTK_CONVEX_POINT_SET = 41, VTK_POLYHEDRON = 42, VTK_PARAMETRIC_CURVE = 51,
  VTK_PARAMETRIC_SURFACE = 52, VTK_PARAMETRIC_TRI_SURFACE = 53, VTK_PARAMETRIC_QUAD_SURFACE = 54, VTK_PARAMETRIC_TETRA_REGION = 55,
  VTK_PARAMETRIC_HEX_REGION = 56, VTK_HIGHER_ORDER_EDGE = 60, VTK_HIGHER_ORDER_TRIANGLE = 61, VTK_HIGHER_ORDER_QUAD = 62,
  VTK_HIGHER_ORDER_POLYGON = 63, VTK_HIGHER_ORDER_TETRAHEDRON = 64, VTK_HIGHER_ORDER_WEDGE = 65, VTK_HIGHER_ORDER_PYRAMID = 66,
  VTK_HIGHER_ORDER_HEXAHEDRON = 67, VTK_NUMBER_OF_CELL_TYPES
}
*/
    int ridx=1; // Some index for the type
    int size = nelem[ridx]*nnode[ridx];

    //printf("iter = %d, nelem = %d, nnode = %d\n",it,nelem[ridx],nnode[ridx]);

    if (it==0) it=1;
    if ((it%nstep)!=0) goto l100;
    ik = it/nstep;

    // New code
    snprintf(fnm,sizeof(fnm),"./%s/fsi.fluid.vtk.%i","output/vtkfluid",ik);

    //fp = fopen(fnm,"w");
    if ((fp = fopen(fnm,"w"))==NULL)
    {
        printf("cat:cannot open %s\n", fnm);
        return  1;
		exit(1);
    }
	


    fprintf(fp,"# vtk DataFile Version 2.0\n");
    fprintf(fp,"VTK example\n");
    fprintf(fp,"ASCII\n");
    fprintf(fp,"DATASET UNSTRUCTURED_GRID\n");

    // Print points
    fprintf(fp,"POINTS %d %s\n",knode,"float");
    for (j=0; j<knode; j++)
    {
        fprintf(fp,"%2.6f %2.6f %2.6f\n",coor[j],coor[j+knode],0.0);
        //fprintf(fp,"%2.6f %2.6f\n",coor[j],coor[j+knode]); // doesn't seem to like 2d
    }
    fprintf(fp,"\n");

    // Print cells
    int n=1;
    fprintf(fp,"CELLS %d  %d\n",nelem[ridx],size);
    for (i=0; i<nelem[ridx]; i++)
    {
        fprintf(fp,"%d",nnode[ridx]-1);
        for (j=0; j<nnode[ridx]-1; j++)
        {
            fprintf(fp," %5d",node[n++]-1);
        }
        fprintf(fp,"\n");
        n++;
    }
    fprintf(fp,"\n");

    // print cell type
    fprintf(fp,"CELL_TYPES %d\n",nelem[ridx]);
    for (i=0; i<nelem[ridx]; i++)
    {
        fprintf(fp,"%d\n",cell_type);
    }
    fprintf(fp,"\n");

    // Print cell data
    fprintf(fp,"CELL_DATA %d\n",nelem[ridx]);

    // print index for each part
    fprintf(fp,"SCALARS %s %s %i\n","section","int",1);
    fprintf(fp,"LOOKUP_TABLE %s\n","mat");
    n=0; // at the end of each row is the index for which part
    for (i=0; i<nelem[ridx]; i++)
    {
        n+=10;
        //fprintf(fp,"%d %d %d %d\n",i,node[i],n,node[n]);
        fprintf(fp,"%d\n",node[n]);
    }
    fprintf(fp,"\n");


    // Print point data
    fprintf(fp,"POINT_DATA %d\n",knode);

    // velocity
    fprintf(fp,"VECTORS %s %s\n","velocity","float");
    for (j=0; j<knode; j++)
    {
        fprintf(fp,"%2.6f %2.6f %2.6f\n",unodc[j],unodc[knode+j],0.0);
    }


    // linear interpolates the pressure, due to Taylor Hood elements
    interppressure(unodc,coor,node,knode,nelem[ridx],nnode[ridx]);

    // pressure
    fprintf(fp,"SCALARS %s %s %i\n","pressure","float",1);
    fprintf(fp,"LOOKUP_TABLE %s\n","p");
    for (j=0; j<knode; j++)
    {
        fprintf(fp,"%2.6f\n",unodc[(2*knode)+j]);
    }
    fprintf(fp,"\n");


    fclose(fp);
	
l100:
    return 0;
}

void interppressure(unod,coor,node,knode,nelem,nnode)
double *unod;
double *coor;
int *node;
int knode,nelem,nnode;
{
    int i,el;
    int zi[5] = {5,6,7,8,9}; // nodes which have zero pressure
    int nzi[5] = {1,2,3,4,1}; // nodes which have non-zero pressure, addition entry for interpolation
    int i0,i1,ii;
    double xi0,xii,xi1,yi0,yii,yi1,pi0,pi1; // probably could replace these
    double d0,d;
    double pi,pc;

    for (el=0; el<nelem; el++)
    {

        pc = 0.0;
        for (i=0; i<4; i++)
        {
            i0 = node[nzi[i]+nnode*el]-1;
            i1 = node[nzi[i+1]+nnode*el]-1;
            ii = node[zi[i]+nnode*el]-1;

            xi0 = coor[i0];
            xii = coor[ii];
            xi1 = coor[i1];
            yi0 = coor[i0+knode];
            yii = coor[ii+knode];
            yi1 = coor[i1+knode];
            pi0 = unod[(2*knode)+i0];
            pi1 = unod[(2*knode)+i1];
            //printf("pi0 = %.6f, pi1 = %.6f\n",pi0,pi1);

            pc = pc + unod[(2*knode)+i0];
            //printf("%.6f + ", unod[(2*knode)+i0]);

            // no need to calculate d1
            d0 = sqrt(pow(xii-xi0,2.0)+pow(yii-yi0,2.0));
            d = sqrt(pow(xi1-xi0,2.0)+pow(yi1-yi0,2.0));

            pi = pi0 + (pi1-pi0)*(d0/d);
            //printf("pi = %.6f\n",pi);
            unod[(2*knode)+ii] = pi;
        }
        // central node, as a numerical average of the non-zero nodes
        ii = node[zi[4]+nnode*el]-1;
        unod[(2*knode)+ii] = pc/4.0;
        //printf(" = %.6f\n",pc/4.0);
    }
}
