      subroutine dew4(coorr,coefr,
     & prmt,estif,emass,edamp,eload,num)
c .... coorr ---- nodal coordinate value
c .... coefr ---- nodal coef value
      implicit real*8 (a-h,o-z)
      dimension estif(12,12),elump(12),emass(12),
     & eload(12)
      dimension prmt(*),coorr(3,4),coor(3)
      common /rdew4/ru(4,16),rv(4,16),rw(4,16),
     & cu(4,4),cv(4,4),cw(4,4)
c .... store shape functions and their partial derivatives
c .... for all integral points
      common /vdew4/rctr(3,3),crtr(3,3)
      common /ddew4/ refc(3,4),gaus(4),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(3),kdord(3),kvord(12,3)
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
      if (num.eq.1) call dew4i
c .... initialize the basic data
      do 10 i=1,nvar
      emass(i)=0.0
      eload(i)=0.0
      do 10 j=1,nvar
      estif(i,j)=0.0
10    continue
      do 999 igaus=1,ngaus
      call dew4t(nnode,nrefc,ncoor,refc(1,igaus),coor,coorr,
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
      if (num.gt.1) goto 2
c .... the following is the shape function caculation
      call dew41(refc(1,igaus),ru(1,iu),rctr,crtr)
      call dew42(refc(1,igaus),rv(1,iv),rctr,crtr)
      call dew43(refc(1,igaus),rw(1,iw),rctr,crtr)
2     continue
c .... the following is the shape function transformation
c .... from reference coordinates to original coordinates
      call shapn(nrefc,ncoor,4,ru(1,iu),cu,crtr,1,4,4)
      call shapn(nrefc,ncoor,4,rv(1,iv),cv,crtr,1,4,4)
      call shapn(nrefc,ncoor,4,rw(1,iw),cw,crtr,1,4,4)
      weigh=det*gaus(igaus)
      if((num.eq.1).and.(igaus.eq.1)) then
      open(97,file='gpstr',form='formatted')
      endif
      read(97,*) sxx,syy,szz,sxy,syz,sxz
      if((num.eq.nelem).and.(igaus.eq.ngaus)) then
      close(97)
      endif
c .... the following is the stiffness computation
      do 202 i=1,4
      iv=kvord(i,1)
      do 201 j=1,4
      jv=kvord(j,1)
      stif=+cu(i,2)*cu(j,2)*sxx*dt
     & +cu(i,2)*cu(j,3)*sxy*dt
     & +cu(i,2)*cu(j,4)*sxz*dt
     & +cu(i,2)*cu(j,2)*sxx*dt
     & +cu(i,2)*cu(j,3)*sxy*dt
     & +cu(i,2)*cu(j,4)*sxz*dt
     & +cu(i,3)*cu(j,2)*sxy*dt
     & +cu(i,3)*cu(j,3)*syy*dt
     & +cu(i,3)*cu(j,4)*syz*dt
     & +cu(i,4)*cu(j,2)*sxz*dt
     & +cu(i,4)*cu(j,3)*syz*dt
     & +cu(i,4)*cu(j,4)*szz*dt
     & +cu(i,2)*cu(j,2)*eg*dt
     & +cu(i,2)*cu(j,2)*eg*dt
     & +cu(i,3)*cu(j,3)*eg*dt
     & +cu(i,4)*cu(j,4)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
201    continue
202    continue
      do 204 i=1,4
      iv=kvord(i,1)
      do 203 j=1,4
      jv=kvord(j,2)
      stif=+cu(i,3)*cv(j,2)*sxx*dt
     & +cu(i,3)*cv(j,3)*sxy*dt
     & +cu(i,3)*cv(j,4)*sxz*dt
     & +cu(i,3)*cv(j,2)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
203    continue
204    continue
      do 206 i=1,4
      iv=kvord(i,1)
      do 205 j=1,4
      jv=kvord(j,3)
      stif=+cu(i,4)*cw(j,2)*sxx*dt
     & +cu(i,4)*cw(j,3)*sxy*dt
     & +cu(i,4)*cw(j,4)*sxz*dt
     & +cu(i,4)*cw(j,2)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
205    continue
206    continue
      do 208 i=1,4
      iv=kvord(i,2)
      do 207 j=1,4
      jv=kvord(j,1)
      stif=+cv(i,2)*cu(j,2)*sxy*dt
     & +cv(i,2)*cu(j,3)*syy*dt
     & +cv(i,2)*cu(j,4)*syz*dt
     & +cv(i,2)*cu(j,3)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
207    continue
208    continue
      do 210 i=1,4
      iv=kvord(i,2)
      do 209 j=1,4
      jv=kvord(j,2)
      stif=+cv(i,3)*cv(j,2)*sxy*dt
     & +cv(i,3)*cv(j,3)*syy*dt
     & +cv(i,3)*cv(j,4)*syz*dt
     & +cv(i,2)*cv(j,2)*sxx*dt
     & +cv(i,2)*cv(j,3)*sxy*dt
     & +cv(i,2)*cv(j,4)*sxz*dt
     & +cv(i,3)*cv(j,2)*sxy*dt
     & +cv(i,3)*cv(j,3)*syy*dt
     & +cv(i,3)*cv(j,4)*syz*dt
     & +cv(i,4)*cv(j,2)*sxz*dt
     & +cv(i,4)*cv(j,3)*syz*dt
     & +cv(i,4)*cv(j,4)*szz*dt
     & +cv(i,3)*cv(j,3)*eg*dt
     & +cv(i,2)*cv(j,2)*eg*dt
     & +cv(i,3)*cv(j,3)*eg*dt
     & +cv(i,4)*cv(j,4)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
209    continue
210    continue
      do 212 i=1,4
      iv=kvord(i,2)
      do 211 j=1,4
      jv=kvord(j,3)
      stif=+cv(i,4)*cw(j,2)*sxy*dt
     & +cv(i,4)*cw(j,3)*syy*dt
     & +cv(i,4)*cw(j,4)*syz*dt
     & +cv(i,4)*cw(j,3)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
211    continue
212    continue
      do 214 i=1,4
      iv=kvord(i,3)
      do 213 j=1,4
      jv=kvord(j,1)
      stif=+cw(i,2)*cu(j,2)*sxz*dt
     & +cw(i,2)*cu(j,3)*syz*dt
     & +cw(i,2)*cu(j,4)*szz*dt
     & +cw(i,2)*cu(j,4)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
213    continue
214    continue
      do 216 i=1,4
      iv=kvord(i,3)
      do 215 j=1,4
      jv=kvord(j,2)
      stif=+cw(i,3)*cv(j,2)*sxz*dt
     & +cw(i,3)*cv(j,3)*syz*dt
     & +cw(i,3)*cv(j,4)*szz*dt
     & +cw(i,3)*cv(j,4)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
215    continue
216    continue
      do 218 i=1,4
      iv=kvord(i,3)
      do 217 j=1,4
      jv=kvord(j,3)
      stif=+cw(i,4)*cw(j,2)*sxz*dt
     & +cw(i,4)*cw(j,3)*syz*dt
     & +cw(i,4)*cw(j,4)*szz*dt
     & +cw(i,2)*cw(j,2)*sxx*dt
     & +cw(i,2)*cw(j,3)*sxy*dt
     & +cw(i,2)*cw(j,4)*sxz*dt
     & +cw(i,3)*cw(j,2)*sxy*dt
     & +cw(i,3)*cw(j,3)*syy*dt
     & +cw(i,3)*cw(j,4)*syz*dt
     & +cw(i,4)*cw(j,2)*sxz*dt
     & +cw(i,4)*cw(j,3)*syz*dt
     & +cw(i,4)*cw(j,4)*szz*dt
     & +cw(i,4)*cw(j,4)*eg*dt
     & +cw(i,2)*cw(j,2)*eg*dt
     & +cw(i,3)*cw(j,3)*eg*dt
     & +cw(i,4)*cw(j,4)*eg*dt
      estif(iv,jv)=estif(iv,jv)+stif*weigh
217    continue
218    continue
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
      elump(2)=stif*weigh
      stif=rou
      elump(5)=stif*weigh
      stif=rou
      elump(8)=stif*weigh
      stif=rou
      elump(11)=stif*weigh
      stif=rou
      elump(3)=stif*weigh
      stif=rou
      elump(6)=stif*weigh
      stif=rou
      elump(9)=stif*weigh
      stif=rou
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
c .... the following is the load vector computation
      do 501 i=1,4
      iv=kvord(i,1)
      stif=+cu(i,1)*gx*rou
     & -cu(i,2)*sxx
     & -cu(i,3)*sxy
     & -cu(i,4)*sxz
      eload(iv)=eload(iv)+stif*weigh
501   continue
      do 502 i=1,4
      iv=kvord(i,2)
      stif=+cv(i,1)*gy*rou
     & -cv(i,2)*sxy
     & -cv(i,3)*syy
     & -cv(i,4)*syz
      eload(iv)=eload(iv)+stif*weigh
502   continue
      do 503 i=1,4
      iv=kvord(i,3)
      stif=+cw(i,1)*gz*rou
     & -cw(i,2)*sxz
     & -cw(i,3)*syz
     & -cw(i,4)*szz
      eload(iv)=eload(iv)+stif*weigh
503   continue
999   continue
998   continue
      return
      end

      subroutine dew4i
      implicit real*8 (a-h,o-z)
      common /ddew4/ refc(3,4),gaus(4),
     & nnode,ngaus,ndisp,nrefc,ncoor,nvar,
     & nvard(3),kdord(3),kvord(12,3)
c .... initial data
c .... refc ---- reference coordinates at integral points
c .... gaus ---- weight number at integral points
c .... nvard ---- the number of var for each unknown
c .... kdord ---- the highest differential order for each unknown
c .... kvord ---- var number at integral points for each unknown
      ngaus=  4
      ndisp=  3
      nrefc=  3
      ncoor=  3
      nvar = 12
      nnode=  4
      kdord(1)=1
      nvard(1)=4
      kvord(1,1)=1
      kvord(2,1)=4
      kvord(3,1)=7
      kvord(4,1)=10
      kdord(2)=1
      nvard(2)=4
      kvord(1,2)=2
      kvord(2,2)=5
      kvord(3,2)=8
      kvord(4,2)=11
      kdord(3)=1
      nvard(3)=4
      kvord(1,3)=3
      kvord(2,3)=6
      kvord(3,3)=9
      kvord(4,3)=12
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


      subroutine dew4t(nnode,nrefc,ncoor,refc,coor,coorr,
     & rc,cr,det)
      implicit real*8 (a-h,o-z)
      dimension refc(nrefc),rc(ncoor,nrefc),cr(nrefc,ncoor),a(5,10),
     & coorr(ncoor,nnode),coor(ncoor)
      call tdew4(refc,coor,coorr,rc)
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

      subroutine dew41(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(4,4),rctr(3,3),crtr(3,3)
      external fdew41
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(fdew41,refc,shpr,3,4,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fdew41(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccdew4/ xa(4),ya(4),za(4)
      common /vdew4/ rctr(3,3),crtr(3,3)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4) n
1     fdew41=+rx 
      goto 1000
2     fdew41=+ry 
      goto 1000
3     fdew41=+rz 
      goto 1000
4     fdew41=+(+1.-rx-ry-rz) 
      goto 1000
1000  return
      end

      subroutine dew42(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(4,4),rctr(3,3),crtr(3,3)
      external fdew42
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(fdew42,refc,shpr,3,4,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fdew42(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccdew4/ xa(4),ya(4),za(4)
      common /vdew4/ rctr(3,3),crtr(3,3)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4) n
1     fdew42=+rx 
      goto 1000
2     fdew42=+ry 
      goto 1000
3     fdew42=+rz 
      goto 1000
4     fdew42=+(+1.-rx-ry-rz) 
      goto 1000
1000  return
      end

      subroutine dew43(refc,shpr,rctr,crtr)
c .... compute shape functions and their partial derivatives
c .... shapr ---- store shape functions and their partial derivatives
      implicit real*8 (a-h,o-z)
      dimension refc(3),shpr(4,4),rctr(3,3),crtr(3,3)
      external fdew43
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dshap(fdew43,refc,shpr,3,4,1)
c .... shape function and their derivatives computation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function fdew43(refc,n)
c .... shape function caculation
      implicit real*8 (a-h,o-z)
      common /ccdew4/ xa(4),ya(4),za(4)
      common /vdew4/ rctr(3,3),crtr(3,3)
      dimension refc(3)
      common /coord/ coor(3),coora(27,3)
      x=coor(1)
      y=coor(2)
      z=coor(3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3,4) n
1     fdew43=+rx 
      goto 1000
2     fdew43=+ry 
      goto 1000
3     fdew43=+rz 
      goto 1000
4     fdew43=+(+1.-rx-ry-rz) 
      goto 1000
1000  return
      end

      subroutine tdew4(refc,coor,coorr,rc)
c .... compute coordinate value and Jacobi's matrix rc
c .... by reference coordinate value
      implicit real*8 (a-h,o-z)
      dimension refc(3),coor(3),coorr(3,4),rc(3,3)
      common /ccdew4/ x(4),y(4),z(4)
      external ftdew4
      do 100 n=1,4
      x(n)=coorr(1,n)
      y(n)=coorr(2,n)
      z(n)=coorr(3,n)
100   continue
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      call dcoor(ftdew4,refc,coor,rc,3,3,1)
c .... coordinate value and their partial derivatives caculation
c .... compute partial derivatives by centered difference
c .... which is in the file ccshap.for of FEPG library
      return
      end

      real*8 function ftdew4(refc,n)
c .... coordinate transfer function caculation
      implicit real*8 (a-h,o-z)
      dimension refc(3)
      common /ccdew4/ x(4),y(4),z(4)
      common /vdew4/ rctr(3,3),crtr(3,3)
      rx=refc(1)
      ry=refc(2)
      rz=refc(3)
      goto (1,2,3) n
1     ftdew4=+(+rx)*x(1)+(+ry)*x(2)+(+rz)*x(3)+(+(+1.-rx-
     & ry-rz))*x(4)
      goto 1000
2     ftdew4=+(+rx)*y(1)+(+ry)*y(2)+(+rz)*y(3)+(+(+1.-rx-
     & ry-rz))*y(4)
      goto 1000
3     ftdew4=+(+rx)*z(1)+(+ry)*z(2)+(+rz)*z(3)+(+(+1.-rx-
     & ry-rz))*z(4)
      goto 1000
1000  return
      end