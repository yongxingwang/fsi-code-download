      implicit real*8 (a-h,o-z)
      character*12 fname,filename(20)
      common /aa/ ia(143610000)
      common /bb/ ib(71800000)
      maxt=143610000/3-1000
      open(1,file=' ',form='unformatted',status='old')
      read(1) knode,kdgof
      close(1)
      kvar=knode*kdgof
      write(*,*) 'knode,kdgof,kvar ='
      write(*,'(1x,4i7)') knode,kdgof,kvar
      kvar1=kvar+1
      kcoor=3
      kelem=17950000
      knb1=kdgof*knode*1
      if (knb1/2*2 .lt. knb1) knb1=knb1+1
      kna4=kcoor*knode*2
      kna1=kdgof*knode*2
      kna2=kdgof*knode*2
      kna3=kdgof*knode*2
      kna5=knode*1
      if (kna5/2*2 .lt. kna5) kna5=kna5+1
      knb4=kelem*1
      if (knb4/2*2 .lt. knb4) knb4=knb4+1
      knb3=kvar1*1
      if (knb3/2*2 .lt. knb3) knb3=knb3+1
      knb2=kvar1*1
      if (knb2/2*2 .lt. knb2) knb2=knb2+1
      knc1=maxt*1
      if (knc1/2*2 .lt. knc1) knc1=knc1+1
      knc2=maxt*1
      if (knc2/2*2 .lt. knc2) knc2=knc2+1
      knc3=maxt*1
      if (knc3/2*2 .lt. knc3) knc3=knc3+1
      kna0=1
      kna1=kna1+kna0
      kna2=kna2+kna1
      kna3=kna3+kna2
      kna4=kna4+kna3
      kna5=kna5+kna4
      if (kna5-1.gt.143610000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 143610000'
      write(*,*) 'memory needed = ',kna5,' in prgram start'
      stop 55555
      endif
      knb0=1
      knb1=knb1+knb0
      knb2=knb2+knb1
      knb3=knb3+knb2
      knb4=knb4+knb3
      if (knb4-1.gt.71800000) then
      write(*,*) 'exceed memory of array ib'
      write(*,*) 'memory of ib = 71800000'
      write(*,*) 'memory needed = ',knb4,' in prgram start'
      stop 55555
      endif
      knc0=1
      knc1=knc1+knc0
      knc2=knc2+knc1
      knc3=knc3+knc2
      if (knc3-1.gt.143610000) then
      write(*,*) 'exceed memory of array ia'
      write(*,*) 'memory of ia = 143610000'
      write(*,*) 'memory needed = ',knc3,' in prgram start'
      stop 55555
      endif
      call start(knode,kdgof,kcoor,kvar,
     *kelem,maxt,kvar1,ia(kna0),ia(kna1),ia(kna2),
     *ia(kna3),ia(kna4),ib(knb0),ib(knb1),ib(knb2),
     *ib(knb3),ia(knc0),ia(knc1),ia(knc2),
     *filename)
      end
      subroutine start(knode,kdgof,kcoor,kvar,
     *kelem,maxt,kvar1,u0,u1,u2,
     *coor,inodvar,nodvar,numcol,lm,node,
     *nap,naj,na,
     *filename)
      implicit real*8 (a-h,o-z)
      character*12 filename(20)
      DIMENSION  NODVAR(KDGOF,KNODE),COOR(KCOOR,KNODE),R(3),
     *  U0(KDGOF,KNODE),U1(KDGOF,KNODE),U2(KDGOF,KNODE),
     *  INODVAR(KNODE),node(kelem)
      dimension LM(kvar1),numcol(kvar1),NAP(MAXT),NAJ(MAXT),NA(MAXT)
 
      CHARACTER*1 MATERIAL
        logical filflg
 
C .................................................................
C ..... KDGOF NUMBER OF D.O.F
C ..... KNODE NUMBER OF NODES
C ..... INODVAR ID DATA
C ..... NODVAR DENOTE THE EQUATION NUMBER CORRESPONDING THE D.O.F
C ..... U0 U1 U2 INITIAL VALUE
C ..... COOR COORDINATES
C ..... NODE ELEMENT NODAL CONNECTION
C .................................................................
6     FORMAT (1X, 15I4)
7     FORMAT (1X,8F9.3)
C.......OPEN ID file
      OPEN (1,FILE=' ',FORM='UNFORMATTED',STATUS='OLD')
      READ (1) NUMNOD,NODDOF,((NODVAR(I,J),I=1,NODDOF),J=1,NUMNOD)
      CLOSE (1)
      call chms(kdgof,knode,NODVAR)
c        WRITE(*,*) 'NUMNOD =',NUMNOD,' NODDOF =',NODDOF
c        WRITE (*,*) 'ID ='
c        WRITE (*,6) ((NODVAR(I,J),I=1,NODDOF),J=1,NUMNOD)
 
C.....  GET THE NATURAL NODAL ORDER
      DO 12 N=1,KNODE
      INODVAR(N)=N
12    CONTINUE
 
C.....  OPEN ORDER.NOD FILE AND READ THE NODAL ORDER IF THE FILE EXIST
      inquire(file='ORDER.NOD',exist=filflg)
      if (filflg) then
       OPEN (1,FILE='ORDER.NOD',FORM='UNFORMATTED',STATUS='OLD')
       READ (1) (INODVAR(I),I=1,NUMNOD)
       CLOSE(1)
       WRITE(*,*) 'NODORDER ='
       WRITE(*,6) (INODVAR(I),I=1,NUMNOD)
      endif
 
C..... GET NV BY ID
      NEQ=0
      DO 20 JNOD=1,NUMNOD
      J=INODVAR(JNOD)
      DO 18 I=1,NODDOF
      IF (NODVAR(I,J).NE.1) GOTO 18
      NEQ = NEQ + 1
      NODVAR(I,J) = NEQ
18    CONTINUE
20    CONTINUE
      DO 30 JNOD=1,NUMNOD
       J=INODVAR(JNOD)
       DO 28 I=1,NODDOF
        IF (NODVAR(I,J).GE.-1) GOTO 28
        N = -NODVAR(I,J)-1
        NODVAR(I,J) = NODVAR(I,N)
28     CONTINUE
30     CONTINUE
 
C.....  OPEN AND WRITE THE NV FILE
      OPEN(8,STATUS='unknown',FILE=' ' ,FORM='UNFORMATTED')
      WRITE(8) ((NODVAR(I,J),I=1,NODDOF),J=1,NUMNOD)
      CLOSE(8)
c        WRITE(*,*) 'NUMNOD =',NUMNOD,'  NODDOF =',NODDOF
c        WRITE(*,6) ((NODVAR(I,J),I=1,NODDOF),J=1,NUMNOD)
 
C.... WRITE THE BOUNDAY CONDITION FILE BFD ACCORDING TO THE DISP0 FILE
C....OPEN DISP0 FILE
      OPEN(1,FILE=' ',FORM='UNFORMATTED',STATUS='OLD')
      READ(1) NUMNOD,NODDOF,((U0(I,J),I=1,NODDOF),J=1,NUMNOD)
      CLOSE(1)
C....OPEN BFD FILE
      OPEN(1,FILE=' ',FORM='UNFORMATTED',STATUS='unknown')
      WRITE(1) ((U0(I,J),I=1,NODDOF),J=1,NUMNOD)
      CLOSE(1)
 
C...... GET THE INITIAL TIME FROM TIME0 FILE
C.......OPEN TIME0 File
      OPEN(1,FILE=' ',FORM='FORMATTED')
      READ(1,*) T0,TMAX,DT
      TIME = T0
      IT = 0
      WRITE(*,*) ' TMAX,DT,TIME,IT =',TMAX,DT,TIME,IT
      CLOSE(1)
C.......OPEN TIME File
      OPEN(1,FILE=' ',FORM='UNFORMATTED',STATUS='unknown')
      WRITE(1) TMAX,DT,TIME,IT
      CLOSE(1)
 
C.......OPEN COOR file
      OPEN (1,FILE=' ',FORM='UNFORMATTED',STATUS='OLD')
      READ (1) NUMNOD,NCOOR,((COOR(I,J),I=1,NCOOR),J=1,NUMNOD)
      CLOSE(1)
c        WRITE(*,*) 'COOR ='
c        WRITE(*,7) ((COOR(I,J),I=1,NCOOR),J=1,NUMNOD)
 
C...... COMPUTE THE INITIAL VALUE BY BOUND.FOR
        zo = 0.0d0
c        DO 321 N=1,NUMNOD
c      DO 100 J=1,NCOOR
c100   R(J) = COOR(J,N)
c      DO 200 J=1,NODDOF
c        U0(J,N) = BOUND(R,zo,J)
c        U1(J,N) = BOUND1(R,zo,J)
c        U2(J,N) = BOUND2(R,zo,J)
c200   CONTINUE
c321   CONTINUE
 
C...... GET THE INITIAL VALUE FROM THE DATA FILES BY PREPROCESSOR
      inquire(file='dispc1',exist=filflg)
      if (filflg) then
      open(16,file='dispc1',form='unformatted',status='old')
      read(16) numnod,noddof,((U0(J,N),J=1,NODDOF),N=1,NUMNOD)
      close(16)
      endif
      inquire(file='dispc2',exist=filflg)
      if (filflg) then
      open(16,file='dispc2',form='unformatted',status='old')
      read(16) numnod,noddof,((U1(J,N),J=1,NODDOF),N=1,NUMNOD)
      close(16)
      endif
      inquire(file='dispc3',exist=filflg)
      if (filflg) then
      open(16,file='dispc3',form='unformatted',status='old')
      read(16) numnod,noddof,((U2(J,N),J=1,NODDOF),N=1,NUMNOD)
      close(16)
      endif
 
c        WRITE(*,*) ' U0 = '
c        WRITE(*,'(6F13.3)') ((U0(J,N),J=1,NODDOF),N=1,NUMNOD)
C     WRITE(*,*) ' U1 = '
C     WRITE(*,'(6F13.3)') ((U1(J,N),J=1,NODDOF),N=1,NUMNOD)
 
C.......OPEN AND WRITE THE INITIAL VALUE FILE UNOD
      OPEN (1,FILE=' ',FORM='UNFORMATTED',STATUS='unknown')
      WRITE(1) ((U0(I,J),J=1,NUMNOD),I=1,NODDOF),
     *  ((U1(I,J),J=1,NUMNOD),I=1,NODDOF),
     *  ((U2(I,J),J=1,NUMNOD),I=1,NODDOF),
     *  ((U0(I,J),J=1,NUMNOD),I=1,NODDOF)
        CLOSE (1)
 
C.... Open IO file
      open(21,file=' ',form='formatted',status='old')
      read(21, '(1a)') material
      read(21,*) numtyp
      close(21)
 
      DO I=1,NEQ
       NUMCOL(I)=0
      ENDDO
C.......OPEN ELEM0 file
      OPEN (3,FILE=' ',FORM='UNFORMATTED',STATUS='OLD')
      JNA = NEQ
      NUMEL=0
      KELEM=0
      KEMATE=0
      DO 2000 ITYP=1,NUMTYP
C.......INPUT ENODE
      READ (3) NUM,NNODE,
     *           ((NODE((I-1)*NNODE+J),J=1,NNODE),I=1,NUM)
CC      WRITE(*,*) 'NUM =',NUM,' NNODE =',NNODE
CC      WRITE(*,*) 'NODE ='
CC      WRITE(*,6) ((NODE((I-1)*NNODE+J),J=1,NNODE),I=1,NUM)
      IF (KELEM.LT.NUM*NNODE) KELEM = NUM*NNODE
      NNE = NNODE
      IF (MATERIAL.EQ.'Y' .OR. MATERIAL.EQ.'y') THEN
       READ (3) MMATE,NMATE
       IF (KEMATE.LT.MMATE*NMATE) KEMATE = MMATE*NMATE
       NNE = NNE-1
      ENDIF
      WRITE(*,*) 'MMATE =',MMATE,' NMATE =',NMATE
CC    WRITE(*,*) 'NUM =',NUM,' NNODE =',NNODE
CC    WRITE(*,*) 'NODE ='
CC    WRITE(*,6) ((NODE((I-1)*NNODE+J),J=1,NNODE),I=1,NUM)
      DO 1000 NE=1,NUM
      L=0
      DO 700 INOD=1,NNE
      NODI=NODE((NE-1)*NNODE+INOD)
      DO 600 IDGF=1,KDGOF
      INV=NODVAR(IDGF,NODI)
      IF (INV.LE.0) GOTO 600
      L=L+1
      LM(L)=INV
600     CONTINUE
700     CONTINUE
      NUMEL=NUMEL+1
c      WRITE (*,*) 'L,LM =',L
c      WRITE (*,'(1X,15I5)') (LM(I),I=1,L)
       IF (L.GT.0) THEN
        CALL  ACLH(NEQ,NUMCOL,NAP,NAJ,L,LM,JNA)
       ENDIF
       IF (JNA.GT.MAXT) THEN
        WRITE(*,*) 'EXCEET ARRAY LENGTH MAXT ....',MAXT,' < ',JNA
        STOP 1111
       ENDIF
1000  CONTINUE
2000  CONTINUE
      CLOSE(3)
      CALL BCLH(NEQ,NAP,NAJ,NUMCOL,NA,LM)
      MAXA=NUMCOL(NEQ+1)
 
C.......OPEN SYS FILE
      OPEN (2,FILE=' ',FORM='UNFORMATTED',STATUS='UNKNOWN')
      WRITE(2) NUMEL,NEQ,NUMTYP,MAXA,KELEM,KEMATE
      CLOSE (2)
 
      OPEN(2,FILE=' ',FORM='UNFORMATTED',STATUS='UNKNOWN')
      WRITE(2) (NUMCOL(I),I=1,NEQ+1)
      WRITE(2) (NA(I),I=1,MAXA)
      CLOSE(2)
 
C        WRITE(*,*) 'NEQ,NUMCOL,NA=',NEQ
C        WRITE(*,6) (NUMCOL(I),I=1,NEQ+1)
C        WRITE(*,6) (NA(I),I=1,MAXA)
 
 
      END
 
      subroutine chms(kdgof,knode,id)
      dimension id(kdgof,knode),ms(1000),is(1000)
      do 1000 k=1,kdgof
      m = 0
      do 800 n=1,knode
      if (id(k,n).le.-1) id(k,n)=-1
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
 
      SUBROUTINE ACLH(NEQ,NUMCOL,NAP,NAJ,ND,LM,JNA)
      IMPLICIT REAL*8 (A-H,O-Z)
      DIMENSION NAP(*),NAJ(*),NUMCOL(*),LM(*)
6     FORMAT(1X,5I15)
C      WRITE (*,*) 'ND= ',ND, (LM(I),I=1,ND)
      DO 400 I=1,ND
      NI = LM(I)
      DO 300 J=1,ND
      NJ = LM(J)
c      IF (NJ.EQ.NI) GOTO 300
      NUMJ = NUMCOL(NI)
      IF (NUMJ.EQ.0) THEN
       JNA = JNA+1
       NAP(NI) = JNA
       NAJ(NI) = NJ
       NUMCOL(NI) = NUMCOL(NI)+1
      ELSE
       JP = NAP(NI)
       JV = NAJ(NI)
       IF (NJ.EQ.JV) GOTO 300
       DO K=1,NUMJ-1
        JV = NAJ(JP)
        JP = NAP(JP)
        IF (NJ.EQ.JV) GOTO 300
       ENDDO
       JNA = JNA+1
       NAP(JP) = JNA
       NAJ(JP) = NJ
       NUMCOL(NI) = NUMCOL(NI)+1
      ENDIF
300   CONTINUE
400   CONTINUE
      RETURN
      END
 
      SUBROUTINE BCLH(NEQ,NAP,NAJ,NUMCOL,NA,LMI)
      IMPLICIT REAL*8 (A-H,O-Z)
      DIMENSION NUMCOL(*),NAP(*),NAJ(*),NA(*),LMI(*)
C        IF(NUMEL.EQ.0) GO TO 1000
      NN = 0
      DO 600 N=1,NEQ
      JP = NAP(N)
      JV = NAJ(N)
      LI = NUMCOL(N)
      DO 500 I=1,LI
      LMI(I) = JV
      JV = NAJ(JP)
      JP = NAP(JP)
500   CONTINUE
      CALL ORDER(LI,LMI)
      DO 550 I=1,LI
      NN = NN+1
550   NA(NN) = LMI(I)
600   CONTINUE
      DO 800 N=1,NEQ-1
800   NUMCOL(N+1) = NUMCOL(N+1)+NUMCOL(N)
      DO 850 N=1,NEQ
850   NUMCOL(NEQ-N+2) = NUMCOL(NEQ-N+1)
      NUMCOL(1) = 0
C       WRITE(*,*) 'NUMCOL ='
C       WRITE(*,6) (NUMCOL(N),N=1,NEQ+1)
C       WRITE(*,*) 'NA ='
C       WRITE(*,6) (NA(I),I=1,NN)
1000    RETURN
6       FORMAT(1X,5I15)
      RETURN
      END
 
      SUBROUTINE ORDER(ND,LM)
      IMPLICIT REAL*8 (A-H,O-Z)
      DIMENSION LM(1)
C       WRITE(*,*) '**** ORDER ****'
C       WRITE(*,*) (LM(I),I=1,ND)
      DO 200 I=1,ND
      LS=LM(I)+1
      DO 100 J=I,ND
      IF (LM(J).GT.LS) GOTO 100
      LS=LM(J)
      J0=J
100     CONTINUE
      LM(J0)=LM(I)
      LM(I)=LS
200     CONTINUE
C       WRITE(*,*) (LM(I),I=1,ND)
C       WRITE(*,*) '-----------------'
      RETURN
      END
 
