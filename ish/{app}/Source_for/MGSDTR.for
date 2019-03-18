C Файл MGSDTR.for
C Содержит подпрограмму MGSDTR
C ================================================================
C  Подпрограмма формирования матрицы жесткости конечного элемента.
C Вызывается из FORMDD   Вызываемых модулей нет.
C ================================================================
C ================== начало кода MGSDTR ===========================
C ================================================================
        subroutine MGSDTR(N,NFL,NOP,CORD,ORT,IMAT,ESTIFM,B)

      DIMENSION NOP(1),CORD(1),ORT(1),B(3,6),
     >ESTIFM(18,18),A(3,6),IMAT(1)
       LOGICAL*1 IPR(1)
C      IF(IPR(20))WRITE (6,103) ((NOP(3*(I-1)+J),J=1,3),I=1,128)
C103   FORMAT (' NOP ВНУТРИ MGSDTR',/,3(' *N',I3,'(',3I4,')'))
      OPEN(NFL,FILE='FORT.3') 
      I=NOP(3*(N-1)+1)
      J=NOP(3*(N-1)+2)
      K=NOP(3*(N-1)+3)
c      WRITE (6,102) N,I,J,K
      L=IMAT(N)
      AJ=CORD(2*(J-1)+1)-CORD(2*(I-1)+1)
      AK=CORD(2*(K-1)+1)-CORD(2*(I-1)+1)
      CJ=CORD(2*(J-1)+2)-CORD(2*(I-1)+2)
      CK=CORD(2*(K-1)+2)-CORD(2*(I-1)+2)
      BJ=0.0
      BK=0.0
      AREA=SQRT((BJ*CK-BK*CJ)**2+(AK*CJ-AJ*CK)**2+(AJ*BK-AK*BJ)**2)/2
C      WRITE (6,101) AK,CJ,CK AREA
      IF(AREA.LE.0.) GO TO 220
      A(1,1)=CJ-CK
      A(1,2)=0.
      A(1,3)=CK
      A(1,4)=0.
      A(1,5)=-CJ
      A(1,6)=0.
      A(2,1)=0.
      A(2,2)=AK-AJ
      A(2,3)=0.
      A(2,4)=-AK
      A(2,5)=0.
      A(2,6)=AJ
      A(3,1)=AK-AJ
      A(3,3)=-AK
      A(3,2)=CJ-CK
      A(3,4)=CK
      A(3,5)=AJ
      A(3,6)=-CJ
      COMM=ORT(7*(L-1)+1)/((1.+ORT(7*(L-1)+2))*(1.-ORT(7*(L-1)+2)*2)
     > *AREA)
      ESTIFM(1,1)=COMM*(1.-ORT(7*(L-1)+2))
      ESTIFM(1,2)=COMM*ORT(7*(L-1)+2)
      ESTIFM(1,3)=0.
      ESTIFM(2,1)=ESTIFM(1,2)
      ESTIFM(2,2)=ESTIFM(1,1)
      ESTIFM(2,3)=0.
      ESTIFM(3,1)=0.
      ESTIFM(3,2)=0.
      ESTIFM(3,3)=ORT(7*(L-1)+1)/(2*(1.+ORT(7*(L-1)+2))*AREA)
      DO 205 I=1,3
      DO 205 J=1,6
      B(I,J)=0.
      DO 205 K=1,3
  205 B(I,J)=B(I,J)+ESTIFM(I,K)/2.*A(K,J)
      IF(NFL.NE.0) WRITE(NFL,*) N,((B(I,J),J=1,6),I=1,3)
      DO 210 I=1,6
      DO 210 J=1,6
      ESTIFM(I,J)=0.
      DO 210 K=1,3
  210 ESTIFM(I,J)=ESTIFM(I,J)+B(K,I)/2.*A(K,J)
      DO 212 I=1,6
      DO 212 J=1,6
  212 ESTIFM(I,J)=ESTIFM(I,J)*ORT(7*(L-1)+7)
      RETURN
  220 WRITE (6,101) AK,CJ,CK,AREA
      WRITE(6,100) N
  100 FORMAT(5X,'HУЛEBAЯ ИЛИ OTPИЦATEЛЬHAЯ ПЛOЩAДЬ ЭЛEMEHTA'/
     *10X,'BЫПOЛHEHИE OГPAHИЧEHИЯ',I10)
  101 FORMAT (3X,4F8.3)    
  102 FORMAT (3X,4I7)
      STOP
C     DEBUG UNIT(9),INIT,SUBTRACE
      END
C ================================================================
C ===================== конец кода MGSDTR =========================
C ================================================================
C конец файла MGSDTR.for
