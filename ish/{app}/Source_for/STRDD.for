C Файл STRSDD.for
C Содержит подпрограмму STRSDD
C ==============================================================
C Подпрограмма предназначена для подсчета значений напряжений в КЭ.
C Вызывается из MAIN       Вызываемых модулей нет.
C     ABTOP MOДИФИKAЦИИ ПЕТРОЧЕНКОВ М.А., 2003
C     ABTOP MOДИФИKAЦИИ ЦВЕТАЕВ Б.М., 2004
C ==============================================================
C ================= начало кода STRSDD ===========================

      subroutine STRSDD(NFL,NP,NE,NCN,NDF,DD,NOP,DIS,FORCE,IPR,BBBB)

      LOGICAL*1 IPR(1)
      DIMENSION FORCE(7,700),NOP(1),BBBB(3,6)
      DIMENSION DIS(2,450),R2(9)
      REWIND NFL
      M9=0
      PMAX=0
      DO 200 N=1,NE
      READ(NFL,*) N,((BBBB(I,J),J=1,6),I=1,3)
 60   FORMAT(2I3)
      DO 260 I=1,NCN
      M=NOP(NCN*(N-1)+I)
      IF(M.EQ.0)GO TO 260
      K=(I-1)*NDF
      DO 240 J=1,NDF
      IJ=J+K
 240  R2(IJ)=DIS(J,M)
 260  CONTINUE
      DO 321 I=1,3
      FORCE(I,N)=0.
      DO 300 J=1,6
 300  FORCE(I,N)=FORCE(I,N)+BBBB(I,J)*R2(J)
 321  CONTINUE
 200  CONTINUE
       IF(IPR(32))WRITE(6,101)
      L=0
      DO 600 N=1,NE
      AF=SQRT(((FORCE(2,N)-FORCE(1,N))/2)**2+FORCE(3,N)**2)
  50  C=(FORCE(1,N)+FORCE(2,N))/2
      FORCE(4,N)=C+AF
      FORCE(5,N)=C-AF
      FORCE(6,N)=(1/SQRT(2.0))*SQRT( (FORCE(1,N)-FORCE(2,N))**2+ 
     * (FORCE(1,N))**2 + (FORCE(2,N))**2 + 6*(FORCE(3,N))**2 )

      IF(FORCE(1,N).EQ.FORCE(2,N)) GO TO 700
      FORCE(7,N)=57.29578*ATAN(2*FORCE(3,N)/(FORCE(1,N)-FORCE(2,N)))
      GO TO 210
 700  FORCE(7,N)=90.
 210  CONTINUE
       
 400  IF(IPR(32))  WRITE(6,111) N,(FORCE(I,N),I=1,7)
 600   CONTINUE
 101   FORMAT(2X,'№_КЭ',3X,'X-HAПP',6X,'Y-HAПP',
     * 4X,'KACAT-HAПP',5X,'1-ОЕ_ГЛ.',3X,'2-ОЕ_ГЛ.',3X,
     * 'ЭКВ-НАПР',5X,'УГOЛ')
 111   FORMAT(I4,6F12.2,F10.3)
C      FORMAT(I4,5F12.2,F10.3)
       RETURN
       END

C ============== конец кода STRSDD ==================================
C конец файла STRSDD.for