C PREPR.FOR
C Содержит подпрограммы PREP_BOUND и PREP_FORCE, реализующие чтение экспортированных из препроцессора данных
C
C       ПОДПPOГPAММА HAЛOЖEНИЯ ГPАНИЧНЫХ УCЛOBИЙ
C          BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.       
C ==================================================================
C ================== начало кода BOUND =============================
C                                                для Example 1
C ==================================================================

      SUBROUTINE PREP_BOUND(NN,CORD,NBC,NFIX,DB,IPR,NP,INVP) ! Комашенко Н.А. 2010 :-)
C
C       ПPOГP. HAЛOЖ. ГPАН. УCЛOBИЙ,BЫЗЫBAETCЯ ИЗ MAIN1
C
      DIMENSION CORD(1),NBC(1),NFIX(1), INVP(1), 
     >TEMP_NBC(1000), TEMP_NFIX(1000) ! Комашенко Н.А. 2010 :-)

      LOGICAL*1 IPR(50)
********************************************************************
***************** Комашенко Н.А. 2010 :-) **************************
******** переписываем NFIX и NBC ***********************************
      OPEN(84,FILE='bounds.nodes',STATUS='OLD',IOSTAT=ios) !открываем файл
      if (ios.eq.0) then          
          read(84,*)NB   ! считываем число закрепленных узлов
          do i=1,NB  
                  NBC(i) = 0      ! обнуляем массивы
                  NFIX(i) = 0  
            enddo     
          do i=1,NB
                  read(84,*)TEMP_NBC(i), TEMP_NFIX(i) ! считываем во временные массивы номера закрепленных узлов и тип закреплений
            enddo        
            close(84)  ! закрываем файл
            ! А теперь надо переставить элементы в массиве согласно новой нумерации узлов, полученной в RENMDD     
            do i = 1, NB 
            NBC(i) = INVP(TEMP_NBC(i))
            NFIX(i) = TEMP_NFIX(I)           
            IF(IPR(21))WRITE(6,19)i,CORD(2*(NBC(i)-1)+1),
     >       CORD(2*(NBC(i)-1)+2),NFIX(i)           
            enddo   
      endif   
********************************************************************    
      IF(IPR(21)) PRINT *,"ЧИСЛО ЗАКРЕПЛЕННЫХ УЗЛОВ NFIX=",NB  
  18  FORMAT('  ГPAHИЧHЫE УCЛOBИЯ'/' УЗEЛ    X      Y    ЗАКР ')
  19  FORMAT(' ',I4,' ',F7.2,' ',F7.2,'  ',I2)
      NN=NB
      RETURN
      END
C ==================================================================
C ================== конец кода BOUND  =============================
C ==================================================================

C     ПOДПPOГPAMMA PAЗHECEHИЯ HAГPУЗOK ПО УЗЛАМ
C     BЫЗЫBAETCЯ ИЗ MAIN, вызываемых модулей нет.
C ==================================================================
*     IPR массив управления печатью
*FORCEX - массив состоящий из номеров точек и координат X точек к которым приложена 
*распределенная сила
*CORD - одномерный массив глобальных координат узлов (первые два элемента этого массива 
*являются координатами узла 1 по оси Х и Y соответственно, вторая пара элементов - узла 2 и т.д.).
*R - массив значений усилий в узлах (аналогичен по структуре массиву CORD, только вместо координат
* в нем указываются значения нагрузок по оси Х и Y в узлах);
C NR- число нагруженных узлов 
C ==================================================================
C ================== начало кода FORCE =============================
C                                                для Example 1
C ==================================================================
      SUBROUTINE PREP_FORCE(NB,CORD,NRC,DB,IPR,NP,RSUM,R,NDF,DH,NR,
     >PRM1,PRM2,PRM3,PRM4,PRM5,PRM6,INVP) ! Комашенко 2010
      LOGICAL*1 IPR(50)
      DIMENSION CORD(1),R(1), INVP(1) ! Комашенко 2010
      REAL TEMP_R(6000) ! Комашенко 2010
       IF(IPR(22)) WRITE(6,22)PRM1,PRM2,PRM3,PRM4,PRM5,PRM6
      IF(IPR(23)) WRITE(6,20)                                                                         
  751  OPEN(84,FILE='forces.nodes',STATUS='OLD',IOSTAT=ios)! открываем файл
      if (ios.eq.0) then
          do i = 1, NP * 2
             R(i) = 0     ! обнуляем массив R     
          enddo 
          read(84,*)NR       ! считываем число нагруженных узлов
          do I = 1, NP
              read(84,*)TEMP_R((I-1)*NDF+1),TEMP_R((I-1)*NDF+2) ! считываем во временные массивы значения узловых сил для каждого узла
          enddo    
          close(84)   !закрываем файл
          WRITE(6,*) NP
          ! А теперь надо переставить элементы в массиве согласно новой нумерации узлов, полученной в RENMDD     
          do I = 1, NP
                J = INVP(I)
                R((J-1)*NDF+1) = TEMP_R((I-1)*NDF+1)
                R((J-1)*NDF+2) = TEMP_R((I-1)*NDF+2)
          enddo
          j = 0
          do i= 1, NP
        IF (ABS(R((i-1)*NDF+1))+ABS(R((i-1)*NDF+2)).gt..001) THEN
           j = j + 1
           WRITE(6,21) j,i,CORD(2*(i-1)+1),CORD(2*(i-1)+2),
     > R((i-1)*NDF+1),R((i-1)*NDF+2)
        endif
        enddo        
      endif   
********************************************************************
      IF (NR.NE.0) THEN
      IF(IPR(23)) PRINT *,"ЧИСЛО НАГРУЖЕННЫХ УЗЛОВ NR=",NR
  21  FORMAT  (2I6,1X,2F10.3,4X,2F9.2)
 122  RETURN
      ENDIF

      WRITE(6,6) (I,(R((I-1)*NDF+J),J=1,NDF),I=1,NP)
   6  FORMAT (' HE HAЙДEHЫ TOЧKИ ПPИЛOЖEHИЯ HAГPУЗOK'/8(I4,2G10.2))
  20  FORMAT (' PACПPEДEЛEHИE HAГPУЗOK'/ '     N    УЗEЛ   X-COORD',
     >        '    Y-COORD       * RX *     * RY *')
22     FORMAT (10X,'СВОБОДНЫЕ ПАРАМЕТРЫ (контроль в  FORCE)'
     >/6X,'PRM1',6X,'PRM2',
     >6X,'PRM3',6X,'PRM4',6X,'PRM5',6X,'PRM6'/(2X,6F10.4))
      STOP
      END
C ==================================================================
C =================== конец кода FORCE для Example 1 ===================
C ==================================================================

C =================================================================
C GRIDDM - ПОДПPOГPAMMA ДEЛEHИЯ ПЛOCKOЙ OБЛACTИ HA KOHEЧHЫE ЭЛE-
C MEHTЫ, ПOДГOTABЛИBAET ИCXOДHЫE ДAHHЫE ДЛЯ METOДA KOHEЧH.ЭЛEMEHTOB
C   Вызывает подпрограмму REGULARIZATION оптимизации сетки КЭ 
C   BЫЗЫBAETCЯ ИЗ MAIN.
C   Вызов PROPERTYGRIDDM - в районе строки 290 (способ 1 задания свойств)
C *****************************************************************
C Господа!!
C скудные комментарии внесены только в июне 2004 года. как народ до 
C этого писал модуль - непонятно. Точнее понятно - главное было 
C написать что-то работающее, чтобы зачли курсач, а остальное пусть 
C хоть медным тазом накроется. Ну что за народ, хоть бы чуть 
C комментировали. Это же не уважение даже по отношению к себе!!!
C *****************************************************************
C =================================================================
C ================ начало кода GRIDDM ==============================
C =================================================================

        subroutine PREP_GRIDDM (NRC,NOP,IPR,MAXNP,NELEM,CORDD,
     *          INBP,INRG,NDD,XP,YP,ZP,JT,NCN,ENV,NMAT,IMAT)
       DIMENSION  XP(1),YP(1),ZP(1),XRG(9),YRG(9),ZRG(9)
     *           ,N(8),NDN(8),LB(3)
     *           ,CORD(3),CORD1(3)
     *           ,NN(52,52),NE(600),XE(600),YE(600),ZE(600),NR(4)
     *,ZC(52,52),YC(52,52),XC(52,52),NNRB(20,4,52),JT(20,4)
     *,ICOMP(4,4),GLOB(9),NDD(8,20),CORDD(1),NOP(1),IMAT(1),ENV(3)
     *,INOUT(NRC*NRC*INRG-NRC*(INRG-1))
       REAL N,NODEX,NODEY
        integer tmp
c      ------------------------------------- 
c      Изменено 21.12.06       
c       opt_flag - ">1.0" расчёт с оптимизацией конечных элементов
c       opt_flag - "<1.0" расчёт без оптимизации конечных элементов 
       integer opt_flag
       character*20 title
c      ------------------------------------- 
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccc Переменная для определения статуса файла (Плагин Rupert) ccc
      INTEGER ios
      Integer op
      Integer nnn;
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc       
       INTEGER NUMOFELEM
       LOGICAL*1 IPR(50)
      DATA ICOMP/-1,1,1,-1,1,-1,-1,1,1,-1,-1,1,-1,1,1,-1/
      DATA IN/ 5/,IO/6/,IP/6/,NBW/0/,NB/0/,NEL/0/
      DATA GLOB/0.,-1.,3.,0.,-.5,-1.,0.,3.,0./
      NT1=0
      NUMOFELEM=NRC*NRC*INRG-NRC*(INRG-1)
      DO I=1,NUMOFELEM
       INOUT(I)=1
      ENDDO
C     WRITE(6,776)NDD
C 776 FORMAT(2X,3I5)
      NT2=0
      IPCH=0
      MAXNP=1
C   ---Printing global coordinates---(точки, образующие зоны)
      IF(IPR(2)) WRITE(IO,36)
   36 FORMAT(              /1X,'GLOBAL COORDINATES'/ ' NUMBER'
     *,9X,'X COORD     Y COORD     Z COORD')
      IF(IPR(2)) WRITE(IO,30) (I,XP(I),YP(I),ZP(I),I=1,INBP)
   30 FORMAT(2X,I3,7X,F7.2,5X,F7.2,5X,F7.2)
C   ---Printing connectivity datas---(как сопрягаются зоны)
      IF(IPR(3)) WRITE(IO,21)
   21 FORMAT( /1X,'CONNECTIVITY DATA' /1X,'REGION',4X,'SIDE',4X
     *,'1      2      3      4')
      IF(.NOT.IPR(3)) GO TO 6
      DO 26 I=1,INRG
   26 WRITE(IO,22)I,(JT(I,J),J=1,4)
   22 FORMAT(2X,I3,13X,4(I2,5X))
C включили счетчик по количеству зон
    6 DO 16 KK=1,INRG
* рассматриваемая зона - NRG
       NRG=KK
* количество рядов и строк в будущей сетке
       NROWS=NRC
       NCOL=NRC
C выбираем точки, образующие текущую зону
       DO 4 I=1,8
    4  NDN(I)=NDD(I,KK)
       IF(IPR(4)) WRITE(IO,18)NRG,NROWS,NCOL,(NDN(I),I=1,8)
   18  FORMAT(      /1X,'****  REGION  ',I2,6H  **** /10X,I2,' ROWS',
     *  10X,I2,' COLUMNS' /5X,'BOUNDARY NODE NUMBERS',8I5)
C < генерация сетки КЭ --- BEGIN SETKA
       DO 5 I=1,8
        II=NDN(I)
        XRG(I)=XP(II)
        ZRG(I)=ZP(II)
    5   YRG(I)=YP(II)
       ZRG(9)=ZRG(1)
       XRG(9)=XRG(1)
       YRG(9)=YRG(1)
* вычисления шага сетки
       TR=NROWS-1
       DETA=2./TR
       TR=NCOL-1
       DSI=2./TR
       DO 12 I=1,NROWS
        TR=I-1
        ETA=1.-TR*DETA
        DO 12 J=1,NCOL
         TR=J-1
         SI=-1.+TR*DSI
* вычисление коэффицентов (ниже будет ясно для чего они)
         N(1)=-0.25*(1.-SI)*(1.-ETA)*(SI+ETA+1.)
         N(2)=0.50*(1.-SI**2)*(1.-ETA)
         N(3)=0.25*(1.+SI)*(1.-ETA)*(SI-ETA-1.)
         N(4)=0.50*(1.+SI)*(1-ETA**2)
         N(5)=0.25*(1.+SI)*(1.+ETA)*(SI+ETA-1.)
         N(6)=0.50*(1.-SI**2)*(1.+ETA)
         N(7)=.25*(1.-SI)*(1.+ETA)*(ETA-SI-1.)
         N(8)=0.50*(1.-SI)*(1.-ETA**2)
* обнуление начальных координат определяемого узла
         XC(I,J)=0.0
         YC(I,J)=0.0
         ZC(I,J)=0.0
* вычисляются координаты узлов сетки
* в формировании координаты нового узла участвуют все восем
* базовых (образующих зону) узлов, координаты каждого из которых 
* умножаются на коэффицент, соответсвующий номеру узла в зоне 
         DO 125 K=1,8
          XC(I,J)=XC(I,J)+XRG(K)*N(K)
          ZC(I,J)=ZC(I,J)+ZRG(K)*N(K)
 125      YC(I,J)=YC(I,J)+YRG(K)*N(K)
C       IF(I.EQ.1.OR.I.EQ.NCOL.OR.J.EQ.1.OR.J.EQ.NROWS)
C     >  WRITE(6,124) I,J,XC(I,J),YC(I,J)
C124    FORMAT(2I3,2F8.2)
12     CONTINUE
       KN1=1
       KS1=1
       KN2=NROWS
       KS2=NCOL
       DO 50 I=1,4
* перебор связей текущей зоны с другими
        NRT=JT(NRG,I)
c        write (6,*) 'i,nrt,nrg',i,nrt,nrg 
* если рассматриваемая зона не связана с текущей
* или номер смежной зоны больше чем рассматриваемой
* то провести какие-то манипуляции
* вообще дальше как-то очень мутно формируется массив NN,
* который содержит номера узлов сетки рассматриваемой зоны
        IF(NRT.EQ.0.OR.NRT.GT.NRG) GO TO 50
        DO 56 J=1,4
* иначе запоминаем номер той стороны смежной зоны,с
* которой смежна рассматриваемая зона
   56   IF(JT(NRT,J).EQ.NRG) NRTS=J
        K=NCOL
        IF(I.EQ.2.OR.I.EQ.4)K=NROWS
        JL=1
* I - номер смежной стороны рассм зоны,
* NRTS - номер смежной стороны текущей зоны
        JK=ICOMP(I,NRTS)
        IF(JK.EQ.-1)JL=K
         DO 44 J=1,K
*       write(6,*) j
        GO TO (45,46,47,48),I
C  45  write(6,*) '45 i,nrt,nrts,jl,nnrb(nrt,nrts,jl)',
C     * i,nrt,nrts,jl,nnrb(nrt,nrts,jl)
 45     NN(NROWS,J)=NNRB(NRT,NRTS,JL)
* узлы на стыке двух зон - внутренние
        IF(J.NE.1.AND.J.NE.NCOL) INOUT(NN(NROWS,J))=0
        KN2=NROWS-1
        GO TO 44
C  46  write(6,*) '46 i,nrt,nrts,jl,nnrb(nrt,nrts,jl)',
C     * i,nrt,nrts,jl,nnrb(nrt,nrts,jl)
 46     NN(J,NCOL)=NNRB(NRT,NRTS,JL)
* узлы на стыке двух зон - внутренние
        IF(J.NE.1.AND.J.NE.NROWS) INOUT(NN(J,NCOL))=0

      KS2=NCOL-1
      GO TO 44
C  47  write(6,*) '47 i,nrt,nrts,jl,nnrb(nrt,nrts,jl)',
C     * i,nrt,nrts,jl,nnrb(nrt,nrts,jl)
  47    NN(1,J)=NNRB(NRT,NRTS,JL)
* узлы на стыке двух зон - внутренние
        IF(J.NE.1.AND.J.NE.NCOL) INOUT(NN(1,J))=0
      KN1=2
      GO TO 44
C  48  write(6,*) '48 i,nrt,nrts,jl,nnrb(nrt,nrts,jl)',
C     * i,nrt,nrts,jl,nnrb(nrt,nrts,jl)
 48     NN(J,1)=NNRB(NRT,NRTS,JL)
* узлы на стыке двух зон - внутренние
        IF(J.NE.1.AND.J.NE.NROWS) INOUT(NN(J,1))=0
      KS1=2
   44 JL=JL+JK
   50 CONTINUE
      IF(KN1.GT.KN2)GO TO 105
      IF(KS1.GT.KS2) GO TO 105
      DO 10 I=KN1,KN2
      DO 10 J=KS1,KS2
      NB=NB+1
   10 NN(I,J)=NB
      DO 42 I=1,NCOL
      NNRB(NRG,1,I)=NN(NROWS,I)
   42 NNRB(NRG,3,I)=NN(1,I)
      DO 43 I=1,NROWS
      NNRB(NRG,2,I)=NN(I,NCOL)
   43 NNRB(NRG,4,I)=NN(I,1)
C Печать номеров узлов, входящих в текущую зону (по линиям)
      IF(IPR(4)) WRITE(IO,49)
   49 FORMAT(//1X,'REGION NODE NUMBERS'/)
      IF(.NOT.IPR(4)) GO TO 7
      DO 52 I=1,NROWS
   52 WRITE(IO,53)(NN(I,J),J=1,NCOL)
   53 FORMAT(1X,20I5)
C Печать номеров и координат узлов, входящих в текущую зону (шапка)
    7 IF(IPR(6)) WRITE(IO,58)
   58 FORMAT(//5X,27HCOORDINATES NOTES OF REGION
     *//2X,6HNUMBER,4X,7HX-COORD,5X,7HY-COORD,5X,7HZ-COORD)
  105 CONTINUE
* < Определение внешних и внутренних узлов
* формируется массив INOUT: если узел внутренний, то соответсвующий
* элемент INOUT равен 0, если внешний - 1.
* все неграничные узлы внутренние;
* если сторона зоны смежна с другой зоной, узлы на этой стороне,
* кроме угловых, тоже внутренние.
* узлы не на границе зоны - внутренние
      DO INODE=2,NROWS-1       
       DO JNODE=2,NCOL-1
         INOUT(NN(INODE,JNODE))=0
       ENDDO
      ENDDO    
* > Определение внешних и внутренних узлов
C > завершена генерация сетки конечных элементов --- END SETKA
C < определение конечных элементов (группировка узлов)--- BEGIN ELEMENT FORM
      K=1
      DO 54 I=1,NROWS
      DO 54 J=1,NCOL
      XE(K)=XC(I,J)
      YE(K)=YC(I,J)
      ZE(K)=ZC(I,J)
      NE(K)=NN(I,J)
      IF(NE(K).GT.MAXNP) MAXNP=NE(K)
      CORDD(2*(NE(K)-1)+1)=XE(K)
      CORDD(2*(NE(K)-1)+2)=YE(K)
      CORD(1)=XE(K)
      CORD(2)=YE(K)
      CORD(3)=ZE(K)
C     CALL PROFIL(GLOB,CORD,CORD1)
      IF(IPR(6)) WRITE(IO,57)
     *NE(K),XE(K),YE(K),ZE(K)
C    *,CORD1
C     IF(NT1.GT.0) WRITE(NT1) NE(K),XE(K),YE(K),ZE(K)
   57 FORMAT(I5,3F12.4)
   54 K=K+1
      IF(IPR(5)) WRITE(IO,55)
   55 FORMAT(//3X,'NEL   NODE NUMBERS')
      L=NROWS-1
      DO 15 I=1,L
      DO 15 J=2,NCOL
      DIAG1=SQRT((XC(I,J)-XC(I+1,J-1))**2+(YC(I,J)-YC(I+1,J-1))**2+
     *(ZC(I,J)-ZC(I+1,J-1))**2)
      DIAG2=SQRT((XC(I+1,J)-XC(I,J-1))**2+(YC(I+1,J)-YC(I,J-1))**2+
     *(ZC(I+1,J)-ZC(I,J-1))**2)
      NR(1)=NCOL*I+J-1
      NR(2)=NCOL*I+J
      NR(3)=NCOL*(I-1)+J
      NR(4)=NCOL*(I-1)+J-1
      DO 15 IJ=1,2
      NEL=NEL+1
      IF((DIAG1/DIAG2).GT.1.01) GO TO 41
      IF((DIAG1/DIAG2).LT.1.01) GO TO 60
      IF(MOD(I+J, 2).EQ.1) GO TO 41
  60  J1=NR(1)
      J2=NR(IJ+1)
      J3=NR(IJ+2)
      GO TO 40
   41 J1=NR(IJ)
      J2=NR(IJ+1)
      J3=NR(4)
   40 LB(1)=IABS(NE(J1)-NE(J2))+1
      LB(2)=IABS(NE(J2)-NE(J3))+1
      LB(3)=IABS(NE(J1)-NE(J3))+1
      DO 107 IK=1,3
      IF(LB(IK).LE.NBW) GO TO 107
      NBW=LB(IK)
      NELBW=NEL
  107 CONTINUE
       NOP(NCN*(NEL-1)+1)=NE(J1)
       NOP(NCN*(NEL-1)+2)=NE(J2)
       NOP(NCN*(NEL-1)+3)=NE(J3)
C завершено определение конечных элементов (группировка узлов) END ELEMENT FORM
C =================================================================
C       Реализация  свойств КЭ в Griddm  (способ 1)
C =================================================================
       CALL PROPERTYGRIDDM (NRG,NMAT,NEL,IMAT)
C =================================================================
C       Конец  реализации свойств КЭ в Griddm
C =================================================================
C Печать номеров и координат узлов, входящих в текущую зону 
      IF(IPR(5)) WRITE(IO,301) NEL,NE(J1),NE(J2),NE(J3)
  301 FORMAT(1X,4I5,9F11.4)
*      IF(IPR(5)) WRITE(IO,302) NEL,CORDD(2*(NE(K)-1)+1),
*     > CORDD(2*(NE(K)-1)+2)
*  302 FORMAT(1X,4I5,9F11.4)

C     IF(NT2.GT.0) WRITE(NT2) NEL,NE(J1),NE(J2),NE(J3),IMAT
C     IF(NT2.GT.0) WRITE(NT2)     NE(J1),NE(J2),NE(J3)
C     IF(IPCH.EQ.0) GO TO 15
C     WRITE(IP,303)NEL,NE(J1),NE(J2),NE(J3),XE(J1),YE(J1),XE(J2),
C    *YE(J2),XE(J3),YE(J3)
C 303 FORMAT(4I3,6F10.4)
   15 CONTINUE
C     WRITE(6,776)NDD.

C =================================================================
*      CALL CORRECTION(XC,YC,NN,NROWS,NCOL)
*      WRITE(6,*) 'RESULT OF CORRECTION'
*      DO 33 I=1,NEL
*        WRITE(6,57) I,NOP(NCN*(I-1)+1),NOP(NCN*(I-1)+2),
*     >              NOP(NCN*(I-1)+3)
* 33   CONTINUE

   16 CONTINUE
      NELEM=NEL
       IF(IPR(7))WRITE(IO,555)INRG,MAXNP,NEL
555    FORMAT(/,20X,'Характеристики сетки',
     >/5X,'ЧИСЛО ЗОН',I3,
     >2X,'KOЛИЧЕСТBO УЗЛOB',I4,
     >2X,'KOЛИЧЕСТBO ЭЛЕМЕНTOB',I4)       
    
       IF(IPR(7)) WRITE(IO,51)NBW*2-1,NELBW
51     FORMAT(/,15X,'Характеристики неупорядоченой матрицы',
     >/,15X,'ПOЛУШИPИHA ЛEHTЫ ',I5,
     >2X,'B ЭЛEMEHTE',I4/)
C++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
   
   62  FORMAT( I3, '   X=',F7.2,'   Y=',F7.2 )
   63  FORMAT( I4,'  ', I4, I4, I4 )
      
      Write(6,*) " "
      OPEN(84,FILE='nodes.ftm',STATUS='OLD', ERR=9)
      READ(84,498) title
      read(84,493)MAXNP
      read(84,493)NEL
      
      do i=1,MAXNP
      CORDD(2*(i-1)+1)=0
      CORDD(2*(i-1)+2)=0
      enddo                         
      
      do i=1,NEL
      NOP(3*(i-1)+1)=0
      NOP(3*(i-1)+2)=0
      NOP(3*(i-1)+3)=0
      enddo
      

      
      NELEM=NEL
      
      read(84,*)
      read(84,*)
      
      do i=1,MAXNP
      read(84,*) per,CORDD(2*(i-1)+1),CORDD(2*(i-1)+2)
      WRITE(6,62) i,CORDD(2*(i-1)+1),CORDD(2*(i-1)+2)
      enddo
      
      read(84,*)
      read(84,*)
      Write(6,*) " "
            
      do i=1,NEL
      read(84,*) per,NOP(3*(i-1)+1), NOP(3*(i-1)+2), NOP(3*(i-1)+3)
      write(6,63) i,NOP(3*(i-1)+1), NOP(3*(i-1)+2), NOP(3*(i-1)+3)
      enddo
      
      close(84)
   9  WRITE(IO,555) MAXNP,NEL
C++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

c Временно используем массив env для хранения координат узлов КЭ до оптимизации
c Только для работы программ GetFine и функции GetDensityFunction
      do tmp=1,NELEM 
c         Получаем координаты первого узла элемента N         
          env(2*(NOP(3*(tmp-1)+1)-1)+1)=
     >CORDD(2*(NOP(3*(tmp-1)+1)-1)+1) 
          env(2*(NOP(3*(tmp-1)+1)-1)+2)=
     >CORDD(2*(NOP(3*(tmp-1)+1)-1)+2)
c         Получаем координаты второго узла элемента N          
          env(2*(NOP(3*(tmp-1)+2)-1)+1)=
     >CORDD(2*(NOP(3*(tmp-1)+2)-1)+1) 
          env(2*(NOP(3*(tmp-1)+2)-1)+2)=
     >CORDD(2*(NOP(3*(tmp-1)+2)-1)+2)
c         Получаем координаты третьего узла элемента N
          env(2*(NOP(3*(tmp-1)+3)-1)+1)=
     >CORDD(2*(NOP(3*(tmp-1)+3)-1)+1) 
          env(2*(NOP(3*(tmp-1)+3)-1)+2)=
     >CORDD(2*(NOP(3*(tmp-1)+3)-1)+2)
      enddo

C      write(6,*) " " 
  
C =================================================================    
c      Мусолов 2.1.2007
c      Считываем флаг оптимизации сетки конечных элементов
C =================================================================  
      open (unit=13,FILE='data')
   
C *****CЧИTЫBAHИE ДAHHЫX ПO KOHCTPУKЦИИ ИЗ ФAЙЛA DATA****
      READ(13,498) title
  498 format(20A)
      read (13,493) opt_flag
  493  format (I3)
      close(13)
C ================================================================= 
      !if (opt_flag.eq.1) then
      if((opt_flag.eq.1).or.(opt_flag.eq.3).or.(opt_flag.eq.22)
     >.or.(opt_flag.eq.5).or.(opt_flag.eq.7).or.(opt_flag.eq.12)
     >.or.(opt_flag.lt.-3).or.(opt_flag.eq.24).or.(opt_flag.eq.14))then 
C        WRITE(IO,*) '      В GRIDDM работает REGULARIZATION-***'
       IF(IPR(26))WRITE(6,601)
601   FORMAT(/,10X,'*****Start REGULARIZATION'
     >' in GRIDDM',/,
     >20X,'(Оптимизация сетки)',/) 
C =================================================================
c вызов подпрограммы оптимизации сетки
        CALL REGULARIZATION(NRC,INRG,NOP,NROWS,NCOL,CORDD,INOUT
     >   ,MAXNP,NEL,IPR)

       IF(IPR(26)) WRITE(6,602)
602   FORMAT(/,10X,'*****Finish  REGULARIZATION'
     >' in GRIDDM')
 
C        WRITE(IO,*) '      REGULARIZATION отработал-***'
      endif
********************************************************************
***************** Комашенко Н.А. 2010 :-) **************************
******** переписываем CORD *****************************************
      OPEN(84,FILE='prep_griddm.nodes',STATUS='OLD',IOSTAT=ios) ! открываем файл
      if (ios.eq.0) then
          read(84,*)MAXNP       ! считываем число узлов 
          do i=1,MAXNP*2        ! цикл по удвоенному числу узлов (по две координаты на узел)
             read(84,*)CORDD(i)    ! читаем координаты узла
          enddo          
          close(84) ! закрываем файл
      endif
 
      OPEN(84,FILE='prep_griddm.elems',STATUS='OLD',IOSTAT=ios)! открываем файл
      if (ios.eq.0) then
          nnn=0
            read(84,*)NELEM ! считываем число КЭ
            do i=0,NELEM-1    !цикл по числу КЭ
                  nnn=i*NCN+1 ! nnn - индекс узла для (i+1)-го КЭ в массиве NOP
                  read(84,*)NOP(nnn) ! считываем номер 1-го узла в (i+1)-м КЭ
               read(84,*)NOP(nnn+1)! считываем номер 2-го узла в (i+1)-м КЭ
                  read(84,*)NOP(nnn+2)! считываем номер 3-го узла в (i+1)-м КЭ
            enddo
            close(84)
      endif
******************************************************************** 
      
C =================================================================
c     Определение качества сетки
c      call GetFine(CORDD,NOP,NELEM,env)   
C ================================================================= 
ccccccccc переписываем CORD ccccccccccccccccccccccccccccccccccc
      OPEN(84,FILE='griddm.nodes',STATUS='OLD',IOSTAT=ios)
      if (ios.eq.0) then
        read(84,*)MAXNP        
      do I=1,MAXNP*2
          read(84,*) CORDD(I)     
        enddo
        close(84)
      endif
      OPEN(84,FILE='griddm.Finout',STATUS='OLD',IOSTAT=ios)
      if (ios.eq.0) then
        close(84)
      OPEN(85,FILE='griddm.inout')
      do i=1,MAXNP
      write(85,*)INOUT(i)
      enddo
      close(85)
      endif
      OPEN(84,FILE='griddm.elems',STATUS='OLD',IOSTAT=ios)
      if (ios.eq.0) then
        nnn=0
        read(84,*)NELEM
        do i=0,NELEM-1
          nnn=i*NCN+1
          read(84,*)NOP(nnn)
       read(84,*)NOP(nnn+1)
          read(84,*)NOP(nnn+2)
        enddo
        close(84)
        endif
885     FORMAT(F7.2)

        RETURN
C     DEBUG INIT
      END
      
        subroutine PREP_PROPERTYFORMDD (NE,NCN,NMAT,CORD,IMAT,NOP)
        DIMENSION CORD(1),IMAT(1),NOP(1)
         DO 300 I=1,NE
         J=(I-1)*NCN
         DO 400 JJ=1,3
C       IF (NMAT.ge.2.and.(40.0-CORD((NOP(J+JJ)-1)*2+2)).gt.0.01) THEN
C           IMAT(I)=2
C           ENDIF
 400    CONTINUE
 300    CONTINUE
******************************************************************** 
***************** Комашенко Н.А. 2010 :-) **************************
********* переписываем IMAT ****************************************
      OPEN(84,FILE='materials.elems',STATUS='OLD',IOSTAT=ios) !открываем файл
      if (ios.eq.0) then
          do i = 1, NE
                  IMAT(I) = 1     ! присваеваем на всякий случай первое свойсво всем КЭ   
            enddo
                          
          do I = 1, NE
                  read(84,*) IMAT(I) ! считываем номера свойств КЭ
            enddo        
            close(84)        ! закрываем файл
      endif   
********************************************************************
       RETURN
       END
C =============== конец кода  PROPERTYFORMDD =====================
C конец файла  FINDNODD.for