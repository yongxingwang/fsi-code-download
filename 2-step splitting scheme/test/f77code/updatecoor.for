      implicit real*8 (a-h,o-z)
c...open coordinate coor1	  	  	   
      open (10,file='coor1',form='unformatted',status='old')
      read (10) knode,ncoor

      call upcoor(knode,ncoor)
      end

      subroutine upcoor(knode,ncoor)
      implicit real*8 (a-h,o-z)
      dimension coor(ncoor,knode),usolid(ncoor,knode),disp(ncoor,knode)

	 
c...open solid velocty file
      open (1,file='usolid',form='unformatted')
      read (1) ((usolid(i,j),j=1,knode),i=1,ncoor)
      close(1)
	  
c...open time	  
      open(1,file='time',form='unformatted',status='old')
      read(1) tmax,dt,time,it
      close(1)
	  
c...update coordinate coor1	  
      rewind(10)
      read (10) knode,ncoor,((coor(i,j),i=1,ncoor),j=1,knode)
	  
c...update displacment disp	  
      open (11,file='disp',form='unformatted')
      read (11) ((disp(i,j),j=1,knode),i=1,ncoor) 	  
	  
	  
      do j=1,knode
      do i=1,ncoor
      coor(i,j)=coor(i,j)+dt*usolid(i,j)  
      disp(i,j)=disp(i,j)+dt*usolid(i,j)		  
      enddo
      enddo	 	   
	  	  
c...update coor1
      rewind(10)
      write(10) knode,ncoor,((coor(i,j),i=1,ncoor),j=1,knode)
      close(10)  
c...update disp	  
      rewind(11)	
      write(11) ((disp(i,j),j=1,knode),i=1,ncoor)
      close(11)	  	    

      end
	  

