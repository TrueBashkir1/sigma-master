C Файл BOUND
C Содержит подпрограмму BOUND
C       ПОДПPOГPAММА ЗАДАНИЯ ГPАНИЧНЫХ УCЛOBИЙ
C          BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.    
C ==================================================================
C wwwwwwwwwwwwwwwwww начало кода BOUND wwwwwwwwwwwwwwwwwwwwwwwwwwwww
C                                                   для Example 3
C Закрепляются от перемещений по осям Х и Y все узлы c координатой X=0.
C ==================================================================
      SUBROUTINE BOUND(NN,CORD,NBC,NFIX,DB,IPR,NP)
      DIMENSION CORD(1),NBC(1),NFIX(1)
    
      LOGICAL*1 IPR(50)
* IPR массив управления печатью      
      NB=0
* NB количество узлов имеющих закрепления      
      IF(IPR(21))WRITE(6,18)  
      DO 56 I=1,NP
* NP - количество узлов
* Координаты точки которая обрабатывается в данный момент
      X1=CORD(2*(I-1)+1)
      Y1=CORD(2*(I-1)+2)
* если данная точка лежит на вертикалной оси системы координат, 
* то отбираем ее для закрепления
      IF (ABS(X1-0).LT.0.01) THEN
          NB=NB+1
* закрепим найденую точку по оси Х  и по оси Y
          NFIX(NB)=11
          NBC(NB)=I
      IF(IPR(21))WRITE(6,19)I,CORD(2*(I-1)+1),CORD(2*(I-1)+2),NFIX(NB)
      ENDIF
  56  CONTINUE
      IF(IPR(21)) PRINT *,"ЧИСЛО ЗАКРЕПЛЕННЫХ УЗЛОВ NFIX=",NB
  18  FORMAT('  ГPAHИЧHЫE УCЛOBИЯ'/' УЗEЛ    X      Y    ЗАКР ')
  19  FORMAT(' ',I4,' ',F7.2,' ',F7.2,'  ',I2)
      NN=NB
      RETURN
      END
C ==================================================================
C wwwwwwwwwwwwwwwwww конец кода BOUND  wwwwwwwwwwwwwwwwwwwwwwwwwwwww
C ==================================================================
C Конец файла BOUND



