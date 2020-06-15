
      real*8 function bound(r,t,j)
      implicit real*8 (a-h,o-z)
      dimension r(2)
      bound=t*t+r(1)*r(1)+r(2)*r(2)
c     write(*,*) 'bound =',bound
      return
      end
 
      real*8 function bound1(r,t,j)
      implicit real*8 (a-h,o-z)
      dimension r(2)
      bound1=2.*t
      return
      end
 
      real*8 function bound2(r,t,j)
      implicit real*8 (a-h,o-z)
      dimension r(2)
      bound2=2.
      return
      end
 
