      implicit real*8 (a-h,o-z)
      common /aa/ ia(200000000)

      open (1,file='coor0',form='unformatted',status='old')
      read(1) nc,ncoor
      close(1)
	  
      kdgof=ncoor

c...elements of the fluid mesh	  
      open (1,file='elem0',form='unformatted',status='old')	  
      read (1) num,nne
      rewind(1)	 	  
      kelem=num*nne+0.5
	  
c.....open the file of projection matrix
      open (3,file='project',form='unformatted',status='old')
      read (3) numtyp,nodmax,nfb,nnode,nf
	  
      write(*,*) 'numtyp,nodmax,nfb,nnode,nf=',
     * numtyp,nodmax,nfb,nnode,nf


      kna3=nodmax*nf*2
      kna4=nodmax*nf*1
      if (kna4/2*2 .lt. kna4) kna4=kna4+1
      kna2=kdgof*nc*2
      kna1=kdgof*nf*2
      kna5=nf*1
      if (kna5/2*2 .lt. kna5) kna5=kna5+1
      kna6=kelem*1
      if (kna6/2*2 .lt. kna6) kna6=kna6+1	  	  
	  
      kna0=1
      kna1=kna1+kna0
      kna2=kna2+kna1
      kna3=kna3+kna2
      kna4=kna4+kna3
      kna5=kna5+kna4
      kna6=kna6+kna5	  
      if (kna6-1.gt.200000000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 200000000'
      write(*,*) 'memory needed = ',kna6,' in prgram ddtv'
      stop 55555
      endif
      call ddtv(kdgof,nc,nf,nnode,kelem,
     *nfb,numtyp,ia(kna0),ia(kna1),ia(kna2),
     *ia(kna3),ia(kna4),ia(kna5))
      end
      subroutine ddtv(kdgof,nc,nf,nnode,kelem,
     *nfb,numtyp,usolid,ufluid,dd,
     *jd,infb,node)
      implicit real*8 (a-h,o-z)
      dimension ufluid(kdgof,nc),usolid(kdgof,nf),node(kelem),
     *  infb(nfb),jd(nnode,nfb),dd(nnode,nfb)

      read (1) num,nne,
     *           ((node((i-1)*nne+j),j=1,nne),i=1,num)	 
      close(1)	 
	 
       read(3) (infb(j),j=1,nfb),
     &         ((jd(i,j),i=1,nnode),j=1,nfb),
     &         ((dd(i,j),i=1,nnode),j=1,nfb)	 
      close(3) 
c....open the nodal values from the fluid mesh
      open(1,file='ufluid',form='unformatted',status='old')
      read(1) ((ufluid(i,j),j=1,nc),i=1,kdgof)	   
      close(1)	   
	   
c..... compute usolid=D*ufluid
      do 2210 i=1,nfb
      do 2220 j=1,kdgof
      uji=0.d0 		
      do 2230 k=1,nnode
      ii=jd(k,i)
      uji=uji+dd(k,i)*ufluid(j,ii)
2230  continue
      usolid(j,infb(i))=uji
2220  continue
2210  continue
		  
c....store the nodal values on the solid mesh
      open(1,file='usolid',form='unformatted',status='unknown')   
      write(1) ((usolid(j,i),i=1,nf),j=1,kdgof)
      close(1)
	  
      return
      end
