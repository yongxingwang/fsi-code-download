      subroutine dgl3g3(r,coefr,prmt,egs,egm,egd,egl,num)
      implicit real*8 (a-h,o-z)
      dimension egs(6,6),egm(6),egl(6),
     & els(6,6),elm(6),ell(6),nc(4),
     & r(2,3),coefr(3,4),y(1,4),z(2,2),prmt(1),t(6,6)
      ngvar = 6
      nlvar = 6
      ngdim = 2
      nldim = 1
      nnode = 3
      nc(1) = 1
      nc(2) = 2
      nc(3) = 3
      ncoef = 2
      do 1 i=1,ngdim
      do 1 j=1,nnode
1     coefr(j,i+ncoef) = r(i,j)
c@smit
      call smit(ngdim,nldim,nnode,r,y,z,nc)
ccccccccccccccccccccccccccccccc	
      imate=prmt(4)+0.5
      if(imate.eq.1) then
      do i=1,nnode
      coefr(i,1)=z(2,1)
      coefr(i,2)=z(2,2)
      enddo
      else
      do i=1,nnode
      coefr(i,1)=-z(2,1)
      coefr(i,2)=-z(2,2)
      enddo
      endif
cccccccccccccccccccccccccccccccccc
c@callges
      call dll3g3(y,coefr,prmt,egs,egm,egd,egl,num)

      return
      end
