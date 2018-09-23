      implicit real*8 (a-h,o-z)
      common /aa/ ia(300000000)
      common /bb/ ib(90300000)
      common /cc/ ic(45150000)
      maxt=300000000
	  
      open(1,file='dimension',form='formatted')
      read(1,*) dim
      close(1)	  	  
	  
      open (1,file='coor0.txt',form='formatted',status='unknown')
      read(1,*) knode

      kcoor=dim
      kdgof=kcoor

      kvar=knode*kdgof
      kvar1=kvar+1
      write(*,*) 'knode,kdgof,kvar ='
      write(*,'(1x,4i7)') knode,kdgof,kvar

	  
      open (2,file='elem0.txt',form='formatted',status='unknown')
      read (2,*) num	  
	  	  
      nnode=10
      if(dim.eq.3) nnode =28
      kelem=num*nnode+1
      write(*,*) 'num=',num
      
      knb1=kdgof*knode*1
      if (knb1/2*2 .lt. knb1) knb1=knb1+1
      kna1=kcoor*knode*2
      kna2=kdgof*knode*2
      kna3=kdgof*knode*2
      kna4=kdgof*knode*2
      knb4=1000*1
      if (knb4/2*2 .lt. knb4) knb4=knb4+1
      knc2=kelem*1
      if (knc2/2*2 .lt. knc2) knc2=knc2+1
      knb2=kvar1*1
      if (knb2/2*2 .lt. knb2) knb2=knb2+1
      knb3=kvar1*1
      if (knb3/2*2 .lt. knb3) knb3=knb3+1
      knd1=maxt*1
      if (knd1/2*2 .lt. knd1) knd1=knd1+1
      knc1=kvar1*1
      if (knc1/2*2 .lt. knc1) knc1=knc1+1
      kna0=1
      kna1=kna1+kna0
      kna2=kna2+kna1
      kna3=kna3+kna2
      kna4=kna4+kna3
      if (kna4-1.gt.300000000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 300000000'
      write(*,*) 'memory needed = ',kna4,' in prgram start'
      stop 55555
      endif
      knb0=1
      knb1=knb1+knb0
      knb2=knb2+knb1
      knb3=knb3+knb2
      knb4=knb4+knb3
      if (knb4-1.gt.45150000) then
      write(*,*) 'exceed memory of array ic'
      write(*,*) 'memory of ic = 45150000'
      write(*,*) 'memory needed = ',knb4,' in prgram start'
      stop 55555
      endif
      knc0=1
      knc1=knc1+knc0
      knc2=knc2+knc1
      if (knc2-1.gt.90300000) then
      write(*,*) 'exceed memory of array ib'
      write(*,*) 'memory of ib = 90300000'
      write(*,*) 'memory needed = ',knc2,' in prgram start'
      stop 55555
      endif
      knd0=1
      knd1=knd1+knd0
      if (knd1-1.gt.300000000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 300000000'
      write(*,*) 'memory needed = ',knd1,' in prgram start'
      stop 55555
      endif
      call start(knode,kdgof,kcoor,kvar,num,nnode,
     *kelem,maxt,kvar1,ia(kna0),ia(kna1),ia(kna2),
     *ia(kna3),ic(knb0),ic(knb1),ic(knb2),ic(knb3),
     *ib(knc0),ib(knc1),ia(knd0))
      end
      subroutine start(knode,kdgof,kcoor,kvar,num,nnode,
     *kelem,maxt,kvar1,coor,u0,u1,
     *u2,nodvar,jnz,numcol,lm,jdiag,
     *node,na)
      implicit real*8 (a-h,o-z)
      dimension  nodvar(kdgof,knode),coor(kcoor,knode),r(kcoor),
     & u0(kdgof,knode),u1(kdgof,knode),u2(kdgof,knode),
     & lm(1000),node(kelem),
     & jnz(kvar1),numcol(kvar1),na(maxt),jdiag(kvar1)
6     format (1x, 15i5)

      do j=1,knode
      read (1,*) (coor(i,j),i=1,kcoor)
      enddo
      close(1)	
  
      do i=1,num
      read (2,*) (node((i-1)*nnode+j),j=1,nnode)
      enddo
      close(2)		  
	  
c.......constraint for fluid
      do i=1,knode
      do j=1,kcoor
      r(j)=coor(j,i)
      enddo
      do j=1,kdgof
      nodvar(j,i)=1
      nodvar(j,i)=id(kcoor,r,j)
      enddo
      enddo
	  
c.......open idb0 file
      open (1,file='idb0',form='unformatted',status='unknown')
      write (1) knode,kdgof,((nodvar(i,j),i=1,kdgof),j=1,knode)	  
      close(1)	  

      call chms(kdgof,knode,nodvar)
c      write(*,*) 'knode =',knode,' kdgof =',kdgof
c      write (*,*) 'id ='
c      write (*,6) ((nodvar(i,j),i=1,kdgof),j=1,knode)
      neq=0
      do 20 j=1,knode
      do 18 i=1,kdgof
      if (nodvar(i,j).ne.1) goto 18
      neq = neq + 1
      nodvar(i,j) = neq
18    continue
20    continue
      do 30 j=1,knode
      do 28 i=1,kdgof
      if (nodvar(i,j).ge.-1) goto 28
      n = -nodvar(i,j)-1
      nodvar(i,j) = nodvar(i,n)
28    continue
30    continue

      open(8,file='nvb',status='unknown',form='unformatted')
      write(8) ((nodvar(i,j),i=1,kdgof),j=1,knode)
      close(8)
c      write(*,*) 'knode =',knode,'  kdgof =',kdgof
c      write(*,6) ((nodvar(i,j),i=1,kdgof),j=1,knode)
      maxcol=maxt/neq
 
      do 350 i=1,neq
      numcol(i)=0
      jnz(i)=0
350   continue
 
      nne = nnode-1
	  
      do jj=1,2
      do 1000 ne=1,num
      l=0
      do 700 inod=1,nne
      nodi=node((ne-1)*nnode+inod)
      do 600 idgf=1,kdgof
      inv=nodvar(idgf,nodi)
      if (inv.le.0) goto 600
      l=l+1
      lm(l)=inv
600   continue
700   continue

c      write (*,*) 'l,lm =',l
c      write (*,'(1x,15i5)') (lm(i),i=1,l)
      if (jj.eq.1) then
      if (l.gt.0) call acln(l,jnz,lm)
      else
      if (l.gt.0) call aclh(neq,jnz,numcol,na,l,lm,maxt)
      endif
1000  continue

      if (jj.eq.1) then
      do 800 n=1,neq-1
800   jnz(n+1) = jnz(n+1)+jnz(n)
      do 850 n=1,neq
850   jnz(neq-n+2) = jnz(neq-n+1)
      jnz(1) = 0
      if (jnz(neq+1).gt.maxt) then
      write(*,*) 'exceet core memory ....',jnz(neq+1),' > ',maxt
      stop 1111
      endif
      rewind(3)
      endif
      enddo
      close(3)
 
      call bclh(neq,jnz,numcol,na,jdiag,lm,maxt)
      maxa=numcol(neq+1)
 
c.......open sys file
      numtyp=1
      kemate=10
      open (2,file='sysb',form='unformatted',status='unknown')
      write(2) num,neq,numtyp,maxa,kelem,kemate
      close (2)

      open(2,file='diagb',form='unformatted',status='unknown')
      write(2) (numcol(i),i=1,neq+1)
      write(2) (na(i),i=1,maxa)
      write(2) (jdiag(i),i=1,neq)
      close(2)
 
c        write(*,*) 'neq,numcol,na=',neq
c        write(*,6) (numcol(i),i=1,neq+1)
c        write(*,6) (na(i),i=1,maxa)

c.......open time0 file
      open(1,file='time0',form='formatted')
      read(1,*) t0,tmax,dt
      time = t0
      it = 0
      write(*,*) ' tmax,dt,time,it =',tmax,dt,time,it
      close(1)
 
c.......open time file
      open(1,file='time',form='unformatted',status='unknown')
      write(1) tmax,dt,time,it
      close(1)


      return
      end
 
      subroutine acln(nd,numcol,lm)
      implicit real*8 (a-h,o-z)
      dimension numcol(*),lm(*)
6     format(1x,10i7)
c      write (*,*) 'nd= ',nd, (lm(i),i=1,nd)
      do 400 i=1,nd
      ni = lm(i)
      do 300 j=1,nd
      nj = lm(j)
cc     if (nj.eq.ni) goto 300
      numcol(ni) = numcol(ni)+1
300   continue
400   continue
c      write(*,*) 'numcol ='
c      write(*,6) (numcol(n),n=1,neq)
1000  return
      end
 
      subroutine aclh(neq,jnz,numcol,mht,nd,lm,maxt)
      implicit real*8 (a-h,o-z)
      dimension mht(maxt),jnz(*),numcol(*),lm(*)
6     format(1x,10i7)
c      write (*,*) 'nd= ',nd, (lm(i),i=1,nd)
      do 400 i=1,nd
      ni = lm(i)
      do 300 j=1,nd
c      if (j.eq.i) goto 300
      nj = lm(j)
      do 200 k=1,numcol(ni)
      if (nj.eq.mht(k+jnz(ni))) goto 300
200   continue
      numcol(ni) = numcol(ni)+1
      if (ni.gt.neq) then
      write(*,*) 'ni ====',ni
      stop 1234
      endif
      mht(numcol(ni)+jnz(ni)) = nj
300   continue
400   continue
c       write(*,*) 'numcol ='
c       write(*,6) (numcol(n),n=1,neq)
c       write(*,*) 'mht ='
c       do 2000 n=1,neq
c2000   write(*,6) (mht(i+jnz(n)),i=1,numcol(n))
1000  return
      end
 
      subroutine order(nd,lm)
      implicit real*8 (a-h,o-z)
      dimension lm(*)
c       write(*,*) '**** order ****'
c       write(*,*) (lm(i),i=1,nd)
      do 200 i=1,nd
      ls=lm(i)+1
      do 100 j=i,nd
      if (lm(j).gt.ls) goto 100
      ls=lm(j)
      j0=j
100   continue
      lm(j0)=lm(i)
      lm(i)=ls
200   continue
c       write(*,*) (lm(i),i=1,nd)
c       write(*,*) '-----------------'
      return
      end
 
      subroutine bclh(neq,jnz,numcol,na,jdiag,lmi,maxt)
      implicit real*8 (a-h,o-z)
      dimension jnz(*),numcol(*),na(*),jdiag(neq),lmi(*)
      do 600 n=1,neq
cc      nn = (n-1)*maxcol
      nn=jnz(n)
      li = numcol(n)
      do 500 i=1,li
500   lmi(i) = na(nn+i)
      call order(li,lmi)
      do 550 i=1,li
550   na(nn+i) = lmi(i)
600   continue
 
      nsum = 0
      do 700 n=1,neq
cc     nn=(n-1)*maxcol
       nn=jnz(n)
      do 700 i=1,numcol(n)
      nsum = nsum+1
      na(nsum) = na(nn+i)
700   continue
      do 800 n=1,neq-1
800   numcol(n+1) = numcol(n+1)+numcol(n)
      do 850 n=1,neq
850   numcol(neq-n+2) = numcol(neq-n+1)
      numcol(1) = 0
c       write(*,*) 'nsum,numcol(neq+1) =',nsum,numcol(neq+1)
c       write(*,*) 'numcol ='
c       write(*,6) (numcol(n),n=1,neq+1)
c       write(*,*) 'na ='
c       write(*,6) (na(i),i=1,nsum)
      do 1400 ir=1, neq-1
      nir0 = numcol(ir)+1
      nir1 = numcol(ir+1)
      do 1380 id=nir0,nir1
      if(na(id).eq.ir) then
      jdiag(ir)=id
      goto 1381
      endif
1380  continue
1381  continue
1400  continue
      jdiag(neq)=numcol(neq+1)
 
1000  return
6     format(1x,5i15)
      end
 
      subroutine chms(kdgof,knode,id)
      dimension id(kdgof,knode),ms(1000),is(1000)
      do 1000 k=1,kdgof
      m = 0
      do 800 n=1,knode
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
