c... This file is used to define contraints for u(j=1),v(j=2)and p(j=3) in the case of 2D,
c... for u(j=1),v(j=2),w(j=3) and p(j=4).

c... id=-1 means the current 'degree of freedom' is contrained. 

c... id=1  means free, which is a default if not specified.

      integer*4 function id(kcoor,r,j)
      implicit real*8 (a-h,o-z)
      logical wall,symmetric,slip,point
      dimension r(kcoor)
      id=1
      ep=1.0d-4
      x=r(1)
      y=r(2)
      z=r(3)

      wall=z.lt.ep .or. x.lt.ep .or. dabs(x-3.d0).lt.ep
      symmetric=dabs(z-1.d0).lt.ep
      slip=y.lt.ep .or. dabs(y-5.d-1).lt.ep	  
      point=x.lt.ep .and. y.lt.ep .and. z.lt.ep

      if(j.eq.1) then
         if(wall) id=-1	 
      elseif (j.eq.2) then
         if(wall) id=-1
         if(slip) id=-1
      elseif (j.eq.3) then
         if(wall) id=-1	 
         if(symmetric) id=-1
      else
         if(point) id=-1
      endif

      return
      end
