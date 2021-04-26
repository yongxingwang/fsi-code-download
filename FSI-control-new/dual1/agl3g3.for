      subroutine agl3g3(r,coefr,prmt,egs,egm,egd,egl,num)
      implicit real*8 (a-h,o-z)
      dimension egs(8,8),egm(8),egl(8),
     & els(8,8),elm(8),ell(8),nc(4),
     & r(2,3),coefr(3,12),y(1,4),z(2,2),prmt(1),t(8,8)
      ngvar = 8
      nlvar = 8
      ngdim = 2
      nldim = 1
      nnode = 3
      nc(1) = 1
      nc(2) = 2
      nc(3) = 3
      ncoef = 10
      do 1 i=1,ngdim
      do 1 j=1,nnode
1     coefr(j,i+ncoef) = r(i,j)
c@smit
      call smit(ngdim,nldim,nnode,r,y,z,nc)
c@callges
      call all3g3(y,coefr,prmt,egs,egm,egd,egl,num)

      egm(1:8)=0.d0


      return
      end
