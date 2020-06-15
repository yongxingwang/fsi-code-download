      implicit real*8 (a-h,o-z)
  
c.......open unod file and store the solution
      open (2,file=' ',form='formatted',status='old')
      read(2,*) o1
      close (2)
 
      beta=1.d2
      open (2,file=' ',form='formatted',status='old',position="append")
      write(2,*) o1*beta/2.d0
      close (2) 

 
      end

