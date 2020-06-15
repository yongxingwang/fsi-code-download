$debug 
      implicit real*8 (a-h,o-z)
	  
  
c.......open elem0 file
      open (3,file=' ',form='unformatted',status='old')  
      read (3) num,nnode
      kelem=num*nnode+0.5
	  
      open (10,file=' ',form='unformatted',status='old')
      read (10) numnod,ncoor

      call upcoor(numnod,ncoor,kelem)
      end

      subroutine upcoor(numnod,ncoor,kelem)
      implicit real*8 (a-h,o-z)
      dimension coor(ncoor,numnod),v(ncoor,numnod),us(ncoor,numnod),
     *          node(kelem),jn(9)
	 
	 
      rewind(3)
      read (3) num,nnode,
     *           ((node((i-1)*nnode+j),j=1,nnode),i=1,num)	 
      close(3)

	 
      rewind(10)
      read (10) numnod,ncoor,((coor(i,j),i=1,ncoor),j=1,numnod)
      rewind(10)	  
	  

c...open velocty of solid
      open (1,file=' ',form='unformatted')
      read (1) ((v(i,j),j=1,numnod),i=1,ncoor)
      close(1)
	
      open(1,file=' ',form='unformatted',status='old')
      read(1) tmax,dt,time,it
      close(1)
 
	  
      open (9,file=' ',form='unformatted')
      read (9) ((us(i,j),j=1,numnod),i=1,ncoor) 
      rewind(9)		  
cccc.. try to update coor1 based on coor1n, unods based on unodsn
      do j=1,numnod	  
c        if (abs(coor(2,j)).lt.1.0d-5) v(1:2,j)=0.0			
        do i=1,ncoor
          us(i,j)=us(i,j)+dt*v(i,j)
          coor(i,j)=coor(i,j)+dt*v(i,j)  		  
        enddo			
      enddo	
cccccccccccccccccccccccccccccccccccccccccccccccc	  
      do ne=1,num
      do j=1,nnode-1
        jn(j) = node((ne-1)*nnode+j)	  	  
      enddo
      do i=1,ncoor
        coor(i,jn(5))=(coor(i,jn(1))+coor(i,jn(2)))/2.
        coor(i,jn(6))=(coor(i,jn(2))+coor(i,jn(3)))/2.
        coor(i,jn(7))=(coor(i,jn(3))+coor(i,jn(4)))/2.		
        coor(i,jn(8))=(coor(i,jn(4))+coor(i,jn(1)))/2.
        coor(i,jn(9))=(coor(i,jn(1))+coor(i,jn(2))
     *               +coor(i,jn(3))+coor(i,jn(4)))/4.
      enddo	    
      enddo
	  
c...update coordinate coor1	  
      write(10) numnod,ncoor,((coor(i,j),i=1,ncoor),j=1,numnod)
      close(10) 	  

c...update unods	  
      write(9) ((us(i,j),j=1,numnod),i=1,ncoor)
      close(9)	
	  
	  
      end
	  