/*
this file is used to define contraints for u(i=1),v(i=2)and p(i=3) in the case of 2d,
for u(i=1),v(i=2),w(i=3) and p(i=4).

id=-1 means the current 'degree of freedom' is contrained. 

id=1  means free, which is a default if not specified.
*/
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <math.h>
int idnod(r,i)
int i;
double r[3];
{
	int id=1, wall=0, outlet=0;
	double const ep=1.e-5, r0=0.05, x0=0.2, y0=0.2;
	double x, y, rr;
	
	x=r[0];
	y=r[1];
	  
	if(i != 3){
		rr=sqrt((x-x0)*(x-x0)+(y-y0)*(y-y0));
		wall = fabs(rr-r0)<ep || fabs(y-0.41)<ep || fabs(y)<ep || fabs(x)<ep; 
		if(wall) 
			id=-1;
	}
	else{
		outlet = fabs(x-2.5)<ep;
		if(outlet) id=-1;
	}

	return id;
}
