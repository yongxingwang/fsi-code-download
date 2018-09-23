c... This file is used to define initial conditions,
c... for u(j=1), v(j=2) and p(j=3) at node/point (x,y)=(r(1),r(2))
c... in the case of 2 dimension (kcoor=2). For 3 deimensions (kcoor=3):
c... u(j=1), v(j=2), w(j=3) and p(j=3) corresponds to node/point (x,y,z)=(r(1),r(2),r(3))

c... upinitial=0 is a default if not specified in this function.

      real*8 function upinitial(kcoor,r,j)
      implicit real*8 (a-h,o-z)
      dimension r(kcoor)
      upinitial=0.0d0
      return
      end


	  