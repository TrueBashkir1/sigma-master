C  файл ROOTLS.for   
C Содержит подпрограмму ROOTLS
C ===============================================================
C Подпрограмма генерации структуры уровней с корнем в узле,
C задаваемым входным параметром ROOT. Учитываются только узлы,
C которым соответствуют ненулевые значения MASK.
C Вызывается из FNROOT.  Вызываемых модулей нет.
C ===============================================================
C ================ начало кода ROOTLS =============================
C ===============================================================
      subroutine ROOTLS(ROOT,XADJ,ADJNCY,MASK,NLVL,XLS,LS)

      INTEGER ADJNCY(1),XADJ(1),LS(1),MASK(1),XLS(1)
     *,I,J,JSTOP,JSTRT,CCSIZE,ROOT
      MASK(ROOT)=0
      LS(1)=ROOT
      NLVL=0
      LVLEND=0
      CCSIZE=1
  200 LBEGIN=LVLEND+1
      LVLEND=CCSIZE
      NLVL=NLVL+1
      XLS(NLVL)=LBEGIN
      DO 400 I=LBEGIN,LVLEND
      NODE=LS(I)
      JSTRT=XADJ(NODE)
      JSTOP=XADJ(NODE+1)-1
      IF(JSTOP.LT.JSTRT)GOTO 400
      DO 300 J=JSTRT,JSTOP
      NBR=ADJNCY(J)
      IF(MASK(NBR).EQ.0) GO TO 300
      CCSIZE=CCSIZE+1
      LS(CCSIZE)=NBR
      MASK(NBR)=0
  300 CONTINUE
  400 CONTINUE
      LVSIZE=CCSIZE-LVLEND
      IF(LVSIZE.GT.0) GO TO 200
      XLS(NLVL+1)=LVLEND+1
      DO 500 I=1,CCSIZE
      NODE=LS(I)
      MASK(NODE)=1
  500 CONTINUE
      RETURN
C     DEBUG SUBCHK,SUBTRACE,INIT(I,NODE,JSTRT,NBR)
      END
C ==============================================================
C ================== конец кода ROOTLS ===========================
C ==============================================================
C конец  файла ROOTLS.for   




