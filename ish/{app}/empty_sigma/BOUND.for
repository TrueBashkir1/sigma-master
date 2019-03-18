C Панфилов А.А., 06-421
C ==================================================================
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
      REAL XI,YI
      NB=0
      WRITE(6,18)  
      DO I=1,NP !Цикл обхода узлов
      XI = CORD(2*(I-1)+1)
      YI = CORD(2*(I-1)+2)
      !Если точка принадлежит окружности:
      IF (ABS(10.0-SQRT(XI**2+YI**2)).LT.0.01) THEN
      NB=NB+1
      NBC(NB)=I
      NFIX(NB)=11  !закрепление по X и Y
      WRITE(6,19) I,CORD(2*(I-1)+1),CORD(2*(I-1)+2),NFIX(NB)
      !Если точка лежит на оси Y
      ELSE IF (XI.LT.0.01) THEN
      NB = NB+1
      NBC(NB)=I
      NFIX(NB)=10  !Закрепление по X
      WRITE(6,19) I,CORD(2*(I-1)+1),CORD(2*(I-1)+2),NFIX(NB)
      !Если точка лежит на оси X
      ELSE IF (YI.LT.0.01) THEN
      NB = NB+1
      NBC(NB)=I
      NFIX(NB)=1 !Закрепление по Y
      WRITE(6,19) I,CORD(2*(I-1)+1),CORD(2*(I-1)+2),NFIX(NB)
      ENDIF
      ENDDO
      
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