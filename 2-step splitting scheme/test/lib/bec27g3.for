      subroutine bec27g3(coorr,coefr,
     & prmt,estif,emass,edamp,eload,num)
c .... coorr ---- nodal coordinate value
c .... coefr ---- nodal coef value
      implicit real*8 (a-h,o-z)
      dimension estif(81,81),elump(81),emass(81),
     & eload(81)
      dimension prmt(*),coef(3),coefr(27,3),coorr(3,27),coor(3)
      common /rbec27g3/ru(27,108),rv(27,108),rw(27,108),
     & cu(27,4),cv(27,4),cw(27,4)
c .... store shape functions and their partial derivatives
c .... for all integral points
      common /vbec27g3/rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      common /dbec27g3/ refc(3,27),gaus(27),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(3),kdord(3),kvord(81,3)
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

      if (num.eq.1) call bec27g3i
c .... initialize the basic data
      do 10 i=1,nvar
      eload(i)=0.0
      do 10 j=1,nvar
      estif(i,j)=0.0
10    continue
      do 999 igaus=1,ngaus
      call bec27g3t(nnode,nrefc,ncoor,refc(1,igaus),coor,coorr,
     & rctr,crtr,det,coefr)
c .... coordinate transfer from reference to original system
c .... rctr ---- Jacobi's matrix
c .... crtr ---- inverse matrix of Jacobi's matrix
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1,igaus)
      ry=refc(2,igaus)
      rz=refc(3,igaus)
      call ebec27g3(refc(1,igaus),coef,coorr,coefr,coefd)
c .... compute coef functions and their partial derivatives
      iu=(igaus-1)*4+1
      iv=(igaus-1)*4+1
      iw=(igaus-1)*4+1
      if (num.gt.1) goto 2
c .... the following is the shape function caculation
      call bec27g31(refc(1,igaus),ru(1,iu),rctr,crtr)
      call bec27g32(refc(1,igaus),rv(1,iv),rctr,crtr)
      call bec27g33(refc(1,igaus),rw(1,iw),rctr,crtr)
2     continue
c .... the following is the shape function transformation
c .... from reference coordinates to original coordinates
      call shapn(nrefc,ncoor,27,ru(1,iu),cu,crtr,1,4,4)
      call shapn(nrefc,ncoor,27,rv(1,iv),cv,crtr,1,4,4)
      call shapn(nrefc,ncoor,27,rw(1,iw),cw,crtr,1,4,4)
c .... the coef function transformation
c .... from reference coordinates to original coordinates
      call shapc(nrefc,ncoor,3,coefd,coefc,crtr,2,9,9)
      un=coef(1)
      vn=coef(2)
      wn=coef(3)
      weigh=det*gaus(igaus)
      fx = +coefc(1,1)*un*dt+coefc(1,2)
     * *vn*dt+coefc(1,3)*wn*dt
      fy = +coefc(2,1)*un*dt+coefc(2,2)
     * *vn*dt+coefc(2,3)*wn*dt
      fz = +coefc(3,1)*un*dt+coefc(3,2)
     * *vn*dt+coefc(3,3)*wn*dt
      gx = +coefc(1,1)*un*dt*dt/2.0d0+coefc(1,2)
     * *vn*dt*dt/2.0d0+coefc(1,3)*wn*dt
     * *dt/2.0d0
      gy = +coefc(2,1)*un*dt*dt/2.0d0+coefc(2,2)
     * *vn*dt*dt/2.0d0+coefc(2,3)*wn*dt
     * *dt/2.0d0
      gz = +coefc(3,1)*un*dt*dt/2.0d0+coefc(3,2)
     * *vn*dt*dt/2.0d0+coefc(3,3)*wn*dt
     * *dt/2.0d0
c .... the following is the stiffness computation
      do 202 i=1,27
      iv=kvord(i,1)
      do 201 j=1,27
      jv=kvord(j,1)
      stif=+cu(i,1)*cu(j,1) 
      estif(iv,jv)=estif(iv,jv)+stif*weigh
201    continue
202    continue
      do 204 i=1,27
      iv=kvord(i,2)
      do 203 j=1,27
      jv=kvord(j,2)
      stif=+cv(i,1)*cv(j,1) 
      estif(iv,jv)=estif(iv,jv)+stif*weigh
203    continue
204    continue
      do 206 i=1,27
      iv=kvord(i,3)
      do 205 j=1,27
      jv=kvord(j,3)
      stif=+cw(i,1)*cw(j,1) 
      estif(iv,jv)=estif(iv,jv)+stif*weigh
205    continue
206    continue
c .... the following is the load vector computation
      do 501 i=1,27
      iv=kvord(i,1)
      stif=-cu(i,1)*fx
     & -cu(i,2)*un*gx
     & -cu(i,3)*vn*gx
     & -cu(i,4)*wn*gx
     & +cu(i,1)*un
     & +cu(i,1)*coefc(1,1)*gx
     & +cu(i,1)*coefc(1,2)*gy
     & +cu(i,1)*coefc(1,3)*gz
      eload(iv)=eload(iv)+stif*weigh
501   continue
      do 502 i=1,27
      iv=kvord(i,2)
      stif=-cv(i,1)*fy
     & -cv(i,2)*un*gy
     & -cv(i,3)*vn*gy
     & -cv(i,4)*wn*gy
     & +cv(i,1)*vn
     & +cv(i,1)*coefc(2,1)*gx
     & +cv(i,1)*coefc(2,2)*gy
     & +cv(i,1)*coefc(2,3)*gz
      eload(iv)=eload(iv)+stif*weigh
502   continue
      do 503 i=1,27
      iv=kvord(i,3)
      stif=-cw(i,1)*fz
     & -cw(i,2)*un*gz
     & -cw(i,3)*vn*gz
     & -cw(i,4)*wn*gz
     & +cw(i,1)*wn
     & +cw(i,1)*coefc(3,1)*gx
     & +cw(i,1)*coefc(3,2)*gy
     & +cw(i,1)*coefc(3,3)*gz
      eload(iv)=eload(iv)+stif*weigh
503   continue
999   continue
998   continue
      return
      end

      subroutine bec27g3i
      implicit real*8 (a-h,o-z)
      common /dbec27g3/ refc(3,27),gaus(27),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(3),kdord(3),kvord(81,3)
c .... initial data
c .... refc ---- reference coordinates at integral points
c .... gaus ---- weight number at integral points
c .... nvard ---- the number of var for each unknown
c .... kdord ---- the highest differential order for each unknown
c .... kvord ---- var number at integral points for each unknown
      ngaus= 27
      ndisp=  3
      nrefc=  3
      ncoor=  3
      nvar = 81
      nnode= 27
      kdord(1)=1
      nvard(1)=27
      kvord(1,1)=1
      kvord(2,1)=25
      kvord(3,1)=4
      kvord(4,1)=34
      kvord(5,1)=61
      kvord(6,1)=28
      kvord(7,1)=10
      kvord(8,1)=31
      kvord(9,1)=7
      kvord(10,1)=37
      kvord(11,1)=64
      kvord(12,1)=40
      kvord(13,1)=73
      kvord(14,1)=79
      kvord(15,1)=67
      kvord(16,1)=46
      kvord(17,1)=70
      kvord(18,1)=43
      kvord(19,1)=13
      kvord(20,1)=49
      kvord(21,1)=16
      kvord(22,1)=58
      kvord(23,1)=76
      kvord(24,1)=52
      kvord(25,1)=22
      kvord(26,1)=55
      kvord(27,1)=19
      kdord(2)=1
      nvard(2)=27
      kvord(1,2)=2
      kvord(2,2)=26
      kvord(3,2)=5
      kvord(4,2)=35
      kvord(5,2)=62
      kvord(6,2)=29
      kvord(7,2)=11
      kvord(8,2)=32
      kvord(9,2)=8
      kvord(10,2)=38
      kvord(11,2)=65
      kvord(12,2)=41
      kvord(13,2)=74
      kvord(14,2)=80
      kvord(15,2)=68
      kvord(16,2)=47
      kvord(17,2)=71
      kvord(18,2)=44
      kvord(19,2)=14
      kvord(20,2)=50
      kvord(21,2)=17
      kvord(22,2)=59
      kvord(23,2)=77
      kvord(24,2)=53
      kvord(25,2)=23
      kvord(26,2)=56
      kvord(27,2)=20
      kdord(3)=1
      nvard(3)=27
      kvord(1,3)=3
      kvord(2,3)=27
      kvord(3,3)=6
      kvord(4,3)=36
      kvord(5,3)=63
      kvord(6,3)=30
      kvord(7,3)=12
      kvord(8,3)=33
      kvord(9,3)=9
      kvord(10,3)=39
      kvord(11,3)=66
      kvord(12,3)=42
      kvord(13,3)=75
      kvord(14,3)=81
      kvord(15,3)=69
      kvord(16,3)=48
      kvord(17,3)=72
      kvord(18,3)=45
      kvord(19,3)=15
      kvord(20,3)=51
      kvord(21,3)=18
      kvord(22,3)=60
      kvord(23,3)=78
      kvord(24,3)=54
      kvord(25,3)=24
      kvord(26,3)=57
      kvord(27,3)=21
      refc(1,1)=7.745966692e-001
      refc(2,1)=7.745966692e-001
      refc(3,1)=7.745966692e-001
      gaus(1)=1.714677641e-001
      refc(1,2)=7.745966692e-001
      refc(2,2)=7.745966692e-001
      refc(3,2)=0.000000000e+000
      gaus(2)=2.743484225e-001
      refc(1,3)=7.745966692e-001
      refc(2,3)=7.745966692e-001
      refc(3,3)=-7.745966692e-001
      gaus(3)=1.714677641e-001
      refc(1,4)=7.745966692e-001
      refc(2,4)=0.000000000e+000
      refc(3,4)=7.745966692e-001
      gaus(4)=2.743484225e-001
      refc(1,5)=7.745966692e-001
      refc(2,5)=0.000000000e+000
      refc(3,5)=0.000000000e+000
      gaus(5)=4.389574760e-001
      refc(1,6)=7.745966692e-001
      refc(2,6)=0.000000000e+000
      refc(3,6)=-7.745966692e-001
      gaus(6)=2.743484225e-001
      refc(1,7)=7.745966692e-001
      refc(2,7)=-7.745966692e-001
      refc(3,7)=7.745966692e-001
      gaus(7)=1.714677641e-001
      refc(1,8)=7.745966692e-001
      refc(2,8)=-7.745966692e-001
      refc(3,8)=0.000000000e+000
      gaus(8)=2.743484225e-001
      refc(1,9)=7.745966692e-001
      refc(2,9)=-7.745966692e-001
      refc(3,9)=-7.745966692e-001
      gaus(9)=1.714677641e-001
      refc(1,10)=0.000000000e+000
      refc(2,10)=7.745966692e-001
      refc(3,10)=7.745966692e-001
      gaus(10)=2.743484225e-001
      refc(1,11)=0.000000000e+000
      refc(2,11)=7.745966692e-001
      refc(3,11)=0.000000000e+000
      gaus(11)=4.389574760e-001
      refc(1,12)=0.000000000e+000
      refc(2,12)=7.745966692e-001
      refc(3,12)=-7.745966692e-001
      gaus(12)=2.743484225e-001
      refc(1,13)=0.000000000e+000
      refc(2,13)=0.000000000e+000
      refc(3,13)=7.745966692e-001
      gaus(13)=4.389574760e-001
      refc(1,14)=0.000000000e+000
      refc(2,14)=0.000000000e+000
      refc(3,14)=0.000000000e+000
      gaus(14)=7.023319616e-001
      refc(1,15)=0.000000000e+000
      refc(2,15)=0.000000000e+000
      refc(3,15)=-7.745966692e-001
      gaus(15)=4.389574760e-001
      refc(1,16)=0.000000000e+000
      refc(2,16)=-7.745966692e-001
      refc(3,16)=7.745966692e-001
      gaus(16)=2.743484225e-001
      refc(1,17)=0.000000000e+000
      refc(2,17)=-7.745966692e-001
      refc(3,17)=0.000000000e+000
      gaus(17)=4.389574760e-001
      refc(1,18)=0.000000000e+000
      refc(2,18)=-7.745966692e-001
      refc(3,18)=-7.745966692e-001
      gaus(18)=2.743484225e-001
      refc(1,19)=-7.745966692e-001
      refc(2,19)=7.745966692e-001
      refc(3,19)=7.745966692e-001
      gaus(19)=1.714677641e-001
      refc(1,20)=-7.745966692e-001
      refc(2,20)=7.745966692e-001
      refc(3,20)=0.000000000e+000
      gaus(20)=2.743484225e-001
      refc(1,21)=-7.745966692e-001
      refc(2,21)=7.745966692e-001
      refc(3,21)=-7.745966692e-001
      gaus(21)=1.714677641e-001
      refc(1,22)=-7.745966692e-001
      refc(2,22)=0.000000000e+000
      refc(3,22)=7.745966692e-001
      gaus(22)=2.743484225e-001
      refc(1,23)=-7.745966692e-001
      refc(2,23)=0.000000000e+000
      refc(3,23)=0.000000000e+000
      gaus(23)=4.389574760e-001
      refc(1,24)=-7.745966692e-001
      refc(2,24)=0.000000000e+000
      refc(3,24)=-7.745966692e-001
      gaus(24)=2.743484225e-001
      refc(1,25)=-7.745966692e-001
      refc(2,25)=-7.745966692e-001
      refc(3,25)=7.745966692e-001
      gaus(25)=1.714677641e-001
      refc(1,26)=-7.745966692e-001
      refc(2,26)=-7.745966692e-001
      refc(3,26)=0.000000000e+000
      gaus(26)=2.743484225e-001
      refc(1,27)=-7.745966692e-001
      refc(2,27)=-7.745966692e-001
      refc(3,27)=-7.745966692e-001
      gaus(27)=1.714677641e-001
      end


      subroutine bec27g3t(nnode,nrefc,ncoor,refc,coor,coorr,
     & rc,cr,det,coefr)
      implicit real*8 (a-h,o-z)
      dimension refc(nrefc),rc(ncoor,nrefc),cr(nrefc,ncoor),a(5,10),
     & coorr(ncoor,nnode),coor(ncoor),coefr(nnode,*)
      call tbec27g3(refc,coor,coorr,coefr,rc)
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

      subroutine bec27g31(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(27,4),rctr(3,3),crtr(3,3)
      external fbec27g31
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(fbec27g31,refc,shpr,3,27,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fbec27g31(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccbec27g3/ xa(27),ya(27),za(27),una(27),
     &vna(27),wna(27)
      common /vbec27g3/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
     & 16,17,18,19,20,21,22,23,24,25,26,27) n
1     fbec27g31=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
2     fbec27g31=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/2. 
      goto 1000
3     fbec27g31=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
4     fbec27g31=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
5     fbec27g31=+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
6     fbec27g31=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
7     fbec27g31=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
8     fbec27g31=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2. 
      goto 1000
9     fbec27g31=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
10     fbec27g31=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
11     fbec27g31=+(+1.-rx**2)*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
12     fbec27g31=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
13     fbec27g31=+rx*(+rx-1.)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
14     fbec27g31=+(+1.-rx**2)*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
15     fbec27g31=+rx*(+1.+rx)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
16     fbec27g31=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
17     fbec27g31=+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
18     fbec27g31=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
19     fbec27g31=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
20     fbec27g31=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2. 
      goto 1000
21     fbec27g31=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
22     fbec27g31=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
23     fbec27g31=+(+1.-rx**2)*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
24     fbec27g31=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
25     fbec27g31=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
26     fbec27g31=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+1.+rz)/2. 
      goto 1000
27     fbec27g31=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
1000  return
      end

      subroutine bec27g32(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(27,4),rctr(3,3),crtr(3,3)
      external fbec27g32
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(fbec27g32,refc,shpr,3,27,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fbec27g32(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccbec27g3/ xa(27),ya(27),za(27),una(27),
     &vna(27),wna(27)
      common /vbec27g3/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
     & 16,17,18,19,20,21,22,23,24,25,26,27) n
1     fbec27g32=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
2     fbec27g32=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/2. 
      goto 1000
3     fbec27g32=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
4     fbec27g32=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
5     fbec27g32=+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
6     fbec27g32=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
7     fbec27g32=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
8     fbec27g32=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2. 
      goto 1000
9     fbec27g32=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
10     fbec27g32=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
11     fbec27g32=+(+1.-rx**2)*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
12     fbec27g32=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
13     fbec27g32=+rx*(+rx-1.)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
14     fbec27g32=+(+1.-rx**2)*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
15     fbec27g32=+rx*(+1.+rx)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
16     fbec27g32=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
17     fbec27g32=+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
18     fbec27g32=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
19     fbec27g32=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
20     fbec27g32=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2. 
      goto 1000
21     fbec27g32=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
22     fbec27g32=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
23     fbec27g32=+(+1.-rx**2)*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
24     fbec27g32=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
25     fbec27g32=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
26     fbec27g32=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+1.+rz)/2. 
      goto 1000
27     fbec27g32=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
1000  return
      end

      subroutine bec27g33(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(27,4),rctr(3,3),crtr(3,3)
      external fbec27g33
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(fbec27g33,refc,shpr,3,27,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fbec27g33(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccbec27g3/ xa(27),ya(27),za(27),una(27),
     &vna(27),wna(27)
      common /vbec27g3/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
     & 16,17,18,19,20,21,22,23,24,25,26,27) n
1     fbec27g33=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
2     fbec27g33=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/2. 
      goto 1000
3     fbec27g33=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
4     fbec27g33=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
5     fbec27g33=+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
6     fbec27g33=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
7     fbec27g33=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
8     fbec27g33=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2. 
      goto 1000
9     fbec27g33=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
10     fbec27g33=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
11     fbec27g33=+(+1.-rx**2)*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
12     fbec27g33=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
13     fbec27g33=+rx*(+rx-1.)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
14     fbec27g33=+(+1.-rx**2)*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
15     fbec27g33=+rx*(+1.+rx)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
16     fbec27g33=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
17     fbec27g33=+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
18     fbec27g33=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
19     fbec27g33=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
20     fbec27g33=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2. 
      goto 1000
21     fbec27g33=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
22     fbec27g33=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
23     fbec27g33=+(+1.-rx**2)*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
24     fbec27g33=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
25     fbec27g33=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
26     fbec27g33=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+1.+rz)/2. 
      goto 1000
27     fbec27g33=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
1000  return
      end

      subroutine tbec27g3(refc,coor,coorr,coefr,rc)
c .... compute coordinate value and Jacobi's matrix rc
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(3),coor(3),coorr(3,27),coefr(27,3),rc(3,3)
      common /ccbec27g3/ x(27),y(27),z(27),un(27),vn(27),wn(27)
      external ftbec27g3
      do 100 n=1,27
      x(n)=coorr(1,n)
      y(n)=coorr(2,n)
      z(n)=coorr(3,n)
100   continue
      do 200 n=1,27
      un(n)=coefr(n,1)
      vn(n)=coefr(n,2)
      wn(n)=coefr(n,3)
200   continue
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dcoor(ftbec27g3,refc,coor,rc,3,3,1)
c .... coordinate value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function ftbec27g3(refc,n)
c .... coordinate transfer function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(3)
      common /ccbec27g3/ x(27),y(27),z(27),un(27),vn(27),wn(27)
      common /vbec27g3/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3) n
1     ftbec27g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-
     & 1.)/2.)*x(1)+(+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*x(9)+(+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*x(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*x(12)
     & +(+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2.)*x(21)+(+rx*
     & (+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*x(10)+(+rx*(+
     & rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*x(4)+(+(+1.-
     & rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*x(11)+(+rx*(+1.+
     & rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*x(3)+(+rx*(+rx-
     & 1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2))*x(13)+(+(+1.-rx**2)*
     & ry*(+ry-1.)/2.*(+1.-rz**2))*x(22)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.*(+1.-rz**2))*x(14)+(+rx*(+rx-1.)/2.*(+1.-
     & ry**2)*(+1.-rz**2))*x(25)+(+(+1.-rx**2)*(+1.-ry**2)*(+
     & 1.-rz**2))*x(27)+(+rx*(+1.+rx)/2.*(+1.-ry**2)*(+1.-rz**
     & 2))*x(23)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-rz**2))*x(16)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**2))*x(24)+(+rx*
     & (+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2))*x(15)+(+rx*(+
     & rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*x(5)+(+(+1.-
     & rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*x(17)+(+rx*(+1.+
     & rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*x(6)+(+rx*(+rx-
     & 1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2.)*x(20)+(+(+1.-rx**2)*
     & (+1.-ry**2)*rz*(+1.+rz)/2.)*x(26)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2)*rz*(+1.+rz)/2.)*x(18)+(+rx*(+rx-1.)/2.*ry*(+
     & 1.+ry)/2.*rz*(+1.+rz)/2.)*x(8)+(+(+1.-rx**2)*ry*(+1.+
     & ry)/2.*rz*(+1.+rz)/2.)*x(19)+(+rx*(+1.+rx)/2.*ry*(+1.+
     & ry)/2.*rz*(+1.+rz)/2.)*x(7)
      goto 1000
2     ftbec27g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-
     & 1.)/2.)*y(1)+(+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*y(9)+(+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*y(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*y(12)
     & +(+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2.)*y(21)+(+rx*
     & (+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*y(10)+(+rx*(+
     & rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*y(4)+(+(+1.-
     & rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*y(11)+(+rx*(+1.+
     & rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*y(3)+(+rx*(+rx-
     & 1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2))*y(13)+(+(+1.-rx**2)*
     & ry*(+ry-1.)/2.*(+1.-rz**2))*y(22)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.*(+1.-rz**2))*y(14)+(+rx*(+rx-1.)/2.*(+1.-
     & ry**2)*(+1.-rz**2))*y(25)+(+(+1.-rx**2)*(+1.-ry**2)*(+
     & 1.-rz**2))*y(27)+(+rx*(+1.+rx)/2.*(+1.-ry**2)*(+1.-rz**
     & 2))*y(23)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-rz**2))*y(16)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**2))*y(24)+(+rx*
     & (+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2))*y(15)+(+rx*(+
     & rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*y(5)+(+(+1.-
     & rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*y(17)+(+rx*(+1.+
     & rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*y(6)+(+rx*(+rx-
     & 1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2.)*y(20)+(+(+1.-rx**2)*
     & (+1.-ry**2)*rz*(+1.+rz)/2.)*y(26)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2)*rz*(+1.+rz)/2.)*y(18)+(+rx*(+rx-1.)/2.*ry*(+
     & 1.+ry)/2.*rz*(+1.+rz)/2.)*y(8)+(+(+1.-rx**2)*ry*(+1.+
     & ry)/2.*rz*(+1.+rz)/2.)*y(19)+(+rx*(+1.+rx)/2.*ry*(+1.+
     & ry)/2.*rz*(+1.+rz)/2.)*y(7)
      goto 1000
3     ftbec27g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-
     & 1.)/2.)*z(1)+(+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*z(9)+(+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*z(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*z(12)
     & +(+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2.)*z(21)+(+rx*
     & (+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*z(10)+(+rx*(+
     & rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*z(4)+(+(+1.-
     & rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*z(11)+(+rx*(+1.+
     & rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*z(3)+(+rx*(+rx-
     & 1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2))*z(13)+(+(+1.-rx**2)*
     & ry*(+ry-1.)/2.*(+1.-rz**2))*z(22)+(+rx*(+1.+rx)/2.*ry*
     & (+ry-1.)/2.*(+1.-rz**2))*z(14)+(+rx*(+rx-1.)/2.*(+1.-
     & ry**2)*(+1.-rz**2))*z(25)+(+(+1.-rx**2)*(+1.-ry**2)*(+
     & 1.-rz**2))*z(27)+(+rx*(+1.+rx)/2.*(+1.-ry**2)*(+1.-rz**
     & 2))*z(23)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-rz**2))*z(16)
     & +(+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**2))*z(24)+(+rx*
     & (+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2))*z(15)+(+rx*(+
     & rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*z(5)+(+(+1.-
     & rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*z(17)+(+rx*(+1.+
     & rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*z(6)+(+rx*(+rx-
     & 1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2.)*z(20)+(+(+1.-rx**2)*
     & (+1.-ry**2)*rz*(+1.+rz)/2.)*z(26)+(+rx*(+1.+rx)/2.*(+
     & 1.-ry**2)*rz*(+1.+rz)/2.)*z(18)+(+rx*(+rx-1.)/2.*ry*(+
     & 1.+ry)/2.*rz*(+1.+rz)/2.)*z(8)+(+(+1.-rx**2)*ry*(+1.+
     & ry)/2.*rz*(+1.+rz)/2.)*z(19)+(+rx*(+1.+rx)/2.*ry*(+1.+
     & ry)/2.*rz*(+1.+rz)/2.)*z(7)
      goto 1000
1000  return
      end

      subroutine ebec27g3(refc,coef,coorr,coefr,coefd)
c .... compute coef value and their partial derivatives
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(3),coef(3),coorr(3,27),coefr(27,3),coefd(3,3)
      external febec27g3
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dcoef(febec27g3,refc,coef,coefd,3,3,2)
c .... coef value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function febec27g3(refc,n)
c .... coef function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(3)
      common /ccbec27g3/ xa(27),ya(27),za(27),un(27),vn(27),wn(27)
      common /vbec27g3/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3) n
1     febec27g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-
     & 1.)/2.)*un(1)+(+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*un(9)+(+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*un(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*un(12)
     & +(+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2.)*un(21)+(+rx*
     & (+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*un(10)+(+rx*(+
     & rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*un(4)+(+(+1.-
     & rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*un(11)+(+rx*(+1.+
     & rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*un(3)+(+rx*(+rx-
     & 1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2))*un(13)+(+(+1.-rx**
     & 2)*ry*(+ry-1.)/2.*(+1.-rz**2))*un(22)+(+rx*(+1.+rx)/2.*
     & ry*(+ry-1.)/2.*(+1.-rz**2))*un(14)+(+rx*(+rx-1.)/2.*(+
     & 1.-ry**2)*(+1.-rz**2))*un(25)+(+(+1.-rx**2)*(+1.-ry**
     & 2)*(+1.-rz**2))*un(27)+(+rx*(+1.+rx)/2.*(+1.-ry**2)*(+
     & 1.-rz**2))*un(23)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-
     & rz**2))*un(16)+(+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**
     & 2))*un(24)+(+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2))*un(15)
     & +(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*un(5)
     & +(+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*un(17)+(+
     & rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*un(6)+(+
     & rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2.)*un(20)+(+(+
     & 1.-rx**2)*(+1.-ry**2)*rz*(+1.+rz)/2.)*un(26)+(+rx*(+1.+
     & rx)/2.*(+1.-ry**2)*rz*(+1.+rz)/2.)*un(18)+(+rx*(+rx-1.)/
     & 2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/2.)*un(8)+(+(+1.-rx**2)*
     & ry*(+1.+ry)/2.*rz*(+1.+rz)/2.)*un(19)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.*rz*(+1.+rz)/2.)*un(7)
      goto 1000
2     febec27g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-
     & 1.)/2.)*vn(1)+(+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*vn(9)+(+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*vn(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*vn(12)
     & +(+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2.)*vn(21)+(+rx*
     & (+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*vn(10)+(+rx*(+
     & rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*vn(4)+(+(+1.-
     & rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*vn(11)+(+rx*(+1.+
     & rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*vn(3)+(+rx*(+rx-
     & 1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2))*vn(13)+(+(+1.-rx**
     & 2)*ry*(+ry-1.)/2.*(+1.-rz**2))*vn(22)+(+rx*(+1.+rx)/2.*
     & ry*(+ry-1.)/2.*(+1.-rz**2))*vn(14)+(+rx*(+rx-1.)/2.*(+
     & 1.-ry**2)*(+1.-rz**2))*vn(25)+(+(+1.-rx**2)*(+1.-ry**
     & 2)*(+1.-rz**2))*vn(27)+(+rx*(+1.+rx)/2.*(+1.-ry**2)*(+
     & 1.-rz**2))*vn(23)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-
     & rz**2))*vn(16)+(+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**
     & 2))*vn(24)+(+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2))*vn(15)
     & +(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*vn(5)
     & +(+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*vn(17)+(+
     & rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*vn(6)+(+
     & rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2.)*vn(20)+(+(+
     & 1.-rx**2)*(+1.-ry**2)*rz*(+1.+rz)/2.)*vn(26)+(+rx*(+1.+
     & rx)/2.*(+1.-ry**2)*rz*(+1.+rz)/2.)*vn(18)+(+rx*(+rx-1.)/
     & 2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/2.)*vn(8)+(+(+1.-rx**2)*
     & ry*(+1.+ry)/2.*rz*(+1.+rz)/2.)*vn(19)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.*rz*(+1.+rz)/2.)*vn(7)
      goto 1000
3     febec27g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-
     & 1.)/2.)*wn(1)+(+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*wn(9)+(+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     & 2.)*wn(2)+(+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*wn(12)
     & +(+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2.)*wn(21)+(+rx*
     & (+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2.)*wn(10)+(+rx*(+
     & rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*wn(4)+(+(+1.-
     & rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*wn(11)+(+rx*(+1.+
     & rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/2.)*wn(3)+(+rx*(+rx-
     & 1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2))*wn(13)+(+(+1.-rx**
     & 2)*ry*(+ry-1.)/2.*(+1.-rz**2))*wn(22)+(+rx*(+1.+rx)/2.*
     & ry*(+ry-1.)/2.*(+1.-rz**2))*wn(14)+(+rx*(+rx-1.)/2.*(+
     & 1.-ry**2)*(+1.-rz**2))*wn(25)+(+(+1.-rx**2)*(+1.-ry**
     & 2)*(+1.-rz**2))*wn(27)+(+rx*(+1.+rx)/2.*(+1.-ry**2)*(+
     & 1.-rz**2))*wn(23)+(+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-
     & rz**2))*wn(16)+(+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**
     & 2))*wn(24)+(+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2))*wn(15)
     & +(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*wn(5)
     & +(+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*wn(17)+(+
     & rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/2.)*wn(6)+(+
     & rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2.)*wn(20)+(+(+
     & 1.-rx**2)*(+1.-ry**2)*rz*(+1.+rz)/2.)*wn(26)+(+rx*(+1.+
     & rx)/2.*(+1.-ry**2)*rz*(+1.+rz)/2.)*wn(18)+(+rx*(+rx-1.)/
     & 2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/2.)*wn(8)+(+(+1.-rx**2)*
     & ry*(+1.+ry)/2.*rz*(+1.+rz)/2.)*wn(19)+(+rx*(+1.+rx)/2.*
     & ry*(+1.+ry)/2.*rz*(+1.+rz)/2.)*wn(7)
      goto 1000
1000  return
      end