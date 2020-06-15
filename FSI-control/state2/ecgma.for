      implicit real*8 (a-h,o-z)
      character*12 fname,filename(20)
      common /aa/ ia(143610000)
      common /bb/ ib(35900000)
      common /cc/ ic(35900000)
      open(1,file=' ',form='unformatted',status='old')
      read(1) knode,kdgof
      close(1)
      maxt=143610000/(1+2)
 
c.......open sys file
      open (2,file=' ',form='unformatted',status='old')
      read(2) numel,neq,numtyp,maxa,kelem,kemate
      close (2)
 
      neq1=neq+1
      if (maxa.gt.maxt) then
      write(*,*) 'matrix a exceed core memery .... ',maxa
      write(*,*) 'required core memery ........... ',maxt
      stop 0000
      endif
      kvar=knode*kdgof
      kcoor=3
c      kelem=17950000
      write(*,*) 'knode,kdgof,kvar,kcoor,kelem ='
      write(*,'(1x,6i7)') knode,kdgof,kvar,kcoor,kelem
 
      kna2=kdgof*knode*1
      if (kna2/2*2 .lt. kna2) kna2=kna2+1
      knc1=kdgof*knode*2
      knc2=kcoor*knode*2
      knc6=kdgof*knode*2
      knc7=kdgof*knode*2
      knc8=knode*2
      knc9=knode*2
      knc10=knode*2
      knc11=knode*2
      knc3=neq*2
      knb1=maxa*2
      knb2=maxa*1
      if (knb2/2*2 .lt. knb2) knb2=knb2+1
      kna1=neq1*1
      if (kna1/2*2 .lt. kna1) kna1=kna1+1
      knc5=kemate*2
      kna3=kelem*1
      if (kna3/2*2 .lt. kna3) kna3=kna3+1
      knc12=100000*2
      knc4=neq*2
      kna0=1
      kna1=kna1+kna0
      kna2=kna2+kna1
      kna3=kna3+kna2
      if (kna3-1.gt.35900000) then
      write(*,*) 'exceed memory of array ib'
      write(*,*) 'memory of ib = 35900000'
      write(*,*) 'memory needed = ',kna3,' in prgram ecgma'
      stop 55555
      endif
      knb0=1
      knb1=knb1+knb0
      knb2=knb2+knb1
      if (knb2-1.gt.143610000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 143610000'
      write(*,*) 'memory needed = ',knb2,' in prgram ecgma'
      stop 55555
      endif
      knc0=1
      knc1=knc1+knc0
      knc2=knc2+knc1
      knc3=knc3+knc2
      knc4=knc4+knc3
      knc5=knc5+knc4
      knc6=knc6+knc5
      knc7=knc7+knc6
      knc8=knc8+knc7
      knc9=knc9+knc8
      knc10=knc10+knc9
      knc11=knc11+knc10
      knc12=knc12+knc11
      if (knc12-1.gt.35900000) then
      write(*,*) 'exceed memory of array ic'
      write(*,*) 'memory of ic = 35900000'
      write(*,*) 'memory needed = ',knc12,' in prgram ecgma'
      stop 55555
      endif
      call ecgma(knode,kdgof,kvar,kcoor,
     *numtyp,numel,neq,kelem,kemate,maxa,
     *maxt,neq1,ib(kna0),ib(kna1),ib(kna2),
     *ia(knb0),ia(knb1),ic(knc0),ic(knc1),ic(knc2),
     *ic(knc3),ic(knc4),ic(knc5),ic(knc6),ic(knc7),
     *ic(knc8),ic(knc9),ic(knc10),ic(knc11),
     *filename)
      end
      subroutine ecgma(knode,kdgof,kvar,kcoor,
     *numtyp,numel,neq,kelem,kemate,maxa,
     *maxt,neq1,numcol,nodvar,node,a,
     *na,u,coor,f,u1,emate,
     *eu0,eu,eus,evs,efx,efy,
     *sml,
     *filename)
      implicit real*8 (a-h,o-z)
      character*12 filename(20)
      interface
      subroutine umfpack_redu(neq,numcol,na,a,f,u)
      implicit real*8 (a-h,o-z)
      !ms$attributes c,alias:'_umfpack_redu_':: umfpack_redu
      real(8) a(10),f(10),u(10)
      integer(4) neq,numcol(10),na(10)
        !ms$attributes reference:: a,f,u,neq,numcol,na
      end subroutine
      end interface
      dimension nodvar(kdgof,knode),u(kdgof,knode),coor(kcoor,knode),
     *eu0(kdgof,knode),eu(kdgof,knode),eus(knode),evs(knode),
     *efx(knode),efy(knode),
     & f(neq),a(maxa),na(maxa),numcol(neq1),emate(kemate),
     & node(kelem),sml(100000),u1(neq)
 
6       format (1x,15i5)
7       format (1x,5e15.5)
1001    format(1x,9i7)
 
c.......open time file
      open(1,file=' ',form='unformatted',status='old')
      read(1) tmax,dt,time,it
      write(*,*) ' tmax,dt,time,it =',tmax,dt,time,it
      close(1)
 
c.......open nodvar file
      open (1,file=' ',form='unformatted',status='old')
      read (1) ((nodvar(i,j),i=1,kdgof),j=1,knode)
      close (1)
cc      write(*,*) 'kdgof =',kdgof,' knode =',knode
cc      write (*,*) 'nodvar ='
cc      write (*,6) ((nodvar(i,j),i=1,kdgof),j=1,knode)
 
c.......open coor file
      open (1,file=' ',form='unformatted',status='old')
      read (1) numnod,ncoor,((coor(i,j),i=1,ncoor),j=1,numnod)
      close(1)
cc      write(*,*) 'numnod,ncoor=',numnod,ncoor
 
c.......open bfd file
      open (32,file=' ',form='unformatted',status='old')
cc        read (32) ((u(j,i),j=1,kdgof),i=1,knode)
cc        close (32)
cc      write (*,*) 'bf ='
cc      write(*,7) ((u(j,i),j=1,kdgof),i=1,knode)
 
      numtyp = 1
      if (it.eq.0) then
      open(11,file='unod',form='unformatted',status='old')
      open(12,file='unods',form='unformatted',status='old')
      open(13,file='force',form='unformatted',status='old')
      else
      open(11,file='unod',form='unformatted',status='old')
      open(12,file='unods',form='unformatted',status='old')
      open(13,file='force',form='unformatted',status='old')
      endif
      read(11) ((eu0(j,i),i=1,knode),j=1,kdgof-1)
      read(12) (eus(i),i=1,knode),
     &  (evs(i),i=1,knode)
      read(13) (efx(i),i=1,knode),
     &  (efy(i),i=1,knode)
      close(13)
	  

      open(14,file='press',form='unformatted',status='unknown')
      read(14)  (eu0(kdgof,i),i=1,knode)
      close(14)
	  
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc	  
      open(14,file='uhat',form='unformatted',status='old')
      read(14)  ((eu(j,i),i=1,knode),j=1,kdgof-1)
      close(14)	  
	  
      alpha=1.d0
	  
c      open (14,file='alpha',form='formatted',status='old')
c      read(14,*) up,down
c      close(14)    
 	  
c      alpha=dsqrt(up)/dsqrt(down)	  
	  
      do i=1,knode
      efx(i)=eu(1,i)*alpha+efx(i)
      efy(i)=eu(2,i)*alpha+efy(i)
      enddo

      write(*,*) "====", alpha
	  
      open(14,file='fnew',form='unformatted',status='unknown')
      write(14) (efx(i),i=1,knode),
     &  (efy(i),i=1,knode)
      close(14)	  
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc	  
c.......open diag file
      open (2,file=' ',form='unformatted',status='old')
      read(2) (numcol(i),i=1,neq1)
      read(2) (na(i),i=1,maxa)
      close(2)
 
c.......open elem0 file
      open (3,file=' ',form='unformatted',status='old')
 
      itime=0
1     continue
      itime=itime+1
      if (itime.gt.1) then
      write(*,*) 'nonlinear iteration times ========',itime
      rewind(3)
      rewind(32)
      endif
 
      read (32) ((u(j,i),j=1,kdgof),i=1,knode)
cc      write (*,*) 'bf ='
cc      write(*,7) ((u(j,i),j=1,kdgof),i=1,knode)
 
      do 111 i=1,maxa
      a(i) = 0.d0
111   continue
 

      numel=0
      do 2000 ityp=1,numtyp
c .... read element nodal connection points and material no.
      read (3) num,nnode,
     *           ((node((i-1)*nnode+j),j=1,nnode),i=1,num)
cc      write(*,*) 'num =',num,' nnode =',nnode
cc      write(*,*) 'node ='
cc      write(*,6) ((node((i-1)*nnode+j),j=1,nnode),i=1,num)
      nne = nnode
      nne = nne-1
      k=0
      do 115 j=1,nne
      jnod = node(j)
      do 115 l=1,kdgof
      if (nodvar(l,jnod).ne.0) k=k+1
115     continue
      write(*,*) 'k =',k
      kk=k*k
      k0=1
      k1=k0+k*k
      k2=k1+k
      k3=k2+k
      k4=k3+k*k
      k5=k4+k*k
      call etsub(knode,kdgof,it,kcoor,kelem,k,kk,nnode,nne,
     & ityp,ncoor,num,time,dt,neq,neq1,maxt,maxa,nodvar,coor,node,emate,
     & a,na,numcol,
     &sml(k0),sml(k1),sml(k2),sml(k3),sml(k4),
     &eus,evs,efx,efy,eu0,eu,
     & u)
2000    continue
 
      close(1)
      close(2)
c        close(3)
      close(11)
      close(12)

c        neq = 0
      do 2050 ij=1,neq
      if (itime.le.1) u1(ij) = 0.d0
      f(ij)=0.0d0
2050    continue
      do 2200 i=1,knode
      do 2100 j=1,kdgof
      ij=nodvar(j,i)
      if (ij.le.0) goto 2100
      f(ij)=f(ij)+u(j,i)
2100    continue
2200    continue
 
cc      write (*,*) 'u ='
cc      write (*,7) ((u(j,i),j=1,kdgof),i=1,knode)
cc      write (*,*) 'neq =',neq,' f  ='
cc      write(*,7) (f(i),i=1,neq)
 
 
      write(*,*) 'multifrontal_solver memory required .... ',maxa
      if (maxa.gt.maxt) then
      write(*,*) 'error, matrix a exceed core memory .... ',maxt
      stop 0000
      endif
 
c..... prepare for calling multifrontal solver
      do i=1,maxa
        na(i)=na(i)-1
      enddo
      call umfpack_redu(neq,numcol,na,a,f,u1)
c     write(*,*) '       u1 = '
c     write(*,7) (a(i),i,maxa)
c     write(*,7) (f(i),i=1,neq)
 

      do 3200 inod=1,knode
      do 3100 idfg=1,kdgof
      n=nodvar(idfg,inod)
c       write (*,*) 'n =',n
      if(n.le.0) then
      eu(idfg,inod)=u(idfg,inod)
      else
      eu(idfg,inod)=u1(n)
      endif
3100    continue
3200    continue

 
      open(10,file=' ',form='unformatted',status='unknown')
      write(10)  ((eu(j,i),i=1,knode),j=1,kdgof-1)
      close(10)
      open(10,file=' ',form='unformatted',status='unknown')
      write(10)  (eu(kdgof,i),i=1,knode)
      close(10)	  
	  
      close (3)
      close (32)
 
c       check solution
      do i=1,maxa
        na(i)=na(i)+1
      enddo
      call check(neq,maxa,na,a,numcol,f,u1)
 
      return
      end
 
      subroutine etsub(knode,kdgof,it,kcoor,kelem,k,kk,nnode,nne,
     & ityp,ncoor,num,time,dt,neq,neq1,maxt,maxa,nodvar,coor,node,emate,
     & a,na,numcol,
     *es,em,ef,estifn,estifv,eus,evs,efx,
     *efy,eu0,eu,
     *u)
      implicit real*8 (a-h,o-z)
      dimension nodvar(kdgof,knode),coor(kcoor,knode),node(kelem),
     *u(kdgof,knode),emate(300),
     &a(maxa),na(maxa),numcol(neq1),
     *es(k,k),em(k),ef(k),eus(knode),
     *evs(knode),efx(knode),efy(knode),eu0(kdgof,knode),
     *eu(kdgof,knode),estifn(k,k),estifv(kk),
     *r(500),prmt(500),coef(500),lm(500)
17      format (1x,15i5)
18      format (1x,8e9.2)
 
	read (3) mmate,nmate,((emate((i-1)*nmate+j),j=1,nmate),
     *	i=1,mmate)
	write(*,*) 'mmate =',mmate,' nmate =',nmate
	write (*,*) 'emate ='
	write (*,18) ((emate((i-1)*nmate+j),j=1,nmate),
     *	i=1,mmate)
        do 1000 ne=1,num
	nr=0
	do 130 j=1,nne
	jnod = node((ne-1)*nnode+j)
        if (jnod.lt.0) jnod = -jnod
        prmt(nmate+7+j) = jnod
      coef(j+0*nne)=eus(jnod)
      coef(j+1*nne)=evs(jnod)
      coef(j+2*nne)=efx(jnod)
      coef(j+3*nne)=efy(jnod)
	do 120 i=1,ncoor
	nr=nr+1
120	r(nr) = coor(i,jnod)
130	continue
	imate = node(nnode*ne)
	do 140 j=1,nmate
140	prmt(j) = emate((imate-1)*nmate+j)
	prmt(nmate+1)=time
	prmt(nmate+2)=dt
        prmt(nmate+3)=imate
        prmt(nmate+4)=ne
        prmt(nmate+5)=num
        prmt(nmate+6)=it
        prmt(nmate+7)=nmate
        prmt(nmate+8)=itime
        prmt(nmate+9)=ityp
 
      goto 1
1     call aeq9g3(r,coef,prmt,es,em,ec,ef,ne)
      goto 2
2     continue
 
c       write(*,*) 'es em ef ='
c       do 555 i=1,k
c555    write(*,18) (es(i,j),j=1,k)
c       write(*,18) (em(i),i=1,k)
c       write(*,18) (ef(i),i=1,k)
 
cc      if (it.gt.0) then
      do 201 i=1,k
      do 201 j=1,k
      estifn(i,j)=0.0
201   continue
      do 202 i=1,k
      estifn(i,i)=estifn(i,i)+em(i)/dt
      do 202 j=1,k
      estifn(i,j)=estifn(i,j)+es(i,j)
202   continue
 
      l=0
      m=0
      i=0
      do 700 inod=1,nne
      nodi=node((ne-1)*nnode+inod)
      do 600 idgf=1,kdgof
      inv=nodvar(idgf,nodi)
      if (inv.eq.0) goto 600
      i=i+1
      if (inv.lt.0) goto 305
      l=l+1
      lm(l)=inv
      u(idgf,nodi)=u(idgf,nodi)
     *+ef(i)+em(i)*eu0(idgf,nodi)/dt
305     j=0
      do 500 jnod=1,nne
      nodj=node((ne-1)*nnode+jnod)
      do 400 jdgf=1,kdgof
      jnv=nodvar(jdgf,nodj)
      if (jnv.eq.0) goto 400
      j=j+1
 
      if (jnv.lt.0) goto 400
      if (inv.lt.0) goto 310
      m=m+1
      estifv(m)=estifn(i,j)
310     continue
 
 
      if (inv.lt.0)
     *  u(jdgf,nodj)=u(jdgf,nodj)-estifn(i,j)*u(idgf,nodi)
400     continue
500     continue
600     continue
700     continue
c       write (*,*) 'u ='
c       write (*,18) ((u(j,i),j=1,kdgof),i=1,knode)
 
      lrd=m
      ner=numel+ne
c       write(*,*) '**************************'
c       write(*,*) (estifv(i),i=1,lrd)
c       write (*,*) 'einform ............'
c       write (*,'(1x,15i5)') l,lrd,(lm(i),i=1,l)
cc      endif
      do 800 i=1,l
      j=lm(i)
800     continue
      call adda(na,a,numcol,l,lm,estifv,neq,maxa)
1000  continue
      return
      end
 
      subroutine adda(na,a,numcol,nd,lm,estif,neq,maxa)
      implicit real*8 (a-h,o-z)
      dimension a(maxa),na(maxa),numcol(*),lm(*),estif(nd,nd)
c       write (*,*) ((estif(i,j),j=1,i),i=1,nd)
      do 300 i=1,nd
      ii = lm(i)
      n0 = numcol(ii)+1
      n1 = numcol(ii+1)
c       write(*,*) 'n0,n1 =',n0,n1
      do 280 j=1,nd
      jj = lm(j)
      do 240 k=n0,n1
      if (na(k).eq.jj) goto 280
240     continue
280     a(k) = a(k) + estif(j,i)
300     continue
400     continue
500     return
      end
 
      subroutine check(neq,maxa,na,a,numcol,f,u)
      implicit real*8 (a-h,o-z)
      dimension a(maxa),na(maxa),numcol(*),f(*),u(*)
 
c.......compute f-a*u & q,q0
      q0 = 0.0d0
      do i=1,neq
       q0 = q0+u(i)*u(i)
      enddo
 
      do n=1,neq
       n0 = numcol(n)+1
       n1 = numcol(n+1)
        do j=n0,n1
          naj = na(j)
          f(naj) = f(naj)-a(j)*u(naj)
        enddo
      enddo
 
      q = 0.0d0
      do i=1,neq
       q = q+f(i)*f(i)
      enddo
 
      write(*,*) 'the square sum q0 of solution u is ',q0
      write(*,*) 'the square sum q of f- a*u is ',q
      end
