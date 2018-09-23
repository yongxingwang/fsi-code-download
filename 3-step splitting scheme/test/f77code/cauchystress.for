      implicit real*8 (a-h,o-z)
      logical filflg
      common /aa/ ia(300000000)
      common /bb/ ib(90300000)
      open (1,file='coor1',form='unformatted',status='old')
      read (1) knode,kcoor
	  
      kdgof=3

      if(kcoor.eq.3) kdgof=6

      kvar=knode*kdgof
      kelem=22570000
      knb1=kdgof*knode*1
      if (knb1/2*2 .lt. knb1) knb1=knb1+1
      kna1=kdgof*knode*2
      kna3=kcoor*knode*2
      kna4=kdgof*knode*2
      kna5=kcoor*knode*2
      kna6=kvar*2
      kna2=kvar*2
      kna8=10000*2
      kna7=kelem*2
      knb2=kelem*1
      if (knb2/2*2 .lt. knb2) knb2=knb2+1
      kna0=1
      kna1=kna1+kna0
      kna2=kna2+kna1
      kna3=kna3+kna2
      kna4=kna4+kna3
      kna5=kna5+kna4
      kna6=kna6+kna5
      kna7=kna7+kna6
      kna8=kna8+kna7
      if (kna8-1.gt.300000000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 300000000'
      write(*,*) 'memory needed = ',kna8,' in prgram ecgme'
      stop 55555
      endif
      knb0=1
      knb1=knb1+knb0
      knb2=knb2+knb1
      if (knb2-1.gt.90300000) then
      write(*,*) 'exceed memory of array ib'
      write(*,*) 'memory of ib = 90300000'
      write(*,*) 'memory needed = ',knb2,' in prgram ecgme'
      stop 55555
      endif
      call ecgme(knode,kdgof,kvar,kcoor,
     *numtyp,neq,kelem,lr,ia(kna0),ia(kna1),
     *ia(kna2),ia(kna3),ia(kna4),ia(kna5),ia(kna6),
     *ia(kna7),ib(knb0),ib(knb1))
      end
      subroutine ecgme(knode,kdgof,kvar,kcoor,
     *numtyp,neq,kelem,lr,u,
     *f,coor,ew,eun,emass,
     *sml,emate,nodvar,node)
      implicit real*8 (a-h,o-z)
      dimension nodvar(kdgof,knode),u(kdgof,knode),coor(kcoor,knode),
     *ew(kdgof,knode),eun(kcoor,knode),emass(kvar),
     & f(kvar),emate(1000),sml(kelem),node(kelem)
       logical filflg
 
c ...............................................................c
c         compute the solution by least square method            c
c ...............................................................c
c ..... kdgof number of d.o.f
c ..... knode number of nodes
c ..... nodvar denote the equation number corresponding the d.o.f
c ..... u initial value
c ..... coor coordinates
c ..... f right hand side term of the equation
c ..... sml store the element stif,mass,damp matrix and load
c ..... node element nodal connection
c ..... emate element material
c .................................................................
6     format (1x,26i3)
7     format (1x,6e12.3)
1001  format(1x,9i7)
 
c.......read coor1 file
      rewind(1)
      read (1) numnod,ncoor,((coor(i,j),i=1,ncoor),j=1,numnod)
      close(1) 
 
      neq = 0
      do j=1,knode
      do i=1,kdgof
      neq = neq+1
      nodvar(i,j) = neq
      u(i,j) = 0.d0
      enddo
      enddo	  

      do i=1,knode
      do j=1,kcoor
      eun(j,i)=coor(j,i)
      enddo
      enddo	 
c.......open coor1.bak file
      open (1,file='coor1.bak',form='unformatted',status='old')
      read (1) numnod,ncoor,((coor(i,j),i=1,ncoor),j=1,numnod)
      close(1) 
 
      do i=1,neq
      emass(i) = 0.0
      enddo

c.......open elem0 file
      open (3,file='elem1',form='unformatted',status='old')
c.......read nodal connection points and material no.
c.......num .... number of elements
c.......nnode .... number of nodes for each element
      read (3) num,nnode,
     *           ((node((i-1)*nnode+j),j=1,nnode),i=1,num)
 
c      write(*,*) 'num =',num,' nnode =',nnode
c      write(*,*) 'node ='
c      write(*,6) ((node((i-1)*nnode+j),j=1,nnode),i=1,num)

      nne = nnode-1
      k=0
      do 116 j=1,nne
      jnod = node(j)
      if (jnod.le.0) goto 116
      do l=1,kdgof
      if (nodvar(l,jnod).ne.0) k=k+1
      enddo
116   continue
c      write(*,*) 'k =',k
      kk=k*k
      k0=1
      k1=k0+k*k
      k2=k1+k
      k3=k2+k
      k4=k3+k*k
      k5=k4+k*k
      k6=k5+k
      k7=k6+k
      call etsub(knode,kdgof,kcoor,kelem,k,kk,nnode,nne,
     *ncoor,num,nodvar,coor,node,emate,
     &sml(k0),sml(k1),sml(k2),sml(k3),sml(k4),sml(k5),sml(k6),
     &eun,ew,emass,u)
      close(3)	 
c......emass lumping matrix for least square method
      emmax=0.0
      do i=1,neq
      if (emmax.lt.emass(i)) emmax=emass(i)
      enddo
      emmin = emmax*1.d-8
	  
      neq = 0
      do ij=1,knode*kdgof
      if (emass(ij).lt.emmin) emass(ij)=emmin
      f(ij)=0.0d0
      enddo
	  
      do i=1,knode
      do 2100 j=1,kdgof
      ij=nodvar(j,i)
      if (ij.le.0) goto 2100
      if (ij.gt.neq) neq = ij
      f(ij) = f(ij)+u(j,i)/emass(ij)
2100  continue
      enddo

      do i=1,knode
      do 2300 j=1,kdgof
      ij=nodvar(j,i)
      ew(j,i) = 0.0
      if (ij.le.0) goto 2300
      ew(j,i) = f(ij)
2300  continue
      enddo
 

      open(10,file='stress',form='unformatted',status='unknown')
      write(10)  ((ew(j,i),i=1,knode),j=1,kdgof)
      close(10)
      end
 
 
      subroutine etsub(knode,kdgof,kcoor,kelem,k,kk,nnode,nne,
     & ncoor,num,nodvar,coor,node,emate,
     *es,em,ef,estifn,estifv,emassn,emassv,
     *eun,ew,emass,u)
      implicit real*8 (a-h,o-z)
      dimension nodvar(kdgof,knode),coor(kcoor,knode),node(kelem),
     *u(kdgof,knode),emate(300),
     *es(k,k),em(k),ef(k),eun(kcoor,knode),
     *ew(kdgof,knode),estifn(k,k),estifv(kk),
     *emassn(k),emassv(k),emass(1),
     * r(500),prmt(500),coef(500),lm(500)
18      format (1x,8e9.2)
 
      read (3) mmate,nmate,((emate((i-1)*nmate+j),j=1,nmate),
     *	i=1,mmate)
      write(*,*) 'mmate =',mmate,' nmate =',nmate
      write (*,*) 'emate ='
      write (*,18) ((emate((i-1)*nmate+j),j=1,nmate),
     *	i=1,mmate)
      do 1000 ne=1,num
      nr=0
      do j=1,nne
      jnod = node((ne-1)*nnode+j)
      if (jnod.lt.0) jnod = -jnod
      prmt(nmate+7+j) = jnod

      do l=1,ncoor
      coef(j+(l-1)*nne)=eun(l,jnod)
      enddo
	  
      do i=1,ncoor
      nr=nr+1
      r(nr) = coor(i,jnod)
      enddo
      enddo
	  
      imate = node(nnode*ne)
      do j=1,nmate
      prmt(j) = emate((imate-1)*nmate+j)
      enddo
 
      if(kcoor.eq.2) then
      call eet3(r,coef,prmt,es,em,ec,ef,ne)
      else
      call eew4(r,coef,prmt,es,em,ec,ef,ne)
      endif
c       write(*,*) 'es em ef ='
c       do 555 i=1,k
c555    write(*,18) (es(i,j),j=1,k)
c       write(*,18) (em(i),i=1,k)
c       write(*,18) (ef(i),i=1,k)
 
      do 201 i=1,k
      do 201 j=1,k
      estifn(i,j)=0.0
201   continue
      do 202 i=1,k
      estifn(i,i)=estifn(i,i)
      do 202 j=1,k
      estifn(i,j)=estifn(i,j)+es(i,j)
202   continue
      do 203 i=1,k
      emassn(i)=0.0
203   continue
      do 204 i=1,k
      emassn(i)=emassn(i)+em(i)
204   continue
 
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
      emassv(l)=emassn(i)
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
 
 
      if (inv.lt.0)
     *  u(jdgf,nodj)=u(jdgf,nodj)-estifn(i,j)*u(idgf,nodi)
400   continue
500   continue
600   continue
700   continue
c       write (*,*) 'u ='
c       write (*,18) ((u(j,i),j=1,kdgof),i=1,knode)
 

      do i=1,l
      j=lm(i)
      emass(j) = emass(j) + emassv(i)
      enddo    
 
1000  continue

      end
	  