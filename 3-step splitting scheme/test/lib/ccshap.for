 
      subroutine dshap(f,x,shap,nrefc,nvar,ndord)
      implicit real*8 (a-h,o-z)
      dimension x(3),shap(nvar,*),dfdx(10)
      external f
c      write(*,*) 'dshap sub nvar ====',nvar
      do 200 n=1,nvar
c      write(*,*) 'dshap sub n ====',n
      call sdfdx(f,x,nrefc,dfdx,ndord,n,m)
      do 100 i=1,m
      shap(n,i) = dfdx(i)
100   continue
200   continue
      return
      end
 
      subroutine dcoef(f,x,cc,dc,nrefc,nvar,ndord)
      implicit real*8 (a-h,o-z)
      dimension x(3),cc(*),dc(nvar,*),dfdx(10)
      external f
c      write(*,*) 'dcoef sub nvar ====',nvar
      do 200 n=1,nvar
c      write(*,*) 'dcoef sub n ====',n
      call sdfdx(f,x,nrefc,dfdx,ndord,n,m)
      cc(n) = dfdx(1)
      do 100 i=1,m-1
      dc(n,i) = dfdx(i+1)
100   continue
200   continue
      return
      end
 
      subroutine sdfdx(f,x,n,dfdx,ndord,iv,m)
      implicit real*8 (a-h,o-z)
      common /coord/ coor(3),coora(27,3)
      dimension x(n),y(3),fx(27),dfdx(*)
      external f
      h = 0.001
      h2 = h*2
c      write(*,*) 'h =',h,'     x =',x
      m = 0
      do 300 i=-1,1
      y(3) = x(3)+h*i
      do 200 j=-1,1
      y(2) = x(2)+h*j
      do 100 k=-1,1
      y(1) = x(1)+h*k
      m = m+1
      if ((n.eq.1) .and. (i*j.ne.0)) goto 100
      if ((n.eq.2) .and. (i.ne.0)) goto 100
      if (ndord.eq.1) then
      kk = k*k+j*j+i*i
      if (kk.gt.1) goto 100
      endif
      do 50 l=1,3
      coor(l)=coora(m,l)
50    continue
      fx(m) = f(y,iv)
c      write(*,'(1x,i3,4f10.4)') m,y,fx(m)
100   continue
200   continue
300   continue
400   continue
c      write(*,*) 'iv,n,m =',iv,n,m,'     fx ='
c      write(*,'(9f8.3)') (fx(i),i=1,m)
      mm = m/2+1
      dfdx(1) = fx(mm)
      m = n+1
      do 500 i=1,n
      j = 3**(i-1)
      dfdx(i+1) = (fx(mm+j)-fx(mm-j))/h2
500   continue
      if (ndord.eq.1) goto 1000
      do 900 i=1,n
      do 800 j=i,n
      i1 = 3**(i-1)
      j1 = 3**(j-1)
      m = m+1
      if (i.eq.j) then
      dfdx(m) = (fx(mm+i1)+fx(mm-i1)-fx(mm)*2)/h/h
      else
      dfdx(m) = (fx(mm+j1+i1)+fx(mm-j1-i1)
     &          -fx(mm+j1-1)-fx(mm-i1-1))/h2/h2
      endif
c     write(*,*) 'i,j,i1,j1,m,dfdx =',i,j,i1,j1,m,dfdx(m)
800   continue
900   continue
1000  continue
c      write(*,*) 'n,m =',n,m,'      dfdx ='
c      write(*,*) (dfdx(i),i=1,m)
      return
      end
 
      subroutine dcoor(f,x,cc,dc,nrefc,nvar,ndord)
      implicit real*8 (a-h,o-z)
      common /coord/ coor(3),coora(27,3)
      dimension x(3),cc(*),dc(nvar,*),dfdx(10)
      external f
c      write(*,*) 'dcoef sub nvar ====',nvar
      do 200 n=1,nvar
c      write(*,*) 'dcoef sub n ====',n
      call sdcdx(f,x,nrefc,dfdx,coora(1,n),ndord,n,m)
      cc(n) = dfdx(1)
      do 100 i=1,m-1
      dc(n,i) = dfdx(i+1)
100   continue
200   continue
c      write(*,*) 'coora =',coora
      return
      end
 
      subroutine sdcdx(f,x,n,dfdx,fx,ndord,iv,m)
      implicit real*8 (a-h,o-z)
      dimension x(n),y(3),fx(27),dfdx(*)
      external f
      h = 0.001
      h2 = h*2
c      write(*,*) 'h =',h,'     x =',x
      m = 0
      do 300 i=-1,1
      y(3) = x(3)+h*i
      do 200 j=-1,1
      y(2) = x(2)+h*j
      do 100 k=-1,1
      y(1) = x(1)+h*k
      m = m+1
      if ((n.eq.1) .and. (i*j.ne.0)) goto 100
      if ((n.eq.2) .and. (i.ne.0)) goto 100
      if (ndord.eq.1) then
      kk = k*k+j*j+i*i
      if (kk.gt.1) goto 100
      endif
      fx(m) = f(y,iv)
c      write(*,'(1x,i3,4f10.4)') m,y,fx(m)
100   continue
200   continue
300   continue
400   continue
c      write(*,*) 'iv,n,m =',iv,n,m,'     fx ='
c      write(*,'(9f8.3)') (fx(i),i=1,m)
      mm = m/2+1
      dfdx(1) = fx(mm)
      m = n+1
      do 500 i=1,n
      j = 3**(i-1)
      dfdx(i+1) = (fx(mm+j)-fx(mm-j))/h2
500   continue
      if (ndord.eq.1) goto 1000
      do 900 i=1,n
      do 800 j=i,n
      i1 = 3**(i-1)
      j1 = 3**(j-1)
      m = m+1
      if (i.eq.j) then
      dfdx(m) = (fx(mm+i1)+fx(mm-i1)-fx(mm)*2)/h/h
      else
      dfdx(m) = (fx(mm+j1+i1)+fx(mm-j1-i1)
     &          -fx(mm+j1-1)-fx(mm-i1-1))/h2/h2
      endif
c     write(*,*) 'i,j,i1,j1,m,dfdx =',i,j,i1,j1,m,dfdx(m)
800   continue
900   continue
1000  continue
c      write(*,*) 'n,m =',n,m,'      dfdx ='
c      write(*,*) (dfdx(i),i=1,m)
      return
      end
