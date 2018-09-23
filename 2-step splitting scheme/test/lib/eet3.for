      subroutine eet3(coorr,coefr,
     & prmt,estif,emass,edamp,eload,num)
c .... coorr ---- nodal coordinate value
c .... coefr ---- nodal coef value
      implicit real*8 (a-h,o-z)
      dimension estif(9,9),elump(9),emass(9),
     & eload(9)
      dimension prmt(*),coef(2),coefr(3,2),coorr(2,3),coor(2)
      common /reet3/rsxx(3,9),rsyy(3,9),rsxy(3,9),
     & csxx(3,3),csyy(3,3),csxy(3,3)
c .... store shape functions and their partial derivatives
c .... for all integral points
      common /veet3/rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      common /deet3/ refc(2,3),gaus(3),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(3),kdord(3),kvord(9,3)
c .... nnode ---- the number of nodes
c .... nrefc ---- the number of numerical integral points
c .... ndisp ---- the number of unknown functions
c .... nrefc ---- the number of reference coordinates
c .... nvar ---- the number of unknown varibles var
c .... refc ---- reference coordinates at integral points
c .... gaus ---- weight number at integral points
c .... nvard ---- the number of var for each unknown
c .... kdord ---- the highest differential order for each unknown
c .... kvord ---- var number at integral points for each unknown
      eg=prmt(1)
      rous=prmt(2)
      rouf=prmt(3)
      gx=prmt(4)
      gy=prmt(5)
      gz=prmt(6)	  


      if (num.eq.1) call eet3i
c .... initialize the basic data
      do 10 i=1,nvar
      emass(i)=0.0
      eload(i)=0.0
      do 10 j=1,nvar
      estif(i,j)=0.0
10    continue
      do 999 igaus=1,ngaus
      call eet3t(nnode,nrefc,ncoor,refc(1,igaus),coor,coorr,
     & rctr,crtr,det,coefr)
c .... coordinate transfer from reference to original system
c .... rctr ---- Jacobi's matrix
c .... crtr ---- inverse matrix of Jacobi's matrix
      x=coor(1)
      y=coor(2)
      rx=refc(1,igaus)
      ry=refc(2,igaus)
      call eeet3(refc(1,igaus),coef,coorr,coefr,coefd)
c .... compute coef functions and their partial derivatives
      isxx=(igaus-1)*3+1
      isyy=(igaus-1)*3+1
      isxy=(igaus-1)*3+1
      if (num.gt.1) goto 2
c .... the following is the shape function caculation
      call eet31(refc(1,igaus),rsxx(1,isxx),rctr,crtr)
      call eet32(refc(1,igaus),rsyy(1,isyy),rctr,crtr)
      call eet33(refc(1,igaus),rsxy(1,isxy),rctr,crtr)
2     continue
c .... the following is the shape function transformation
c .... from reference coordinates to original coordinates
      call shapn(nrefc,ncoor,3,rsxx(1,isxx),csxx,crtr,1,3,3)
      call shapn(nrefc,ncoor,3,rsyy(1,isyy),csyy,crtr,1,3,3)
      call shapn(nrefc,ncoor,3,rsxy(1,isxy),csxy,crtr,1,3,3)
c .... the coef function transformation
c .... from reference coordinates to original coordinates
      call shapc(nrefc,ncoor,2,coefd,coefc,crtr,2,5,5)
      un=coef(1)
      vn=coef(2)
      weigh=det*gaus(igaus)
      fxx = +coefc(1,1)
      fxy = +coefc(1,2)
      fyx = +coefc(2,1)
      fyy = +coefc(2,2)
      enxx = +fxx*fxx+fxy*fxy
      enxy = +fxx*fyx+fxy*fyy
      enyx = +fyx*fxx+fyy*fxy
      enyy = +fyx*fyx+fyy*fyy
      enxx = +enxx-1
      enyy = +enyy-1
      snxx = +enxx*eg
      snxy = +enxy*eg
      snyx = +enyx*eg
      snyy = +enyy*eg
      if((num.eq.1).and.(igaus.eq.1)) then
        open(97,file='gpstr',form='formatted')
      endif
      write(97,*) snxx,snyy,snxy
      if((num.eq.nelem).and.(igaus.eq.ngaus)) then
        close(97)
      endif
c .... the following is the stiffness computation

c .... the following is the mass matrix computation
      stif=1.0
      elump(1)=stif*weigh
      stif=1.0
      elump(4)=stif*weigh
      stif=1.0
      elump(7)=stif*weigh
      stif=1.0
      elump(2)=stif*weigh
      stif=1.0
      elump(5)=stif*weigh
      stif=1.0
      elump(8)=stif*weigh
      stif=1.0
      elump(3)=stif*weigh
      stif=1.0
      elump(6)=stif*weigh
      stif=1.0
      elump(9)=stif*weigh
      do 301 i=1,nvard(1)
      iv = kvord(i,1)
      emass(iv)=emass(iv)+elump(iv)*csxx(i,1)
301   continue
      do 302 i=1,nvard(2)
      iv = kvord(i,2)
      emass(iv)=emass(iv)+elump(iv)*csyy(i,1)
302   continue
      do 303 i=1,nvard(3)
      iv = kvord(i,3)
      emass(iv)=emass(iv)+elump(iv)*csxy(i,1)
303   continue
c .... the following is the load vector computation
      do 501 i=1,3
      iv=kvord(i,1)
      stif=+csxx(i,1)*snxx
      eload(iv)=eload(iv)+stif*weigh
501   continue
      do 502 i=1,3
      iv=kvord(i,2)
      stif=+csyy(i,1)*snyy
      eload(iv)=eload(iv)+stif*weigh
502   continue
      do 503 i=1,3
      iv=kvord(i,3)
      stif=+csxy(i,1)*snxy
      eload(iv)=eload(iv)+stif*weigh
503   continue
999   continue
998   continue
      return
      end

      subroutine eet3i
      implicit real*8 (a-h,o-z)
      common /deet3/ refc(2,3),gaus(3),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(3),kdord(3),kvord(9,3)
c .... initial data
c .... refc ---- reference coordinates at integral points
c .... gaus ---- weight number at integral points
c .... nvard ---- the number of var for each unknown
c .... kdord ---- the highest differential order for each unknown
c .... kvord ---- var number at integral points for each unknown
      ngaus=  3
      ndisp=  3
      nrefc=  2
      ncoor=  2
      nvar =  9
      nnode=  3
      kdord(1)=1
      nvard(1)=3
      kvord(1,1)=1
      kvord(2,1)=4
      kvord(3,1)=7
      kdord(2)=1
      nvard(2)=3
      kvord(1,2)=2
      kvord(2,2)=5
      kvord(3,2)=8
      kdord(3)=1
      nvard(3)=3
      kvord(1,3)=3
      kvord(2,3)=6
      kvord(3,3)=9
      refc(1,1)=1.
      refc(2,1)=0.
      gaus(1)=0.1666666
      refc(1,2)=0.
      refc(2,2)=1.
      gaus(2)=0.1666666
      refc(1,3)=0.
      refc(2,3)=0.
      gaus(3)=0.1666666
      end


      subroutine eet3t(nnode,nrefc,ncoor,refc,coor,coorr,
     & rc,cr,det,coefr)
      implicit real*8 (a-h,o-z)
      dimension refc(nrefc),rc(ncoor,nrefc),cr(nrefc,ncoor),a(5,10),
     & coorr(ncoor,nnode),coor(ncoor),coefr(nnode,*)
      call teet3(refc,coor,coorr,coefr,rc)
      n=nrefc
      m=n*2
      det = 1.0
      do 10 i=1,n
      do 10 j=1,n
      if (i.le.ncoor) a(i,j) = rc(i,j)
      if (i.gt.ncoor) a(i,j)=1.0
      a(i,n+j)=0.0
      if (i.eq.j) a(i,n+i) = 1.0
10    continue
c     write(*,*) 'a ='
c     do 21 i=1,n
c21   write(*,8) (a(i,j),j=1,m)
      do 400 i=1,n
      amax = 0.0
      l = 0
      do 50 j=i,n
      c = a(j,i)
      if (c.lt.0.0) c = -c
      if (c.le.amax) goto 50
      amax = c
      l = j
50    continue
      do 60 k=1,m
      c = a(l,k)
      a(l,k) = a(i,k)
      a(i,k) = c
60    continue
      c = a(i,i)
      det = c*det
      do 100 k=i+1,m
100   a(i,k) = a(i,k)/c
      do 300 j=1,n
      if (i.eq.j) goto 300
      do 200 k=i+1,m
200   a(j,k) = a(j,k)-a(i,k)*a(j,i)
c     write(*,*) 'i =',i,'  j =',j,'  a ='
c     do 11 ii=1,n
c11   write(*,8) (a(ii,jj),jj=1,m)
300   continue
400   continue
      do 500 i=1,nrefc
      do 500 j=1,ncoor
500   cr(i,j) = a(i,n+j)
c     write(*,*) 'a ='
c     do 22 i=1,n
c22   write(*,8) (a(i,j),j=1,m)
c     write(*,*) 'rc ='
c     do 24 i=1,ncoor
c24   write(*,8) (rc(i,j),j=1,nrefc)
c     write(*,*) 'cr ='
c     do 23 i=1,nrefc
c23   write(*,8) (cr(i,j),j=1,ncoor)
c     write(*,*) 'det =',det
      if (det.lt.0.0) det=-det
c     write(*,*) 'det =',det
8     format(1x,6f12.3)
      end

      subroutine eet31(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(3,3),rctr(2,2),crtr(2,2)
      external feet31
      rx=refc(1)
      ry=refc(2)
      call dshap(feet31,refc,shpr,2,3,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feet31(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /cceet3/ xa(3),ya(3),una(3),vna(3)
      common /veet3/ rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3) n
1     feet31=+rx 
      goto 1000
2     feet31=+ry 
      goto 1000
3     feet31=+(+1.-rx-ry) 
      goto 1000
1000  return
      end

      subroutine eet32(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(3,3),rctr(2,2),crtr(2,2)
      external feet32
      rx=refc(1)
      ry=refc(2)
      call dshap(feet32,refc,shpr,2,3,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feet32(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /cceet3/ xa(3),ya(3),una(3),vna(3)
      common /veet3/ rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3) n
1     feet32=+rx 
      goto 1000
2     feet32=+ry 
      goto 1000
3     feet32=+(+1.-rx-ry) 
      goto 1000
1000  return
      end

      subroutine eet33(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(3,3),rctr(2,2),crtr(2,2)
      external feet33
      rx=refc(1)
      ry=refc(2)
      call dshap(feet33,refc,shpr,2,3,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feet33(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /cceet3/ xa(3),ya(3),una(3),vna(3)
      common /veet3/ rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3) n
1     feet33=+rx 
      goto 1000
2     feet33=+ry 
      goto 1000
3     feet33=+(+1.-rx-ry) 
      goto 1000
1000  return
      end

      subroutine teet3(refc,coor,coorr,coefr,rc)
c .... compute coordinate value and Jacobi's matrix rc
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(2),coor(2),coorr(2,3),coefr(3,2),rc(2,2)
      common /cceet3/ x(3),y(3),un(3),vn(3)
      external fteet3
      do 100 n=1,3
      x(n)=coorr(1,n)
      y(n)=coorr(2,n)
100   continue
      do 200 n=1,3
      un(n)=coefr(n,1)
      vn(n)=coefr(n,2)
200   continue
      rx=refc(1)
      ry=refc(2)
      call dcoor(fteet3,refc,coor,rc,2,2,1)
c .... coordinate value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fteet3(refc,n)
c .... coordinate transfer function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(2)
      common /cceet3/ x(3),y(3),un(3),vn(3)
      common /veet3/ rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      rx=refc(1)
      ry=refc(2)
      goto (1,2) n
1     fteet3=+(+rx)*x(1)+(+ry)*x(2)+(+(+1.-rx-ry))*x(3)
      goto 1000
2     fteet3=+(+rx)*y(1)+(+ry)*y(2)+(+(+1.-rx-ry))*y(3)
      goto 1000
1000  return
      end

      subroutine eeet3(refc,coef,coorr,coefr,coefd)
c .... compute coef value and their partial derivatives
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(2),coef(2),coorr(2,3),coefr(3,2),coefd(2,2)
      external feeet3
      rx=refc(1)
      ry=refc(2)
      call dcoef(feeet3,refc,coef,coefd,2,2,2)
c .... coef value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feeet3(refc,n)
c .... coef function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(2)
      common /cceet3/ xa(3),ya(3),un(3),vn(3)
      common /veet3/ rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2) n
1     feeet3=+(+rx)*un(1)+(+ry)*un(2)+(+(+1.-rx-ry))*un(3)
      goto 1000
2     feeet3=+(+rx)*vn(1)+(+ry)*vn(2)+(+(+1.-rx-ry))*vn(3)
      goto 1000
1000  return
      end