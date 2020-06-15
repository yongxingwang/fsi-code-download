      implicit real*8 (a-h,o-z)
      character*12 fname,filename(20)
      logical filflg
      character*12 fname1,fname2
      common /aa/ ia(180610000)
c.... open disp0 file to get the numbers of nodes and degree of freedom
c.... knode .... number of nodes, kdgof .... number of d.o.f.
      open(1,file=' ',form='unformatted')
      read(1) knode,kdgof
      close(1)
      kvar=knode*kdgof
      kcoor=2
      kna3=kdgof*knode*1
      if (kna3/2*2 .lt. kna3) kna3=kna3+1
      kna1=kcoor*knode*2
      kna2=kdgof*knode*2
      kna0=1
      kna1=kna1+kna0
      kna2=kna2+kna1
      kna3=kna3+kna2
      if (kna3-1.gt.180610000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 180610000'
      write(*,*) 'memory needed = ',kna3,' in prgram bft'
      stop 55555
      endif
      call bft(knode,kdgof,kcoor,tmax,
     *time,it,ia(kna0),ia(kna1),ia(kna2),
     *filename)
 
c ...... open the file to obtain graph file names
      inquire(file='plotname',exist=filflg)
      if (.not. filflg) then
      fname1 = 'unod'
      open(6,file='plotname',form='formatted',status='unknown')
      write(6,'(8a)') fname1
      close(6)
      endif
      open(6,file='plotname',form='formatted',status='old')
c ...... open the batch file for storing the result to graphic
      open(7,file='post.bat',form='formatted',status='unknown')
      open(8,file='pri.bat',form='formatted',status='unknown')  
c ...... store the result for each nstep time step
      nstep = 5
      ik = it/nstep
      kk = it-ik*nstep
cc      write(*,*) 'nstep,it,ik,kk =',nstep,it,ik,kk
      if (kk.gt.0) goto 9999 
	  
      nn=0
9998  continue
      nn=nn+1
c ...... get the graphic file name
      read(6,'(8a)',end=9999) fname1
c       write(*,*) 'fname1 =',fname1
      fname2 = fname1
      call getname(fname2,ik)
c ...... write copy command to post.bat file for storing the result
      if(nn .ge. 6) then
      write(8,*) 'copy ',fname2,' ',fname1	
      else
      write(7,*) 'copy ',fname1,' ',fname2	  
      endif
	  
      goto 9998
9999  continue
      close(6)
      close(7)
      close(8)
c       write(*,*) 'it =',it
c       write(*,*) fname1
c       write(*,*) fname2
 
c.......open stop file if the last time is arrived
      if (time-tmax.gt.-1.0d-20) then
cc       open(1,file=' ',form='unformatted',status='unknown')
       open(16,file='plotno',form='formatted',status='unknown')
       write(16,*) 1,ik
       close(16)
      endif
      end
      subroutine bft(knode,kdgof,kcoor,tmax,
     *time,it,coor,bf,nodvar,
     *filename)
      implicit real*8 (a-h,o-z)
      character*12 filename(20)
      dimension nodvar(kdgof,knode),coor(kcoor,knode),
     *  bf(kdgof,knode),r(3)
 
c.......open time file and update the time
      open(1,file=' ',form='unformatted')
      read(1) tmax,dt,time,it  
      t = time+dt
      time = time+dt
      it = it+1
cc        write(*,*) ' tmax,dt,time,it =',tmax,dt,time,it
      rewind(1)
      write(1) tmax,dt,time,it
      close(1)
 
c.......open coor file
      open (1,file=' ',form='unformatted',status='old')
      read (1) knode,ncoor,((coor(i,j),i=1,ncoor),j=1,knode)
      close(1)
 
c.......open nodvar file
      open (1,file=' ',form='unformatted',status='old')
      read (1) ((nodvar(i,j),i=1,kdgof),j=1,knode)
      close (1)
c     write(*,*) 'knode =',knode,' kdgof =',kdgof
c     write (*,*) 'nodvar ='
c     write (*,6) ((nodvar(i,j),i=1,kdgof),j=1,knode)
 
c......compute boundary condition
      do 333 n=1,knode
      do 100 j=1,ncoor
100   r(j) = coor(j,n)
      do 200 j=1,kdgof
      id = nodvar(j,n)
      bf(j,n) = 0.0
      if (id.lt.0) bf(j,n) = bound(r,t,j)
c     if (id.gt.0) bf(j,n) = force(r,t,j)
200   continue
333   continue
cc        write(*,*) ' bf = '
cc        write(*,'(6f13.3)') ((bf(j,n),j=1,kdgof),n=1,knode)
 
c.......open bfd file and write boundary condition
      open (1,file=' ',form='unformatted',status='unknown')
      write(1) ((bf(i,j),i=1,kdgof),j=1,knode)
      close (1)
c.......open bfdc file and write boundary condition
      open (1,file=' ',form='unformatted',status='unknown')
      write(1) ((bf(i,j),i=1,kdgof-1),j=1,knode)
      close (1)	  
c.......open stop file if the last time is arrived
      if (time-tmax.gt.-1.0d-20) then
      open(1,file=' ',form='unformatted',status='unknown')
      endif
      end
 
      subroutine getname(name,it)
      implicit real*8 (a-h,o-z)
      character name*12,ch3*4
c     if (it.lt.10) write(unit=ch3,fmt='(i1)') it
c     if (it.ge.10) write(unit=ch3,fmt='(i2)') it
c     if (it.ge.100) write(unit=ch3,fmt='(i3)') it
      call getext(it,ch3)
c     write(*,*) 'name =',name,'++++ ch3 =',ch3
      do 10 i=1,12
      if (name(i:i).eq.' ') then
      j=i
      goto 20
      endif
10    continue
20    continue
      if (j.gt.9) then
      write(*,*) 'error, plot filename too long .......',name
      write(*,*) ' the length of name must be less or equal 8 character'
      stop 111
      endif
c     read(*,'(a3)') ch3
      name(j:j)='.'
      name(j+1:j+4)=ch3
c     write(*,*) 'plot filename = ',name
      return
      end
 
      subroutine getext(ii,ch3)
      implicit real*8 (a-h,o-z)
      character ch3*4
      it = ii
      ch3 = '    '
      k = 0
      if (ii.ge.1000) then
      n = it/1000
      k = k+1	
      call getchar(n,k,ch3)
      it = it - n*1000	
      endif
      if (ii.ge.100) then
      n = it/100
      k = k+1
      call getchar(n,k,ch3)
      it = it - n*100
      endif
      if (ii.ge.10) then
      n = it/10
      k = k+1
      call getchar(n,k,ch3)
      it = it - n*10
      endif
      n = it
      k = k+1
      call getchar(n,k,ch3)
      return
      end
 
      subroutine getchar(n,k,ch3)
      implicit real*8 (a-h,o-z)
      character ch3*4
      if (n.eq.0) ch3(k:k) = '0'
      if (n.eq.1) ch3(k:k) = '1'
      if (n.eq.2) ch3(k:k) = '2'
      if (n.eq.3) ch3(k:k) = '3'
      if (n.eq.4) ch3(k:k) = '4'
      if (n.eq.5) ch3(k:k) = '5'
      if (n.eq.6) ch3(k:k) = '6'
      if (n.eq.7) ch3(k:k) = '7'
      if (n.eq.8) ch3(k:k) = '8'
      if (n.eq.9) ch3(k:k) = '9'
      return
      end

      real*8 function bound(r,t,j)
      implicit real*8 (a-h,o-z)
      dimension r(2)
      bound=0.d0 
	  
      ubar=1.d0
      ep=1.0d-4
      yb=5.d-1
	  
      x=r(1)	
      y=r(2)  	  
      if (x.le.ep .and. dabs(y).le.(yb+ep) .and. j.eq.1) then  
        if (t<1.d0) then
        bound=t*ubar*(yb+y)*(yb-y)/yb/yb
        else
        bound=ubar*(yb+y)*(yb-y)/yb/yb
        endif
      endif
	  
	  
	  
      return
      end
 