C Файл REGULARIZATION.for
C Содержит подпрограмму REGULARIZATION
C ===================================================================
C REGULARIZATION - процедура оптимизации конечных элементов по углам
C вызывается из GRIDDM,
C вызывает модули FINDNODD, GET_STAR, FIND_MIN_ANG
C ===================================================================
C  входные параметры:
C    NRC  - параметр разбиения
C    INRG - число зон
C    NOPR - массив номеров узлов, сост-щих элементы
C    NROWS - число строк узлов в зоне ( равно NRC)
C    NCOL - число столбцов узлов в зоне ( равно NRC)
C    CORDDR  - массив координат узлов
C    INOUTR - массив признаков узлов (узел граничный или внутренний)
C    NP - число узлов
C    NUMOFEL - число элементов
C  выходные параметры отсутствуют
C =================================================================
C ================ начало кода REGULARIZATION ======================

      subroutine REGULARIZATION(NRC,INRG,NOPR,NROWS,NCOL,
     > CORDDR,INOUTR,NP,NUMOFEL,IPR)
      DIMENSION NOPR(1),CORDDR(1),INOUTR(NP),ISTAR(100),CDNT(6),
     > EX(4),EY(4), CORDDR_NO_OPT(6000),NOTMOVE(6000)
      INTEGER NOUTPNT,IND,NSTEL,L,MAXL,K,INDSTAR,
     > JNDSTAR,KTIMES,MAXTIMES
      REAL MINANG,NEWMINANG,MINSIDE,NEWMINSIDE,CURMINANG,CURMINSIDE,
     > STEP,COORX,COORY,MAXDELTA,CURDELTA,MANG,MODMANG,
     > NEWMODMANG
         INTEGER I,MM,J,NOTMOVE
* NOTMOVE - массив для хранения номеров узлов, которые лежат на границе материалов
* J - колличество элементов в массиве NOTMOVE
       LOGICAL*1 IPR(50)
      REAL X1,Y1
      DATA EX/1,0,-1,0/,EY/0,1,0,-1/,MAXL/3/
      DATA KTIMES/0/,MAXTIMES/100/

      NOUTPNT=(3*NRC-4)*INRG+NRC-(INRG-1)*NRC

C =================================================================
c      Изменено 21.12.2006
c      копируем массив координат для последующего сравнения
         do i=1,np
            CORDDR_NO_OPT(2*(i-1)+1) = CORDDR(2*(i-1)+1)
            CORDDR_NO_OPT(2*(i-1)+2) = CORDDR(2*(i-1)+2)
         enddo
C =============================================================
c       Вызов процедуры поиска узлов, лежащим на границе свойств КЭ
C =============================================================
       IF(IPR(26))WRITE(6,601)
601    FORMAT(/,20X,'*****Start FINDNODD in REGULARIZATION'
     > ' in GRIDDM',/,
     > 20X,'(поиск узлов, лежащих на границе свойств КЭ)')     
       CALL FINDNODD(INOUTR,NP,CORDDR)
       IF(IPR(26)) WRITE(6,602)
602    FORMAT(20X,'*****Finish FINDNODD in REGULARIZATION'
     > ' in GRIDDM',/)
      IF(IPR(15)) WRITE(6,*) ' nomer prohoda;','  max izm ugla;', 
     > ' naim- ugol iz;',' naim-y izm ug;'
* -- число прогонов процедуры оптимизации
 71    KTIMES= KTIMES+1
         MANG=1.0472
         MODMANG=1.0472
         NEWMODMANG=1.0472
         MAXDELTA=0.0
* -- цикл по узлам
       DO 61 IND=1,NP

* если текущий узел не принадлежит границе области и не относится к узлам,
* которые лежат на границе материалов      
*       IF ((INOUTR(IND).EQ.0).AND.(NTM(IND,NOTMOVE,J).EQ.0)) THEN

*       PRINT*, "Работаем с узлом ====== ",IND,"---",NTM(IND,NOTMOVE,J)
* -- принадлежит ли узел границе области
       IF(INOUTR(IND).EQ.0)THEN
C ==============================================================
C -- определяем звезду, соотв-ю данному узлу
C =================================================================

        CALL GET_STAR(IND,NOPR,NUMOFEL,ISTAR,NSTEL)

*        WRITE(6,*) NSTEL,(((ISTAR(3*(I-1)+J)),J=1,3),I=1,NSTEL)
* 18     FORMAT(I,6(/3I4))

* -- найти более хорошее положение узла
* вычисление мин. угла при исходных коор-тах
* перебор эл-тов звезды
         MINANG=1.0472
        DO 62 INDSTAR=1,NSTEL
* перебор узлов текущего эл-та
         DO 63 JNDSTAR=1,3
* опр-ние коор-т узлов тек. эл-та для вычисл. мин. угла
          CDNT(2*(JNDSTAR-1)+1)=
     >    CORDDR(2*(ISTAR(3*(INDSTAR-1)+JNDSTAR)-1)+1)
          CDNT(2*(JNDSTAR-1)+2)=
     >    CORDDR(2*(ISTAR(3*(INDSTAR-1)+JNDSTAR)-1)+2)
*         WRITE(6,*) CDNT(2*(JNDSTAR-1)+1),CDNT(2*(JNDSTAR-1)+2),IND
 63     ENDDO
C ==============================================================
*     Определение мин. угла в эл-те
C =================================================================
         CALL FIND_MIN_ANG(CDNT,CURMINANG,CURMINSIDE)
*         WRITE(6,69) INDSTAR,IND,CURMINANG/3.141592*180,CURMINSIDE
 69   FORMAT(' EL',I3,'  ND',I3,'  ANG',F12.6,'  MSD',F12.6)
* определение минимального угла звезды
*          WRITE(6,*)MINANG,CURMINANG,MINANG/CURMINANG
         IF((MINANG/CURMINANG).GT.1.001) THEN
          MINANG=CURMINANG
          MINSIDE=CURMINSIDE
         ENDIF

 62      ENDDO
*         WRITE(6,69) IND,IND,MINANG/3.141592*180,MINSIDE

C < осуществляем оптимизацию положения узла
        STEP=MINSIDE/3
        DO 64 L=1,MAXL
         STEP=STEP/2
* 68     WRITE(6,*) 'STEP',STEP
  68     DO  65 K=1,4
          COORX=CORDDR(2*(IND-1)+1)+STEP*EX(K)
          COORY=CORDDR(2*(IND-1)+2)+STEP*EY(K)
*         WRITE(6,*) COORX,COORY

* вычисление минимального звезды угла при новом положении узла
          NEWMINANG=1.0472
          DO 66 INDSTAR=1,NSTEL
* перебор узлов текущего эл-та
           DO 67 JNDSTAR=1,3
* опр-ние коор-т узлов тек. эл-та для вычисл. мин. угла
* если это оптимизируемый узел, принять новые координаты
            IF(ISTAR(3*(INDSTAR-1)+JNDSTAR).EQ.IND)THEN
             CDNT(2*(JNDSTAR-1)+1)=COORX
             CDNT(2*(JNDSTAR-1)+2)=COORY
            ELSE             
             CDNT(2*(JNDSTAR-1)+1)=
     >       CORDDR(2*(ISTAR(3*(INDSTAR-1)+JNDSTAR)-1)+1)
             CDNT(2*(JNDSTAR-1)+2)=
     >       CORDDR(2*(ISTAR(3*(INDSTAR-1)+JNDSTAR)-1)+2)
            ENDIF
 67        ENDDO
C ==============================================================
C < вычисление мин. угла и стороны тек. эл-та звезды
C =================================================================
           CALL FIND_MIN_ANG(CDNT,CURMINANG,CURMINSIDE)
*         WRITE(6,70) INDSTAR,IND,CURMINANG/3.141592*180,CURMINSIDE
 70   FORMAT(' K',I3,'  ND',I3,'  ANG',F12.6,'  MSD',F12.6)
* FORMAT(' COORY',F12.6,'  COORY',F12.6,'  ANG',F12.6,'  MSD',F12.6)
*          WRITE(6,*)NEWMINANG,CURMINANG,NEWMINANG/CURMINANG

* определение минимального угла звезды
           IF((NEWMINANG/CURMINANG).GT.1.001) THEN
             NEWMINANG=CURMINANG
             NEWMINSIDE=CURMINSIDE
           ENDIF
 66       ENDDO
*         WRITE(6,70) K,IND,NEWMINANG/3.141592*180,NEWMINSIDE
* Определение минимального угла из всех
* нужно лишь для проверки
          IF(MINANG.LE.MANG)THEN
           MANG=MINANG
          ENDIF

* выяснить, лучше ли нов. коор. узла, т.е. увеличился ли мин. угол
          IF(NEWMINANG/MINANG.GT.1.001)THEN
           CURDELTA=NEWMINANG-MINANG
           IF(CURDELTA.GT.MAXDELTA)THEN
            MAXDELTA=CURDELTA
           ENDIF
* Определение минимального измененного угла из всех
* нужно лишь для проверки
           IF(MODMANG.GE.MINANG) MODMANG=MINANG
           IF(NEWMODMANG.GE.NEWMINANG) NEWMODMANG=NEWMINANG
           CORDDR(2*(IND-1)+1)=COORX
           CORDDR(2*(IND-1)+2)=COORY
           MINANG=NEWMINANG
           GO TO 68
          ENDIF
*         WRITE(6,*) '            ---------------------------         ' 
 65      ENDDO
 64     ENDDO
       ENDIF
 61   ENDDO
      IF(IPR(15)) WRITE (6,72) KTIMES,MAXDELTA/3.141592*180,
     >MANG/3.141592*180, MODMANG/3.141592*180
  72  FORMAT(10X,I3,3(5X,F10.6))
C ==============================================================
c      Изменено 21.12.2006
C       IF(MAXDELTA.GT.(0.0).AND.KTIMES.LT.MAXTIMES) GO TO 71
       IF(MAXDELTA.GT.(0.001).AND.KTIMES.LT.MAXTIMES) GO TO 71
c      Печатаем результаты оптимизации по узлам
C ==============================================================
      IF(IPR(15)) write (6,*) 
      IF(IPR(15)) write (6,*) '---- Результаты оптимизации ----'
      IF(IPR(15)) write (6,*) 
      IF(IPR(15)) write (6,800)
       do i=1,np
      IF(IPR(15))write (6,801) i,CORDDR(2*(i-1)+1),
     >      CORDDR_NO_OPT(2*(i-1)+1),
     >      Abs(CORDDR(2*(i-1)+1)-CORDDR_NO_OPT(2*(i-1)+1)),
     >      CORDDR(2*(i-1)+2),CORDDR_NO_OPT(2*(i-1)+2),
     >      Abs(CORDDR(2*(i-1)+2)-CORDDR_NO_OPT(2*(i-1)+2))
       enddo
 800   format (4x,'N узл.   X_opt   ','X_no_opt  ','|Delta_X|  ',
     >            'Y_opt     ','Y_no_opt  ','|Delta_Y|  ')   
 801   format (4x,i4,3x,f7.2,3x,f7.2,3x,f7.4,3x,f7.2,3x,f7.2,3x,f7.4)   
c     -------------------------------------

C > определяем звезду, соотв-ю данному узлу -- END
      END
C / END REGULARIZATION /
C =================================================================
C ============== конец кода REGULARIZATION =========================
C =================================================================
C  конец файла  REGULARIZATION.for