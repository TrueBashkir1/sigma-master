C Файл BOUND
C Содержит подпрограмму BOUND
C       ПОДПPOГPAММА HAЛOЖEНИЯ ГPАНИЧНЫХ УCЛOBИЙ
C          BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.       
C ==================================================================
C wwwwwwwwwwwwwwwwww начало кода BOUND wwwwwwwwwwwwwwwwwwwwwwwwwwwww
C                                                для Example 2
C Закрепляются от перемещений вдоль оси Y  все узлы c координатой Y=0.
C Закрепляются от перемещений вдоль оси X  все узлы c координатой Х=0.
C ==================================================================
      SUBROUTINE BOUND(NN,CORD,NBC,NFIX,DB,IPR,NP)
C
C       ПPOГPММA HAЛOЖEНИЯ ГPЧH УCЛOBИЙ,BЫЗЫBAETCЯ ИЗ MAIN1
C
      DIMENSION CORD(1),NBC(1),NFIX(1)

      LOGICAL*1 IPR(50)
* IPR массив управления печатью      
      NB=0
* NB количество узлов имеющих закрепления      
      WRITE(6,18)  
      DO 56 I=1,NP
* NP - количество узлов
* Координаты точки которая обрабатывается в данный момент
      X1=CORD(2*(I-1)+1)
      Y1=CORD(2*(I-1)+2)
      IF (ABS(X1-0).LT.0.01) THEN
        NB=NB+1
          NFIX(NB)=10
          NBC(NB)=I
          WRITE(6,19) I,CORD(2*(I-1)+1),CORD(2*(I-1)+2),NFIX(NB)
      ENDIF
      IF (ABS(Y1-0).LT.0.01) THEN
          NB=NB+1
          NFIX(NB)=1
          NBC(NB)=I
          WRITE(6,19) I,CORD(2*(I-1)+1),CORD(2*(I-1)+2),NFIX(NB)    
      ENDIF       
  56  CONTINUE
  18  FORMAT('  ГPAHИЧHЫE УCЛOBИЯ'/' УЗEЛ    X      Y    ЗАКР ')
  19  FORMAT(' ',I4,' ',F7.2,' ',F7.2,'  ',I2)
      NN=NB
      RETURN
      END
C ==================================================================
C wwwwwwwwwwwwwwwwww конец кода BOUND  wwwwwwwwwwwwwwwwwwwwwwwwwwwww
C ==================================================================


