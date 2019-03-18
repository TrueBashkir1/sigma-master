C Файл RCMSLV.for
C Содержит подпрограмму RCMSLV
C =================================================================
C ПОДПPOГPAMMA PEШEHИЯ CИCTEMЫ УPABHEHИЙ ПPOФИЛЬHЫM METOДOM
C Вызывается из MAIN. Вызываемые подпрограммы ESFCT, ELSLV, EUSLV 
C =================================================================
C ================== начало кода RCMSLV ============================
C =================================================================
       subroutine RCMSLV (N,XENV,ENV,DIAG,R,IERR,IPR)

       DIMENSION XENV(1),ENV(1),DIAG(1),R(1)
       INTEGER XENV,IERR
       LOGICAL*1 IPR(50)
       REAL*8 OPS
       COMMON /SPKOPS/ OPS
       OPS=0.D0
       IF(IPR(26))WRITE(6,951)
951    FORMAT(/,10X,'*****Start  ESFCT in RCMSLV',/,
     > 10X,'(разложение матрицы профильным методом)')
C =================================================================
       CALL ESFCT (N,XENV,ENV,DIAG,IERR)
C =================================================================
       IF(IPR(26)) WRITE(6,952)
952     FORMAT(10X,'*****Finish ESFCT in RCMSLV')
                   IF (IERR.NE.0) RETURN
       IF(IPR(16))then 
         WRITE(6,800)
800    FORMAT(/,2(30X,'РАСПЕЧАТКА МНОЖИТЕЛЯ L')/)
         CALL PRNTDD(1,N,XENV,ENV,DIAG,IPR)
         endif                  
       IF(IPR(26))WRITE(6,953)
953    FORMAT(/,10X,'*****Start  ELSLV in RCMSLV',/,
     > 10X,'(решение нижней треугольной матрицы)')
C =================================================================
       CALL ELSLV (N,XENV,ENV,DIAG,R)
C =================================================================
       IF(IPR(26)) WRITE(6,954)
954     FORMAT(10X,'*****Finish ELSLV in RCMSLV')
       IF(IPR(26))WRITE(6,955)
955    FORMAT(/,10X,'*****Start  EUSLV  in RCMSLV',/,
     > 10X,'(решение верхней треугольной матрицы)')
       CALL EUSLV (N,XENV,ENV,DIAG,R)
       IF(IPR(26)) WRITE(6,956)
956     FORMAT(10X,'*****Finish EUSLV  in RCMSLV')       
C
       WRITE(6,100) OPS
100    FORMAT(/,5X,'KOЛИЧECTBO OПEPAЦИЙ  ПPИ PEШEHИИ CИCTEMЫ =',D16.6)
       RETURN
       END
C ================================================================
C ================= конец кода RCMSLV ==============================
C ================================================================
C конец файла RCMSLV.for




