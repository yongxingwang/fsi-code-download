      implicit real*8 (a-h,o-z)
      character*12 fname0,fname1,fname2,fname01
      character*12 gname0,gname1,gname2,gname01
      character*36 path


      open(1,file='run.bat',form='formatted',status='unknown')

	  
      do ik=1,100
	     fname01 = 'state'		  
	     fname0 = 'state'		  
         fname1 = 'state'	     
         fname2 = 'state'
	     gname01 = 'dual'	
	     gname0 = 'dual'		 
	     gname1 = 'dual'
	     gname2 = 'dual'	  
	  	  
         call getname(fname1,ik)
         call getname(fname2,ik+1)
         call getname(gname1,ik)	  
         call getname(gname2,ik+1)	

         if (ik.gt.1) then
         call getname(fname0,ik-1)
         call getname(gname0,ik-1)
		 
		 
         if (ik.gt.2) 
     *   write(1,*) 'Xcopy /E /I ',trim(fname1), ' ', trim(fname2)	 
         write(1,*) 'cd ',fname1


         if (ik.eq.2) then
         path='copy ..\'//trim(fname0)//'\force.* .'	
         write(1,*) trim(path)
         path='copy ..\'//trim(fname0)//'\unod.??? vel.???'	
         write(1,*) trim(path)		 
         endif
	 		 
         path='copy ..\'//trim(gname0)//'\uhat.* .'	
         write(1,*) trim(path)
		 
         if (ik.gt.2) then
         path='copy ..\'//trim(fname0)//'\fnew.??? force.???'
         write(1,*) trim(path)	  
         path='copy ..\'//trim(fname0)//'\force.??? fold.???'
         write(1,*) trim(path)
         call getname(gname01,ik-2)		 
         path='copy ..\'//trim(gname01)//'\uhat.??? uold.???'
         write(1,*) trim(path)					
         endif

         write(1,*) 'call cgm.bat'	
			 
         write(1,*) 'cd ..'		
         write(1,*)
         endif				 
		 

         write(1,*) 'Xcopy /E /I ', trim(gname1), ' ', trim(gname2)
         write(1,*) 'cd ',gname1
         path='copy ..\'//trim(fname1)//'\unod.* .'	 
         write(1,*) trim(path)
         path='copy ..\'//trim(fname1)//'\press.* .'	 
         write(1,*) trim(path)
         path='copy ..\'//trim(fname1)//'\unodb.* .'
         write(1,*) trim(path)
         path='copy ..\'//trim(fname1)//'\unods.* .'
         write(1,*) trim(path)
         path='copy ..\'//trim(fname1)//'\coor0.* .'
         write(1,*) trim(path)
         path='copy ..\'//trim(fname1)//'\time .'
         write(1,*) trim(path)		 		 
		 
         write(1,*) 'copy ..\obj.txt .'	 
         write(1,*) 'call cgm.bat'	 
         write(1,*) 'copy obj.txt ..\'	 	
         write(1,*) 'cd ..'	
         write(1,*)
		 
      enddo
	  
      close(1)

c       write(*,*) 'it =',it
c       write(*,*) fname1
c       write(*,*) gname1
 

      end

 
      subroutine getname(name,it)
      implicit real*8 (a-h,o-z)
      character name*24,ch3*4
c     if (it.lt.10) write(unit=ch3,fmt='(i1)') it
c     if (it.ge.10) write(unit=ch3,fmt='(i2)') it
c     if (it.ge.100) write(unit=ch3,fmt='(i3)') it
      call getext(it,ch3)
c     write(*,*) 'name =',name,'++++ ch3 =',ch3
      do 10 i=1,24
      if (name(i:i).eq.' ') then
      j=i
      goto 20
      endif
10    continue
20    continue

      if (j.gt.20) then
      write(*,*) 'Error, plot path too long .......',name
      write(*,*) 'The length of name must be less or equal 20 character'
      stop 111
      endif
c     read(*,'(a3)') ch3
c      name(j:j)='.'
c      name(j+1:j+4)=ch3
      name(j:j+3)=ch3
c     write(*,*) 'plot path = ',name
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

 