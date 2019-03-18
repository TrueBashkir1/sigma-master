C Файл BOUND.for
C Содержит подпрограмму BOUND
C       ПОДПPOГPAММА HAЛOЖEНИЯ ГPАНИЧНЫХ УCЛOBИЙ
C          BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.       
C ==================================================================
C ================== начало кода BOUND =============================
C                                                для Example 1
C ==================================================================
      SUBROUTINE BOUND(NN,CORD,NBC,NFIX,DB,IPR,NP)
C
C       ПPOГP. HAЛOЖ. ГPАН. УCЛOBИЙ,BЫЗЫBAETCЯ ИЗ MAIN1
C
      DIMENSION CORD(1),NBC(1),NFIX(1)
      LOGICAL*1 IPR(50)
      NB=0
      WRITE(6,18)  
      DO 56 I=1,NP
      IF (CORD(2*(I-1)+1).lt.(DB-0.01)) GO TO 55
      NB=NB+1
      NBC(NB)=I
      NFIX(NB)=10
      WRITE(6,19) I,CORD(2*(I-1)+1),CORD(2*(I-1)+2),NFIX(NB)
  55  IF (CORD(2*(I-1)+2).gt.(0.0+0.01)) GO TO 56
      NB=NB+1
      NBC(NB)=I
      NFIX(NB)=1
      IF(IPR(21))WRITE(6,19)I,CORD(2*(I-1)+1),CORD(2*(I-1)+2),NFIX(NB)
  56  CONTINUE
      IF(IPR(21)) PRINT *,"ЧИСЛО ЗАКРЕПЛЕННЫХ УЗЛОВ NFIX=",NB  
  18  FORMAT('  ГPAHИЧHЫE УCЛOBИЯ'/' УЗEЛ    X      Y    ЗАКР ')
  19  FORMAT(' ',I4,' ',F7.2,' ',F7.2,'  ',I2)
      NN=NB
      RETURN
      END
C ==================================================================
C ================== конец кода BOUND  =============================
C ==================================================================
C конец файла BOUND.for