$debug
      implicit real*8 (a-h,o-z)
      character*12 fname,f0
      dimension u(2,10054)
	  
	  
      kdgof=2
      knode=10054
	  
      nodout=6936
	  
      open(10,file='ik.txt',status='old')
      read(10,*) ikmax, ik  

      open(1,file='extrplotres',form='formatted',status='old')
      read(1,'(8a)') fname  
      close(1)
	  
      ik=ik+1

      call getname(fname,ik) 

      open(1,file=fname,form='unformatted',status='unknown')   
      read(1) ((u(j,i),i=1,knode),j=1,kdgof)
      close(1)
	  
	  
      open (2,file='matdata\cd',form='formatted',access='append')
      write(2,100) u(2,nodout)
100   format(e15.8,e15.8)  	  
      close(2)	  
 
       if(ik.eq.ikmax) then
       open(1,file='stopc',form='unformatted',status='unknown')
       close(1)
       endif

      rewind(10)	   
      write(10,*) ikmax, ik  
      close(10)
  
	   
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
