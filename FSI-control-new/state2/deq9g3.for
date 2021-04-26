      subroutine deq9g3(coorr,coefr,
     & prmt,estif,emass,edamp,eload,num)
c .... coorr ---- nodal coordinate value
c .... coefr ---- nodal coef value
      implicit real*8 (a-h,o-z)
      dimension estif(18,18),elump(18),emass(18),
     & eload(18)
      dimension prmt(*),coef(2),coefr(9,2),coorr(2,9),coor(2)
      common /rdeq9g3/ru(9,27),rv(9,27),
     & cu(9,3),cv(9,3)
c .... store shape functions and their partial derivatives
c .... for all integral points
      common /vdeq9g3/rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      common /ddeq9g3/ refc(2,9),gaus(9),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(2),kdord(2),kvord(18,2)
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
      data=prmt(1)
      time=prmt(2)
      dt=prmt(3)
      imate=prmt(4)+0.5
      ielem=prmt(5)+0.5
      nelem=prmt(6)+0.5
      it=prmt(7)+0.5
      nmate=prmt(8)+0.5
      itime=prmt(9)+0.5
      ityp=prmt(10)+0.5
      if (num.eq.1) call deq9g3i
c .... initialize the basic data
      do 10 i=1,nvar
      emass(i)=0.0
      eload(i)=0.0
      do 10 j=1,nvar
      estif(i,j)=0.0
10    continue
      do 999 igaus=1,ngaus
      call deq9g3t(nnode,nrefc,ncoor,refc(1,igaus),coor,coorr,
     & rctr,crtr,det,coefr)
c .... coordinate transfer from reference to original system
c .... rctr ---- Jacobi's matrix
c .... crtr ---- inverse matrix of Jacobi's matrix
      x=coor(1)
      y=coor(2)
      rx=refc(1,igaus)
      ry=refc(2,igaus)
      call edeq9g3(refc(1,igaus),coef,coorr,coefr,coefd)
c .... compute coef functions and their partial derivatives
      iu=(igaus-1)*3+1
      iv=(igaus-1)*3+1
      if (num.gt.1) goto 2
c .... the following is the shape function caculation
      call deq9g31(refc(1,igaus),ru(1,iu),rctr,crtr)
      call deq9g32(refc(1,igaus),rv(1,iv),rctr,crtr)
2     continue
c .... the following is the shape function transformation
c .... from reference coordinates to original coordinates
      call shapn(nrefc,ncoor,9,ru(1,iu),cu,crtr,1,3,3)
      call shapn(nrefc,ncoor,9,rv(1,iv),cv,crtr,1,3,3)
c .... the coef function transformation
c .... from reference coordinates to original coordinates
      call shapc(nrefc,ncoor,2,coefd,coefc,crtr,2,5,5)
      un=coef(1)
      vn=coef(2)
      weigh=det*gaus(igaus)
c .... the following is the stiffness computation
      do 202 i=1,9
      iv=kvord(i,1)
      do 201 j=1,9
      jv=kvord(j,1)
      stif=+cu(i,1)*cu(j,1)*0.d0
      estif(iv,jv)=estif(iv,jv)+stif*weigh
201    continue
202    continue
c .... the following is the mass matrix computation
      stif=1.d0
      elump(1)=stif*weigh
      stif=1.d0
      elump(3)=stif*weigh
      stif=1.d0
      elump(5)=stif*weigh
      stif=1.d0
      elump(7)=stif*weigh
      stif=1.d0
      elump(9)=stif*weigh
      stif=1.d0
      elump(11)=stif*weigh
      stif=1.d0
      elump(13)=stif*weigh
      stif=1.d0
      elump(15)=stif*weigh
      stif=1.d0
      elump(17)=stif*weigh
      stif=1.d0
      elump(2)=stif*weigh
      stif=1.d0
      elump(4)=stif*weigh
      stif=1.d0
      elump(6)=stif*weigh
      stif=1.d0
      elump(8)=stif*weigh
      stif=1.d0
      elump(10)=stif*weigh
      stif=1.d0
      elump(12)=stif*weigh
      stif=1.d0
      elump(14)=stif*weigh
      stif=1.d0
      elump(16)=stif*weigh
      stif=1.d0
      elump(18)=stif*weigh
      do 301 i=1,nvard(1)
      iv = kvord(i,1)
      emass(iv)=emass(iv)+elump(iv)*cu(i,1)
301   continue
      do 302 i=1,nvard(2)
      iv = kvord(i,2)
      emass(iv)=emass(iv)+elump(iv)*cv(i,1)
302   continue
c .... the following is the load vector computation
      do 501 i=1,9
      iv=kvord(i,1)
      stif=+cu(i,1)*0.d0
      eload(iv)=eload(iv)+stif*weigh
501   continue
999   continue
998   continue
      return
      end

      subroutine deq9g3i
      implicit real*8 (a-h,o-z)
      common /ddeq9g3/ refc(2,9),gaus(9),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(2),kdord(2),kvord(18,2)
c .... initial data
c .... refc ---- reference coordinates at integral points
c .... gaus ---- weight number at integral points
c .... nvard ---- the number of var for each unknown
c .... kdord ---- the highest differential order for each unknown
c .... kvord ---- var number at integral points for each unknown
      ngaus=  9
      ndisp=  2
      nrefc=  2
      ncoor=  2
      nvar = 18
      nnode=  9
      kdord(1)=1
      nvard(1)=9
      kvord(1,1)=1
      kvord(2,1)=9
      kvord(3,1)=3
      kvord(4,1)=15
      kvord(5,1)=17
      kvord(6,1)=11
      kvord(7,1)=7
      kvord(8,1)=13
      kvord(9,1)=5
      kdord(2)=1
      nvard(2)=9
      kvord(1,2)=2
      kvord(2,2)=10
      kvord(3,2)=4
      kvord(4,2)=16
      kvord(5,2)=18
      kvord(6,2)=12
      kvord(7,2)=8
      kvord(8,2)=14
      kvord(9,2)=6
      refc(1,1)=7.745966692e-001
      refc(2,1)=7.745966692e-001
      gaus(1)=3.086419753e-001
      refc(1,2)=7.745966692e-001
      refc(2,2)=0.000000000e+000
      gaus(2)=4.938271605e-001
      refc(1,3)=7.745966692e-001
      refc(2,3)=-7.745966692e-001
      gaus(3)=3.086419753e-001
      refc(1,4)=0.000000000e+000
      refc(2,4)=7.745966692e-001
      gaus(4)=4.938271605e-001
      refc(1,5)=0.000000000e+000
      refc(2,5)=0.000000000e+000
      gaus(5)=7.901234568e-001
      refc(1,6)=0.000000000e+000
      refc(2,6)=-7.745966692e-001
      gaus(6)=4.938271605e-001
      refc(1,7)=-7.745966692e-001
      refc(2,7)=7.745966692e-001
      gaus(7)=3.086419753e-001
      refc(1,8)=-7.745966692e-001
      refc(2,8)=0.000000000e+000
      gaus(8)=4.938271605e-001
      refc(1,9)=-7.745966692e-001
      refc(2,9)=-7.745966692e-001
      gaus(9)=3.086419753e-001
      end


      subroutine deq9g3t(nnode,nrefc,ncoor,refc,coor,coorr,
     & rc,cr,det,coefr)
      implicit real*8 (a-h,o-z)
      dimension refc(nrefc),rc(ncoor,nrefc),cr(nrefc,ncoor),a(5,10),
     & coorr(ncoor,nnode),coor(ncoor),coefr(nnode,*)
      call tdeq9g3(refc,coor,coorr,coefr,rc)
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

      subroutine deq9g31(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(9,3),rctr(2,2),crtr(2,2)
      external fdeq9g31
      rx=refc(1)
      ry=refc(2)
      call dshap(fdeq9g31,refc,shpr,2,9,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fdeq9g31(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccdeq9g3/ xa(9),ya(9),una(9),vna(9)
      common /vdeq9g3/ rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3,4,5,6,7,8,9) n
1     fdeq9g31=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2. 
      goto 1000
2     fdeq9g31=+(+1.-rx**2)*ry*(+ry-1.)/2. 
      goto 1000
3     fdeq9g31=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2. 
      goto 1000
4     fdeq9g31=+rx*(+rx-1.)/2.*(+1.-ry**2) 
      goto 1000
5     fdeq9g31=+(+1.-rx**2)*(+1.-ry**2) 
      goto 1000
6     fdeq9g31=+rx*(+1.+rx)/2.*(+1.-ry**2) 
      goto 1000
7     fdeq9g31=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2. 
      goto 1000
8     fdeq9g31=+(+1.-rx**2)*ry*(+1.+ry)/2. 
      goto 1000
9     fdeq9g31=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2. 
      goto 1000
1000  return
      end

      subroutine deq9g32(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(9,3),rctr(2,2),crtr(2,2)
      external fdeq9g32
      rx=refc(1)
      ry=refc(2)
      call dshap(fdeq9g32,refc,shpr,2,9,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fdeq9g32(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccdeq9g3/ xa(9),ya(9),una(9),vna(9)
      common /vdeq9g3/ rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3,4,5,6,7,8,9) n
1     fdeq9g32=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2. 
      goto 1000
2     fdeq9g32=+(+1.-rx**2)*ry*(+ry-1.)/2. 
      goto 1000
3     fdeq9g32=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2. 
      goto 1000
4     fdeq9g32=+rx*(+rx-1.)/2.*(+1.-ry**2) 
      goto 1000
5     fdeq9g32=+(+1.-rx**2)*(+1.-ry**2) 
      goto 1000
6     fdeq9g32=+rx*(+1.+rx)/2.*(+1.-ry**2) 
      goto 1000
7     fdeq9g32=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2. 
      goto 1000
8     fdeq9g32=+(+1.-rx**2)*ry*(+1.+ry)/2. 
      goto 1000
9     fdeq9g32=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2. 
      goto 1000
1000  return
      end

      subroutine tdeq9g3(refc,coor,coorr,coefr,rc)
c .... compute coordinate value and Jacobi's matrix rc
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(2),coor(2),coorr(2,9),coefr(9,2),rc(2,2)
      common /ccdeq9g3/ x(9),y(9),un(9),vn(9)
      external ftdeq9g3
      do 100 n=1,9
      x(n)=coorr(1,n)
      y(n)=coorr(2,n)
100   continue
      do 200 n=1,9
      un(n)=coefr(n,1)
      vn(n)=coefr(n,2)
200   continue
      rx=refc(1)
      ry=refc(2)
      call dcoor(ftdeq9g3,refc,coor,rc,2,2,1)
c .... coordinate value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function ftdeq9g3(refc,n)
c .... coordinate transfer function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(2)
      common /ccdeq9g3/ x(9),y(9),un(9),vn(9)
      common /vdeq9g3/ rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      rx=refc(1)
      ry=refc(2)
      goto (1,2) n
1     ftdeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*x(1)+(+(+
     & 1.-rx**2)*ry*(+ry-1.)/2.)*x(5)+(+rx*(+1.+rx)/2.*ry*(+
     & ry-1.)/2.)*x(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*x(8)+(+
     & (+1.-rx**2)*(+1.-ry**2))*x(9)+(+rx*(+1.+rx)/2.*(+1.-
     & ry**2))*x(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*x(4)+(+
     & (+1.-rx**2)*ry*(+1.+ry)/2.)*x(7)+(+rx*(+1.+rx)/2.*ry*
     & (+1.+ry)/2.)*x(3)
      goto 1000
2     ftdeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*y(1)+(+(+
     & 1.-rx**2)*ry*(+ry-1.)/2.)*y(5)+(+rx*(+1.+rx)/2.*ry*(+
     & ry-1.)/2.)*y(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*y(8)+(+
     & (+1.-rx**2)*(+1.-ry**2))*y(9)+(+rx*(+1.+rx)/2.*(+1.-
     & ry**2))*y(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*y(4)+(+
     & (+1.-rx**2)*ry*(+1.+ry)/2.)*y(7)+(+rx*(+1.+rx)/2.*ry*
     & (+1.+ry)/2.)*y(3)
      goto 1000
1000  return
      end

      subroutine edeq9g3(refc,coef,coorr,coefr,coefd)
c .... compute coef value and their partial derivatives
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(2),coef(2),coorr(2,9),coefr(9,2),coefd(2,2)
      external fedeq9g3
      rx=refc(1)
      ry=refc(2)
      call dcoef(fedeq9g3,refc,coef,coefd,2,2,2)
c .... coef value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fedeq9g3(refc,n)
c .... coef function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(2)
      common /ccdeq9g3/ xa(9),ya(9),un(9),vn(9)
      common /vdeq9g3/ rctr(2,2),crtr(2,2),coefd(2,5),coefc(2,5)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2) n
1     fedeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*un(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*un(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*un(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*un(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*un(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*un(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*un(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*un(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*un(3)
      goto 1000
2     fedeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*vn(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*vn(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*vn(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*vn(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*vn(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*vn(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*vn(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*vn(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*vn(3)
      goto 1000
1000  return
      end

