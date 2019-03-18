C Файл DEGREE.for
C Содержит подпрограмму DEGREE
C ==================================================================
C Подпрограмма вычисляет степени узлов в связанной компоненте, 
C задаваемой MASK и ROOT. Узлы, для которых MASK(I)=0, игнорируются.
C          Вызывается из RCM. BЫЗЫBAEMЫX MOДУЛEЙ HET.
C ==================================================================
C ================ начало кода DEGREE ===============================
C ==================================================================                 
      subroutine DEGREE(ROOT,XADJ,ADJNCY,MASK,DEG,CCSIZE,LS)

      INTEGER ADJNCY(1),DEG(1),LS(1),MASK(1),XADJ(1),CCSIZE,ROOT
      LS(1)=ROOT
      XADJ(ROOT)=-XADJ(ROOT)
      LVLEND=0
      CCSIZE=1
  100 LBEGIN=LVLEND+1
      LVLEND=CCSIZE
      DO 400 I=LBEGIN,LVLEND
      NODE=LS(I)
      JSTRT=-XADJ(NODE)
      JSTOP=IABS(XADJ(NODE+1))-1
      IDEG=0
      IF(JSTOP.LT.JSTRT) GO TO 300
      DO 200 J=JSTRT,JSTOP
      NBR=ADJNCY(J)
      IF(MASK(NBR).EQ.0)GO TO 200
      IDEG=IDEG+1
      IF(XADJ(NBR).LT.0) GO TO 200
      XADJ(NBR)=-XADJ(NBR)
      CCSIZE=CCSIZE+1
      LS(CCSIZE)=NBR
  200 CONTINUE
  300 DEG(NODE)=IDEG
  400 CONTINUE
      LVSIZE=CCSIZE-LVLEND
      IF(LVSIZE.GT.0) GO TO 100
      DO 500 I=1,CCSIZE
      NODE=LS(I)
      XADJ(NODE)=-XADJ(NODE)
  500 CONTINUE
      RETURN
C     DEBUG SUBTRACE,SUBCHK,INIT
      END
C =================================================================
C ================== конец кода DEGREE =============================
C =================================================================
C конец файла DEGREE.for