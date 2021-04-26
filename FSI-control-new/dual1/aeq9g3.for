      subroutine aeq9g3(coorr,coefr,
     & prmt,estif,emass,edamp,eload,num)
c .... coorr ---- nodal coordinate value
c .... coefr ---- nodal coef value
      implicit real*8 (a-h,o-z)
      dimension estif(22,22),elump(22),emass(22),
     & eload(22)
      dimension prmt(*),coef(10),coefr(9,10),
     & ediv(22),edxx(22),edyy(22),edxy(22),
     & coorr(2,9),coor(2)
      common /raeq9g3/ru(9,27),rv(9,27),rp(4,27),
     & cu(9,3),cv(9,3),cp(4,3)
c .... store shape functions and their partial derivatives
c .... for all integral points
      common /vaeq9g3/rctr(2,2),crtr(2,2),coefd(10,5),coefc(10,5)
      common /daeq9g3/ refc(2,9),gaus(9),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(3),kdord(3),kvord(22,3)
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
      time=prmt(5)
      dt=prmt(6)
      imate=prmt(7)+0.5
      ielem=prmt(8)+0.5
      nelem=prmt(9)+0.5
      it=prmt(10)+0.5
      nmate=prmt(11)+0.5
      itime=prmt(12)+0.5
      ityp=prmt(13)+0.5
      beta=1.d5
      if (imate.eq.1) then
      ek=0.d0
      rou=rouf
      emu=emuf
      c1=0.0d0
      else
      ek=beta*dt
      rou=rous
      emu=c1*dt
      endif
      if (num.eq.1) call aeq9g3i
c .... initialize the basic data
      do 10 i=1,nvar
      emass(i)=0.0
      eload(i)=0.0
      do 10 j=1,nvar
      estif(i,j)=0.0
10    continue
      do 999 igaus=1,ngaus
      call aeq9g3t(nnode,nrefc,ncoor,refc(1,igaus),coor,coorr,
     & rctr,crtr,det,coefr)
c .... coordinate transfer from reference to original system
c .... rctr ---- Jacobi's matrix
c .... crtr ---- inverse matrix of Jacobi's matrix
      x=coor(1)
      y=coor(2)
      rx=refc(1,igaus)
      ry=refc(2,igaus)
      call eaeq9g3(refc(1,igaus),coef,coorr,coefr,coefd)
c .... compute coef functions and their partial derivatives
      iu=(igaus-1)*3+1
      iv=(igaus-1)*3+1
      ip=(igaus-1)*3+1
      if (num.gt.1) goto 2
c .... the following is the shape function caculation
      call aeq9g31(refc(1,igaus),ru(1,iu),rctr,crtr)
      call aeq9g32(refc(1,igaus),rv(1,iv),rctr,crtr)
      call aeq9g33(refc(1,igaus),rp(1,ip),rctr,crtr)
2     continue
c .... the following is the shape function transformation
c .... from reference coordinates to original coordinates
      call shapn(nrefc,ncoor,9,ru(1,iu),cu,crtr,1,3,3)
      call shapn(nrefc,ncoor,9,rv(1,iv),cv,crtr,1,3,3)
      call shapn(nrefc,ncoor,4,rp(1,ip),cp,crtr,1,3,3)
c .... the coef function transformation
c .... from reference coordinates to original coordinates
      call shapc(nrefc,ncoor,10,coefd,coefc,crtr,2,5,5)
      un=coef(1)
      vn=coef(2)
      us=coef(3)
      vs=coef(4)
      um=coef(5)
      vm=coef(6)
      ud=coef(7)
      vd=coef(8)
      uw=coef(9)
      vw=coef(10)
      weigh=det*gaus(igaus)
      do 100 i=1,22
      ediv(i) = 0.0
      edxx(i) = 0.0
      edyy(i) = 0.0
      edxy(i) = 0.0
100   continue
      do 101 i=1,9
      iv=kvord(i,1)
      stif=+cu(i,2) 
      ediv(iv)=ediv(iv)+stif
101   continue
      do 102 i=1,9
      iv=kvord(i,2)
      stif=+cv(i,3) 
      ediv(iv)=ediv(iv)+stif
102   continue
      do 103 i=1,9
      iv=kvord(i,1)
      stif=+cu(i,2)*2.0d0
      edxx(iv)=edxx(iv)+stif
103   continue
      do 104 i=1,9
      iv=kvord(i,1)
      stif=+cu(i,3) 
      edxy(iv)=edxy(iv)+stif
104   continue
      do 105 i=1,9
      iv=kvord(i,2)
      stif=+cv(i,2) 
      edxy(iv)=edxy(iv)+stif
105   continue
      do 106 i=1,9
      iv=kvord(i,2)
      stif=+cv(i,3)*2.0d0
      edyy(iv)=edyy(iv)+stif
106   continue
c .... the following is the stiffness computation
      do 202 i=1,9
      iv=kvord(i,1)
      do 201 j=1,9
      jv=kvord(j,1)
      stif=+cu(i,1)*cu(j,1)*coefc(1,1)*rou
     & +cu(i,1)*cu(j,2)*(un-um)*rou
     & +cu(i,1)*cu(j,3)*(vn-vm)*rou
     & -cu(i,2)*cu(j,2)*coefc(3,1)*c1*dt
     & -cu(i,3)*cu(j,3)*coefc(3,1)*c1*dt
     & -cu(i,2)*cu(j,2)*coefc(3,1)*c1*dt
     & -cu(i,2)*cu(j,3)*coefc(3,2)*c1*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
201    continue
202    continue
      do 204 i=1,9
      iv=kvord(i,1)
      do 203 j=1,9
      jv=kvord(j,2)
      stif=+cu(i,1)*cv(j,1)*coefc(1,2)*rou
     & -cu(i,2)*cv(j,2)*coefc(3,2)*c1*dt
     & -cu(i,3)*cv(j,3)*coefc(3,2)*c1*dt
     & -cu(i,3)*cv(j,2)*coefc(3,1)*c1*dt
     & -cu(i,3)*cv(j,3)*coefc(3,2)*c1*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
203    continue
204    continue
      do 206 i=1,9
      iv=kvord(i,2)
      do 205 j=1,9
      jv=kvord(j,1)
      stif=+cv(i,1)*cu(j,1)*coefc(2,1)*rou
     & -cv(i,2)*cu(j,2)*coefc(4,1)*c1*dt
     & -cv(i,3)*cu(j,3)*coefc(4,1)*c1*dt
     & -cv(i,2)*cu(j,2)*coefc(4,1)*c1*dt
     & -cv(i,2)*cu(j,3)*coefc(4,2)*c1*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
205    continue
206    continue
      do 208 i=1,9
      iv=kvord(i,2)
      do 207 j=1,9
      jv=kvord(j,2)
      stif=+cv(i,1)*cv(j,1)*coefc(2,2)*rou
     & +cv(i,1)*cv(j,2)*(un-um)*rou
     & +cv(i,1)*cv(j,3)*(vn-vm)*rou
     & -cv(i,2)*cv(j,2)*coefc(4,2)*c1*dt
     & -cv(i,3)*cv(j,3)*coefc(4,2)*c1*dt
     & -cv(i,3)*cv(j,2)*coefc(4,1)*c1*dt
     & -cv(i,3)*cv(j,3)*coefc(4,2)*c1*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
207    continue
208    continue
      do 210 iv=1,22
      do 209 j=1,4
      jv=kvord(j,3)
      stif=-ediv(iv)*cp(j,1) 
      estif(iv,jv)=estif(iv,jv)+stif*weigh
209    continue
210    continue
      do 212 i=1,4
      iv=kvord(i,3)
      do 211 jv=1,22
      stif=-cp(i,1)*ediv(jv) 
      estif(iv,jv)=estif(iv,jv)+stif*weigh
211    continue
212    continue
      do 214 iv=1,22
      do 213 jv=1,22
      stif=+edxx(iv)*edxx(jv)*emu/2.0d0
     & +edxy(iv)*edxy(jv)*emu/2.0d0
     & +edxy(iv)*edxy(jv)*emu/2.0d0
     & +edyy(iv)*edyy(jv)*emu/2.0d0
      estif(iv,jv)=estif(iv,jv)+stif*weigh
213    continue
214    continue
c .... the following is the mass matrix computation
      stif=rou
      elump(1)=stif*weigh
      stif=rou
      elump(4)=stif*weigh
      stif=rou
      elump(7)=stif*weigh
      stif=rou
      elump(10)=stif*weigh
      stif=rou
      elump(13)=stif*weigh
      stif=rou
      elump(15)=stif*weigh
      stif=rou
      elump(17)=stif*weigh
      stif=rou
      elump(19)=stif*weigh
      stif=rou
      elump(21)=stif*weigh
      stif=rou
      elump(2)=stif*weigh
      stif=rou
      elump(5)=stif*weigh
      stif=rou
      elump(8)=stif*weigh
      stif=rou
      elump(11)=stif*weigh
      stif=rou
      elump(14)=stif*weigh
      stif=rou
      elump(16)=stif*weigh
      stif=rou
      elump(18)=stif*weigh
      stif=rou
      elump(20)=stif*weigh
      stif=rou
      elump(22)=stif*weigh
      stif= 0.d0
      elump(3)=stif*weigh
      stif= 0.d0
      elump(6)=stif*weigh
      stif= 0.d0
      elump(9)=stif*weigh
      stif= 0.d0
      elump(12)=stif*weigh
      do 301 i=1,nvard(1)
      iv = kvord(i,1)
      emass(iv)=emass(iv)+elump(iv)*cu(i,1)
301   continue
      do 302 i=1,nvard(2)
      iv = kvord(i,2)
      emass(iv)=emass(iv)+elump(iv)*cv(i,1)
302   continue
      do 303 i=1,nvard(3)
      iv = kvord(i,3)
      emass(iv)=emass(iv)+elump(iv)*cp(i,1)
303   continue
c .... the following is the load vector computation
      do 501 i=1,9
      iv=kvord(i,1)
      stif=-cu(i,1)*us*ek
     & +cu(i,1)*ud*ek
      eload(iv)=eload(iv)+stif*weigh
501   continue
      do 502 i=1,9
      iv=kvord(i,2)
      stif=-cv(i,1)*vs*ek
     & +cv(i,1)*vd*ek
      eload(iv)=eload(iv)+stif*weigh
502   continue
999   continue
998   continue
      return
      end

      subroutine aeq9g3i
      implicit real*8 (a-h,o-z)
      common /daeq9g3/ refc(2,9),gaus(9),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(3),kdord(3),kvord(22,3)
c .... initial data
c .... refc ---- reference coordinates at integral points
c .... gaus ---- weight number at integral points
c .... nvard ---- the number of var for each unknown
c .... kdord ---- the highest differential order for each unknown
c .... kvord ---- var number at integral points for each unknown
      ngaus=  9
      ndisp=  3
      nrefc=  2
      ncoor=  2
      nvar = 22
      nnode=  9
      kdord(1)=1
      nvard(1)=9
      kvord(1,1)=1
      kvord(2,1)=13
      kvord(3,1)=4
      kvord(4,1)=19
      kvord(5,1)=21
      kvord(6,1)=15
      kvord(7,1)=10
      kvord(8,1)=17
      kvord(9,1)=7
      kdord(2)=1
      nvard(2)=9
      kvord(1,2)=2
      kvord(2,2)=14
      kvord(3,2)=5
      kvord(4,2)=20
      kvord(5,2)=22
      kvord(6,2)=16
      kvord(7,2)=11
      kvord(8,2)=18
      kvord(9,2)=8
      kdord(3)=1
      nvard(3)=4
      kvord(1,3)=3
      kvord(2,3)=6
      kvord(3,3)=9
      kvord(4,3)=12
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


      subroutine aeq9g3t(nnode,nrefc,ncoor,refc,coor,coorr,
     & rc,cr,det,coefr)
      implicit real*8 (a-h,o-z)
      dimension refc(nrefc),rc(ncoor,nrefc),cr(nrefc,ncoor),a(5,10),
     & coorr(ncoor,nnode),coor(ncoor),coefr(nnode,*)
      call taeq9g3(refc,coor,coorr,coefr,rc)
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

      subroutine aeq9g31(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(9,3),rctr(2,2),crtr(2,2)
      external faeq9g31
      rx=refc(1)
      ry=refc(2)
      call dshap(faeq9g31,refc,shpr,2,9,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function faeq9g31(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccaeq9g3/ xa(9),ya(9),una(9),vna(9),
     &usa(9),vsa(9),uma(9),vma(9),uda(9),vda(9),
     &uwa(9),vwa(9)
      common /vaeq9g3/ rctr(2,2),crtr(2,2),coefd(10,5),coefc(10,5)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3,4,5,6,7,8,9) n
1     faeq9g31=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2. 
      goto 1000
2     faeq9g31=+(+1.-rx**2)*ry*(+ry-1.)/2. 
      goto 1000
3     faeq9g31=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2. 
      goto 1000
4     faeq9g31=+rx*(+rx-1.)/2.*(+1.-ry**2) 
      goto 1000
5     faeq9g31=+(+1.-rx**2)*(+1.-ry**2) 
      goto 1000
6     faeq9g31=+rx*(+1.+rx)/2.*(+1.-ry**2) 
      goto 1000
7     faeq9g31=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2. 
      goto 1000
8     faeq9g31=+(+1.-rx**2)*ry*(+1.+ry)/2. 
      goto 1000
9     faeq9g31=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2. 
      goto 1000
1000  return
      end

      subroutine aeq9g32(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(9,3),rctr(2,2),crtr(2,2)
      external faeq9g32
      rx=refc(1)
      ry=refc(2)
      call dshap(faeq9g32,refc,shpr,2,9,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function faeq9g32(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccaeq9g3/ xa(9),ya(9),una(9),vna(9),
     &usa(9),vsa(9),uma(9),vma(9),uda(9),vda(9),
     &uwa(9),vwa(9)
      common /vaeq9g3/ rctr(2,2),crtr(2,2),coefd(10,5),coefc(10,5)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3,4,5,6,7,8,9) n
1     faeq9g32=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2. 
      goto 1000
2     faeq9g32=+(+1.-rx**2)*ry*(+ry-1.)/2. 
      goto 1000
3     faeq9g32=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2. 
      goto 1000
4     faeq9g32=+rx*(+rx-1.)/2.*(+1.-ry**2) 
      goto 1000
5     faeq9g32=+(+1.-rx**2)*(+1.-ry**2) 
      goto 1000
6     faeq9g32=+rx*(+1.+rx)/2.*(+1.-ry**2) 
      goto 1000
7     faeq9g32=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2. 
      goto 1000
8     faeq9g32=+(+1.-rx**2)*ry*(+1.+ry)/2. 
      goto 1000
9     faeq9g32=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2. 
      goto 1000
1000  return
      end

      subroutine aeq9g33(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(2),shpr(4,3),rctr(2,2),crtr(2,2)
      external faeq9g33
      rx=refc(1)
      ry=refc(2)
      call dshap(faeq9g33,refc,shpr,2,4,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function faeq9g33(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccaeq9g3/ xa(9),ya(9),una(9),vna(9),
     &usa(9),vsa(9),uma(9),vma(9),uda(9),vda(9),
     &uwa(9),vwa(9)
      common /vaeq9g3/ rctr(2,2),crtr(2,2),coefd(10,5),coefc(10,5)
      dimension refc(2)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3,4) n
1     faeq9g33=+(+1.-rx)/2.*(+1.-ry)/2. 
      goto 1000
2     faeq9g33=+(+1.+rx)/2.*(+1.-ry)/2. 
      goto 1000
3     faeq9g33=+(+1.+rx)/2.*(+1.+ry)/2. 
      goto 1000
4     faeq9g33=+(+1.-rx)/2.*(+1.+ry)/2. 
      goto 1000
1000  return
      end

      subroutine taeq9g3(refc,coor,coorr,coefr,rc)
c .... compute coordinate value and Jacobi's matrix rc
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(2),coor(2),coorr(2,9),coefr(9,10),rc(2,2)
      common /ccaeq9g3/ x(9),y(9),un(9),vn(9),us(9),vs(9),
     &um(9),vm(9),ud(9),vd(9),uw(9),vw(9)
      external ftaeq9g3
      do 100 n=1,9
      x(n)=coorr(1,n)
      y(n)=coorr(2,n)
100   continue
      do 200 n=1,9
      un(n)=coefr(n,1)
      vn(n)=coefr(n,2)
      us(n)=coefr(n,3)
      vs(n)=coefr(n,4)
      um(n)=coefr(n,5)
      vm(n)=coefr(n,6)
      ud(n)=coefr(n,7)
      vd(n)=coefr(n,8)
      uw(n)=coefr(n,9)
      vw(n)=coefr(n,10)
200   continue
      rx=refc(1)
      ry=refc(2)
      call dcoor(ftaeq9g3,refc,coor,rc,2,2,1)
c .... coordinate value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function ftaeq9g3(refc,n)
c .... coordinate transfer function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(2)
      common /ccaeq9g3/ x(9),y(9),un(9),vn(9),us(9),vs(9),
     &um(9),vm(9),ud(9),vd(9),uw(9),vw(9)
      common /vaeq9g3/ rctr(2,2),crtr(2,2),coefd(10,5),coefc(10,5)
      rx=refc(1)
      ry=refc(2)
      goto (1,2) n
1     ftaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*x(1)+(+(+
     & 1.-rx**2)*ry*(+ry-1.)/2.)*x(5)+(+rx*(+1.+rx)/2.*ry*(+
     & ry-1.)/2.)*x(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*x(8)+(+
     & (+1.-rx**2)*(+1.-ry**2))*x(9)+(+rx*(+1.+rx)/2.*(+1.-
     & ry**2))*x(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*x(4)+(+
     & (+1.-rx**2)*ry*(+1.+ry)/2.)*x(7)+(+rx*(+1.+rx)/2.*ry*
     & (+1.+ry)/2.)*x(3)
      goto 1000
2     ftaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*y(1)+(+(+
     & 1.-rx**2)*ry*(+ry-1.)/2.)*y(5)+(+rx*(+1.+rx)/2.*ry*(+
     & ry-1.)/2.)*y(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*y(8)+(+
     & (+1.-rx**2)*(+1.-ry**2))*y(9)+(+rx*(+1.+rx)/2.*(+1.-
     & ry**2))*y(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*y(4)+(+
     & (+1.-rx**2)*ry*(+1.+ry)/2.)*y(7)+(+rx*(+1.+rx)/2.*ry*
     & (+1.+ry)/2.)*y(3)
      goto 1000
1000  return
      end

      subroutine eaeq9g3(refc,coef,coorr,coefr,coefd)
c .... compute coef value and their partial derivatives
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(2),coef(10),coorr(2,9),coefr(9,10),coefd(10,2)
      external feaeq9g3
      rx=refc(1)
      ry=refc(2)
      call dcoef(feaeq9g3,refc,coef,coefd,2,10,2)
c .... coef value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feaeq9g3(refc,n)
c .... coef function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(2)
      common /ccaeq9g3/ xa(9),ya(9),un(9),vn(9),us(9),vs(9),
     &um(9),vm(9),ud(9),vd(9),uw(9),vw(9)
      common /vaeq9g3/ rctr(2,2),crtr(2,2),coefd(10,5),coefc(10,5)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      rx=refc(1)
      ry=refc(2)
      goto (1,2,3,4,5,6,7,8,9,10) n
1     feaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*un(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*un(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*un(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*un(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*un(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*un(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*un(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*un(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*un(3)
      goto 1000
2     feaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*vn(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*vn(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*vn(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*vn(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*vn(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*vn(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*vn(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*vn(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*vn(3)
      goto 1000
3     feaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*us(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*us(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*us(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*us(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*us(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*us(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*us(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*us(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*us(3)
      goto 1000
4     feaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*vs(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*vs(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*vs(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*vs(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*vs(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*vs(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*vs(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*vs(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*vs(3)
      goto 1000
5     feaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*um(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*um(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*um(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*um(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*um(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*um(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*um(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*um(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*um(3)
      goto 1000
6     feaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*vm(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*vm(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*vm(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*vm(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*vm(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*vm(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*vm(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*vm(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*vm(3)
      goto 1000
7     feaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*ud(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*ud(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*ud(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*ud(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*ud(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*ud(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*ud(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*ud(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*ud(3)
      goto 1000
8     feaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*vd(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*vd(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*vd(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*vd(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*vd(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*vd(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*vd(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*vd(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*vd(3)
      goto 1000
9     feaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*uw(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*uw(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*uw(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*uw(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*uw(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*uw(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*uw(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*uw(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*uw(3)
      goto 1000
10     feaeq9g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.)*vw(1)+(+
     & (+1.-rx**2)*ry*(+ry-1.)/2.)*vw(5)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.)*vw(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2))*vw(8)
     & +(+(+1.-rx**2)*(+1.-ry**2))*vw(9)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2))*vw(6)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.)*vw(4)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.)*vw(7)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.)*vw(3)
      goto 1000
1000  return
      end

