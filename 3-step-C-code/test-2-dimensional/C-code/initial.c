/*
this file is used to define initial conditions,
for u(i=1), v(i=2) and p(i=3) at node/point (x,y)=(r(1),r(2))
in the case of 2 dimension. 
for 3 deimensions:
u(i=1), v(i=2), w(i=3) and p(i=3) corresponds to node/point (x,y,z)=(r(1),r(2),r(3))

upinitial=0 is a default if not specified in this function.n.
*/
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <math.h>
double initial(r,i)
int i;
double r[3];
{
	double upinitial;
	
	upinitial=0.0;
	
	return upinitial;
}

	  