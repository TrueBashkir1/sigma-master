C Файл FNROOT.for
C Содержит подпрограмму FNROOT
C ============================================================
C Подпрограмма поиска псевдопереферийного узла. Реализует
C модифицированный вариант схемы Гиббса, Пулла и Стокмейера.
C    Вызывается из  GENRCM.   Вызывает  ROOTLS
C ============================================================
C ============== начало кода FNROOT ============================
C ============================================================
      subroutine FNROOT(ROOT,XADJ,ADJNCY,MASK,NLVL,XLS,LS)

      INTEGER ADJNCY(1),LS(1),MASK(1),XLS(1),XADJ(1)
      INTEGER ROOT,CCSIZE
      CALL ROOTLS(ROOT,XADJ,ADJNCY,MASK,NLVL,XLS,LS)
      CCSIZE=XLS(NLVL+1)-1
      IF(NLVL.EQ.1.OR.NLVL.EQ.CCSIZE) RETURN
  100 JSTRT=XLS(NLVL)
      MINDEG=CCSIZE
      ROOT=LS(JSTRT)
      IF(CCSIZE.EQ.JSTRT) GO TO 400
      DO 300 J=JSTRT,CCSIZE
      NODE=LS(J)
      NDEG=0
      KSTRT=XADJ(NODE)
      KSTOP=XADJ(NODE+1)-1
      DO 200 K=KSTRT,KSTOP
      NABOR=ADJNCY(K)
      IF(MASK(NABOR).GT.0) NDEG=NDEG+1
  200 CONTINUE
         IF(NDEG.GE.MINDEG) GO TO 300
         ROOT=NODE
         MINDEG=NDEG
  300 CONTINUE
  400 CALL ROOTLS(ROOT,XADJ,ADJNCY,MASK,NUNLVL,XLS,LS)
      IF(NUNLVL.LE.NLVL)RETURN
      NLVL=NUNLVL
      IF(NLVL.LT.CCSIZE) GO TO 100
      RETURN
C     DEBUG SUBTRACE,SUBCHK
            END
C ============================================================
C ================= конец кода FNROOT ==========================
C ============================================================
C конец файла FNROOT.for