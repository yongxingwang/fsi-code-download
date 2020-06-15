      subroutine cgl3g3(r,coefr,prmt,egs,egm,egd,egl,num)
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
      imate=prmt(5)+0.5
      do i=1,nnode
      coefr(i,1)=z(1,1)
      coefr(i,2)=z(1,2)
      enddo
cccccccccccccccccccccccccccccccccc
c@callges
      call cll3g3(y,coefr,prmt,els,elm,eld,ell,num)
      do 10 i=1,nlvar
      do 10 j=1,ngvar
10    t(i,j) = 0.0
      call tkt(ngvar,nlvar,t,els,egs)
      call tmt(ngvar,nlvar,t,elm,egm)
      call tl(ngvar,nlvar,t,ell,egl)
      return
      end
