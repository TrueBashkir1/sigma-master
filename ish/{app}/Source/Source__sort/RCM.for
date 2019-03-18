C  файл RCM.for
C Содержит подпрограмму RCM
C ============================================================
C Подпрограмма RCM обратного упорядочения Катхилла-Макки. 
C Нумерует связанную  компоненту, заданную MASK и ROOT.
C Вызывается из GENRCM
C Вызывает подпрограмму DEGREE вычисления степени узлов. 
C ============================================================
C ================== начало кода RCM ===========================
C ============================================================
       subroutine RCM (ROOT,XADJ,ADJNCY,MASK,PERM,CCSIZE,DEG,FL)

      INTEGER ADJNCY(1),DEG(1),MASK(1),PERM(1),XADJ(1),
     >CCSIZE,FNBR,ROOT,FL
C ============================================================
   33 CALL DEGREE (ROOT,XADJ,ADJNCY,MASK,DEG,CCSIZE,PERM)
      MASK(ROOT)=0
C
      IF(CCSIZE.LE.1) RETURN
      LVLEND=0
      LNBR=1
  100 LBEGIN=LVLEND+1
      LVLEND=LNBR
        DO 600 I=LBEGIN,LVLEND
        NODE=PERM(I)
        JSTRT=XADJ(NODE)
      JSTOP=XADJ(NODE+1)-1
      FNBR=LNBR+1
      DO 200 J=JSTRT,JSTOP
      NBR=ADJNCY(J)
      IF(MASK(NBR).EQ.0) GO TO 200
      LNBR=LNBR+1
      MASK(NBR)=0
      PERM(LNBR)=NBR
  200 CONTINUE
      IF(FNBR.GE.LNBR) GO TO 600
      K=FNBR
  300 L=K
      K=K+1
      NBR=PERM(K)
  400 IF(L.LT.FNBR) GO TO 500
      LPERM=PERM(L)
      IF(DEG(LPERM).LE.DEG(NBR)) GO TO 500
      PERM(L+1)=LPERM
      L=L-1
      GO TO 400
 500    PERM(L+1)=NBR
      IF(K.LT.LNBR) GO TO 300
 600  CONTINUE
      IF(LNBR.GT.LVLEND) GO TO 100
C ------ OБPAЩEHИE УПOPЯДOЧEHИЯ KATXИЛЛA-MAKKИ -----
      IF (FL.LT.10) THEN
	  
      K=CCSIZE/2
      L=CCSIZE
      DO 700 I=1,K
      LPERM=PERM(L)
      PERM(L)=PERM(I)
      PERM(I)=LPERM
      L=L-1
 700  CONTINUE
 
	  ENDIF
		
C     DEBUG SUBTRACE,INIT
      RETURN
      END
C ============================================================
C ================ конец кода RCM ==============================
C ============================================================
C  конец файла RCM.for




