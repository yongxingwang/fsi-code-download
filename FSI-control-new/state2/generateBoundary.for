      implicit real*8 (a-h,o-z)
      character*12 fname1,fname2
      common /aa/ ia(180610000)

      open(1,file='coor0bak',form='unformatted')
      read(1) knode,kcoor
      rewind(1)
      kdgof=2

c.......open elem0 file
      open (3,file='elem0',form='unformatted',status='old')
      read (3) num,nnode
      rewind(3)
      write(*,*) 'num,nnode=',num,nnode
      kelem=num*nnode+0.5	  

      kna4=kelem*1
      if (kna4/2*2 .lt. kna4) kna4=kna4+1	  
      kna3=knode*1
      if (kna3/2*2 .lt. kna3) kna3=kna3+1
      kna1=kcoor*knode*2
      kna2=kdgof*knode*2
      kna0=1
      kna1=kna1+kna0
      kna2=kna2+kna1
      kna3=kna3+kna2
      kna4=kna4+kna3	  
      if (kna3-1.gt.180610000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 180610000'
      write(*,*) 'memory needed = ',kna3,' in prgram bft'
      stop 55555
      endif
      call bft(knode,kdgof,kcoor,kelem,
     *ia(kna0),ia(kna1),ia(kna2),ia(kna3))
      end
	  
      subroutine bft(knode,kdgof,kcoor,kelem,
     *coor,us,nb,node)
      implicit real*8 (a-h,o-z)
      dimension coor(kcoor,knode),nb(knode),us(kdgof,knode),
     * node(kelem)
 
c.......open coor file
      read (1) knode,ncoor,((coor(i,j),i=1,ncoor),j=1,knode)
      close(1)
 
      read (3) num,nnode,
     *           ((node((i-1)*nnode+j),j=1,nnode),i=1,num)	
      close(3) 

cccccccccccccccccccccccccccccccc
      y0=2.5d-1
      ep=1.d-5
      ncount=0
	  
      do j=1,knode
      y=coor(2,j)
        if (dabs(y-y0).lt.ep) then
        ncount=ncount+1
        nb(ncount)=j
        endif
      enddo	  
	  
      write(*,*) 'ncount=',ncount	  
	  
      do i=1,ncount-1
      do j=i+1,ncount
         xi=coor(1,nb(i))
         xj=coor(1,nb(j))
         if(xj<xi) then
         n=nb(i)
         nb(i)=nb(j)
         nb(j)=n
         endif   	  
      enddo
      enddo	  
cccccccccccccccccccccccccccccccc	
      open(1,file='unods.100',form='unformatted')
      read (1) ((us(i,j),j=1,knode),i=1,kcoor) 
      close(1)

      open(1,file='boundarynode.txt',form='formatted')    
      open(2,file='boundarycoor.txt',form='formatted')        
      do i=1,ncount
      nod=nb(i)
      write(1,*) nod
      x=us(1,nod)!+coor(1,nod)
      y=us(2,nod)!+coor(2,nod)
      write(2,*) x,y
      enddo	  
      close(1)
      close(2)
	  
      end
 
