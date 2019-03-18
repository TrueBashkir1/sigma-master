C Файл ESFCT.for
C Содержит подпрограмму ESFCT 
C ================================================================
C Решение системы алгебраических уравнений
C ПOДПPOГPAMMA ESFCT - CИMMETPИЧHOE PAЗЛOЖEHИE ПPOФИЛЬHЫM METOДOM 
C  Вызывается из  RCMSLV   Вызывает ELSLV.
C ================================================================
C ================== начало кода ESFCT  =============================
C ================================================================
      subroutine ESFCT (NEQNS,XENV,ENV,DIAG,IFLAG)

      REAL*8 COUNT,OPS
      COMMON /SPKOPS/ OPS
      REAL DIAG(1),ENV(1)
      INTEGER XENV(1)
       IFLAG=0
       II=-1
      IF(DIAG(1).LE.0.E0) GO TO 400
      DIAG(1)=SQRT(DIAG(1))
      IF(NEQNS.EQ.1) RETURN
      DO 300 I=2,NEQNS
       II=I
      IXENV=XENV(I)
      IBAND=XENV(I+1)-IXENV
      TEMP=DIAG(I)
      IF(IBAND.EQ.0) GO TO 200
      IFIRST=I-IBAND
C ================================================================
      CALL ELSLV (IBAND,XENV(IFIRST),ENV,DIAG(IFIRST),ENV( IXENV))
      JSTOP=XENV(I+1)-1
      DO 100 J=IXENV,JSTOP
      S=ENV(J)
      TEMP=TEMP-S*S
  100  CONTINUE
  200  IF(TEMP.LE.0.E0) GO TO 400
      DIAG(I)=SQRT(TEMP)
                    COUNT=IBAND
                    OPS=OPS+COUNT
 300  CONTINUE
      RETURN
 400   IFLAG=II
      RETURN
C       DEBUG UNIT(9),INIT(II),SUBTRACE
      END
C ================================================================
C ================== конец кода ESFCT   =============================
C ================================================================
C конец файла ESFCT.for
