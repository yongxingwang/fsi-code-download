c... This file is used to define contraints for u(j=1),v(j=2)and p(j=3) in the case of 2D,
c... for u(j=1),v(j=2),w(j=3) and p(j=4).

c... id=-1 means the current 'degree of freedom' is contrained. 

c... id=1  means free, which is a default if not specified.

      integer*4 function id(kcoor,r,j)
      implicit real*8 (a-h,o-z)
      logical point,symetric
      dimension r(kcoor)
      id=1
      ep=1.0d-4
      x=r(1)
      y=r(2)
      z=r(3)
	  
      if(j.eq.1) then
         symetric = x.lt.ep .or. dabs(x-5.d-1).lt.ep  
         if(symetric) id=-1
      elseif(j.eq.2) then
         symetric = y.lt.ep .or. dabs(y-5.d-1).lt.ep  
         if(symetric) id=-1
      elseif(j.eq.3) then
         symetric = z.lt.ep .or. dabs(z-3.d-1).lt.ep  
         if(symetric) id=-1
      else
         point=x.lt.ep .and. y.lt.ep .and. z.lt.ep
         if(point) id=-1
      endif

      return
      end
