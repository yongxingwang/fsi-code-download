      implicit real*8 (a-h,o-z)
      common /aa/ ia(300000000)
      common /bb/ ib(90300000)
      common /cc/ ic(45150000)
      open(10,file='coor0',form='unformatted',status='old')
      read(10) knode,kcoor

      kdgof=kcoor
	  
      maxt=300000000/(1+2*2)
 
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
      knc2=kcoor*knode*2
      knc11=kdgof*knode*2
      knc12=kdgof*knode*2
      knc4=neq*2
      knb1=maxa*2
      knb3=maxa*1
      if (knb3/2*2 .lt. knb3) knb3=knb3+1
      kna1=neq1*1
      if (kna1/2*2 .lt. kna1) kna1=kna1+1
      kna2=neq*1
      if (kna2/2*2 .lt. kna2) kna2=kna2+1
      knc10=kemate*2
      kna4=kelem*1
      if (kna4/2*2 .lt. kna4) kna4=kna4+1
      knc13=100000*2
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
      if (kna4-1.gt.90300000) then
      write(*,*) 'exceed memory of array ib'
      write(*,*) 'memory of ib = 90300000'
      write(*,*) 'memory needed = ',kna4,' in prgram ecgmb'
      stop 55555
      endif
      knb0=1
      knb1=knb1+knb0
      knb2=knb2+knb1
      knb3=knb3+knb2
      if (knb3-1.gt.300000000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 300000000'
      write(*,*) 'memory needed = ',knb3,' in prgram ecgmb'
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
      if (knc13-1.gt.45150000) then
      write(*,*) 'exceed memory of array ic'
      write(*,*) 'memory of ic = 45150000'
      write(*,*) 'memory needed = ',knc13,' in prgram ecgmb'
      stop 55555
      endif
      call ecgmb(knode,kdgof,kvar,kcoor,
     *numtyp,numel,neq,kelem,kemate,maxa,
     *maxt,neq1,ib(kna0),ib(kna1),ib(kna2),
     *ib(kna3),ia(knb0),ia(knb1),ia(knb2),ic(knc0),
     *ic(knc1),ic(knc2),ic(knc3),ic(knc4),ic(knc5),
     *ic(knc6),ic(knc7),ic(knc8),ic(knc9),ic(knc10),
     *ic(knc11),ic(knc12))
      end
      subroutine ecgmb(knode,kdgof,kvar,kcoor,
     *numtyp,numel,neq,kelem,kemate,maxa,
     *maxt,neq1,numcol,jdiag,nodvar,node,
     *a,an,na,u,coor,u1,
     *f,x0,r0,p,w,hp,
     *emate,eu,eun,sml)
      implicit real*8 (a-h,o-z)
      dimension nodvar(kdgof,knode),u(kdgof,knode),coor(kcoor,knode),
     *eu(kdgof,knode),eun(kdgof,knode),
     & f(neq),a(maxa),na(maxa),numcol(neq1),jdiag(neq),emate(kemate),
     & node(kelem),sml(100000),u1(neq),an(maxa),
     & x0(neq),r0(neq),p(neq),w(neq),hp(neq)
 
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
      rewind(10)
      read (10) numnod,ncoor,((coor(i,j),i=1,ncoor),j=1,numnod)
      close(10)
cc    write(*,*) 'numnod,ncoor=',numnod,ncoor
 
c.......open bf file
      open (1,file='bfdb',form='unformatted',status='old')
      read (1) ((u(j,i),j=1,kdgof),i=1,knode)
      close (1)
cc      write (*,*) 'bf ='
cc      write(*,7) ((u(j,i),j=1,kdgof),i=1,knode)
 
      open(1,file='ufluid',form='unformatted',status='old')
      read(1) ((eun(j,i),i=1,knode),j=1,kdgof)
      close(1)
	  
c.......open diag file
      open (1,file='diagb',form='unformatted',status='old')
      read(1) (numcol(i),i=1,neq1)
      read(1) (na(i),i=1,maxa)
      read(1) (jdiag(i),i=1,neq)
      close(1)
 
c.......open elem0 file
      open (3,file='elem0',form='unformatted',status='old')
      read (3) num,nnode,
     *           ((node((i-1)*nnode+j),j=1,nnode),i=1,num)
 
cc      write(*,*) 'num =',num,' nnode =',nnode
cc      write(*,*) 'node ='
cc      write(*,6) ((node((i-1)*nnode+j),j=1,nnode),i=1,num)

      do i=1,maxa
      a(i) = 0.0d0
      enddo
 
c.......open emate+enode+eload file
c.......input enode
      nne = nnode-1
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
      call etsub(knode,kdgof,kcoor,kelem,k,kk,nnode,nne,
     &ncoor,num,dt,neq,neq1,maxt,maxa,nodvar,coor,node,emate,
     &a,na,numcol,jdiag,
     &sml(k0),sml(k1),sml(k2),sml(k3),sml(k4),
     &eun,eu,u)
      close(3)	
	  
      do ij=1,neq
      u1(ij) = 0.0d0
      f(ij)=0.0d0
      enddo
	  
      do 2200 i=1,knode
      do 2100 j=1,kdgof
      ij=nodvar(j,i)
      if (ij.le.0) goto 2100
      f(ij)=f(ij)+u(j,i)
2100  continue
2200  continue
 
cc      write (*,*) 'u ='
cc      write (*,7) ((u(j,i),j=1,kdgof),i=1,knode)
cc      write (*,*) 'neq =',neq,' f  ='
cc      write(*,7) (f(i),i=1,neq)
 
      maxa = jdiag(neq)
c     write(*,*) 'jdiag ='
c     write(*,6) (jdiag(i),i=1,neq)
 
      write(*,*) 'ilucg_solver memory required .... ',maxa
      if (maxa.gt.maxt) then
      write(*,*) 'warning matrix a exceed core memory .... ',maxt
c      stop 0000
      endif
	  
      call ilu(na, a, an, numcol, neq, maxa,jdiag)
      errilu=1.d-6
      call redu(na, a,an, u1, f, numcol, neq, maxa, kkk,
     &                x0,r0,p,w,hp,jdiag,errilu)
c     write(*,*) '       u1 = '
c     write(*,7) (a(i),i,maxa)
c     write(*,7) (f(i),i=1,neq)
 
      do inod=1,knode
      do idfg=1,kdgof
      n=nodvar(idfg,inod)
c       write (*,*) 'n =',n
      if(n.le.0) then
      eu(idfg,inod)=u(idfg,inod)
      else
      eu(idfg,inod)=u1(n)
      endif
      enddo
      enddo

      open(1,file='ufluid',form='unformatted',status='unknown')
      write(1)  ((eu(j,i),i=1,knode),j=1,kdgof)
      close(1)

      return
      end
 
      subroutine etsub(knode,kdgof,kcoor,kelem,k,kk,nnode,nne,
     &ncoor,num,dt,neq,neq1,maxt,maxa,nodvar,coor,node,emate,
     &a,na,numcol,jdiag,
     &es,em,ef,estifn,estifv,eun,eu,u)
      implicit real*8 (a-h,o-z)
      dimension nodvar(kdgof,knode),coor(kcoor,knode),node(kelem),
     & u(kdgof,knode),emate(300),
     & a(maxa),na(maxa),numcol(neq1),jdiag(neq),
     *es(k,k),em(k),ef(k),eun(kdgof,knode),
     *eu(kdgof,knode),estifn(k,k),estifv(kk),
     *r(500),prmt(500),coef(500),lm(500)
18    format (1x,8e9.2)
 
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
      do 110 l=1,kdgof
      coef(j+(l-1)*nne)=eun(l,jnod)
110   continue
       do 120 i=1,ncoor
       nr=nr+1
120	   r(nr) = coor(i,jnod)
130	   continue
       imate = node(nnode*ne)
       do 140 j=1,nmate
140	   prmt(j) = emate((imate-1)*nmate+j)
       prmt(nmate+1)=dt

      if(kcoor.eq.2) then	   
      call beq9g3(r,coef,prmt,es,em,ec,ef,ne)
      else
      call bec27g3(r,coef,prmt,es,em,ec,ef,ne)
      endif	  
c       write(*,*) 'es em ef ='
c       do 555 i=1,k
c555    write(*,18) (es(i,j),j=1,k)
c       write(*,18) (em(i),i=1,k)
c       write(*,18) (ef(i),i=1,k)
 
      do 201 i=1,k
      do 201 j=1,k
      estifn(i,j)=0.0d0
201   continue
      do 202 i=1,k
c      estifn(i,i)=estifn(i,i)
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
      u(idgf,nodi)=u(idgf,nodi)+ef(i)
305   j=0
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
310   continue
 
      if (inv.lt.0) u(jdgf,nodj)=u(jdgf,nodj)-estifn(i,j)*u(idgf,nodi)
	  
400   continue
500   continue
600   continue
700   continue
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
240   continue
280   a(k) = a(k) + estif(i,j)
300   continue
400   continue
500   return
      end
 
      subroutine redu(na, a,an, u, f, numcol, neq, maxa, kkk,
     &                x0,r0,p,w,hp,jdiag,err)
      implicit real*8 (a-h,o-z)
      dimension na(maxa),a(maxa),an(maxa),f(neq),u(neq),numcol(1)
      dimension x0(neq), r0(neq), p(neq), w(neq),hp(neq),jdiag(neq)
c      write(*,*) '=++++++++='
c      write(*,*) f
c      epsilon = 1.0d-12
      epsilon = 0.0
      do 1 i=1, neq
c      x0(i) = 0.0d0
       x0(i) = u(i)
      epsilon = epsilon+f(i)*f(i)
1     continue
cc      write(*,*) 'input err'
cc      read(*,*) err
      epsilon = sqrt(epsilon)
      write(*,*) '|f| = ',epsilon
      epsilon = epsilon*1.0e-3*err
 
c ---- giving the initial guess
      do 2 i=1, neq
c      x0(i) = 0.0d0
      x0(i) = u(i)
2     continue
 
c ----  computing the product a*x0 = w
200   do 400 i=1, neq
      n0 = numcol(i)+1
      n1 = numcol(i+1)
      w(i) = 0.0d0
      do 400 j = n0, n1
      naj = na(j)
      w(i) = w(i) + a(j)*x0(naj)
400   continue
 
      rr0 = 0.0
      do 10 i = 1, neq
      r0(i) = w(i) -f(i)
      hp(i)=-r0(i)
10    continue
 
      call iluredu(na,an,hp, numcol, neq, maxa,jdiag)
      do 11 i=1,neq
      p(i) =hp(i)
      rr0 = rr0 - r0(i)*hp(i)
      u(i) = x0(i)
11    continue
 
      iter = 1
c -----  w = a*p
100   do 500 i=1,neq
      n0 = numcol(i)+1
      n1 = numcol(i+1)
      w(i) = 0.0d0
      do 500 j = n0, n1
      naj = na(j)
      w(i) = w(i) + a(j)*p(naj)
500   continue
c      write(*,*) '**************=========****************'
 
      pp = 0.0
      do 30 i =1, neq
      pp = pp + p(i)*w(i)
30    continue
c      write(*,*) 'r0,======='
c      write(*,*) (r0(i),i=1,neq)
c      write(*,*) 'w(i)======='
c     write(*,*) (w(i),i=1,neq)
      ak = rr0/(pp + 1.0d-40)
      do 40 i =1, neq
      u(i) = u(i) + ak*p(i)
      r0(i) = r0(i) + ak*w(i)
      hp(i)=-r0(i)
40    continue
c      write(*,*) 'ak====',ak
c      write(*,*) 'r0(i)====='
c      write(*,*) (r0(i),i=1,neq)
c      write(*,*) '******khp*************'
      call iluredu(na,an,hp,numcol,neq,maxa,jdiag)
c      write(*,*) (hp(i),i=1,neq)
c      call chckb(am,hp,fb,jdiab,neq,maxab)
 
      rr1 = 0.0
      err = 0.0
      do 50 i =1, neq
      rr1 = rr1 - r0(i)*hp(i)
      err = err + r0(i)*r0(i)
50    continue
      err = sqrt(err)
cccccccccccc      write(*,*) 'iter,err = ',iter,err
c      if(err.le.1.0d-6) goto 1000
      if(err.le.epsilon) goto 1000
      iter = iter + 1
c      write(*,*) 'iter===========',iter
      beta = rr1/(rr0 + 1.0d-40)
      do 70 i =1, neq
      p(i) = hp(i) + beta*p(i)
70    continue
 
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
100   an(i)=a(i)
 
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
      endif
391   continue
392   continue
      ijr0=irdiag+1
      do 394 ij=jj+1,nii1
      do 393 ijr=ijr0,nir1
      if(na(ijr).eq.na(ij)) then
      an(ij)=an(ij)-an(jj)*an(ijr)
      ijr0=ijr+1
      goto 394
      endif
393   continue
394   continue
 
400   continue
      an(jdiag(neq))=1./an(jdiag(neq))
      return
      end
 
      subroutine iluredu(na, a, u, numcol, neq, maxa,jdiag)
      implicit real*8 (a-h,o-z)
      dimension na(maxa), a(maxa), u(neq), numcol(*),jdiag(neq)
      do 600 i=2, neq
      n0 = numcol(i)+1
      n1 = numcol(i+1)
      idiag=jdiag(i)
      do 500 j = n0,idiag-1
      u(i)=u(i)-a(j)*u(na(j))
500   continue
600   continue
200   do 450 i=1,neq
      n0 = numcol(neq-i+1)+1
      n1 = numcol(neq-i+2)
      idiag=jdiag(neq-i+1)
      do 400 j = idiag+1,n1
      u(neq-i+1)=u(neq-i+1)-a(j)*u(na(j))
400   continue
      u(neq-i+1)=u(neq-i+1)*a(idiag)
450   continue
      end
