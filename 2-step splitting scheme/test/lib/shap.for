      subroutine shap(nrefc,ncoor,nvar,shpr,shpc,cr,
     *                   dord,tolc,tolr)
      implicit real*8 (a-h,o-z)
      integer tolc,tolr,dord
      dimension shpr(nvar,tolr),shpc(nvar,tolc),cr(nrefc,ncoor)
c     write(*,*) 'nrefc,ncoor,nvar,dord,tolr,tolc='
c     write(*,9) nrefc,ncoor,nvar,dord,tolr,tolc
c     write(*,*) 'shpr ='
c     do 21 i=1,nvar
c21   write(*,8) (shpr(i,j),j=1,tolr)
      do 100 i=1,nvar
      lr=1
      lc=1
      shpc(i,lc)=shpr(i,lr)
      do 20 j=1,ncoor
      c=0.0
      do 10 k=1,nrefc
10    c = c + shpr(i,lr+k)*cr(k,j)
20    shpc(i,lc+j) = c
      lc = lc + ncoor
      lr = lr + nrefc
      if (dord.eq.1) goto 100
      do 60 j1=1,ncoor
      do 50 j2=j1,ncoor
      j = (2*ncoor-j1)*(j1-1)/2+j2
      c = 0.0
      do 40 k1=1,nrefc
      do 30 k2=k1,nrefc
      k = (2*nrefc-k1)*(k1-1)/2+k2
      c = c + shpr(i,lr+k)*cr(k1,j1)*cr(k2,j2)
      if (k1.lt.k2) c = c + shpr(i,lr+k)*cr(k2,j1)*cr(k1,j2)
30    continue
40    continue
50    shpc(i,lc+j) = c
60    continue
100   continue
c     write(*,*) 'shpc ='
c     do 22 i=1,nvar
c22   write(*,8) (shpc(i,j),j=1,tolc)
8     format(1x,8f9.2)
9     format(1x,15i4)
      return
      end
 
      subroutine shapn(nrefc,ncoor,nvar,shpr,shpc,cr,
     *                   dord,tolc,tolr)
      implicit real*8 (a-h,o-z)
      integer tolc,tolr,dord
      dimension shpr(nvar,tolr),shpc(nvar,tolc),cr(nrefc,ncoor)
c     write(*,*) 'nrefc,ncoor,nvar,dord,tolr,tolc='
c     write(*,9) nrefc,ncoor,nvar,dord,tolr,tolc
c     write(*,*) 'shpr ='
c     do 21 i=1,nvar
c21   write(*,8) (shpr(i,j),j=1,tolr)
      do 100 i=1,nvar
      lr=1
      lc=1
      shpc(i,lc)=shpr(i,lr)
      do 20 j=1,ncoor
      c=0.0
      do 10 k=1,nrefc
10    c = c + shpr(i,lr+k)*cr(k,j)
20    shpc(i,lc+j) = c
      lc = lc + ncoor
      lr = lr + nrefc
      if (dord.eq.1) goto 100
      do 60 j1=1,ncoor
      do 50 j2=j1,ncoor
      j = (2*ncoor-j1)*(j1-1)/2+j2
      c = 0.0
      do 40 k1=1,nrefc
      do 30 k2=k1,nrefc
      k = (2*nrefc-k1)*(k1-1)/2+k2
      c = c + shpr(i,lr+k)*cr(k1,j1)*cr(k2,j2)
      if (k1.lt.k2) c = c + shpr(i,lr+k)*cr(k2,j1)*cr(k1,j2)
30    continue
40    continue
50    shpc(i,lc+j) = c
60    continue
100   continue
c     write(*,*) 'shpc ='
c     do 22 i=1,nvar
c22   write(*,8) (shpc(i,j),j=1,tolc)
8     format(1x,6e13.4)
9     format(1x,15i5)
      return
      end
 
      subroutine shapc(nrefc,ncoor,nvar,shpr,shpc,cr,
     *                   dord,tolc,tolr)
      implicit real*8 (a-h,o-z)
      integer tolc,tolr,dord
      dimension shpr(nvar,tolr),shpc(nvar,tolc),cr(nrefc,ncoor)
c     write(*,*) 'nrefc,ncoor,nvar,dord,tolr,tolc='
c     write(*,9) nrefc,ncoor,nvar,dord,tolr,tolc
c     write(*,*) 'shpr ='
c     do 21 i=1,nvar
c21   write(*,8) (shpr(i,j),j=1,tolr)
      do 100 i=1,nvar
      lr=0
      lc=0
      do 20 j=1,ncoor
      c=0.0
      do 10 k=1,nrefc
10    c = c + shpr(i,lr+k)*cr(k,j)
20    shpc(i,lc+j) = c
      lc = lc + ncoor
      lr = lr + nrefc
      if (dord.eq.1) goto 100
      do 60 j1=1,ncoor
      do 50 j2=j1,ncoor
      j = (2*ncoor-j1)*(j1-1)/2+j2
      c = 0.0
      do 40 k1=1,nrefc
      do 30 k2=k1,nrefc
      k = (2*nrefc-k1)*(k1-1)/2+k2
      c = c + shpr(i,lr+k)*cr(k1,j1)*cr(k2,j2)
      if (k1.lt.k2) c = c + shpr(i,lr+k)*cr(k2,j1)*cr(k1,j2)
30    continue
40    continue
50    shpc(i,lc+j) = c
60    continue
100   continue
c     write(*,*) 'shpc ='
c     do 22 i=1,nvar
c22   write(*,8) (shpc(i,j),j=1,tolc)
8     format(1x,6e13.4)
9     format(1x,15i5)
      return
      end

      subroutine mstress6(kdgof,estr,emstr)
      implicit real*8 (a-h,o-z)
      dimension estr(kdgof),emstr(kdgof)
      a1=estr(1)+estr(2)+estr(3)
      a2=estr(1)*estr(2)+estr(2)*estr(3)+estr(3)*estr(1)
      a2=a2-estr(4)**2-estr(5)**2-estr(6)**2
      a3=estr(1)*estr(2)*estr(3)
      a3=a3+2*estr(4)*estr(5)*estr(6)
      a3=a3-estr(1)*estr(4)**2-estr(2)*estr(5)**2
      a3=a3-estr(3)*estr(6)**2
      emstr(1)=a1 
      emstr(2)=a2
      emstr(3)=a3 
      pi=4*datan(1.d0)
      p=a2-a1*a1/3.
      q=a1*a2/3.-2.*a1**3/27.-a3
      dd=(q*0.5)**2+(p/3.)**3
      if(dd.gt.0)  dd=-dd
      if(q.eq.0) then
      ang=pi/2
      else
      ang=datan2(2.*dsqrt(-dd),-q)
      end if
      if(p.gt.0) p=-p
      aa=2.*dsqrt(-p/3.)
      emstr(4)=aa*dcos(ang/3.)
      emstr(5)=aa*dcos((2*pi+ang)/3.)
      emstr(6)=aa*dcos((2*pi-ang)/3.)
      emstr(4)=emstr(4)+a1/3
      emstr(5)=emstr(5)+a1/3
      emstr(6)=emstr(6)+a1/3
      if (emstr(4).lt.emstr(5)) then
      etemp=emstr(4)
      emstr(4)=emstr(5)
      emstr(5)=etemp
      end if
      if (emstr(5).lt.emstr(6)) then
      etemp=emstr(5)
      emstr(5)=emstr(6)
      emstr(6)=etemp
      end if
      if (emstr(4).lt.emstr(5)) then
      etemp=emstr(4)
      emstr(4)=emstr(5)
      emstr(5)=etemp
      end if 
      return
      end

      subroutine mstress3(kdgof,estr,emstr)
      implicit real*8 (a-h,o-z)
      dimension estr(kdgof),emstr(kdgof)
      emstr(1)=estr(1)+estr(2)
      coefb=-estr(1)-estr(2)
      coefc=estr(1)*estr(2)-estr(3)**2
      emstr(2)=((-coefb)+dsqrt(coefb**2-4*coefc))/2
      emstr(3)=((-coefb)-dsqrt(coefb**2-4*coefc))/2
      if (emstr(2).lt.emstr(3)) then
      etemp=emstr(2)
      emstr(2)=emstr(3)
      emstr(3)=etemp
      endif
      return
      end

      subroutine mstress4(kdgof,estr,emstr)
      implicit real*8 (a-h,o-z)
      dimension estr(kdgof),emstr(kdgof)
      emstr(1)=estr(1)+estr(2)+estr(3)
      emstr(2)=estr(2)
      coefb=-estr(1)-estr(3)
      coefc=estr(1)*estr(3)-estr(4)**2
      emstr(3)=((-coefb)+dsqrt(coefb**2-4*coefc))/2
      emstr(4)=((-coefb)-dsqrt(coefb**2-4*coefc))/2
      if (emstr(2).lt.emstr(3)) then
      etemp=emstr(2)
      emstr(2)=emstr(3)
      emstr(3)=etemp
      endif
      if (emstr(3).lt.emstr(4)) then
      etemp=emstr(3)
      emstr(3)=emstr(4)
      emstr(4)=etemp
      endif
      if (emstr(2).lt.emstr(3)) then
      etemp=emstr(2)
      emstr(2)=emstr(3)
      emstr(3)=etemp
      endif
      return
      end
