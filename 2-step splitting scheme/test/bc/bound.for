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
      bound=0.0d0
      ep=1.0d-4

      if(j.eq.1 .and. dabs(r(2)-1.0d0).lt.ep) bound=1.0d0
	  
      return
      end


	  