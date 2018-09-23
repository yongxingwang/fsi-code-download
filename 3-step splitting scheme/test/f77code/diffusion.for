      implicit real*8 (a-h,o-z)
      common /aa/ ia(350000000)
      common /bb/ ib(90300000)
      common /cc/ ic(45150000)
	  
c.....open cgmj file
      open (21,file='project',form='unformatted',status='old')
      read (21) nouse,nouse,nfb,nod,nouse	  
      write(*,*) 'nfb,nod===',nfb,nod
	  
      open (22,file='bf',form='unformatted',status='unknown')
      read(22) maxb,neqb 
  
      neqb1=neqb+1
	  
      open(1,file='coor0',form='unformatted',status='old')
      read(1) knode,kcoor
      close(1)
	  
      kdgof=kcoor
	  
      write(*,*) 'knode,kdgof=',knode,kdgof
      maxt=350000000/(1+2*2)
 
c.......open sys file
      open (2,file='sysb',form='unformatted',status='old')
      read(2) numel,neq,numtyp,maxa,kelem,kemate
      close (2)

      neq1=neq+1
      if (maxa.gt.maxt) then
      write(*,*) 'matrix a exceed core memery .... ',maxa
      write(*,*) 'required core memery ........... ',maxt
      stop 0000
      endif
      kvar=knode*kdgof

      write(*,*) 'knode,kdgof,kvar,kcoor,kelem ='
      write(*,'(1x,6i7)') knode,kdgof,kvar,kcoor,kelem
 
      kna3=kdgof*knode*1
      if (kna3/2*2 .lt. kna3) kna3=kna3+1
      knc1=kdgof*knode*2
      knc2=kdgof*knode*2
      knc11=kdgof*knode*2
      knc12=kcoor*knode*2
      knc13=0
      knc14=0
      knc15=0
      knc4=neq*2
      knb1=maxa*2
      knb3=maxa*1
      if (knb3/2*2 .lt. knb3) knb3=knb3+1
      knb4=maxb*1
      if (knb4/2*2 .lt. knb4) knb4=knb4+1	  
      kna1=neq1*1
      if (kna1/2*2 .lt. kna1) kna1=kna1+1
      kna2=neq*1
      if (kna2/2*2 .lt. kna2) kna2=kna2+1
      knc10=kemate*2
      kna4=kelem*1
      if (kna4/2*2 .lt. kna4) kna4=kna4+1
      kna4_new=maxb*2  
      knc16=100000*2
      knc3=neq*2
      knb2=maxa*2
      knc5=neq*2
      knc6=neq*2
      knc7=neq*2
      knc8=neq*2
      knc9=neq*2
      kna0=1
      kna1=kna1+kna0
      kna2=kna2+kna1
      kna3=kna3+kna2
      kna4=kna4+kna3
      kna4_new=kna4_new+kna3	  	  
      if (kna4-1.gt.90300000 .or. kna4_new-1.gt.90300000) then
      write(*,*) 'exceed memory of array ib'
      write(*,*) 'memory of ib = 90300000'
      write(*,*) 'memory needed = ',kna4,' in prgram ecgma'
      stop 55555
      endif
      knb0=1
      knb1=knb1+knb0
      knb2=knb2+knb1
      knb3=knb3+knb2
      knb4=knb4+knb3
      if (knb4-1.gt.350000000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 350000000'
      write(*,*) 'memory needed = ',knb4,' in prgram ecgma'
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
      knc13=knc13+knc12
      knc14=knc14+knc13
      knc15=knc15+knc14
      knc16=knc16+knc15
	  
      knc10_n=neqb*2
      knc10_n=knc10_n+knc9
	  
      knc11_n=neqb1*1
      if (knc11_n/2*2 .lt. knc11_n) knc11_n=knc11_n+1
      knc11_n=knc11_n+knc10_n	 

      knc12_n=nod*nfb*2
      knc12_n=knc12_n+knc11_n	 	  

      knc13_n=nod*nfb*1
      if (knc13_n/2*2 .lt. knc13_n) knc13_n=knc13_n+1
      knc13_n=knc13_n+knc12_n	  
	  
      knc14_n=nfb*1
      if (knc14_n/2*2 .lt. knc14_n) knc14_n=knc14_n+1
      knc14_n=knc14_n+knc13_n	

      knc15_n=neqb*2
      knc15_n=knc15_n+knc14_n		  

      knc16_n=kdgof*knode*1
      if (knc16_n/2*2 .lt. knc16_n) knc16_n=knc16_n+1
      knc16_n=knc16_n+knc15_n
	  
      knc17_n=neq*2
      knc17_n=knc17_n+knc16_n	  
	  
      knc18_n=neq*2
      knc18_n=knc18_n+knc17_n		  
	  
      knc19_n=neqb*2
      knc19_n=knc19_n+knc18_n

      knc20_n=neqb*2
      knc20_n=knc20_n+knc19_n	  
	  
      if (knc16-1.gt.45150000 .or. knc20_n-1.gt.45150000) then
      write(*,*) 'exceed memory of array ic'
      write(*,*) 'memory of ic = 45150000'
      write(*,*) 'memory needed = ',knc16,knc20_n,' in prgram ecgma'
      stop 55555
      endif
      call ecgma(knode,kdgof,kvar,kcoor,maxb,neqb,neqb1,
     *numtyp,numel,neq,kelem,kemate,maxa,maxt,neq1,nod,nfb,
     *ib(kna0),ib(kna1),ib(kna2),ib(kna3),
     *ia(knb0),ia(knb1),ia(knb2),ia(knb3),
     *ic(knc0),ic(knc1),ic(knc2),
     *ic(knc3),ic(knc4),ic(knc5),ic(knc6),ic(knc7),ic(knc8),
     *ic(knc9),ic(knc10),ic(knc11),
     *ic(knc15),
     *ib(kna3),ic(knc9),ic(knc10_n),
     *ic(knc11_n),ic(knc12_n),ic(knc13_n),ic(knc14_n),
     *ic(knc15_n),ic(knc16_n),ic(knc17_n),ic(knc18_n),ic(knc19_n))
      end
	  
      subroutine ecgma(knode,kdgof,kvar,kcoor,maxb,neqb,neqb1,
     *numtyp,numel,neq,kelem,kemate,maxa,maxt,neq1,nod,nfb,
     *numcol,jdiag,nodvar,node,
     *a,an,na,nb,
     *u,eu,u1,
     *f,x0,r0,p,w0,w1,
     *emate,eu0,coor,
     *sml,
     *b,g,numcb,
     *dd,jd,infb,tg,
     *id0,w2,z1,g1,tg1)
      implicit real*8 (a-h,o-z)
      dimension nodvar(kdgof,knode),u(kdgof,knode),eu(kdgof,knode),
     & f(neq),a(maxa),na(maxa),numcol(neq1),jdiag(neq),
     & x0(neq),r0(neq),p(neq),w0(neq),w1(neq),u1(neq),an(maxa),
     & w2(neq),z1(neq)

c...will not be used after ascembling	 
      dimension emate(kemate),eu0(kdgof,knode),coor(kcoor,knode),
     * node(kelem),sml(100000)

      dimension b(maxb),nb(maxb),g(neqb),numcb(neqb1),
     *  infb(nfb),jd(nod,nfb),dd(nod,nfb),tg(neqb),id0(kdgof,knode),
     *  g1(neqb),tg1(neqb)
	 
6       format (1x,15i5)
7       format (1x,5e15.5)
1001    format(1x,9i7)
 
 
c.......open time file
      open(1,file='time',form='unformatted',status='old')
      read(1) tmax,dt,time,it
      write(*,*) ' tmax,dt,time,it =',tmax,dt,time,it
      close(1)
 
c.......open nodvar file
      open (1,file='nvb',form='unformatted',status='old')
      read (1) ((nodvar(i,j),i=1,kdgof),j=1,knode)
      close (1)
cc      write(*,*) 'kdgof =',kdgof,' knode =',knode
cc      write (*,*) 'nodvar ='
cc      write (*,6) ((nodvar(i,j),i=1,kdgof),j=1,knode)
 
c.......open coor file
      open (1,file='coor0',form='unformatted',status='old')
      read (1) numnod,ncoor,((coor(i,j),i=1,ncoor),j=1,numnod)
      close(1)
cc      write(*,*) 'numnod,ncoor=',numnod,ncoor
 
c.......open bf file
      open (32,file='bfdb',form='unformatted',status='old')
cc    read (32) ((u(j,i),j=1,kdgof),i=1,knode)
cc    close (32)
cc    write (*,*) 'bf ='
cc    write(*,7) ((u(j,i),j=1,kdgof),i=1,knode)
 
      numtyp = 1
      open(11,file='ufluid',form='unformatted',status='old')
      read(11) ((eu0(j,i),i=1,knode),j=1,kdgof)
      close(11) 

c.......open diag file
      open (2,file='diagb',form='unformatted',status='old')
      read(2) (numcol(i),i=1,neq1)
      read(2) (na(i),i=1,maxa)
      read(2) (jdiag(i),i=1,neq)
      close(2)
 
c.......open elem0 file
      open (3,file='elem0',form='unformatted',status='old')
 
 
      read (32) ((u(j,i),j=1,kdgof),i=1,knode)
cc      write (*,*) 'bf ='
cc      write(*,7) ((u(j,i),j=1,kdgof),i=1,knode)

      do i=1,maxa
      a(i) = 0.0d0
      enddo

c.......open emate+enode+eload file
      do 2000 ityp=1,numtyp
c.......input enode
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
115   continue
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
     & a,na,numcol,jdiag,
     & sml(k0),sml(k1),sml(k2),sml(k3),sml(k4),
     & eu0,u)
2000  continue
 
      close(3)
  
      do ij=1,neq
      f(ij)=0.0d0
      enddo
 	  
      do 2200 i=1,knode
      do 2100 j=1,kdgof
      ij=nodvar(j,i)
      if (ij.le.0) goto 2100
      f(ij)=f(ij)+u(j,i)
      u1(ij)=eu0(j,i)
2100  continue
2200  continue  
 
cc      write (*,*) 'u ='
cc      write (*,7) ((u(j,i),j=1,kdgof),i=1,knode)
cc      write (*,*) 'neq =',neq,' f  ='
cc      write(*,7) (f(i),i=1,neq)
 

      maxa = jdiag(neq)
c     write(*,*) 'jdiag ='
c     write(*,6) (jdiag(i),i=1,neq)
 
      write(*,*) 'ilu_CG_solver memory required .... ',maxa
      if (maxa.gt.maxt) then
      write(*,*) 'warning matrix a exceed core memory .... ',maxt
c      stop 0000
      endif

      call ilu(na, a, an, numcol, neq, maxa,jdiag)
c      call ill(na, a, an, numcol, neq, maxa,jdiag)	  
c.... read the preconditioner
 
c      open (1,file='an',form='unformatted',status='unknown')
c      read (1) an(1:maxa)
c      close(1)	
 
c.......open diag file
      open (10,file='diagd',form='unformatted',status='old')
      read(10) (numcb(i),i=1,neqb1)
      read(10) (nb(i),i=1,maxb)
      close(10)	  

      read(21) (infb(j),j=1,nfb),
     &         ((jd(i,j),i=1,nod),j=1,nfb),
     &         ((dd(i,j),i=1,nod),j=1,nfb)	 
      close(21) 

      read(22) (b(i),i=1,maxb)	       
      read(22) (g(i),i=1,neqb)
      close(22)	 

c.......open id0 file
      open (22,file='idb0',form='unformatted',status='old')
      read (22) numnod,noddof,((id0(i,j),i=1,noddof),j=1,numnod)	  
      close(22)	  
c.....compute D^t *g  + f, nfb=knf (all nodes of the solid)
      ns=0
      do 2210 i=1,nfb
      do 2220 j=1,kdgof
      ns=ns+1
      do 2230 k=1,nod
      ii=jd(k,i)
      jj=nodvar(j,ii)
      if(jj.le.0) goto 2230
      f(jj)=f(jj)+dd(k,i)*g(ns)
2230  continue
2220  continue
2210  continue

      rewind(32)
      read (32) ((u(j,i),j=1,kdgof),i=1,knode)
      close(32)
c=====================================================  
c... g will be used as a temporary array
      errilu=1.0d-8

      call redu(na, a,an, u1, f, numcol, neq, maxa,
     &          x0,r0,p,w0,w1,jdiag,errilu,
     &          b,nb,numcb,jd,dd,g,tg,nodvar,id0,u,
     &          maxb,neqb,nfb,nod,kdgof,knode)	  
	  
c      call pminres(na, a,an, u1, f, numcol, neq, maxa,
c     &          x0,r0,p,w0,w1,w2,z1,jdiag,errilu,
c     &          b,nb,numcb,jd,dd,g,tg,g1,tg1,nodvar,id0,u,
c     &          maxb,neqb,nfb,nod,kdgof,knode)	 
c     write(*,*) '       u1 = '
c     write(*,7) (a(i),i,maxa)
c     write(*,7) (f(i),i=1,neq)
	  
      do 3200 inod=1,knode
      do 3100 idfg=1,kdgof
      n=nodvar(idfg,inod)
      m=id0(idfg,inod)	  
      if(m.le.0) then
      eu(idfg,inod)=u(idfg,inod)
      else
      eu(idfg,inod)=u1(n)
      endif
3100  continue
3200  continue

 
      open(10,file='ufluid',form='unformatted',status='unknown')
      write(10)  ((eu(j,i),i=1,knode),j=1,kdgof)
      close(10)

	  
      return
      end
 
      subroutine etsub(knode,kdgof,it,kcoor,kelem,k,kk,nnode,nne,
     & ityp,ncoor,num,time,dt,neq,neq1,maxt,maxa,nodvar,coor,node,emate,
     & a,na,numcol,jdiag,
     *es,em,ef,estifn,estifv,
     *eu0,u)
      implicit real*8 (a-h,o-z)
      dimension nodvar(kdgof,knode),coor(kcoor,knode),node(kelem),
     * u(kdgof,knode),emate(300),
     * a(maxa),na(maxa),numcol(neq1),jdiag(neq),
     * es(k,k),em(k),ef(k),eu0(kdgof,knode),
     * estifn(k,k),estifv(kk),
     * r(500),prmt(500),coef(500),lm(500)
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
      do 120 i=1,ncoor
      nr=nr+1
120	  r(nr) = coor(i,jnod)
130	  continue
	  imate = node(nnode*ne)
      do 140 j=1,nmate
140	  prmt(j) = emate((imate-1)*nmate+j)
	  prmt(nmate+1)=time
      prmt(nmate+2)=dt
      prmt(nmate+3)=imate
      prmt(nmate+4)=ne
      prmt(nmate+5)=num
      prmt(nmate+6)=it
      prmt(nmate+7)=nmate
      prmt(nmate+8)=itime
      prmt(nmate+9)=ityp

      if(kcoor.eq.2) then	 	  
      call aeq9g3(r,coef,prmt,es,em,ec,ef,ne)
      else
      call aec27g3(r,coef,prmt,es,em,ec,ef,ne)	  
      endif
 
c       write(*,*) 'es em ef ='
c       do 555 i=1,k
c555    write(*,18) (es(i,j),j=1,k)
c       write(*,18) (em(i),i=1,k)
c       write(*,18) (ef(i),i=1,k)
 
cc      if (it.gt.0) then
      do 201 i=1,k
      do 201 j=1,k
      estifn(i,j)=0.0d0
201   continue
      do 202 i=1,k
      estifn(i,i)=estifn(i,i)+em(i)/dt
      do 202 j=i,k
      estifn(i,j)=estifn(i,j)+es(i,j)
      estifn(j,i)=estifn(i,j)
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
 

      call adda(na,a,numcol,l,lm,estifv,neq,maxa)
1000  continue
      return
      end
 
      subroutine adda(na,a,numcol,nd,lm,estif,neq,maxa)
      implicit real*8 (a-h,o-z)
      dimension a(maxa),na(maxa),numcol(*),lm(*),estif(nd,nd)
c      write (*,*) ((estif(i,j),j=1,i),i=1,nd)
      do 300 i=1,nd
      ii = lm(i)
      n0 = numcol(ii)+1
      n1 = numcol(ii+1)
c      write(*,*) 'n0,n1 =',n0,n1
      do 280 j=1,nd
      jj = lm(j)
      do 240 k=n0,n1
      if (na(k).eq.jj) goto 280
240     continue
280     a(k) = a(k) + estif(i,j)
300     continue
400     continue
500     return
      end
 
c//////////////////////////////////////////////////////////////////// 
      subroutine pminres(na, a, an, u, f, numcol, neq, maxa,
     &                v0,v1,v2,w0,w1,w2,z1,jdiag,err,
     &                b,nb,numcb,jd,dd,g,tg,g1,tg1,nodvar,id0,bfu,
     &                maxb,neqb,nfb,nod,kdgof,knode)
      implicit real*8 (a-h,o-z)
      dimension na(maxa),a(maxa),an(maxa),f(neq),u(neq),numcol(1)
      dimension v0(neq),v1(neq),v2(neq),w0(neq),w1(neq),w2(neq),
     * z1(neq)
      dimension b(maxb),nb(maxb),numcb(neqb+1),jd(nod,nfb),dd(nod,nfb),
     *g(neqb),tg(neqb),g1(neqb),tg1(neqb),nodvar(kdgof,knode),
     *id0(kdgof,knode),bfu(kdgof,knode),jdiag(neq)

      do i=1,neq
      v0(i)=0.0d0
      v1(i)=0.0d0	  
      w0(i)=0.0d0	  
      w1(i)=0.0d0
      enddo

cccccccccccccccccccccccccccccccccccc
c ----  compute the product D^t *B * D * u + v1	->  v1  
      call dtbdx_add_y(v1,u,nodvar,b,nb,numcb,jd,dd,g,tg,
     *                 kdgof,knode,maxb,neqb,neq,nod,nfb)
cccccccccccccccccccccccccccccccccccc 	  
	  
c ----  compute the product a*u
      tol_1=0.0d0
      tol_2=0.0d0
	  
      do i=1, neq		 
         n0 = numcol(i)+1
         n1 = numcol(i+1)
         do j = n0, n1
            naj = na(j)
            v1(i) = v1(i) + a(j)*u(naj)
         enddo
         v1(i) = f(i)-v1(i) !  v1 = f - (A+D^tBD) u
		 
         tol_1 = tol_1+f(i)*f(i)	
         tol_2 = tol_2+v1(i)*v1(i)			 
         z1(i)=v1(i)		 
      enddo
      tol_1 = dsqrt(tol_1)*1.0d-8
      tol_2 = dsqrt(tol_2)*err 
	  
c.....compute m^{-1}*z1, m is a preconditioner
c      call illredu(na,an,z1, numcol, neq, maxa,jdiag)
      call iluredu(na,an,z1, numcol, neq, maxa,jdiag)
      gam1 = 0.0d0	  
      do i=1,neq
         gam1 = gam1 + z1(i)*v1(i)
      enddo
      gam1=dsqrt(gam1)

      gam0=1.0d0	  
      eta=gam1
      s0=0.0d0
      s1=0.0d0
      c0=1.0d0
      c1=1.0d0	  
	  
c.....loop from 100 
      iter = 1
100   continue
      
      do i=1,neq
	     z1(i)=z1(i)/gam1 
         v2(i) = 0.0d0
         w2(i)=0.0d0		 
      enddo

cccccccccccccccccccccccccccccccccccc
c ----  compute the product D^t *B * D * z1 + v2	->  v2  
c ----  compute the product D^t *B * D * u  + w2	->  w2  
      call dtbdx_add_y2(v2,z1,w2,u,nodvar,b,nb,numcb,jd,dd,g,tg,
     *                  g1,tg1,kdgof,knode,maxb,neqb,neq,nod,nfb)
cccccccccccccccccccccccccccccccccccc 
      err = 0.0d0		  
      delta=0.0d0
      do i=1,neq
         n0 = numcol(i)+1
         n1 = numcol(i+1)
         do j = n0, n1
            naj = na(j)
            v2(i) = v2(i) + a(j)*z1(naj)
            w2(i) = w2(i) + a(j)*u(naj)
         enddo
         delta=delta+v2(i)*z1(i)		 
         w2(i) = f(i)-w2(i) !  w2 = f - (A+D^tBD) u		 
         err = err+w2(i)*w2(i)			 
      enddo
      err = dsqrt(err)
	  
      do i =1, neq
         v2(i) = v2(i) - v1(i)*delta/gam1 - v0(i)*gam1/gam0
         v0(i) = v2(i)
      enddo

c      call illredu(na,an,v0,numcol,neq,maxa,jdiag)
      call iluredu(na,an,v0,numcol,neq,maxa,jdiag)
      gam2 = 0.0d0	  
      do i=1,neq
         gam2 = gam2 + v0(i)*v2(i)
      enddo
      gam2=dsqrt(gam2)	  
	  
	  
      rr0=c1*delta-c0*s1*gam1
      rr1=dsqrt(rr0*rr0+gam2*gam2)
      rr2=s1*delta+c0*c1*gam1
      rr3=s0*gam1
      c2=rr0/rr1
      s2=gam2/rr1
	    
      do i =1, neq
      w2(i)=( z1(i) - rr3*w0(i) - rr2*w1(i) ) / rr1
      u(i)=u(i)+c2*eta*w2(i)
      enddo
      eta=-s2*eta

ccccccccccccccccccccccccccccccccc	
c...project the solustion using constraint 
c      do j=1,knode 
c      do i=1,kdgof
c      if (id0(i,j).eq.-2) u(nodvar(i,j))=bfu(i,j)
c      enddo	
c      enddo	  
cccccccccccccccccccccccccccccc
	  
	  
      write(*,*) 'iter,err = ',iter,err
      if(err.le.tol_1 .or. err.le.tol_2
     *  .or.err.le.1.0d-16 .or.iter.gt.10000) goto 1000
	  
c.........................reset for loop
      iter = iter + 1

      do i =1, neq
         z1(i) = v0(i)
         v0(i) = v1(i)
         v1(i) = v2(i)
         w0(i) = w1(i)
         w1(i) = w2(i)	 
      enddo
 
      gam0 = gam1
      gam1 = gam2
      c0=c1
      c1=c2
      s0=s1
      s1=s2  
c..............................	  
      goto 100
 
1000  write(*, *) 'iluMinRes: iter, the residue f-a*u'
      write(*, 88) iter, err
88    format(3x, i5, d18.5)
      return
      end
	  
cccccccccccccccccccccccccccccccccccccccccccccccccccccc
 
      subroutine redu(na, a, an, u, f, numcol, neq, maxa,
     &                x,r,q,w,d,jdiag,err,
     &                b,nb,numcb,jd,dd,g,tg,nodvar,id0,bfu,
     &                maxb,neqb,nfb,nod,kdgof,knode)
      implicit real*8 (a-h,o-z)
      dimension na(maxa),a(maxa),an(maxa),f(neq),u(neq),numcol(1)
      dimension x(neq), r(neq), q(neq), w(neq),d(neq),jdiag(neq)
      dimension b(maxb),nb(maxb),numcb(neqb+1),jd(nod,nfb),dd(nod,nfb),
     *g(neqb),tg(neqb),nodvar(kdgof,knode),id0(kdgof,knode),
     * bfu(kdgof,knode)

      tol = 0.0d0
      do i=1, neq
         x(i) = u(i)           !initial guess x0
         tol = tol+f(i)*f(i)
      enddo
      tol = dsqrt(tol)*err 
 
c ----  computing the product a*x = w
      do i=1, neq
         n0 = numcol(i)+1
         n1 = numcol(i+1)
         w(i) = 0.0d0
         do j = n0, n1
            naj = na(j)
            w(i) = w(i) + a(j)*x(naj)
         enddo
c         r(i) = w(i) -f(i)
c         d(i)=-r(i)		 
      enddo

cccccccccccccccccccccccccccccccccccc
c ----  computing the product D^t *B * D * x + w	->  w  
      call dtbdx_add_y(w,x,nodvar,b,nb,numcb,jd,dd,g,tg,
     *                       kdgof,knode,maxb,neqb,neq,nod,nfb)

      do i=1, neq
         r(i) = w(i) -f(i)
         d(i)=-r(i)		 
      enddo
cccccccccccccccccccccccccccccccccccc 
c.....compute m^{-1}*d, m is a preconditioner
c      call illredu(na,an,d, numcol, neq, maxa,jdiag)
      call iluredu(na,an,d, numcol, neq, maxa,jdiag)
      rr0 = 0.0d0	  
      do i=1,neq
         q(i) =d(i)
         rr0 = rr0 - r(i)*d(i) !r(i)^t * a^{-1} * r(i)
         u(i) = x(i)
      enddo
 
c.....loop from 100 
      iter = 1
100   continue
      do i=1,neq
         n0 = numcol(i)+1
         n1 = numcol(i+1)
         w(i) = 0.0d0
         do j = n0, n1
            naj = na(j)
            w(i) = w(i) + a(j)*q(naj)
         enddo
      enddo
c        write(*,*) '**************=========****************'
cccccccccccccccccccccccccccccccccccc
c ----  computing the product D^t *B * D * q + w	->  w  
      call dtbdx_add_y(w,q,nodvar,b,nb,numcb,jd,dd,g,tg,
     *                       kdgof,knode,maxb,neqb,neq,nod,nfb)
cccccccccccccccccccccccccccccccccccc 
 
      pp = 0.0d0
      do i =1, neq
         pp = pp + q(i)*w(i)  !d(i)^t * a * d(i)
      enddo
c       write(*,*) 'r,======='
c       write(*,*) (r(i),i=1,neq)
c       write(*,*) 'w(i)======='
c       write(*,*) (w(i),i=1,neq)
      alpha = rr0/(pp + 1.0d-40)
      do i =1, neq
         u(i) = u(i) + alpha*q(i) !x(i+1) = x(i) + alpha*d(i)
         r(i) = r(i) + alpha*w(i) !r(i+1) = r(i) + alpha*a*d(i)
         d(i)=-r(i)
      enddo
ccccccccccccccccccccccccccccccccc	
c...project the solustion using constraint 
c      do j=1,knode 
c      do i=1,kdgof
c      if (id0(i,j).lt.0) u(nodvar(i,j))=bfu(i,j)
c      enddo	
c      enddo	  
cccccccccccccccccccccccccccccc
c        write(*,*) 'alpha====',alpha
c        write(*,*) 'r(i)====='
c        write(*,*) (r(i),i=1,neq)
c        write(*,*) '******khp*************'
c      call illredu(na,an,d,numcol,neq,maxa,jdiag)
      call iluredu(na,an,d,numcol,neq,maxa,jdiag)
      rr1 = 0.0d0
      err = 0.0d0
      do i =1, neq
      rr1 = rr1 - r(i)*d(i) !r(i+1)^t * a^{-1} * r(i+1)
      err = err + r(i)*r(i)
      enddo
	  
      err = dsqrt(err)
ccccccccccccc      write(*,*) 'iter,err = ',iter,err
      if(err.le.tol .or.err.le.1.0d-16) goto 1000
      iter = iter + 1
      beta = rr1/(rr0 + 1.0d-40)
      do i =1, neq
         q(i) = d(i) + beta*q(i)
      enddo
 
      rr0 = rr1
      goto 100
 
1000  write(*, *) 'ilucg: iter, the residue f-a*u'
      write(*, 88) iter, err
88    format(3x, i5, d18.5)
      return
      end	  


      subroutine ilu(na, a, an, numcol, neq, maxa,jdiag)
      implicit real*8 (a-h,o-z)
      dimension na(maxa),a(maxa),numcol(*),an(maxa),jdiag(neq)
      do 100 i=1,maxa
100     an(i)=a(i)
 
      do 400 ir=1, neq-1
        nir0 = numcol(ir)+1
        nir1 = numcol(ir+1)
      irdiag=jdiag(ir)
        an(irdiag)=1./an(irdiag)
      do 400 ii = irdiag+1,nir1
        nii0 = numcol(na(ii))+1
        nii1 = numcol(na(ii)+1)
        do 391 jj=nii0,nii1
           if(na(jj).eq.ir) then
             an(jj)=an(irdiag)*an(jj)
             goto 392
            end if
391     continue
392     continue
             ijr0=irdiag+1
             do 394 ij=jj+1,nii1
         do 393 ijr=ijr0,nir1
          if(na(ijr).eq.na(ij)) then
           an(ij)=an(ij)-an(jj)*an(ijr)
           ijr0=ijr+1
           goto 394
          end if
393      continue
394      continue
 
400     continue
       an(jdiag(neq))=1./an(jdiag(neq))
      return
      end
 

      subroutine iluredu(na, a, u, numcol, neq, maxa,jdiag)
      implicit real*8 (a-h,o-z)
      dimension na(maxa), a(maxa), u(neq), numcol(*),jdiag(neq)
      do i=2, neq
       n0 = numcol(i)+1
         idiag=jdiag(i)
         do j = n0,idiag-1
             u(i)=u(i)-a(j)*u(na(j))
         enddo
      enddo
      do i=1,neq
          n1 = numcol(neq-i+2)
          idiag=jdiag(neq-i+1)
          do j = idiag+1,n1
             u(neq-i+1)=u(neq-i+1)-a(j)*u(na(j))
          enddo
          u(neq-i+1)=u(neq-i+1)*a(idiag)
      enddo  
      return
      end


	  
      subroutine dtbdx_add_y(y,x,nodvar,b,nb,numcb,jd,dd,g,tg,
     *                       kdgof,knode,maxb,neqb,neq,nod,nfb)
      implicit real*8 (a-h,o-z)
      dimension x(neq), y(neq)
      dimension b(maxb),nb(maxb),numcb(neqb+1),jd(nod,nfb),dd(nod,nfb),
     *g(neqb),tg(neqb),nodvar(kdgof,knode)

cccccccccccccccccccccccccccccccccccc
c ----  computing the product D^t *B * D * q + w	->  w  
c...D * x = g
      ns=0
      do i=1,nfb
      do j=1,kdgof
         ns=ns+1	
         g(ns)=0.0d0
         do 20 k=1,nod
            ii=jd(k,i)
            jj=nodvar(j,ii)
            if(jj.le.0) goto 20
            g(ns)=g(ns)+dd(k,i)*x(jj)
20       continue
      enddo
      enddo  
c...B * g = tg
      do i=1, neqb
         n0 = numcb(i)+1
         n1 = numcb(i+1)
         tg(i)=0.0d0
         do j = n0, n1
            nbj = nb(j)
            tg(i) = tg(i) + b(j)*g(nbj)
         enddo	 
      enddo
c...D^t * tg + y  ->  y
       ns=0
       do i=1,nfb
       do j=1,kdgof
       ns=ns+1
         do 10 k=1,nod
         ii=jd(k,i)
         jj=nodvar(j,ii)
         if(jj.le.0) goto 10
         y(jj)=y(jj)+dd(k,i)*tg(ns)
10       continue
       enddo
       enddo

      return
      end	 
	  
	  
      subroutine dtbdx_add_y2(y,x,y1,x1,nodvar,b,nb,numcb,jd,dd,g,tg,
     *                        g1,tg1,kdgof,knode,maxb,neqb,neq,nod,nfb)
      implicit real*8 (a-h,o-z)
      dimension x(neq), y(neq), x1(neq), y1(neq)
      dimension b(maxb),nb(maxb),numcb(neqb+1),jd(nod,nfb),dd(nod,nfb),
     *g(neqb),tg(neqb),g1(neqb),tg1(neqb),nodvar(kdgof,knode)

cccccccccccccccccccccccccccccccccccc
c ----  computing the product D^t *B * D * q + w	->  w  
c...D * x = g
c...D * x1 = g1
      ns=0
      do i=1,nfb
      do j=1,kdgof
         ns=ns+1	
		 
         g(ns)=0.0d0
         g1(ns)=0.0d0		 
         do 20 k=1,nod
            ii=jd(k,i)
            jj=nodvar(j,ii)
            if(jj.le.0) goto 20
            g(ns)=g(ns)+dd(k,i)*x(jj)
            g1(ns)=g1(ns)+dd(k,i)*x1(jj)
20       continue
      enddo
      enddo  
c...B * g = tg
c...B * g1 = tg1

      do i=1, neqb
	     tg(i)=0.0d0
         tg1(i)=0.0d0
		 
         n0 = numcb(i)+1
         n1 = numcb(i+1)
         do j = n0, n1
            nbj = nb(j)
            tg(i) = tg(i) + b(j)*g(nbj)
            tg1(i) = tg1(i) + b(j)*g1(nbj)			
         enddo	 
      enddo
c...D^t * tg + y  ->  y
c...D^t * tg1 + y1  ->  y1
       ns=0
       do i=1,nfb
       do j=1,kdgof
       ns=ns+1
         do 10 k=1,nod
         ii=jd(k,i)
         jj=nodvar(j,ii)
         if(jj.le.0) goto 10
         y(jj)=y(jj)+dd(k,i)*tg(ns)
         y1(jj)=y1(jj)+dd(k,i)*tg1(ns)		 
10       continue
      enddo
      enddo

      return
      end	 	  
	  
	  
cccccccccccccc choleskey factorizaiton:ccccccccccccccccccccccccccccccccccccccc
c                       u11  u12  u13  u14  u15
c                            u22  u23  u24  u25
c    	     L^t=                 u33  u34  u35
c                                      u44  u45
c                                           u55
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c...the diagonal of the upper diagonal matrix is inversed in oerder to compute the interse of the mtrix
c... used in iluredu()
      subroutine ill(na, a, an, numcol, neq, maxa,jdiag,pmass)
      implicit real*8 (a-h,o-z)
      dimension na(maxa),a(maxa),numcol(*),an(maxa),jdiag(neq)
	  
      an(1:maxa)=a(1:maxa)
      do ir=1,neq
         nir1 = numcol(ir+1)
         irdiag=jdiag(ir)	 
         if(dabs(an(irdiag)).lt.1.0d-15) an(irdiag)=pmass	 
		    write(*,*) an(irdiag)
         an(irdiag)=dsqrt(an(irdiag))
         do j=irdiag+1,nir1
           an(j)=an(j)/an(irdiag)			   
         enddo		 		 
      do jj = irdiag+1,nir1
         ii0 = jdiag(na(jj))
         ii1=numcol(na(jj)+1)
         ijr0=irdiag+1		
         do 394 ij=ii0,ii1
         do 393 ijr=ijr0,nir1
             if(na(ijr).eq.na(ij)) then
             an(ij)=an(ij)-an(jj)*an(ijr)
             ijr0=ijr+1		 
             goto 394
             endif 
393      continue
394      continue
 
      enddo
ccc...inverse the diagonal and copy upper triangle to the lower triangle	
        an(irdiag)=1.0d0/an(irdiag)	  
        do 395 ii = irdiag+1,nir1
         nii0 = numcol(na(ii))+1
         jrdiag=jdiag(na(ii))	 
         do jj=nii0,jrdiag-1
             if(na(jj).eq.ir) then
             an(jj)=an(ii)
             goto 395
             end if
         enddo		 
395     continue		  
      enddo
	  
      return
      end	  
	  
      subroutine illredu(na, a, u, numcol, neq, maxa,jdiag)
      implicit real*8 (a-h,o-z)
      dimension na(maxa), a(maxa), u(neq), numcol(*),jdiag(neq)
      do i=1, neq
         n0 = numcol(i)+1
         idiag=jdiag(i)
         do j = n0,idiag-1
             u(i)=u(i)-a(j)*u(na(j))
         enddo
	     u(i)=u(i)*a(idiag)		 
      enddo
      do i=1,neq
          n1 = numcol(neq-i+2)
          idiag=jdiag(neq-i+1)
          do j = idiag+1,n1
             u(neq-i+1)=u(neq-i+1)-a(j)*u(na(j))
          enddo
          u(neq-i+1)=u(neq-i+1)*a(idiag)
      enddo  
      return
      end	  
	  