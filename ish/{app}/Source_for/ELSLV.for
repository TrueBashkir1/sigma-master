C Файл ELSLV.for
C Содержит подпрограмму ELSLV
C =====================================================
C Программа ELSLV решения нижней треугольной матрицы
C  Вызывается из ESFCT. Вызываемых модулей нет.
C =====================================================
C =============== начало кода ELSLV  =====================
C ===================================================== 
      subroutine  ELSLV (NEQNS,XENV,ENV,DIAG,RHS)

      REAL*8 CONT,OPS
      COMMON /SPKOPS / OPS
      INTEGER XENV(1)
      REAL  DIAG(1),ENV(1),RHS(1)
      IFIRST=0
  100 IFIRST=IFIRST+1
      IF(RHS(IFIRST).NE.0.E0) GO TO 200
      IF(IFIRST.LT.NEQNS) GO TO 100
      RETURN
  200  LAST=0
      DO 500 I=IFIRST,NEQNS
      IBAND=XENV(I+1)-XENV(I)
      IF(IBAND.GE.I) IBAND=I-1
      S=RHS(I)
      L=I-IBAND
      RHS(I)=0.E0
      IF(IBAND.EQ.0 .OR. LAST.LT.L) GO TO 400
      KSTRT=XENV(I+1)-IBAND
      KSTOP=XENV(I+1)-1
      DO 300 K=KSTRT,KSTOP
      S=S-ENV(K)*RHS(L)
      L=L+1
  300  CONTINUE
      COUNT=IBAND
      OPS=OPS+COUNT
  400  IF(S.EQ.0.E0) GO TO 500
      RHS(I)=S/DIAG(I)
      OPS=OPS+1.D0
      LAST=I
  500  CONTINUE
      RETURN
C     DEBUG UNIT(9),SUBTRACE
      END
C =====================================================
C ============ конец кода ELSLV   ========================
C =====================================================
C конец файла ELSLV.for
