      subroutine eew4(coorr,coefr,
     & prmt,estif,emass,edamp,eload,num)
c .... coorr ---- nodal coordinate value
c .... coefr ---- nodal coef value
      implicit real*8 (a-h,o-z)
      dimension estif(24,24),elump(24),emass(24),
     & eload(24)
      dimension prmt(*),coef(3),coefr(4,3),coorr(3,4),coor(3)
      common /reew4/rsxx(4,16),rsyy(4,16),rszz(4,16),
     & rsxy(4,16),rsyz(4,16),rsxz(4,16),
     & csxx(4,4),csyy(4,4),cszz(4,4),csxy(4,4),
     & csyz(4,4),csxz(4,4)
c .... store shape functions and their partial derivatives
c .... for all integral points
      common /veew4/rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      common /deew4/ refc(3,4),gaus(4),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(6),kdord(6),kvord(24,6)
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
	  
      if (num.eq.1) call eew4i
c .... initialize the basic data
      do 10 i=1,nvar
      emass(i)=0.0
      eload(i)=0.0
      do 10 j=1,nvar
      estif(i,j)=0.0
10    continue
      do 999 igaus=1,ngaus
      call eew4t(nnode,nrefc,ncoor,refc(1,igaus),coor,coorr,
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
      call eeew4(refc(1,igaus),coef,coorr,coefr,coefd)
c .... compute coef functions and their partial derivatives
      isxx=(igaus-1)*4+1
      isyy=(igaus-1)*4+1
      iszz=(igaus-1)*4+1
      isxy=(igaus-1)*4+1
      isyz=(igaus-1)*4+1
      isxz=(igaus-1)*4+1
      if (num.gt.1) goto 2
c .... the following is the shape function caculation
      call eew41(refc(1,igaus),rsxx(1,isxx),rctr,crtr)
      call eew42(refc(1,igaus),rsyy(1,isyy),rctr,crtr)
      call eew43(refc(1,igaus),rszz(1,iszz),rctr,crtr)
      call eew44(refc(1,igaus),rsxy(1,isxy),rctr,crtr)
      call eew45(refc(1,igaus),rsyz(1,isyz),rctr,crtr)
      call eew46(refc(1,igaus),rsxz(1,isxz),rctr,crtr)
2     continue
c .... the following is the shape function transformation
c .... from reference coordinates to original coordinates
      call shapn(nrefc,ncoor,4,rsxx(1,isxx),csxx,crtr,1,4,4)
      call shapn(nrefc,ncoor,4,rsyy(1,isyy),csyy,crtr,1,4,4)
      call shapn(nrefc,ncoor,4,rszz(1,iszz),cszz,crtr,1,4,4)
      call shapn(nrefc,ncoor,4,rsxy(1,isxy),csxy,crtr,1,4,4)
      call shapn(nrefc,ncoor,4,rsyz(1,isyz),csyz,crtr,1,4,4)
      call shapn(nrefc,ncoor,4,rsxz(1,isxz),csxz,crtr,1,4,4)
c .... the coef function transformation
c .... from reference coordinates to original coordinates
      call shapc(nrefc,ncoor,3,coefd,coefc,crtr,2,9,9)
      un=coef(1)
      vn=coef(2)
      wn=coef(3)
      weigh=det*gaus(igaus)
      fxx = +coefc(1,1)
      fxy = +coefc(1,2)
      fxz = +coefc(1,3)
      fyx = +coefc(2,1)
      fyy = +coefc(2,2)
      fyz = +coefc(2,3)
      fzx = +coefc(3,1)
      fzy = +coefc(3,2)
      fzz = +coefc(3,3)
      enxx = +fxx*fxx+fxy*fxy+fxz*fxz
      enxy = +fxx*fyx+fxy*fyy+fxz*fyz
      enxz = +fxx*fzx+fxy*fzy+fxz*fzz
      enyx = +fyx*fxx+fyy*fxy+fyz*fxz
      enyy = +fyx*fyx+fyy*fyy+fyz*fyz
      enyz = +fyx*fzx+fyy*fzy+fyz*fzz
      enzx = +fzx*fxx+fzy*fxy+fzz*fxz
      enzy = +fzx*fyx+fzy*fyy+fzz*fyz
      enzz = +fzx*fzx+fzy*fzy+fzz*fzz
      enxx = +enxx-1
      enyy = +enyy-1
      enzz = +enzz-1
      snxx = +enxx*eg
      snxy = +enxy*eg
      snxz = +enxz*eg
      snyx = +enyx*eg
      snyy = +enyy*eg
      snyz = +enyz*eg
      snzx = +enzx*eg
      snzy = +enzy*eg
      snzz = +enzz*eg
      if((num.eq.1).and.(igaus.eq.1)) then
        open(97,file='gpstr',form='formatted')
      endif
      write(97,*) snxx,snyy,snzz,snxy,snyz,snxz
      if((num.eq.nelem).and.(igaus.eq.ngaus)) then
        close(97)
      endif
c .... the following is the stiffness computation
      do 202 i=1,4
      iv=kvord(i,1)
      do 201 j=1,4
      jv=kvord(j,1)
      stif=+csxx(i,1)*csxx(j,1)*0.d0
      estif(iv,jv)=estif(iv,jv)+stif*weigh
201    continue
202    continue
c .... the following is the mass matrix computation
      stif=1.d0
      elump(1)=stif*weigh
      stif=1.d0
      elump(7)=stif*weigh
      stif=1.d0
      elump(13)=stif*weigh
      stif=1.d0
      elump(19)=stif*weigh
      stif=1.d0
      elump(2)=stif*weigh
      stif=1.d0
      elump(8)=stif*weigh
      stif=1.d0
      elump(14)=stif*weigh
      stif=1.d0
      elump(20)=stif*weigh
      stif=1.d0
      elump(3)=stif*weigh
      stif=1.d0
      elump(9)=stif*weigh
      stif=1.d0
      elump(15)=stif*weigh
      stif=1.d0
      elump(21)=stif*weigh
      stif=1.d0
      elump(4)=stif*weigh
      stif=1.d0
      elump(10)=stif*weigh
      stif=1.d0
      elump(16)=stif*weigh
      stif=1.d0
      elump(22)=stif*weigh
      stif=1.d0
      elump(5)=stif*weigh
      stif=1.d0
      elump(11)=stif*weigh
      stif=1.d0
      elump(17)=stif*weigh
      stif=1.d0
      elump(23)=stif*weigh
      stif=1.d0
      elump(6)=stif*weigh
      stif=1.d0
      elump(12)=stif*weigh
      stif=1.d0
      elump(18)=stif*weigh
      stif=1.d0
      elump(24)=stif*weigh
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
      emass(iv)=emass(iv)+elump(iv)*cszz(i,1)
303   continue
      do 304 i=1,nvard(4)
      iv = kvord(i,4)
      emass(iv)=emass(iv)+elump(iv)*csxy(i,1)
304   continue
      do 305 i=1,nvard(5)
      iv = kvord(i,5)
      emass(iv)=emass(iv)+elump(iv)*csyz(i,1)
305   continue
      do 306 i=1,nvard(6)
      iv = kvord(i,6)
      emass(iv)=emass(iv)+elump(iv)*csxz(i,1)
306   continue
c .... the following is the load vector computation
      do 501 i=1,4
      iv=kvord(i,1)
      stif=+csxx(i,1)*snxx
      eload(iv)=eload(iv)+stif*weigh
501   continue
      do 502 i=1,4
      iv=kvord(i,2)
      stif=+csyy(i,1)*snyy
      eload(iv)=eload(iv)+stif*weigh
502   continue
      do 503 i=1,4
      iv=kvord(i,3)
      stif=+cszz(i,1)*snzz
      eload(iv)=eload(iv)+stif*weigh
503   continue
      do 504 i=1,4
      iv=kvord(i,4)
      stif=+csxy(i,1)*snxy
      eload(iv)=eload(iv)+stif*weigh
504   continue
      do 505 i=1,4
      iv=kvord(i,5)
      stif=+csyz(i,1)*snyz
      eload(iv)=eload(iv)+stif*weigh
505   continue
      do 506 i=1,4
      iv=kvord(i,6)
      stif=+csxz(i,1)*snxz
      eload(iv)=eload(iv)+stif*weigh
506   continue
999   continue
998   continue
      return
      end

      subroutine eew4i
      implicit real*8 (a-h,o-z)
      common /deew4/ refc(3,4),gaus(4),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(6),kdord(6),kvord(24,6)
c .... initial data
c .... refc ---- reference coordinates at integral points
c .... gaus ---- weight number at integral points
c .... nvard ---- the number of var for each unknown
c .... kdord ---- the highest differential order for each unknown
c .... kvord ---- var number at integral points for each unknown
      ngaus=  4
      ndisp=  6
      nrefc=  3
      ncoor=  3
      nvar = 24
      nnode=  4
      kdord(1)=1
      nvard(1)=4
      kvord(1,1)=1
      kvord(2,1)=7
      kvord(3,1)=13
      kvord(4,1)=19
      kdord(2)=1
      nvard(2)=4
      kvord(1,2)=2
      kvord(2,2)=8
      kvord(3,2)=14
      kvord(4,2)=20
      kdord(3)=1
      nvard(3)=4
      kvord(1,3)=3
      kvord(2,3)=9
      kvord(3,3)=15
      kvord(4,3)=21
      kdord(4)=1
      nvard(4)=4
      kvord(1,4)=4
      kvord(2,4)=10
      kvord(3,4)=16
      kvord(4,4)=22
      kdord(5)=1
      nvard(5)=4
      kvord(1,5)=5
      kvord(2,5)=11
      kvord(3,5)=17
      kvord(4,5)=23
      kdord(6)=1
      nvard(6)=4
      kvord(1,6)=6
      kvord(2,6)=12
      kvord(3,6)=18
      kvord(4,6)=24
      refc(1,1)=1.000000e+00
      refc(2,1)=0.000000e+00
      refc(3,1)=0.000000e+00
      gaus(1)=0.041666667
      refc(1,2)=0.000000e+00
      refc(2,2)=1.000000e+00
      refc(3,2)=0.000000e+00
      gaus(2)=0.041666667
      refc(1,3)=0.000000e+00
      refc(2,3)=0.000000e+00
      refc(3,3)=0.000000e+00
      gaus(3)=0.041666667
      refc(1,4)=0.000000e+00
      refc(2,4)=0.000000e+00
      refc(3,4)=1.000000e+00
      gaus(4)=0.041666667
      end


      subroutine eew4t(nnode,nrefc,ncoor,refc,coor,coorr,
     & rc,cr,det,coefr)
      implicit real*8 (a-h,o-z)
      dimension refc(nrefc),rc(ncoor,nrefc),cr(nrefc,ncoor),a(5,10),
     & coorr(ncoor,nnode),coor(ncoor),coefr(nnode,*)
      call teew4(refc,coor,coorr,coefr,rc)
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

      subroutine eew41(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(4,4),rctr(3,3),crtr(3,3)
      external feew41
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(feew41,refc,shpr,3,4,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feew41(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /cceew4/ xa(4),ya(4),za(4),una(4),
     &vna(4),wna(4)
      common /veew4/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4) n
1     feew41=+rx 
      goto 1000
2     feew41=+ry 
      goto 1000
3     feew41=+rz 
      goto 1000
4     feew41=+(+1.-rx-ry-rz) 
      goto 1000
1000  return
      end

      subroutine eew42(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(4,4),rctr(3,3),crtr(3,3)
      external feew42
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(feew42,refc,shpr,3,4,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feew42(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /cceew4/ xa(4),ya(4),za(4),una(4),
     &vna(4),wna(4)
      common /veew4/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4) n
1     feew42=+rx 
      goto 1000
2     feew42=+ry 
      goto 1000
3     feew42=+rz 
      goto 1000
4     feew42=+(+1.-rx-ry-rz) 
      goto 1000
1000  return
      end

      subroutine eew43(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(4,4),rctr(3,3),crtr(3,3)
      external feew43
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(feew43,refc,shpr,3,4,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feew43(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /cceew4/ xa(4),ya(4),za(4),una(4),
     &vna(4),wna(4)
      common /veew4/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4) n
1     feew43=+rx 
      goto 1000
2     feew43=+ry 
      goto 1000
3     feew43=+rz 
      goto 1000
4     feew43=+(+1.-rx-ry-rz) 
      goto 1000
1000  return
      end

      subroutine eew44(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(4,4),rctr(3,3),crtr(3,3)
      external feew44
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(feew44,refc,shpr,3,4,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feew44(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /cceew4/ xa(4),ya(4),za(4),una(4),
     &vna(4),wna(4)
      common /veew4/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4) n
1     feew44=+rx 
      goto 1000
2     feew44=+ry 
      goto 1000
3     feew44=+rz 
      goto 1000
4     feew44=+(+1.-rx-ry-rz) 
      goto 1000
1000  return
      end

      subroutine eew45(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(4,4),rctr(3,3),crtr(3,3)
      external feew45
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(feew45,refc,shpr,3,4,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feew45(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /cceew4/ xa(4),ya(4),za(4),una(4),
     &vna(4),wna(4)
      common /veew4/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4) n
1     feew45=+rx 
      goto 1000
2     feew45=+ry 
      goto 1000
3     feew45=+rz 
      goto 1000
4     feew45=+(+1.-rx-ry-rz) 
      goto 1000
1000  return
      end

      subroutine eew46(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(4,4),rctr(3,3),crtr(3,3)
      external feew46
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(feew46,refc,shpr,3,4,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feew46(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /cceew4/ xa(4),ya(4),za(4),una(4),
     &vna(4),wna(4)
      common /veew4/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4) n
1     feew46=+rx 
      goto 1000
2     feew46=+ry 
      goto 1000
3     feew46=+rz 
      goto 1000
4     feew46=+(+1.-rx-ry-rz) 
      goto 1000
1000  return
      end

      subroutine teew4(refc,coor,coorr,coefr,rc)
c .... compute coordinate value and Jacobi's matrix rc
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(3),coor(3),coorr(3,4),coefr(4,3),rc(3,3)
      common /cceew4/ x(4),y(4),z(4),un(4),vn(4),wn(4)
      external fteew4
      do 100 n=1,4
      x(n)=coorr(1,n)
      y(n)=coorr(2,n)
      z(n)=coorr(3,n)
100   continue
      do 200 n=1,4
      un(n)=coefr(n,1)
      vn(n)=coefr(n,2)
      wn(n)=coefr(n,3)
200   continue
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dcoor(fteew4,refc,coor,rc,3,3,1)
c .... coordinate value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fteew4(refc,n)
c .... coordinate transfer function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(3)
      common /cceew4/ x(4),y(4),z(4),un(4),vn(4),wn(4)
      common /veew4/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3) n
1     fteew4=+(+rx)*x(1)+(+ry)*x(2)+(+rz)*x(3)+(+(+1.-rx-
     & ry-rz))*x(4)
      goto 1000
2     fteew4=+(+rx)*y(1)+(+ry)*y(2)+(+rz)*y(3)+(+(+1.-rx-
     & ry-rz))*y(4)
      goto 1000
3     fteew4=+(+rx)*z(1)+(+ry)*z(2)+(+rz)*z(3)+(+(+1.-rx-
     & ry-rz))*z(4)
      goto 1000
1000  return
      end

      subroutine eeew4(refc,coef,coorr,coefr,coefd)
c .... compute coef value and their partial derivatives
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(3),coef(3),coorr(3,4),coefr(4,3),coefd(3,3)
      external feeew4
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dcoef(feeew4,refc,coef,coefd,3,3,2)
c .... coef value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function feeew4(refc,n)
c .... coef function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(3)
      common /cceew4/ xa(4),ya(4),za(4),un(4),vn(4),wn(4)
      common /veew4/ rctr(3,3),crtr(3,3),coefd(3,9),coefc(3,9)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3) n
1     feeew4=+(+rx)*un(1)+(+ry)*un(2)+(+rz)*un(3)+(+(+1.-
     & rx-ry-rz))*un(4)
      goto 1000
2     feeew4=+(+rx)*vn(1)+(+ry)*vn(2)+(+rz)*vn(3)+(+(+1.-
     & rx-ry-rz))*vn(4)
      goto 1000
3     feeew4=+(+rx)*wn(1)+(+ry)*wn(2)+(+rz)*wn(3)+(+(+1.-
     & rx-ry-rz))*wn(4)
      goto 1000
1000  return
      end