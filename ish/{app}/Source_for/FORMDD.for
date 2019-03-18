C Файл FORMDD. for
C Содержит подпрограмму FORMDD 
C ===================================================================
C   Подпрограмма формирования матрицы жесткости для  
C          профильного метода решения.
C     BЫЗЫBAETCЯ ИЗ MAIN, вызывает MGSDTR .
C ===================================================================
C =================== начало кода FORMDD ============================= 
C =================================================================
      subroutine FORMDD (NP,NE,NCN,NDF,NB,NMAT,BAND,NOP,CORD,ORT,
     >                   IMAT,NBC,NFIX,XENV,DIAG,ENV,BB,IPR)

      DIMENSION CORD(1),NOP(1),ORT(1),IMAT(1),XENV(1),ENV(1),DIAG(1),
     >           NBC(1),NFIX(1),ESTIFM(18,18),BB(3,6)
      INTEGER XENV
      LOGICAL*1 IPR(1)
      DATA NFL/3/
      NSZF=NP*NDF
      J=XENV(NSZF+1)-1
C      WRITE (6,102) NCN
C 102  FORMAT (2X,'NCN=',I5)
C        OБHУЛEHИE MACCИBOB M.Ж.K.
      DO 10 I=1,J
  10  ENV(I)=0.0
       DO 11 I=1,NSZF
  11   DIAG(I)=0.0
C =================================================================
c Начало реализации свойств КЭ в Formdd (способ 2 реализации свойств)
C =================================================================
        CALL PROPERTYFORMDD (NE,NCN,NMAT,CORD,IMAT,NOP)
C =================================================================
C        DO 300 I=1,NE
C         J=(I-1)*NCN
C         DO 400 JJ=1,3
C       IF (NMAT.ge.2.and.(40.0-CORD((NOP(J+JJ)-1)*2+2)).gt.0.01) THEN
C           IMAT(I)=2
C           ENDIF
C 400    CONTINUE
C 300    CONTINUE
C =================================================================
c      Конец  реализации свойств КЭ    
C =================================================================
      IF(IPR(20))WRITE (6,101)(I,(NOP(NCN*(I-1)+J),J=1,NCN),I=1,NE)
101   FORMAT (' NOP в FORMDD ПЕРЕД ВХОДОМ В MGSDTR',
     >/,3(' *N',I3,'(',3I4,')'))
C       ГЛABHЫЙ ЦИKЛ ПO ЭЛEMEHTAM      
      DO 100 N=1,NE
c      WRITE (6,*) CORD(3),CORD(4)
c      WRITE (6,*) CORD(9),CORD(10)
c      WRITE (6,*) CORD(5),CORD(6)
C =================================================================
      CALL MGSDTR (N,NFL,NOP,CORD,ORT,IMAT,ESTIFM,BB)
       DO 2 I=1,NCN
       NCOLB=(NOP(NCN*(N-1)+I)-1)*NDF
        DO 3 J=1,NDF
        NCOL=NCOLB+J
        IENV=XENV(NCOL+1)-NCOL
        IE=(I-1)*NDF+J
         DO 4 K=1,NCN
         NROWB=(NOP(NCN*(N-1)+K)-1)*NDF
         IF(NROWB.GT.NCOLB) GO TO 4
         KSTRT=NROWB+1
         KSTOP=NROWB+NDF
         IF(KSTOP.GT.NCOL) KSTOP=NCOL
         JE=(K-1)*NDF-KSTRT+1
          DO 5 L=KSTRT,KSTOP
          IF(NCOL.NE.L) GO TO 6
          DIAG(NCOL)=DIAG(NCOL)+ESTIFM(IE,JE+L)
          GO TO 5
  6       IEN =IENV+L
      IF ( IEN  .LT. XENV(NCOL)) GO TO 500
          ENV(IEN )=ENV(IEN )+ESTIFM(IE,JE+L)
  5       CONTINUE
  4      CONTINUE
  3     CONTINUE
  2    CONTINUE
 100  CONTINUE
C
C  УЧET ГPAHИЧHЫX УCЛOBИЙ
C
      DO 200 N=1,NB
      NX=10**(NDF-1)
      II=NBC(N)
      NROWB=(II-1)*NDF
       DO 7 M=1,NDF
       NROWB=NROWB+1
       ICON=NFIX(N)/NX
       IF(ICON)  9,9,8
  8    DIAG(NROWB)=1.0
       KSTRT=XENV(NROWB)
       KSTOP=XENV(NROWB+1)-1
        IF(KSTOP.LT.KSTRT)GO TO 15
        DO 12 J=KSTRT,KSTOP
  12    ENV(J)=0.0
  15   NR=NROWB+1
       NRE=NR+BAND
        DO 13 J=NR,NSZF
        K=XENV(J+1)-J+NROWB
        IF(K .LT. XENV(J)) GO TO 13
        ENV(K)=0.0
  13    CONTINUE
       NFIX(N)=NFIX(N)-NX*ICON
   9   NX=NX/10
   7   CONTINUE
 200  CONTINUE
      RETURN
 500  WRITE(6,600) N
 600  FORMAT('  +++ ЭЛEMEHTУ',I6,' HET MECTA B CTPУKTУPE ENV +++++')
      STOP
C      DEBUG UNIT(9),INIT(  II  ),SUBTRACE
      END
C ================================================================
C ================== конец кода FORMDD ============================
C ================================================================
C
C конец файла FORMDD.for