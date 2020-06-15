      implicit real*8 (a-h,o-z)
      dimension rdata(100000,20),idata(100000,40)
111   format(1x,i6,30i6)
222   format(1x,i6,20e12.4)
      equivalence(rdata(1,1),idata(1,1))
      open(12,file='out',form='formatted',status='unknown')
      write(12,*) 'c ............... coor'
      open(11,file='coor0',form='unformatted',status='old')
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      write(12,*) 'c ............... id for field cgma'
      open(11,file='id0',form='unformatted',status='old')
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      close(11)
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      write(12,*) 'c ............... id for field cgmb'
      open(11,file='idb0',form='unformatted',status='old')
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      close(11)
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      write(12,*) 'c ............... id for field cgmc'
      open(11,file='idc0',form='unformatted',status='old')
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      close(11)
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      write(12,*) 'c ............... id for field cgmd'
      open(11,file='idd0',form='unformatted',status='old')
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      close(11)
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      write(12,*) 'c ............... disp0 for field cgma'
      open(11,file='disp0',form='unformatted',status='old')
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      write(12,*) 'c ............... dispb0 for field cgmb'
      open(11,file='dispb0',form='unformatted',status='old')
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      write(12,*) 'c ............... dispc0 for field cgmc'
      open(11,file='dispc0',form='unformatted',status='old')
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      write(12,*) 'c ............... dispd0 for field cgmd'
      open(11,file='dispd0',form='unformatted',status='old')
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      write(12,*) 'c ............... disp1 for field cgma'
      open(11,file='disp1',form='unformatted',status='old')
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      close(11)
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      write(12,*) 'c ............... element data for field cgma'
      open(11,file='elem0',form='unformatted',status='old')
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' element aeq9g3      '
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' material data '
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' element all3g3      '
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' material data '
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      close(11)
      write(12,*) 'c ............... element data for field cgmb'
      open(11,file='elemb0',form='unformatted',status='old')
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' element beq9g3      '
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' material data '
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' element bll3g3      '
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' material data '
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      close(11)
      write(12,*) 'c ............... element data for field cgmc'
      open(11,file='elemc0',form='unformatted',status='old')
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' element ceq9g3      '
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' material data '
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' element cll3g3      '
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' material data '
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      close(11)
      write(12,*) 'c ............... element data for field cgmd'
      open(11,file='elemd0',form='unformatted',status='old')
      read(11) maxnod,nd,((idata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' element deq9g3      '
      do i=1,maxnod
      write(12,111) i,(idata(i,j),j=1,nd)
      enddo
      read(11) maxnod,nd,((rdata(i,j),j=1,nd),i=1,maxnod)
      write(12,*) ' material data '
      do i=1,maxnod
      write(12,222) i,(rdata(i,j),j=1,nd)
      enddo
      close(11)
      end
