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
	int id=1, wall=0, slipwall=0, point=0;
	double const ep=1.e-4;
	double x, y;
	
	x=r[0];
	y=r[1];
	  
	if(i != 3){
		wall=fabs(x-4.)<ep || fabs(x)<ep || fabs(y)<ep; 
		if(wall) id=-1;
	}
	
	
	if(i == 2){
		slipwall=fabs(y-1.0)<ep; 
		if(slipwall) id=-1;
	}
		
	
	
//	else{
//		point=fabs(x-4.)<ep && fabs(y-1.)<ep;
//		if(point) id=-1;
//	}

	return id;
}
