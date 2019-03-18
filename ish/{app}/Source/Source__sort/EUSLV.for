C Файл EUSLV.for
C Содержит подпрограмму EUSLV
C ==============================================================
C Решение системы алгебраических уравнений
C    ПOДПPOГPAMMA EUSLV - PEШEHИE BEPXHEЙ TPEУГOЛЬHOЙ MATPИЦЫ 
C  Вызывается из  RCMSLV  Вызываемых модулей нет.
C ==============================================================
C =================== начало кода EUSLV  ==========================
C ==============================================================
      subroutine EUSLV ( NEQNS,XENV,ENV,DIAG,RHS )

      REAL*8 COUNT,OPS
      COMMON /SPKOPS / OPS
      REAL DIAG(1),ENV(1), RHS(1)
      INTEGER XENV(1)
      I=NEQNS+1
  100  I=I-1
      IF(I.EQ.0) GO TO 300
      IF(RHS(I).EQ.0.E0) GO TO 100
      S=RHS(I)/DIAG(I)
      RHS(I)=S
      OPS=OPS+1.D0
      IBAND=XENV(I+1)-XENV(I)
      IF(IBAND.GE.I) IBAND=I-1
      IF(IBAND.EQ.0) GO TO 100
      KSTRT=I-IBAND
      KSTOP=I-1
      L=XENV(I+1) - IBAND
      DO 200 K=KSTRT,KSTOP
      RHS(K)=RHS(K)-S*ENV(L)
      L=L+1
  200  CONTINUE
      COUNT=IBAND
      OPS=OPS+COUNT
      GO TO 100
 300  RETURN
C     DEBUG UNIT(9),SUBTRACE
      END
C ==============================================================
C ======================= конец кода EUSLV =======================
C ==============================================================
C конец файла EUSLV.for

