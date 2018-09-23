c...This file is used to define boundary conditions,
c...which can time related or cordinates (x,y)/(x,y,z) related.

c... In the case of 2 dimensions, kcoor=2,
c... here we are specifying the values of veloicty u(j=1) v(j=2) and pressure p(j=3)
c... at time t and node/point (x,y)=(r(1),r(2)).

c... In the case of 3 dimensions, kcoor=3, j=1, 2, 3, 4,
c... and (x,y,z)=(r(1),r(2),r(3))

 
c... Notic that this function is only called when the current
c... 'degree of freedom is labelled as "-1" (i.e. constrained) in file id.for.


      real*8 function bound(kcoor,r,t,j)
      implicit real*8 (a-h,o-z)
      dimension r(kcoor)
      bound=0.d0
      if(j.ne.1) goto 10	  
      pi=3.14159265d0
      ep=1.0d-4
      x=r(1)
      y=r(2)
	  
      dd=dabs(x-4.d0)
      if(x.lt.ep .or. dd.lt.ep) then
          bound=1.5d1*y*(2.0d0-y)*dsin(2.0d0*pi*t)
      endif
	  
10    return
      end


	  