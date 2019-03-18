C Файл STSM.for
C Содержит подпрограмму STSM
C ===================================================================
C  ПOДПPOГPAMMA ФOPMИPOBAHИЯ CTPУKTУPЫ CMEЖHOCTИ ИЗ MACCИBA CBЯЗИ NOP
C    Вызывается из RENMDD  Вызываемых модулей нет.
C ===================================================================
C =============== начало кода STSM =====================================
C ===================================================================
      subroutine STSM(NP,NE,NCN,NOP,XADJ,ADJNCY)

      INTEGER XADJ(1),ADJNCY(1),NST(40),NOP(NCN,NE)
C     OБЩИЙ ЦИKЛ ПO УЗЛAM
      DO 10 I=1,NP
      L=1
C    ПPOCMOTP ЭЛEMEHTOB HA HAЛИЧИE I-TOГO УЗЛA
      DO 12 J=1,NE
      DO 11 K=1,NCN
      IF(NOP(K,J).NE.I) GO TO 11
C    BЫБOP COCEДEЙ I-TOГO УЗЛA B NST HEУПOPЯДOЧEHHЫЙ
      DO 13 M=1,NCN
      IF(M.EQ.K) GO TO 14
      NST(L)=NOP(M,J)
      L=L+1
   14 CONTINUE
   13 CONTINUE
      GO TO 12
   11 CONTINUE
   12 CONTINUE
      LL=L-1
      LR=0
      LM=L-1
      DO 20 J=1,LL
      LB=J+1
      LE=L-LR-1
      NMIN=NST(J)
      KMIN=J
      IF(LE.LT.LB) GO TO 22
      DO 21 K=LB,LE
   25 IF(NMIN-NST(K)) 21,23,24
   24 NMIN=NST(K)
      KMIN=K
      GO TO 21
   23 IF(K.GT.(LM-LR)) GO TO 21
      NST(K)=NST(LM-LR)
      LR=LR+1
      GO TO 25
   21 CONTINUE
      NST(KMIN)=NST(J)
      NST(J)=NMIN
   22 CONTINUE
   20 CONTINUE
C     ЗAПOЛHEHИE CTPУKTУPЫ CMEЖHOCTИ
      JB=XADJ(I)
      LX=L-LR-1
      XADJ(I+1)=XADJ(I)+LX
      DO 26 J=1,LX
   26 ADJNCY(J+JB-1)=NST(J)
   10 CONTINUE
      RETURN
C     DEBUG INIT(NST)
      END
C ===================================================================
C ================== конец кода STSM ==================================
C ===================================================================
C конец файла STSM.for