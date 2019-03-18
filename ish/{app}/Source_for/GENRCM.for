C Файл GENRCM.for
C Содержит подпрограмму GENRCM
C =================================================================
C   OПPEДEЛEHИE BEKTOPOB ПEPECTAHOBKИ                             
C    PERM(INEW)=IOLD                                               
C    INVP(IOLD)=INEW                                             
C    INVP(PERM(INEW))=INEW 
C Вызывается из   RENMDD   Вызывает модули FNROOT,RCM          
C =================================================================
C =============== начало кода GENRCM ==============================
C =================================================================
      subroutine GENRCM( NEQNS,XADJ,ADJNCY,PERM,MASK,XLS,FL)

      INTEGER ADJNCY(1),MASK(1),PERM(1),XLS(1),XADJ(1),CCSIZE,ROOT,FL
      DO 100 I=1,NEQNS
      MASK(I)=1
  100  CONTINUE
       NUM=1
       DO 200 I=1,NEQNS
         IF(MASK(I).EQ.0) GO TO 200
       ROOT= I
       CALL FNROOT ( ROOT,XADJ,ADJNCY,MASK,NLVL,XLS,PERM(NUM))
       CALL RCM ( ROOT,XADJ,ADJNCY,MASK,PERM(NUM),CCSIZE,XLS,FL)
       NUM=NUM+CCSIZE
       IF(NUM.GT.NEQNS) RETURN
  200  CONTINUE
      RETURN
      END
C =================================================================
C =================== конец кода GENRCM ============================
C =================================================================
C конец файла GENRCM.for