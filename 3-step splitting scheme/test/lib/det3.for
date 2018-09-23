      subroutine det3(coorr,coefr,
     & prmt,estif,emass,edamp,eload,num)
c .... coorr ---- nodal coordinate value
c .... coefr ---- nodal coef value
      implicit real*8 (a-h,o-z)
      dimension estif(6,6),elump(6),emass(6),
     & eload(6)
      dimension prmt(*),coorr(2,3),coor(2)
      common /rdet3/ru(3,9),rv(3,9),
     & cu(3,3),cv(3,3)
c .... store shape functions and their partial derivatives
c .... for all integral points
      common /vdet3/rctr(2,2),crtr(2,2)
      common /ddet3/ refc(2,3),gaus(3),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(2),kdord(2),kvord(6,2)
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
      time=prmt(7)
      dt=prmt(8)
      imate=prmt(9)+0.5
      ielem=prmt(10)+0.5
      nelem=prmt(11)+0.5
      it=prmt(12)+0.5
      nmate=prmt(13)+0.5
      itime=prmt(14)+0.5
      ityp=prmt(15)+0.5
      rou=rous-rouf
      if (num.eq.1) call det3i
c .... initialize the basic data
      do 10 i=1,nvar
      emass(i)=0.0
      eload(i)=0.0
      do 10 j=1,nvar
      estif(i,j)=0.0
10    continue
      do 999 igaus=1,ngaus
      call det3t(nnode,nrefc,ncoor,refc(1,igaus),coor,coorr,
     & rctr,crtr,det)
c .... coordinate transfer from reference to original system
c .... rctr ---- Jacobi's matrix
c .... crtr ---- inverse matrix of Jacobi's matrix
      x=coor(1)
      y=coor(2)
      rx=refc(1,igaus)
      ry=refc(2,igaus)
      iu=(igaus-1)*3+1
      iv=(igaus-1)*3+1
      if (num.gt.1) goto 2
c .... the following is the shape function caculation
      call det31(refc(1,igaus),ru(1,iu),rctr,crtr)
      call det32(refc(1,igaus),rv(1,iv),rctr,crtr)
2     continue
c .... the following is the shape function transformation
c .... from reference coordinates to original coordinates
      call shapn(nrefc,ncoor,3,ru(1,iu),cu,crtr,1,3,3)
      call shapn(nrefc,ncoor,3,rv(1,iv),cv,crtr,1,3,3)
      weigh=det*gaus(igaus)
      if((num.eq.1).and.(igaus.eq.1)) then
      open(97,file='gpstr',form='formatted')
      endif
      read(97,*) sxx,syy,sxy
      if((num.eq.nelem).and.(igaus.eq.ngaus)) then
      close(97)
      endif
c .... the following is the stiffness computation
      do 202 i=1,3
      iv=kvord(i,1)
      do 201 j=1,3
      jv=kvord(j,1)
      stif=+cu(i,2)*cu(j,2)*sxx*dt
     & +cu(i,2)*cu(j,3)*sxy*dt
     & +cu(i,2)*cu(j,2)*sxx*dt
     & +cu(i,2)*cu(j,3)*sxy*dt
     & +cu(i,3)*cu(j,2)*sxy*dt
     & +cu(i,3)*cu(j,3)*syy*dt
     & +cu(i,2)*cu(j,2)*eg*dt
     & +cu(i,2)*cu(j,2)*eg*dt
     & +cu(i,3)*cu(j,3)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
201    continue
202    continue
      do 204 i=1,3
      iv=kvord(i,1)
      do 203 j=1,3
      jv=kvord(j,2)
      stif=+cu(i,3)*cv(j,2)*sxx*dt
     & +cu(i,3)*cv(j,3)*sxy*dt
     & +cu(i,3)*cv(j,2)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
203    continue
204    continue
      do 206 i=1,3
      iv=kvord(i,2)
      do 205 j=1,3
      jv=kvord(j,1)
      stif=+cv(i,2)*cu(j,2)*sxy*dt
     & +cv(i,2)*cu(j,3)*syy*dt
     & +cv(i,2)*cu(j,3)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
205    continue
206    continue
      do 208 i=1,3
      iv=kvord(i,2)
      do 207 j=1,3
      jv=kvord(j,2)
      stif=+cv(i,3)*cv(j,2)*sxy*dt
     & +cv(i,3)*cv(j,3)*syy*dt
     & +cv(i,2)*cv(j,2)*sxx*dt
     & +cv(i,2)*cv(j,3)*sxy*dt
     & +cv(i,3)*cv(j,2)*sxy*dt
     & +cv(i,3)*cv(j,3)*syy*dt
     & +cv(i,3)*cv(j,3)*eg*dt
     & +cv(i,2)*cv(j,2)*eg*dt
     & +cv(i,3)*cv(j,3)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
207    continue
208    continue
c .... the following is the mass matrix computation
      stif=rou
      elump(1)=stif*weigh
      stif=rou
      elump(3)=stif*weigh
      stif=rou
      elump(5)=stif*weigh
      stif=rou
      elump(2)=stif*weigh
      stif=rou
      elump(4)=stif*weigh
      stif=rou
      elump(6)=stif*weigh
      do 301 i=1,nvard(1)
      iv = kvord(i,1)
      emass(iv)=emass(iv)+elump(iv)*cu(i,1)
301   continue
      do 302 i=1,nvard(2)
      iv = kvord(i,2)
      emass(iv)=emass(iv)+elump(iv)*cv(i,1)
302   continue
c .... the following is the load vector computation
      do 501 i=1,3
      iv=kvord(i,1)
      stif=+cu(i,1)*gx*rou
     & -cu(i,2)*sxx
     & -cu(i,3)*sxy
      eload(iv)=eload(iv)+stif*weigh
501   continue
      do 502 i=1,3
      iv=kvord(i,2)
      stif=+cv(i,1)*gy*rou
     & -cv(i,2)*sxy
     & -cv(i,3)*syy
      eload(iv)=eload(iv)+stif*weigh
502   continue
999   continue
998   continue
      return
      end

      subroutine det3i
      implicit real*8 (a-h,o-z)
      common /ddet3/ refc(2,3),gaus(3),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(2),kdord(2),kvord(6,2)
c .... initial data
c .... refc ---- reference coordinates at integral points
c .... gaus ---- weight number at integral points
c .... nvard ---- the number of var for each unknown
c .... kdord ---- the highest differential order for each unknown
c .... kvord ---- var number at integral points for each unknown
      ngaus=  3
      ndisp=  2
      nrefc=  2
      ncoor=  2
      nvar =  6
      nnode=  3
      kdord(1)=1
      nvard(1)=3
      kvord(1,1)=1
      kvord(2,1)=3
      kvord(3,1)=5
      kdord(2)=1
      nvard(2)=3
      kvord(1,2)=2
      kvord(2,2)=4
      kvord(3,2)=6
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


      subroutine det3t(nnode,nrefc,ncoor,refc,coor,coorr,
     & rc,cr,det)
      implicit real*8 (a-h,o-z)
      dimension refc(nrefc),rc(ncoor,nrefc),cr(nrefc,ncoor),a(5,10),
     & coorr(ncoor,nnode),coor(ncoor)
      call tdet3(refc,coor,coorr,rc)
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

      subroutine det31(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(3,3),rctr(2,2),crtr(2,2)
      external fdet31
      rx=refc(1)
      ry=refc(2)
      call dshap(fdet31,refc,shpr,2,3,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fdet31(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccdet3/ xa(3),ya(3)
      common /vdet3/ rctr(2,2),crtr(2,2)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3) n
1     fdet31=+rx 
      goto 1000
2     fdet31=+ry 
      goto 1000
3     fdet31=+(+1.-rx-ry) 
      goto 1000
1000  return
      end

      subroutine det32(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(3,3),rctr(2,2),crtr(2,2)
      external fdet32
      rx=refc(1)
      ry=refc(2)
      call dshap(fdet32,refc,shpr,2,3,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fdet32(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccdet3/ xa(3),ya(3)
      common /vdet3/ rctr(2,2),crtr(2,2)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3) n
1     fdet32=+rx 
      goto 1000
2     fdet32=+ry 
      goto 1000
3     fdet32=+(+1.-rx-ry) 
      goto 1000
1000  return
      end

      subroutine tdet3(refc,coor,coorr,rc)
c .... compute coordinate value and Jacobi's matrix rc
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(2),coor(2),coorr(2,3),rc(2,2)
      common /ccdet3/ x(3),y(3)
      external ftdet3
      do 100 n=1,3
      x(n)=coorr(1,n)
      y(n)=coorr(2,n)
100   continue
      rx=refc(1)
      ry=refc(2)
      call dcoor(ftdet3,refc,coor,rc,2,2,1)
c .... coordinate value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function ftdet3(refc,n)
c .... coordinate transfer function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(2)
      common /ccdet3/ x(3),y(3)
      common /vdet3/ rctr(2,2),crtr(2,2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2) n
1     ftdet3=+(+rx)*x(1)+(+ry)*x(2)+(+(+1.-rx-ry))*x(3)
      goto 1000
2     ftdet3=+(+rx)*y(1)+(+ry)*y(2)+(+(+1.-rx-ry))*y(3)
      goto 1000
1000  return
      end