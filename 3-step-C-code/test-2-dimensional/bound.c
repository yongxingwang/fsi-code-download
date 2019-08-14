/*
This file is used to define boundary conditions,
which can time related or cordinates (x,y)/(x,y,z) related.

In the case of 2 dimensions, kcoor=2,
here we are specifying the values of veloicty u(i=1) v(i=2) and pressure p(i=3)
at time t and node/point (x,y)=(r[0],r[1]).

In the case of 3 dimensions, kcoor=3, i=1, 2, 3, 4,
and (x,y,z)=(r[0],r[1],r[2])

 
Notice that this function is only called when the current
'degree of freedom is labelled as "-1" (i.e. constrained) in file id.for.
*/

/*
NOTE: 
If the boundary condition does not depend on time t,
you may want to comment fuction bftbound() in bft.c,
or bound() will be called in every time step, which is not necessary.  
*/
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <math.h>
double bound(t,r,i)
int i;
double t,r[3]; 
{
	int top;
	double bd=0.0, y;
	double const ep=1.e-4;
	
	y=r[1];

	top = (i==1 && fabs(y-1.0)<ep);
	if(top) bd=1.0;

	return bd;
}


	  