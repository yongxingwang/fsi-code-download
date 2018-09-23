c... This file is used to define contraints for u(j=1),v(j=2)and p(j=3) in the case of 2D,
c... for u(j=1),v(j=2),w(j=3) and p(j=4).

c... id=-1 means the current 'degree of freedom' is contrained. 

c... id=1  means free, which is a default if not specified.

      integer*4 function id(kcoor,r,j)
      implicit real*8 (a-h,o-z)
      logical wall,symmetric,point
      dimension r(kcoor)
      id=1
      ep=1.0d-4
      x=r(1)
      y=r(2)

      wall=y.lt.ep .or. x.lt.ep .or. dabs(x-4.d0).lt.ep
      symmetric=dabs(y-1.d0).lt.ep
      point=dabs(y-1.d0).lt.ep .and. dabs(x-4.d0).lt.ep

      if(j.eq.1) then
         if(wall) id=-1
      elseif (j.eq.2) then
         if(wall) id=-1
         if(symmetric) id=-1		 
      else
         if(point) id=-1
      endif

      return
      end
