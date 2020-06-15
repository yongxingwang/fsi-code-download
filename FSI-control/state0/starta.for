      implicit real*8 (a-h,o-z)
      character*12 fname,filename(20)
      common /aa/ ia(143610000)
      common /bb/ ib(71800000)
      maxt=143610000/3-1000
      open(1,file=' ',form='unformatted',status='old')
      read(1) knode,kdgof
      close(1)
      kvar=knode*kdgof
      write(*,*) 'knode,kdgof,kvar ='
      write(*,'(1x,4i7)') knode,kdgof,kvar
      kvar1=kvar+1
      kcoor=3
      kelem=17950000
      knb1=kdgof*knode*1
      if (knb1/2*2 .lt. knb1) knb1=knb1+1
      kna4=kcoor*knode*2
      kna1=kdgof*knode*2
      kna2=kdgof*knode*2
      kna3=kdgof*knode*2
      kna5=knode*1
      if (kna5/2*2 .lt. kna5) kna5=kna5+1
      knb4=kelem*1
      if (knb4/2*2 .lt. knb4) knb4=knb4+1
      knb3=kvar1*1
      if (knb3/2*2 .lt. knb3) knb3=knb3+1
      knb2=kvar1*1
      if (knb2/2*2 .lt. knb2) knb2=knb2+1
      knc1=maxt*1
      if (knc1/2*2 .lt. knc1) knc1=knc1+1
      knc2=maxt*1
      if (knc2/2*2 .lt. knc2) knc2=knc2+1
      knc3=maxt*1
      if (knc3/2*2 .lt. knc3) knc3=knc3+1
      kna0=1
      kna1=kna1+kna0
      kna2=kna2+kna1
      kna3=kna3+kna2
      kna4=kna4+kna3
      kna5=kna5+kna4
      if (kna5-1.gt.143610000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 143610000'
      write(*,*) 'memory needed = ',kna5,' in prgram start'
      stop 55555
      endif
      knb0=1
      knb1=knb1+knb0
      knb2=knb2+knb1
      knb3=knb3+knb2
      knb4=knb4+knb3
      if (knb4-1.gt.71800000) then
      write(*,*) 'exceed memory of array ib'
      write(*,*) 'memory of ib = 71800000'
      write(*,*) 'memory needed = ',knb4,' in prgram start'
      stop 55555
      endif
      knc0=1
      knc1=knc1+knc0
      knc2=knc2+knc1
      knc3=knc3+knc2
      if (knc3-1.gt.143610000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 143610000'
      write(*,*) 'memory needed = ',knc3,' in prgram start'
      stop 55555
      endif
      call start(knode,kdgof,kcoor,kvar,
     *kelem,maxt,kvar1,ia(kna0),ia(kna1),ia(kna2),
     *ia(kna3),ia(kna4),ib(knb0),ib(knb1),ib(knb2),
     *ib(knb3),ia(knc0),ia(knc1),ia(knc2),
     *filename)
      end
      subroutine start(knode,kdgof,kcoor,kvar,
     *kelem,maxt,kvar1,u0,u1,u2,
     *coor,inodvar,nodvar,numcol,lm,node,
     *nap,naj,na,
     *filename)
      implicit real*8 (a-h,o-z)
      character*12 filename(20)
      dimension  nodvar(kdgof,knode),coor(kcoor,knode),r(3),
     *  u0(kdgof,knode),u1(kdgof,knode),u2(kdgof,knode),
     *  inodvar(knode),node(kelem)
      dimension lm(kvar1),numcol(kvar1),nap(maxt),naj(maxt),na(maxt)
 
      character*1 material
        logical filflg
 
c .................................................................
c ..... kdgof number of d.o.f
c ..... knode number of nodes
c ..... inodvar id data
c ..... nodvar denote the equation number corresponding the d.o.f
c ..... u0 u1 u2 initial value
c ..... coor coordinates
c ..... node element nodal connection
c .................................................................
6     format (1x, 15i4)
7     format (1x,8f9.3)
c.......open id file
      open (1,file=' ',form='unformatted',status='old')
      read (1) numnod,noddof,((nodvar(i,j),i=1,noddof),j=1,numnod)
      close (1)
      call chms(kdgof,knode,nodvar)
c        write(*,*) 'numnod =',numnod,' noddof =',noddof
c        write (*,*) 'id ='
c        write (*,6) ((nodvar(i,j),i=1,noddof),j=1,numnod)
 
c.....  get the natural nodal order
      do 12 n=1,knode
      inodvar(n)=n
12    continue
 
c.....  open order.nod file and read the nodal order if the file exist
      inquire(file='order.nod',exist=filflg)
      if (filflg) then
       open (1,file='order.nod',form='unformatted',status='old')
       read (1) (inodvar(i),i=1,numnod)
       close(1)
       write(*,*) 'nodorder ='
       write(*,6) (inodvar(i),i=1,numnod)
      endif
 
c..... get nv by id
      neq=0
      do 20 jnod=1,numnod
      j=inodvar(jnod)
      do 18 i=1,noddof
      if (nodvar(i,j).ne.1) goto 18
      neq = neq + 1
      nodvar(i,j) = neq
18    continue
20    continue
      do 30 jnod=1,numnod
       j=inodvar(jnod)
       do 28 i=1,noddof
        if (nodvar(i,j).ge.-1) goto 28
        n = -nodvar(i,j)-1
        nodvar(i,j) = nodvar(i,n)
28     continue
30     continue
 
c.....  open and write the nv file
      open(8,status='unknown',file=' ' ,form='unformatted')
      write(8) ((nodvar(i,j),i=1,noddof),j=1,numnod)
      close(8)
c        write(*,*) 'numnod =',numnod,'  noddof =',noddof
c        write(*,6) ((nodvar(i,j),i=1,noddof),j=1,numnod)
 
c.... write the bounday condition file bfd according to the disp0 file
c....open disp0 file
      open(1,file=' ',form='unformatted',status='old')
      read(1) numnod,noddof,((u0(i,j),i=1,noddof),j=1,numnod)
      close(1)
c....open bfd file
      open(1,file=' ',form='unformatted',status='unknown')
      write(1) ((u0(i,j),i=1,noddof),j=1,numnod)
      close(1)
 
c...... get the initial time from time0 file
c.......open time0 file
      open(1,file=' ',form='formatted')
      read(1,*) t0,tmax,dt
      time = t0
      it = 0
      write(*,*) ' tmax,dt,time,it =',tmax,dt,time,it
      close(1)
c.......open time file
      open(1,file=' ',form='unformatted',status='unknown')
      write(1) tmax,dt,time,it
      close(1)
 
c.......open coor file
      open (1,file=' ',form='unformatted',status='old')
      read (1) numnod,ncoor,((coor(i,j),i=1,ncoor),j=1,numnod)
      close(1)
c        write(*,*) 'coor ='
c        write(*,7) ((coor(i,j),i=1,ncoor),j=1,numnod)
 
c...... compute the initial value by bound.for
        zo = 0.0d0
c        do 321 n=1,numnod
c      do 100 j=1,ncoor
c100   r(j) = coor(j,n)
c      do 200 j=1,noddof
c        u0(j,n) = bound(r,zo,j)
c        u1(j,n) = bound1(r,zo,j)
c        u2(j,n) = bound2(r,zo,j)
c200   continue
c321   continue
 
c...... get the initial value from the data files by preprocessor
      inquire(file='disp1',exist=filflg)
      if (filflg) then
      open(16,file='disp1',form='unformatted',status='old')
      read(16) numnod,noddof,((u0(j,n),j=1,noddof),n=1,numnod)
      close(16)
      endif
      inquire(file='disp2',exist=filflg)
      if (filflg) then
      open(16,file='disp2',form='unformatted',status='old')
      read(16) numnod,noddof,((u1(j,n),j=1,noddof),n=1,numnod)
      close(16)
      endif
      inquire(file='disp3',exist=filflg)
      if (filflg) then
      open(16,file='disp3',form='unformatted',status='old')
      read(16) numnod,noddof,((u2(j,n),j=1,noddof),n=1,numnod)
      close(16)
      endif
 
c        write(*,*) ' u0 = '
c        write(*,'(6f13.3)') ((u0(j,n),j=1,noddof),n=1,numnod)
c     write(*,*) ' u1 = '
c     write(*,'(6f13.3)') ((u1(j,n),j=1,noddof),n=1,numnod)
      open(1,file=' ',form='unformatted',status='old')
      write(1) ((u0(i,j),j=1,numnod),i=1,noddof-1)
      close(1)  
 
c      open(1,file='unod0',form='unformatted',status='old')
c      read(1) ((u0(i,j),j=1,numnod),i=1,noddof-1)
c      close(1) 
 
c.......open and write the initial value file unod
      open (1,file=' ',form='unformatted',status='unknown')
      write(1) ((u0(i,j),j=1,numnod),i=1,noddof),
     *  ((u1(i,j),j=1,numnod),i=1,noddof),
     *  ((u2(i,j),j=1,numnod),i=1,noddof),
     *  ((u0(i,j),j=1,numnod),i=1,noddof)
        close (1)
 
c.... open io file
      open(21,file=' ',form='formatted',status='old')
      read(21, '(1a)') material
      read(21,*) numtyp
      close(21)
 
      do i=1,neq
       numcol(i)=0
      enddo
c.......open elem0 file
      open (3,file=' ',form='unformatted',status='old')
      jna = neq
      numel=0
      kelem=0
      kemate=0
      do 2000 ityp=1,numtyp
c.......input enode
      read (3) num,nnode,
     *           ((node((i-1)*nnode+j),j=1,nnode),i=1,num)
cc      write(*,*) 'num =',num,' nnode =',nnode
cc      write(*,*) 'node ='
cc      write(*,6) ((node((i-1)*nnode+j),j=1,nnode),i=1,num)
      if (kelem.lt.num*nnode) kelem = num*nnode
      nne = nnode
      if (material.eq.'y' .or. material.eq.'y') then
       read (3) mmate,nmate
       if (kemate.lt.mmate*nmate) kemate = mmate*nmate
       nne = nne-1
      endif
      write(*,*) 'mmate =',mmate,' nmate =',nmate
cc    write(*,*) 'num =',num,' nnode =',nnode
cc    write(*,*) 'node ='
cc    write(*,6) ((node((i-1)*nnode+j),j=1,nnode),i=1,num)
      do 1000 ne=1,num
      l=0
      do 700 inod=1,nne
      nodi=node((ne-1)*nnode+inod)
      do 600 idgf=1,kdgof
      inv=nodvar(idgf,nodi)
      if (inv.le.0) goto 600
      l=l+1
      lm(l)=inv
600     continue
700     continue
      numel=numel+1
c      write (*,*) 'l,lm =',l
c      write (*,'(1x,15i5)') (lm(i),i=1,l)
       if (l.gt.0) then
        call  aclh(neq,numcol,nap,naj,l,lm,jna)
       endif
       if (jna.gt.maxt) then
        write(*,*) 'exceet array length maxt ....',maxt,' < ',jna
        stop 1111
       endif
1000  continue
2000  continue
      close(3)
      call bclh(neq,nap,naj,numcol,na,lm)
      maxa=numcol(neq+1)
 
c.......open sys file
      open (2,file=' ',form='unformatted',status='unknown')
      write(2) numel,neq,numtyp,maxa,kelem,kemate
      close (2)
 
      open(2,file=' ',form='unformatted',status='unknown')
      write(2) (numcol(i),i=1,neq+1)
      write(2) (na(i),i=1,maxa)
      close(2)
 
c        write(*,*) 'neq,numcol,na=',neq
c        write(*,6) (numcol(i),i=1,neq+1)
c        write(*,6) (na(i),i=1,maxa)
 
 
      end
 
      subroutine chms(kdgof,knode,id)
      dimension id(kdgof,knode),ms(1000),is(1000)
      do 1000 k=1,kdgof
      m = 0
      do 800 n=1,knode
      if (id(k,n).le.-1) id(k,n)=-1
      if (id(k,n).le.1) goto 800
       j=id(k,n)
       j0=0
       if (m.gt.0) then
        do i=1,m
         if (j.eq.ms(i)) j0=is(i)
        enddo
       endif
       if (j0.eq.0) then
        m=m+1
        ms(m)=j
        is(m)=n
        id(k,n)=1
       else
        id(k,n)=-j0-1
       endif
800   continue
1000  continue
      return
      end
 
      subroutine aclh(neq,numcol,nap,naj,nd,lm,jna)
      implicit real*8 (a-h,o-z)
      dimension nap(*),naj(*),numcol(*),lm(*)
6     format(1x,5i15)
c      write (*,*) 'nd= ',nd, (lm(i),i=1,nd)
      do 400 i=1,nd
      ni = lm(i)
      do 300 j=1,nd
      nj = lm(j)
c      if (nj.eq.ni) goto 300
      numj = numcol(ni)
      if (numj.eq.0) then
       jna = jna+1
       nap(ni) = jna
       naj(ni) = nj
       numcol(ni) = numcol(ni)+1
      else
       jp = nap(ni)
       jv = naj(ni)
       if (nj.eq.jv) goto 300
       do k=1,numj-1
        jv = naj(jp)
        jp = nap(jp)
        if (nj.eq.jv) goto 300
       enddo
       jna = jna+1
       nap(jp) = jna
       naj(jp) = nj
       numcol(ni) = numcol(ni)+1
      endif
300   continue
400   continue
      return
      end
 
      subroutine bclh(neq,nap,naj,numcol,na,lmi)
      implicit real*8 (a-h,o-z)
      dimension numcol(*),nap(*),naj(*),na(*),lmi(*)
c        if(numel.eq.0) go to 1000
      nn = 0
      do 600 n=1,neq
      jp = nap(n)
      jv = naj(n)
      li = numcol(n)
      do 500 i=1,li
      lmi(i) = jv
      jv = naj(jp)
      jp = nap(jp)
500   continue
      call order(li,lmi)
      do 550 i=1,li
      nn = nn+1
550   na(nn) = lmi(i)
600   continue
      do 800 n=1,neq-1
800   numcol(n+1) = numcol(n+1)+numcol(n)
      do 850 n=1,neq
850   numcol(neq-n+2) = numcol(neq-n+1)
      numcol(1) = 0
c       write(*,*) 'numcol ='
c       write(*,6) (numcol(n),n=1,neq+1)
c       write(*,*) 'na ='
c       write(*,6) (na(i),i=1,nn)
1000    return
6       format(1x,5i15)
      return
      end
 
      subroutine order(nd,lm)
      implicit real*8 (a-h,o-z)
      dimension lm(1)
c       write(*,*) '**** order ****'
c       write(*,*) (lm(i),i=1,nd)
      do 200 i=1,nd
      ls=lm(i)+1
      do 100 j=i,nd
      if (lm(j).gt.ls) goto 100
      ls=lm(j)
      j0=j
100     continue
      lm(j0)=lm(i)
      lm(i)=ls
200     continue
c       write(*,*) (lm(i),i=1,nd)
c       write(*,*) '-----------------'
      return
      end
 
