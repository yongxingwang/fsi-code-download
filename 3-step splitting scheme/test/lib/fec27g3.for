      subroutine fec27g3(coorr,coefr,
     & prmt,estif,emass,edamp,eload,num)
c .... coorr ---- nodal coordinate value
c .... coefr ---- nodal coef value
      implicit real*8 (a-h,o-z)
      dimension estif(89,89),elump(89),emass(89),
     & eload(89)
      dimension prmt(*),
     & ediv(89),coorr(3,27),coor(3)
      common /rfec27g3/ru(27,108),rv(27,108),rw(27,108),
     & rp(8,108),
     & cu(27,4),cv(27,4),cw(27,4),cp(8,4)
c .... store shape functions and their partial derivatives
c .... for all integral points
      common /vfec27g3/rctr(3,3),crtr(3,3)
      common /dfec27g3/ refc(3,27),gaus(27),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(4),kdord(4),kvord(89,4)
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
      rouf=prmt(1)
      emuf=prmt(2)
      time=prmt(3)
      dt=prmt(4)
      imate=prmt(5)+0.5
      ielem=prmt(6)+0.5
      nelem=prmt(7)+0.5
      it=prmt(8)+0.5
      nmate=prmt(9)+0.5
      itime=prmt(10)+0.5
      ityp=prmt(11)+0.5
      if (num.eq.1) call fec27g3i
c .... initialize the basic data
      do 10 i=1,nvar
      emass(i)=0.d0
      eload(i)=0.d0
      elump(i)=0.d0
      do 10 j=1,nvar
      estif(i,j)=0.d0
10    continue
      do 999 igaus=1,ngaus
      call fec27g3t(nnode,nrefc,ncoor,refc(1,igaus),coor,coorr,
     & rctr,crtr,det)
c .... coordinate transfer from reference to original system
c .... rctr ---- Jacobi's matrix
c .... crtr ---- inverse matrix of Jacobi's matrix
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1,igaus)
      ry=refc(2,igaus)
      rz=refc(3,igaus)
      iu=(igaus-1)*4+1
      iv=(igaus-1)*4+1
      iw=(igaus-1)*4+1
      ip=(igaus-1)*4+1
      if (num.gt.1) goto 2
c .... the following is the shape function caculation
      call fec27g31(refc(1,igaus),ru(1,iu),rctr,crtr)
      call fec27g32(refc(1,igaus),rv(1,iv),rctr,crtr)
      call fec27g33(refc(1,igaus),rw(1,iw),rctr,crtr)
      call fec27g34(refc(1,igaus),rp(1,ip),rctr,crtr)
2     continue
c .... the following is the shape function transformation
c .... from reference coordinates to original coordinates
      call shapn(nrefc,ncoor,27,ru(1,iu),cu,crtr,1,4,4)
      call shapn(nrefc,ncoor,27,rv(1,iv),cv,crtr,1,4,4)
      call shapn(nrefc,ncoor,27,rw(1,iw),cw,crtr,1,4,4)
      call shapn(nrefc,ncoor,8,rp(1,ip),cp,crtr,1,4,4)
      weigh=det*gaus(igaus)
      do 100 i=1,89
      ediv(i) = 0.0
100   continue
      do 101 i=1,27
      iv=kvord(i,1)
      stif=+cu(i,2) 
      ediv(iv)=ediv(iv)+stif
101   continue
      do 102 i=1,27
      iv=kvord(i,2)
      stif=+cv(i,3) 
      ediv(iv)=ediv(iv)+stif
102   continue
      do 103 i=1,27
      iv=kvord(i,3)
      stif=+cw(i,4) 
      ediv(iv)=ediv(iv)+stif
103   continue
c .... the following is the stiffness computation
      do 202 iv=1,89
      do 201 j=1,8
      jv=kvord(j,4)
      stif=-ediv(iv)*cp(j,1) 
      estif(iv,jv)=estif(iv,jv)+stif*weigh
201    continue
202    continue
      do 204 i=1,8
      iv=kvord(i,4)
      do 203 jv=1,89
      stif=-cp(i,1)*ediv(jv) 
      estif(iv,jv)=estif(iv,jv)+stif*weigh
203    continue
204    continue
c .... the following is the mass matrix computation
      stif=rouf
      elump(1)=stif*weigh
      stif=rouf
      elump(5)=stif*weigh
      stif=rouf
      elump(9)=stif*weigh
      stif=rouf
      elump(13)=stif*weigh
      stif=rouf
      elump(17)=stif*weigh
      stif=rouf
      elump(21)=stif*weigh
      stif=rouf
      elump(25)=stif*weigh
      stif=rouf
      elump(29)=stif*weigh
      stif=rouf
      elump(33)=stif*weigh
      stif=rouf
      elump(36)=stif*weigh
      stif=rouf
      elump(39)=stif*weigh
      stif=rouf
      elump(42)=stif*weigh
      stif=rouf
      elump(45)=stif*weigh
      stif=rouf
      elump(48)=stif*weigh
      stif=rouf
      elump(51)=stif*weigh
      stif=rouf
      elump(54)=stif*weigh
      stif=rouf
      elump(57)=stif*weigh
      stif=rouf
      elump(60)=stif*weigh
      stif=rouf
      elump(63)=stif*weigh
      stif=rouf
      elump(66)=stif*weigh
      stif=rouf
      elump(69)=stif*weigh
      stif=rouf
      elump(72)=stif*weigh
      stif=rouf
      elump(75)=stif*weigh
      stif=rouf
      elump(78)=stif*weigh
      stif=rouf
      elump(81)=stif*weigh
      stif=rouf
      elump(84)=stif*weigh
      stif=rouf
      elump(87)=stif*weigh
      stif=rouf
      elump(2)=stif*weigh
      stif=rouf
      elump(6)=stif*weigh
      stif=rouf
      elump(10)=stif*weigh
      stif=rouf
      elump(14)=stif*weigh
      stif=rouf
      elump(18)=stif*weigh
      stif=rouf
      elump(22)=stif*weigh
      stif=rouf
      elump(26)=stif*weigh
      stif=rouf
      elump(30)=stif*weigh
      stif=rouf
      elump(34)=stif*weigh
      stif=rouf
      elump(37)=stif*weigh
      stif=rouf
      elump(40)=stif*weigh
      stif=rouf
      elump(43)=stif*weigh
      stif=rouf
      elump(46)=stif*weigh
      stif=rouf
      elump(49)=stif*weigh
      stif=rouf
      elump(52)=stif*weigh
      stif=rouf
      elump(55)=stif*weigh
      stif=rouf
      elump(58)=stif*weigh
      stif=rouf
      elump(61)=stif*weigh
      stif=rouf
      elump(64)=stif*weigh
      stif=rouf
      elump(67)=stif*weigh
      stif=rouf
      elump(70)=stif*weigh
      stif=rouf
      elump(73)=stif*weigh
      stif=rouf
      elump(76)=stif*weigh
      stif=rouf
      elump(79)=stif*weigh
      stif=rouf
      elump(82)=stif*weigh
      stif=rouf
      elump(85)=stif*weigh
      stif=rouf
      elump(88)=stif*weigh
      stif=rouf
      elump(3)=stif*weigh
      stif=rouf
      elump(7)=stif*weigh
      stif=rouf
      elump(11)=stif*weigh
      stif=rouf
      elump(15)=stif*weigh
      stif=rouf
      elump(19)=stif*weigh
      stif=rouf
      elump(23)=stif*weigh
      stif=rouf
      elump(27)=stif*weigh
      stif=rouf
      elump(31)=stif*weigh
      stif=rouf
      elump(35)=stif*weigh
      stif=rouf
      elump(38)=stif*weigh
      stif=rouf
      elump(41)=stif*weigh
      stif=rouf
      elump(44)=stif*weigh
      stif=rouf
      elump(47)=stif*weigh
      stif=rouf
      elump(50)=stif*weigh
      stif=rouf
      elump(53)=stif*weigh
      stif=rouf
      elump(56)=stif*weigh
      stif=rouf
      elump(59)=stif*weigh
      stif=rouf
      elump(62)=stif*weigh
      stif=rouf
      elump(65)=stif*weigh
      stif=rouf
      elump(68)=stif*weigh
      stif=rouf
      elump(71)=stif*weigh
      stif=rouf
      elump(74)=stif*weigh
      stif=rouf
      elump(77)=stif*weigh
      stif=rouf
      elump(80)=stif*weigh
      stif=rouf
      elump(83)=stif*weigh
      stif=rouf
      elump(86)=stif*weigh
      stif=rouf
      elump(89)=stif*weigh
      stif=0.0d0
      elump(4)=stif*weigh
      stif=0.0d0
      elump(8)=stif*weigh
      stif=0.0d0
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
      emass(iv)=emass(iv)+elump(iv)*cw(i,1)
303   continue
      do 304 i=1,nvard(4)
      iv = kvord(i,4)
      emass(iv)=emass(iv)+elump(iv)*cp(i,1)
304   continue
c .... the following is the load vector computation

999   continue

      return
      end

      subroutine fec27g3i
      implicit real*8 (a-h,o-z)
      common /dfec27g3/ refc(3,27),gaus(27),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(4),kdord(4),kvord(89,4)
c .... initial data
c .... refc ---- reference coordinates at integral points
c .... gaus ---- weight number at integral points
c .... nvard ---- the number of var for each unknown
c .... kdord ---- the highest differential order for each unknown
c .... kvord ---- var number at integral points for each unknown
      ngaus= 27
      ndisp=  4
      nrefc=  3
      ncoor=  3
      nvar = 89
      nnode= 27
      kdord(1)=1
      nvard(1)=27
      kvord(1,1)=1
      kvord(2,1)=33
      kvord(3,1)=5
      kvord(4,1)=42
      kvord(5,1)=69
      kvord(6,1)=36
      kvord(7,1)=13
      kvord(8,1)=39
      kvord(9,1)=9
      kvord(10,1)=45
      kvord(11,1)=72
      kvord(12,1)=48
      kvord(13,1)=81
      kvord(14,1)=87
      kvord(15,1)=75
      kvord(16,1)=54
      kvord(17,1)=78
      kvord(18,1)=51
      kvord(19,1)=17
      kvord(20,1)=57
      kvord(21,1)=21
      kvord(22,1)=66
      kvord(23,1)=84
      kvord(24,1)=60
      kvord(25,1)=29
      kvord(26,1)=63
      kvord(27,1)=25
      kdord(2)=1
      nvard(2)=27
      kvord(1,2)=2
      kvord(2,2)=34
      kvord(3,2)=6
      kvord(4,2)=43
      kvord(5,2)=70
      kvord(6,2)=37
      kvord(7,2)=14
      kvord(8,2)=40
      kvord(9,2)=10
      kvord(10,2)=46
      kvord(11,2)=73
      kvord(12,2)=49
      kvord(13,2)=82
      kvord(14,2)=88
      kvord(15,2)=76
      kvord(16,2)=55
      kvord(17,2)=79
      kvord(18,2)=52
      kvord(19,2)=18
      kvord(20,2)=58
      kvord(21,2)=22
      kvord(22,2)=67
      kvord(23,2)=85
      kvord(24,2)=61
      kvord(25,2)=30
      kvord(26,2)=64
      kvord(27,2)=26
      kdord(3)=1
      nvard(3)=27
      kvord(1,3)=3
      kvord(2,3)=35
      kvord(3,3)=7
      kvord(4,3)=44
      kvord(5,3)=71
      kvord(6,3)=38
      kvord(7,3)=15
      kvord(8,3)=41
      kvord(9,3)=11
      kvord(10,3)=47
      kvord(11,3)=74
      kvord(12,3)=50
      kvord(13,3)=83
      kvord(14,3)=89
      kvord(15,3)=77
      kvord(16,3)=56
      kvord(17,3)=80
      kvord(18,3)=53
      kvord(19,3)=19
      kvord(20,3)=59
      kvord(21,3)=23
      kvord(22,3)=68
      kvord(23,3)=86
      kvord(24,3)=62
      kvord(25,3)=31
      kvord(26,3)=65
      kvord(27,3)=27
      kdord(4)=1
      nvard(4)=8
      kvord(1,4)=4
      kvord(2,4)=8
      kvord(3,4)=12
      kvord(4,4)=16
      kvord(5,4)=20
      kvord(6,4)=24
      kvord(7,4)=28
      kvord(8,4)=32
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


      subroutine fec27g3t(nnode,nrefc,ncoor,refc,coor,coorr,
     & rc,cr,det)
      implicit real*8 (a-h,o-z)
      dimension refc(nrefc),rc(ncoor,nrefc),cr(nrefc,ncoor),a(5,10),
     & coorr(ncoor,nnode),coor(ncoor)
      call tfec27g3(refc,coor,coorr,rc)
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

      subroutine fec27g31(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(27,4),rctr(3,3),crtr(3,3)
      external ffec27g31
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(ffec27g31,refc,shpr,3,27,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function ffec27g31(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccfec27g3/ xa(27),ya(27),za(27)
      common /vfec27g3/ rctr(3,3),crtr(3,3)
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
1     ffec27g31=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
2     ffec27g31=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/2. 
      goto 1000
3     ffec27g31=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
4     ffec27g31=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
5     ffec27g31=+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
6     ffec27g31=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
7     ffec27g31=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
8     ffec27g31=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2. 
      goto 1000
9     ffec27g31=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
10     ffec27g31=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
11     ffec27g31=+(+1.-rx**2)*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
12     ffec27g31=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
13     ffec27g31=+rx*(+rx-1.)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
14     ffec27g31=+(+1.-rx**2)*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
15     ffec27g31=+rx*(+1.+rx)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
16     ffec27g31=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
17     ffec27g31=+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
18     ffec27g31=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
19     ffec27g31=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
20     ffec27g31=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2. 
      goto 1000
21     ffec27g31=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
22     ffec27g31=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
23     ffec27g31=+(+1.-rx**2)*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
24     ffec27g31=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
25     ffec27g31=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
26     ffec27g31=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+1.+rz)/2. 
      goto 1000
27     ffec27g31=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
1000  return
      end

      subroutine fec27g32(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(27,4),rctr(3,3),crtr(3,3)
      external ffec27g32
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(ffec27g32,refc,shpr,3,27,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function ffec27g32(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccfec27g3/ xa(27),ya(27),za(27)
      common /vfec27g3/ rctr(3,3),crtr(3,3)
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
1     ffec27g32=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
2     ffec27g32=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/2. 
      goto 1000
3     ffec27g32=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
4     ffec27g32=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
5     ffec27g32=+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
6     ffec27g32=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
7     ffec27g32=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
8     ffec27g32=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2. 
      goto 1000
9     ffec27g32=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
10     ffec27g32=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
11     ffec27g32=+(+1.-rx**2)*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
12     ffec27g32=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
13     ffec27g32=+rx*(+rx-1.)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
14     ffec27g32=+(+1.-rx**2)*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
15     ffec27g32=+rx*(+1.+rx)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
16     ffec27g32=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
17     ffec27g32=+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
18     ffec27g32=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
19     ffec27g32=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
20     ffec27g32=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2. 
      goto 1000
21     ffec27g32=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
22     ffec27g32=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
23     ffec27g32=+(+1.-rx**2)*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
24     ffec27g32=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
25     ffec27g32=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
26     ffec27g32=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+1.+rz)/2. 
      goto 1000
27     ffec27g32=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
1000  return
      end

      subroutine fec27g33(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(27,4),rctr(3,3),crtr(3,3)
      external ffec27g33
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(ffec27g33,refc,shpr,3,27,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function ffec27g33(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccfec27g3/ xa(27),ya(27),za(27)
      common /vfec27g3/ rctr(3,3),crtr(3,3)
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
1     ffec27g33=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
2     ffec27g33=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+rz-1.)/2. 
      goto 1000
3     ffec27g33=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
4     ffec27g33=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
5     ffec27g33=+(+1.-rx**2)*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
6     ffec27g33=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+rz-1.)/2. 
      goto 1000
7     ffec27g33=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
8     ffec27g33=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+rz-1.)/2. 
      goto 1000
9     ffec27g33=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+rz-1.)/
     *2. 
      goto 1000
10     ffec27g33=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
11     ffec27g33=+(+1.-rx**2)*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
12     ffec27g33=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*(+1.-rz**2) 
      goto 1000
13     ffec27g33=+rx*(+rx-1.)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
14     ffec27g33=+(+1.-rx**2)*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
15     ffec27g33=+rx*(+1.+rx)/2.*(+1.-ry**2)*(+1.-rz**2) 
      goto 1000
16     ffec27g33=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
17     ffec27g33=+(+1.-rx**2)*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
18     ffec27g33=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*(+1.-rz**2) 
      goto 1000
19     ffec27g33=+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
20     ffec27g33=+(+1.-rx**2)*ry*(+ry-1.)/2.*rz*(+1.+rz)/2. 
      goto 1000
21     ffec27g33=+rx*(+1.+rx)/2.*ry*(+ry-1.)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
22     ffec27g33=+rx*(+rx-1.)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
23     ffec27g33=+(+1.-rx**2)*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
24     ffec27g33=+rx*(+1.+rx)/2.*(+1.-ry**2)*rz*(+1.+rz)/2. 
      goto 1000
25     ffec27g33=+rx*(+rx-1.)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
26     ffec27g33=+(+1.-rx**2)*ry*(+1.+ry)/2.*rz*(+1.+rz)/2. 
      goto 1000
27     ffec27g33=+rx*(+1.+rx)/2.*ry*(+1.+ry)/2.*rz*(+1.+rz)/
     *2. 
      goto 1000
1000  return
      end

      subroutine fec27g34(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(8,4),rctr(3,3),crtr(3,3)
      external ffec27g34
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(ffec27g34,refc,shpr,3,8,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function ffec27g34(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccfec27g3/ xa(27),ya(27),za(27)
      common /vfec27g3/ rctr(3,3),crtr(3,3)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4,5,6,7,8) n
1     ffec27g34=+(+1.-rx)/2.*(+1.-ry)/2.*(+1.-rz)/2. 
      goto 1000
2     ffec27g34=+(+1.+rx)/2.*(+1.-ry)/2.*(+1.-rz)/2. 
      goto 1000
3     ffec27g34=+(+1.+rx)/2.*(+1.+ry)/2.*(+1.-rz)/2. 
      goto 1000
4     ffec27g34=+(+1.-rx)/2.*(+1.+ry)/2.*(+1.-rz)/2. 
      goto 1000
5     ffec27g34=+(+1.-rx)/2.*(+1.-ry)/2.*(+1.+rz)/2. 
      goto 1000
6     ffec27g34=+(+1.+rx)/2.*(+1.-ry)/2.*(+1.+rz)/2. 
      goto 1000
7     ffec27g34=+(+1.+rx)/2.*(+1.+ry)/2.*(+1.+rz)/2. 
      goto 1000
8     ffec27g34=+(+1.-rx)/2.*(+1.+ry)/2.*(+1.+rz)/2. 
      goto 1000
1000  return
      end

      subroutine tfec27g3(refc,coor,coorr,rc)
c .... compute coordinate value and Jacobi's matrix rc
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(3),coor(3),coorr(3,27),rc(3,3)
      common /ccfec27g3/ x(27),y(27),z(27)
      external ftfec27g3
      do 100 n=1,27
      x(n)=coorr(1,n)
      y(n)=coorr(2,n)
      z(n)=coorr(3,n)
100   continue
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dcoor(ftfec27g3,refc,coor,rc,3,3,1)
c .... coordinate value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function ftfec27g3(refc,n)
c .... coordinate transfer function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(3)
      common /ccfec27g3/ x(27),y(27),z(27)
      common /vfec27g3/ rctr(3,3),crtr(3,3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3) n
1     ftfec27g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-
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
2     ftfec27g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-
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
3     ftfec27g3=+(+rx*(+rx-1.)/2.*ry*(+ry-1.)/2.*rz*(+rz-
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