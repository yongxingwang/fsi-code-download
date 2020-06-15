      subroutine eeq9g3(coorr,coefr,
     & prmt,estif,emass,edamp,eload,num)
c .... coorr ---- nodal coordinate value
c .... coefr ---- nodal coef value
      implicit real*8 (a-h,o-z)
      dimension estif(9,9),elump(9),emass(9),
     & eload(9)
      dimension prmt(*),coef(4),coefr(9,4),coorr(2,9),coor(2)
      common /reeq9g3/ru(9,27),
     & cu(9,3)
c .... store shape functions and their partial derivatives
c .... for all integral points
      common /veeq9g3/rctr(2,2),crtr(2,2),coefd(4,5),coefc(4,5)
      common /deeq9g3/ refc(2,9),gaus(9),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(1),kdord(1),kvord(9,1)
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
      c1=prmt(1)
      rous=prmt(2)
      rouf=prmt(3)
      emuf=prmt(4)
      gx=prmt(5)
      gy=prmt(6)
      time=prmt(7)
      dt=prmt(8)
      imate=prmt(9)+0.5
      ielem=prmt(10)+0.5
      nelem=prmt(11)+0.5
      it=prmt(12)+0.5
      nmate=prmt(13)+0.5
      itime=prmt(14)+0.5
      ityp=prmt(15)+0.5
      if (imate.eq.1) then
      aa1=0.d0
      rou=rouf
      emu=emuf
      c1=0.0d0
      else
      aa1=1.d0
      rou=rous
      emu=c1*dt
      endif

      if (num.eq.1) call eeq9g3i
c .... initialize the basic data
      do 10 i=1,nvar
      emass(i)=0.0
      eload(i)=0.0
      do 10 j=1,nvar
      estif(i,j)=0.0
10    continue
      do 999 igaus=1,ngaus
      call eeq9g3t(nnode,nrefc,ncoor,refc(1,igaus),coor,coorr,
     & rctr,crtr,det,coefr)
c .... coordinate transfer from reference to original system
c .... rctr ---- Jacobi's matrix
c .... crtr ---- inverse matrix of Jacobi's matrix
      x=coor(1)
      y=coor(2)
      rx=refc(1,igaus)
      ry=refc(2,igaus)
      call eeeq9g3(refc(1,igaus),coef,coorr,coefr,coefd)
c .... compute coef functions and their partial derivatives
      iu=(igaus-1)*3+1
      if (num.gt.1) goto 2
c .... the following is the shape function caculation
      call eeq9g31(refc(1,igaus),ru(1,iu),rctr,crtr)
2     continue
c .... the following is the shape function transformation
c .... from reference coordinates to original coordinates
      call shapn(nrefc,ncoor,9,ru(1,iu),cu,crtr,1,3,3)
c .... the coef function transformation
c .... from reference coordinates to original coordinates
      call shapc(nrefc,ncoor,4,coefd,coefc,crtr,2,5,5)
      un=coef(1)
      vn=coef(2)
      uo=coef(3)
      vo=coef(4)
      weigh=det*gaus(igaus)
      uu=+un-uo+vn-vo
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
      elump(2)=stif*weigh
      stif=1.d0
      elump(3)=stif*weigh
      stif=1.d0
      elump(4)=stif*weigh
      stif=1.d0
      elump(5)=stif*weigh
      stif=1.d0
      elump(6)=stif*weigh
      stif=1.d0
      elump(7)=stif*weigh
      stif=1.d0
      elump(8)=stif*weigh
      stif=1.d0
      elump(9)=stif*weigh
      do 301 i=1,nvard(1)
      iv = kvord(i,1)
      emass(iv)=emass(iv)+elump(iv)*cu(i,1)
301   continue
c .... the following is the load vector computation
      do 501 i=1,9
      iv=kvord(i,1)
      stif=+cu(i,1)*uu*rou/dt
      eload(iv)=eload(iv)+stif*weigh
501   continue
999   continue
998   continue
      return
      end

      subroutine eeq9g3i
      implicit real*8 (a-h,o-z)
      common /deeq9g3/ refc(2,9),gaus(9),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(1),kdord(1),kvord(9,1)
c .... initial data
c .... refc ---- reference coordinates at integral points
c .... gaus ---- weight number at integral points
c .... nvard ---- the number of var for each unknown
c .... kdord ---- the highest differential order for each unknown
c .... kvord ---- var number at integral points for each unknown
      ngaus=  9
      ndisp=  1
      nrefc=  2
      ncoor=  2
      nvar =  9
      nnode=  9
      kdord(1)=1
      nvard(1)=9
      kvord(1,1)=1
      kvord(2,1)=5
      kvord(3,1)=2
      kvord(4,1)=8
      kvord(5,1)=9
      kvord(6,1)=6
      kvord(7,1)=4
      kvord(8,1)=7
      kvord(9,1)=3
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


      subroutine eeq9g3t(nnode,nrefc,ncoor,refc,coor,coorr,
     & rc,cr,det,coefr)
      implicit real*8 (a-h,o-z)
      dimension refc(nrefc),rc(ncoor,nrefc),cr(nrefc,ncoor),a(5,10),
     & coorr(ncoor,nnode),coor(ncoor),coefr(nnode,*)
      call teeq9g3(refc,coor,coorr,coefr,rc)
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

      subroutine eeq9g31(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(9,3),rctr(2,2),crtr(2,2)
      external feeq9g31
      rx=refc(1)
      ry=refc(2)
      call dshap(feeq9g31,refc,shpr,2,9,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feeq9g31(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /cceeq9g3/ xa(9),ya(9),una(9),vna(9),
     &uoa(9),voa(9)
      common /veeq9g3/ rctr(2,2),crtr(2,2),coefd(4,5),coefc(4,5)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3,4,5,6,7,8,9) n
1     feeq9g31=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2. 
      goto 1000
2     feeq9g31=+(+1.-rx**2)*ry*(+ry-1.)/2. 
      goto 1000
3     feeq9g31=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2. 
      goto 1000
4     feeq9g31=+rx*(+rx-1.)/2.*(+1.-ry**2) 
      goto 1000
5     feeq9g31=+(+1.-rx**2)*(+1.-ry**2) 
      goto 1000
6     feeq9g31=+rx*(+1.+rx)/2.*(+1.-ry**2) 
      goto 1000
7     feeq9g31=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2. 
      goto 1000
8     feeq9g31=+(+1.-rx**2)*ry*(+1.+ry)/2. 
      goto 1000
9     feeq9g31=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2. 
      goto 1000
1000  return
      end

      subroutine teeq9g3(refc,coor,coorr,coefr,rc)
c .... compute coordinate value and Jacobi's matrix rc
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(2),coor(2),coorr(2,9),coefr(9,4),rc(2,2)
      common /cceeq9g3/ x(9),y(9),un(9),vn(9),uo(9),vo(9)
      external fteeq9g3
      do 100 n=1,9
      x(n)=coorr(1,n)
      y(n)=coorr(2,n)
100   continue
      do 200 n=1,9
      un(n)=coefr(n,1)
      vn(n)=coefr(n,2)
      uo(n)=coefr(n,3)
      vo(n)=coefr(n,4)
200   continue
      rx=refc(1)
      ry=refc(2)
      call dcoor(fteeq9g3,refc,coor,rc,2,2,1)
c .... coordinate value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fteeq9g3(refc,n)
c .... coordinate transfer function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(2)
      common /cceeq9g3/ x(9),y(9),un(9),vn(9),uo(9),vo(9)
      common /veeq9g3/ rctr(2,2),crtr(2,2),coefd(4,5),coefc(4,5)
      rx=refc(1)
      ry=refc(2)
      goto (1,2) n
1     fteeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*x(1)+(+(+
     & 1.-rx**2)*ry*(+ry-1.)/2.)*x(5)+(+rx*(+1.+rx)/2.*ry*(+
     & ry-1.)/2.)*x(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*x(8)+(+
     & (+1.-rx**2)*(+1.-ry**2))*x(9)+(+rx*(+1.+rx)/2.*(+1.-
     & ry**2))*x(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*x(4)+(+
     & (+1.-rx**2)*ry*(+1.+ry)/2.)*x(7)+(+rx*(+1.+rx)/2.*ry*
     & (+1.+ry)/2.)*x(3)
      goto 1000
2     fteeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*y(1)+(+(+
     & 1.-rx**2)*ry*(+ry-1.)/2.)*y(5)+(+rx*(+1.+rx)/2.*ry*(+
     & ry-1.)/2.)*y(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*y(8)+(+
     & (+1.-rx**2)*(+1.-ry**2))*y(9)+(+rx*(+1.+rx)/2.*(+1.-
     & ry**2))*y(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*y(4)+(+
     & (+1.-rx**2)*ry*(+1.+ry)/2.)*y(7)+(+rx*(+1.+rx)/2.*ry*
     & (+1.+ry)/2.)*y(3)
      goto 1000
1000  return
      end

      subroutine eeeq9g3(refc,coef,coorr,coefr,coefd)
c .... compute coef value and their partial derivatives
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(2),coef(4),coorr(2,9),coefr(9,4),coefd(4,2)
      external feeeq9g3
      rx=refc(1)
      ry=refc(2)
      call dcoef(feeeq9g3,refc,coef,coefd,2,4,2)
c .... coef value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feeeq9g3(refc,n)
c .... coef function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(2)
      common /cceeq9g3/ xa(9),ya(9),un(9),vn(9),uo(9),vo(9)
      common /veeq9g3/ rctr(2,2),crtr(2,2),coefd(4,5),coefc(4,5)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3,4) n
1     feeeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*un(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*un(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*un(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*un(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*un(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*un(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*un(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*un(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*un(3)
      goto 1000
2     feeeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*vn(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*vn(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*vn(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*vn(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*vn(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*vn(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*vn(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*vn(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*vn(3)
      goto 1000
3     feeeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*uo(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*uo(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*uo(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*uo(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*uo(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*uo(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*uo(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*uo(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*uo(3)
      goto 1000
4     feeeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*vo(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*vo(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*vo(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*vo(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*vo(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*vo(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*vo(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*vo(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*vo(3)
      goto 1000
1000  return
      end

