      implicit real*8 (a-h,o-z)
      character*12 fname,filename(20)
      common /aa/ ia(143610000)
      open(10,file=' ',form='formatted')
      read(10,*) maxnod,maxelem
      read(10,*)
      open(12,file='giddisp',form='formatted')
      maxrow=maxelem*10+10000
      if (maxrow.gt.143610000/2) maxrow=143610000/2
      kna2=maxnod*3*2
      kna1=maxnod*3*2
      kna3=maxrow*10*1
      if (kna3/2*2 .lt. kna3) kna3=kna3+1
      kna0=1
      kna1=kna1+kna0
      kna2=kna2+kna1
      kna3=kna3+kna2
      if (kna3-1.gt.143610000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 143610000'
      write(*,*) 'memory needed = ',kna3,' in prgram fgidpre'
      stop 55555
      endif
      call fgidpre(maxnod,maxrow,ia(kna0),ia(kna1),
     *ia(kna2),
     *filename)
      close(10)
      close(12)
      end
      subroutine fgidpre(maxnod,maxrow,coor,rdata,
     *idata,
     *filename)
      implicit real*8 (a-h,o-z)
      character*12 filename(20)
      dimension rdata(maxnod,3),coor(maxnod,3),
     & idata(maxrow,10),rmdata(9,40)
      dimension ns(100),nnode(100)
      nf = 4
c ............... coor
      nd = 2
      call getrd(maxnod,nd,coor)
      open(11,file='coor0',form='unformatted',status='unknown')
      write(11) maxnod,nd,((coor(i,j),j=1,nd),i=1,maxnod)
      close(11)
c ............... id for field cgma
      nd = 3
      call getid(maxnod,nd,idata,maxrow)
      open(11,file='id0',form='unformatted',status='unknown')
      write(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      close(11)
c ............... id for field cgmb
      nd = 2
      call getid(maxnod,nd,idata,maxrow)
      open(11,file='idb0',form='unformatted',status='unknown')
      write(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      close(11)
c ............... id for field cgmc
      nd = 2
      call getid(maxnod,nd,idata,maxrow)
      open(11,file='idc0',form='unformatted',status='unknown')
      write(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      close(11)
c ............... id for field cgmd
      nd = 1
      call getid(maxnod,nd,idata,maxrow)
      open(11,file='idd0',form='unformatted',status='unknown')
      write(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      close(11)
c ............... disp0 for field cgma
      nd = 3
      call getdisp(maxnod,nd,rdata,coor)
      open(11,file='disp0',form='unformatted',status='unknown')
      write(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
c ............... dispb0 for field cgmb
      nd = 2
      call getdisp(maxnod,nd,rdata,coor)
      open(11,file='dispb0',form='unformatted',status='unknown')
      write(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
c ............... dispc0 for field cgmc
      nd = 2
      call getdisp(maxnod,nd,rdata,coor)
      open(11,file='dispc0',form='unformatted',status='unknown')
      write(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
c ............... dispd0 for field cgmd
      nd = 1
      call getdisp(maxnod,nd,rdata,coor)
      open(11,file='dispd0',form='unformatted',status='unknown')
      write(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
c ............... disp1 for field cgma
      nd = 3
      call getrd(maxnod,nd,rdata)
      open(11,file='disp1',form='unformatted',status='unknown')
      write(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
c ............... element
      nelmt = 4
      call getelem(maxrow,10,idata,ns,nnode,netype)
      maxm = 9
      do n=1,maxm
      do i=1,4
      rmdata(n,i) = 0.0d0
      enddo
      enddo
c ............... element data for field cgma
      open(11,file='elem0',form='unformatted',status='unknown')
      k = 1
      n0 = ns(k)
      n1 = ns(k+1)
      nod = nnode(k)
      write(11) n1-n0,nod,((idata(i,j),j=1,nod),i=n0+1,n1)
      rmdata(1,1) = 2.d-1
      rmdata(1,2) = 1.d0
      rmdata(1,3) = 1.d0
      rmdata(1,4) = 1.d-2
      rmdata(2,1) = 2.d-1
      rmdata(2,2) = 1.d0
      rmdata(2,3) = 1.d0
      rmdata(2,4) = 1.d-2
      maxm = 2
      nmate = 4
      write(11) maxm,nmate,((rmdata(i,j),j=1,nmate),i=1,maxm)
 
      k = 2
      n0 = ns(k)
      n1 = ns(k+1)
      nod = nnode(k)
      write(11) n1-n0,nod,((idata(i,j),j=1,nod),i=n0+1,n1)
      rmdata(1,1) = 0.d0
      rmdata(1,2) = 0.d0
      maxm = 1
      nmate = 2
      write(11) maxm,nmate,((rmdata(i,j),j=1,nmate),i=1,maxm)
      close(11)
c ............... element data for field cgmb
      open(11,file='elemb0',form='unformatted',status='unknown')
      k = 3
      n0 = ns(k)
      n1 = ns(k+1)
      nod = nnode(k)
      write(11) n1-n0,nod,((idata(i,j),j=1,nod),i=n0+1,n1)
      rmdata(1,1) = 1.d0
      rmdata(1,2) = 1.d0
      rmdata(1,3) = 1.d0
      rmdata(1,4) = 1.d0
      maxm = 1
      nmate = 4
      write(11) maxm,nmate,((rmdata(i,j),j=1,nmate),i=1,maxm)
 
      k = 4
      n0 = ns(k)
      n1 = ns(k+1)
      nod = nnode(k)
      write(11) n1-n0,nod,((idata(i,j),j=1,nod),i=n0+1,n1)
      rmdata(1,1) = 0.d0
      rmdata(1,2) = 0.d0
      maxm = 1
      nmate = 2
      write(11) maxm,nmate,((rmdata(i,j),j=1,nmate),i=1,maxm)
      close(11)
c ............... element data for field cgmc
      open(11,file='elemc0',form='unformatted',status='unknown')
      k = 5
      n0 = ns(k)
      n1 = ns(k+1)
      nod = nnode(k)
      write(11) n1-n0,nod,((idata(i,j),j=1,nod),i=n0+1,n1)
      rmdata(1,1) = 0.d0
      maxm = 1
      nmate = 1
      write(11) maxm,nmate,((rmdata(i,j),j=1,nmate),i=1,maxm)
 
      k = 6
      n0 = ns(k)
      n1 = ns(k+1)
      nod = nnode(k)
      write(11) n1-n0,nod,((idata(i,j),j=1,nod),i=n0+1,n1)
      rmdata(1,1) = 0.d0
      maxm = 1
      nmate = 1
      write(11) maxm,nmate,((rmdata(i,j),j=1,nmate),i=1,maxm)
      close(11)
c ............... element data for field cgmd
      open(11,file='elemd0',form='unformatted',status='unknown')
      k = 7
      n0 = ns(k)
      n1 = ns(k+1)
      nod = nnode(k)
      write(11) n1-n0,nod,((idata(i,j),j=1,nod),i=n0+1,n1)
      rmdata(1,1) = 0.d0
      rmdata(2,1) = 0.d0
      maxm = 2
      nmate = 1
      write(11) maxm,nmate,((rmdata(i,j),j=1,nmate),i=1,maxm)
      close(11)
c ............... changing id0 file
      call chid(maxnod,rdata,idata)
      end
 
        subroutine getdisp(n,m,rdata,coor)
        implicit real*8 (a-h,o-z)
        dimension coor(n,3),rdata(n,m),rd(100),pd(100),r(3)
        l=0
        do i=1,n
        do j=1,m
        rdata(i,j) = 0.0d0
        enddo
        enddo
1       read(12,*) k,(rd(i),pd(i),i=1,m)
      if (k.gt.0) then
        l=l+1
       do j=1,m
        kk=pd(j)+0.5
        if (kk.eq.0) then
         rdata(k,j)=rd(j)
        else
         r(1)=coor(k,1)
         r(2)=coor(k,2)
         r(3)=coor(k,3)
         rdata(k,j)=bfd(kk,r)
        endif
       enddo
        goto 1
      endif
       return
      end
 
        subroutine getrd(n,m,rdata)
        implicit real*8 (a-h,o-z)
        dimension rdata(n,m),rd(100)
        l=0
        do i=1,n
        do j=1,m
        rdata(i,j) = 0.0d0
        enddo
        enddo
1       read(10,*) k,(rd(i),i=1,m)
        if (k.gt.0) then
        l=l+1
        do j=1,m
        rdata(k,j)=rd(j)
        enddo
        goto 1
        endif
c        if (l.eq.0) goto 1
        return
        end
        subroutine getid(n,m,idata,nr)
      implicit real*8 (a-h,o-z)
c        implicit real*8 (a-h,o-z)
        dimension idata(nr,m),id(100)
        l=0
        do i=1,n
        do j=1,m
        idata(i,j) = 1
        enddo
        enddo
1       read(10,*) k,(id(i),i=1,m)
        if (k.gt.0) then
        l=l+1
        do j=1,m
        idata(k,j)=id(j)
        enddo
        goto 1
        endif
c        if (l.eq.0) goto 1
        return
        end
 
        subroutine getelem(n,mm,idata,ns,nnode,netype)
      implicit real*8 (a-h,o-z)
c        implicit real*8 (a-h,o-z)
        dimension idata(n,mm),id(200),nnode(100),ns(100)
c        dimension ind(100),itype(100,2)
        m=mm
        l=0
        netype=0
1       read(10,*) k,(id(i),i=1,m)
c        write(*,*) 'k,id ===== ',k,(id(i),i=1,m)
        if (k.eq.-4000) goto 1
        if (k.lt.0) then
        m = 1-k
        netype=netype+1
        nnode(netype)=m
        ns(netype)=l
        if (k.eq.-5000) goto 2
        else
        l=l+1
        do j=1,m
        idata(l,j)=id(j)
        enddo
        endif
        goto 1
2       continue
        ns(netype+1)=l
c      write(*,*) 'netype = ',netype
c      write(*,*) 'ns = ',(ns(i),i=1,netype+1)
c      write(*,*) 'nnode = ',(nnode(i),i=1,netype)
        return
        end
 
      subroutine coortran(np,nd,d,kkk)
      implicit real*8 (a-h,o-z)
      dimension d(np,nd)
      do 100 n=1,np
      goto (1,2,3) kkk
1     continue
      r=d(n,1)
      o=d(n,2)
      d(n,1)=r*dcos(o)
      d(n,2)=r*dsin(o)
      goto 100
2     continue
      r=d(n,1)
      o=d(n,2)
      d(n,1)=r*dcos(o)
      d(n,2)=r*dsin(o)
      goto 100
3     continue
      r=d(n,1)
      s=d(n,2)
      o=d(n,3)
      d(n,1)=r*dsin(s)*dcos(o)
      d(n,2)=r*dsin(s)*dsin(o)
      d(n,3)=r*dcos(s)
100   continue
      open(11,file='coor1',form='unformatted',status='unknown')
      write(11) np,nd,((d(i,j),j=1,nd),i=1,np)
      close(11)
      return
      end
 
      subroutine chid(np,id,node)
      dimension id(np,*),node(*)
      open(20,file='id0',form='unformatted',status='old')
      read(20) np,nd,((id(i,j),j=1,nd),i=1,np)
      rewind(20)
      open(21,file='elem0',form='unformatted',status='old')
      read(21) nelem,melem,(node(i),i=1,nelem*melem)
      close(21)
      nnode=melem-1
      do n=1,nelem
      k=melem*(n-1)
      if (nnode.eq.6) m=3
      if (nnode.eq.9) m=4
      if (nnode.eq.10) m=4
      if (nnode.eq.18) m=6
      if (nnode.eq.27) m=8
      do i=k+m+1,k+nnode
      j=node(i)
      id(j,nd) = 0
      enddo
      enddo
      write(20) np,nd,((id(i,j),j=1,nd),i=1,np)
      return
      end
      real*8 function bfd(k,r)
      implicit real*8 (a-h,o-z)
      dimension r(3)
      bfd = 0.0
      end
