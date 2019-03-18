C Последняя модификация: декабрь 2011 года, Насибуллин Т.Р.

C  файл MAIN.for
C  Содержит программу MAIN - управляющую программу комплекса Sigma
C ===================================================================
C ===================================================================
C ПPOГPAMMHЫЙ KOMПЛEKC SIGMA ДЛЯ РАСЧЕТА HAПPЯЖEHHO-ДEФOPMИPOBAHHOГO
C COCTOЯHИЯ  ПЛOCKИX KOHCTPУKЦИЙ
C PEAЛИЗУET METOД KOHEЧHOГO ЭЛEMEHTA  PAЗPAБOTAHA HA KAФ 603
C           ABTOP PAЗPAБOTKИ PУCEЦKИЙ B.A.
C ПPOГPAMMA MOДИФИЦИPOBAHA HA KAФ 609
C           ABTOP MOДИФИKAЦИИ CTOЛЯPЧУK B.A.
C ===================================================================
C ===================================================================
C        MAIN - УПPABЛЯЮЩAЯ ПPOГPAMMA KOMПЛEKCA
C BЫЗЫBAET ПOДПPOГPAMMЫ:DATA,DGRIDD,GRIDDM,RENMDD,BOUND,
C FORCE, FNENDD,FORMDD,PRNTDD,STRSDD и т.д.(см. схему расчетного блока)
C
C XADJ - массив,хранящий структуру смежности упорядоченного графа
C ADJNCY - массив,хранящий структуру смежности упорядоченного графа
C PERM - вектор, содержащий обратное переупорядочение Катхилла-Макки.
C INVP - массив с информацией о перестановке для переупорядочения матрицы
C XENV - индексный массив профильного метода
C NOP - массив номеров узлов
C CORD - массив одномерный массив глобальных координат узлов
C DIAG - массив диагональных элементов
C ORT - массив характеристик материалов, из которых изготовлена конструкция
C IMAT - номер материала
C R - массив значений усилий в узлах
C NBC - массив номеров узлов, имеющих закрепление по оси X или Y
C NFIX - массив, в котором указывается тип закрепления узла
C ENV - массив оболочки матрицы
C ESIGMA - хранит значения 6 видов напряжений и значение угла для каждого КЭ
C IPR - логический массив управления печатью (выводом в текстовый файл)
C IPR  задается в "Конфигурация комплекса", раздел "Результаты расчета"
C ===================================================================
C ================== начало кода MAIN =============================
       INTEGER*2 I,J
       INTEGER COUNTER
       REAL*8    X1,X2,X3,X4,X5,X6,X7,X8
       DIMENSION XADJ(10000), ADJNCY(60000), PERM(20000), INVP(20000),
     >          XENV(20000), ENV(300000), NOP(30000), CORD(60000),
     >          DIAG(10000),ORT(1000),IMAT(10000),R(30000),NBC(10000),
     >          NFIX(10000), ESIGMA(42000), CORDPO(10),deg(3000),
     >          marker(3000),RCHESET(3000),NBRHD(3000),
     >          QSIZE(3000),QLINK(3000), ADJNCYBC(6000),
     >          FORM(40),GLOB(9),Density(10000),
     >          XP(600),YP(600),ZP(600),
     >          CORDD(1),NDD(8,20),JT(20,4),BBB(3,6)
C ******************************************************************
C NFP=10 ЛOГИЧECKИЙ HOMEP ФAЙЛA УПPABЛEHИЯ ПEЧATЬЮ PRINTF01 FORTRAN
C ******************************************************************
       dimension mrglnk(1000),nzsub(3000),
     > rchlnk(1000), xlnz(3000),xnzsub(3000)
       integer flag,maxlnz,maxsub,FL

       INTEGER NFP/10/,XADJ,ADJNCY,PERM,INVP,XENV,ENVSZE,BANDW,test
        LOGICAL PREP
       LOGICAL*1 IPR(50)
C       character*512  ExpGrd

       DATA R/30000*0.0/,IMAT/10000*1/,IPR/50*.FALSE./,
     > TEXTF/'FORM'/,ORT/1000*0.0/,Density/10000*1.0/,
     > PRM1/0.0/,PRM2/0.0/,PRM3/0.0/,PRM4/0.0/,PRM5/0.0/,PRM6/0.0/
C
C        ЗABOДИM ЧACЫ
C     CALL STIMER ('TASK',EXIT,1000000)
C ***************************************************************
C        CЧИTЫBAHИE ДAHHЫX ПO KOHCTPУKЦИИ
C ================================================================

       OPEN(33,FILE='RESULT1.BIN',FORM='BINARY')
       OPEN(34,FILE='RESULT2.BIN',FORM='BINARY')

       WRITE(6,777)
777    FORMAT(9X,'Hello!')


!    Панфилов А.А.
!    Пытаемся найти файлы с данными из препроцессора
!    Если все необходимые файлы существуют, дальше работаем с данным из
!    препроцессора
      PREP = .FALSE.
      inquire( file="bounds.nodes", exist=PREP)
      IF (PREP) THEN
      inquire( file="forces.nodes", exist=PREP)
      ENDIF
      IF (PREP) THEN
      inquire( file="materials.elems", exist=PREP)
      ENDIF
      IF (PREP) THEN
      inquire( file="prep_griddm.elems", exist=PREP)
      ENDIF
      IF (PREP) THEN
      inquire( file="prep_griddm.nodes", exist=PREP)
      ENDIF
! Идентификатор PREP в дальнейшем используем для вызова связанных с
! препроцессором функций


       IF(IPR(26)) WRITE(6,999)
999    FORMAT(/,5X,'**********Start  DATA',/,
     > 10X,'(считывание основных параметров задачи)',/)
C ================================================================
       CALL DATA  (NFP,IPR,ORT,NMAT,NCN,NDF,NRC,DD,DB,DH,
     > PRM1,PRM2,PRM3,PRM4,PRM5,PRM6,FL)
C ==============================================================
       IF(IPR(26)) WRITE(6,1000)
1000   FORMAT(/,5X,'*****Finish DATA')
C ==============================================================
C      ФOPMИPУEM ДAHHЫE ДЛЯ GRIDDM
C *******************************************************
       IF(IPR(26)) WRITE(6,998)
998    FORMAT(/,5X,'*****Start DGRIDD',/,
     > 10X,'(считывание данных геометрии)')
C ================================================================
       CALL DGRIDD (INRG,INBP,XP,YP,ZP,JT,NDD,NCN)
C
       IF(IPR(26))  WRITE(6,79)
79     FORMAT(5X,'*****Finish DGRIDD')
C ===============================================================
C  ПPOГPAMMA ПOДГOTOBKИ ИCXOДHЫX ДAHHЫX ДЛЯ MKЭ
C  ФOPMИPOBAHИE CETKИ KOHEЧHЫX ЭЛEMEHTOB
C  ==============================================================


       IF(IPR(26)) WRITE(6,997)
997    FORMAT(/,5X,'*****Start  GRIDDM',/,
     > 10X,'(генерация сетки конечных элементов)'/)
C ================================================================
      IF (PREP) THEN
       CALL PREP_GRIDDM(NRC,NOP,IPR,NP,NE,CORD,
     >  INBP,INRG,NDD,XP,YP,ZP,JT,NCN,ENV,NMAT,IMAT)
      ELSE
       CALL GRIDDM(NRC,NOP,IPR,NP,NE,CORD,
     >  INBP,INRG,NDD,XP,YP,ZP,JT,NCN,ENV,NMAT,IMAT)
      ENDIF
C
       IF(IPR(26)) WRITE(6,1001)
1001   FORMAT(/,5X,'*****Finish GRIDDM')
C ================================================================
c Записываем в файл 2 номера узлов, составляющих конечные элементы.

       DO 663 I=1,NE
        WRITE(34) INT2(NOP(NCN*(I-1)+1))
        WRITE(34) INT2(NOP(NCN*(I-1)+2))
        WRITE(34) INT2(NOP(NCN*(I-1)+3))
663    CONTINUE
       WRITE(34) INT2(-1)

c Записываем в файл 1 координаты узлов после разбиения на КЭ.

       DO 664 I=1,NP
        X1 = CORD(2*(I-1)+1)
        X2 = CORD(2*(I-1)+2)

c исключение разделителя "-1" из возможных данных
       IF(X1.eq.(-1)) X1=X1+0.001
       IF(X2.eq.(-1)) X2=X2+0.001
c
        WRITE(33) X1,X2
664    CONTINUE
       WRITE(33) DBLE(-1)

C  ==============================================================
C  ПEPEHУMEPOBЫBAEM ДЛЯ OБECПEЧEHИЯ MIN ШИPИHЫ ПPOФИЛЯ
C  ==============================================================

554    IF(IPR(26)) WRITE(6,996)
996    FORMAT(/,5X,'*****Start RENMDD',/,
     > 10X,'(перенумерация узлов)'/)
C      write (6,500) NP,NE,NCN
C500   FORMAT (/,'NP=',I5,'  NE=',I5,'  NCN=',I5)
C ================================================================
       CALL RENMDD(NP,NE,NCN,NOP,PERM,INVP,XADJ,ADJNCY,IPR,
     > CORD,ESIGMA,FL,deg,marker,RCHESET,NBRHD,QSIZE,
     > QLINK,ADJNCYBC)
        neqns=np
       IF(IPR(26))WRITE(6,1002)
1002   FORMAT(/,5X,'*****Finish RENMDD')
       IF(IPR(14))WRITE(6,99)(I,(NOP(NCN*(I-1)+J),J=1,NCN),I=1,NE)
99     FORMAT(/' НОВАЯ НУМЕРАЦИЯ УЗЛОВ (ЭЛЕМЕНТ И ЕГО УЗЛЫ)',
     > 2X,' MACCИB <<NOP>>'/(3('  *N',I3,'(' ,3I4,')')))


c       calc(XADJ,ADJNCY,PERM,INVP,XENV,ENV,NOP,cord,
c     >diag,ort,imat,nrc,inrg,r,NBC,NFIX,ESIGMA,NLL)
C   ==============================================================
C              ЗAДAHИE  ГPAHИЧHЫX УCЛOBИЙ
C   ==============================================================
       IF(IPR(26)) WRITE(6,995)
995    FORMAT(/,5X,'*****Start BOUND',/,
     > 10X,'(реализация граничных условий)'/)
C ================================================================
      IF (PREP) THEN
       CALL PREP_BOUND(NB,CORD,NBC,NFIX,DB,IPR,NP,INVP) ! Комашенко Н.А. 2010 :-)
      ELSE
       CALL BOUND(NB,CORD,NBC,NFIX,DB,IPR,NP)
      ENDIF

       IF(IPR(26)) WRITE(6,1003)
1003   FORMAT(/,5X,'*****Finish BOUND')

c Записываем в файл 1 граничные условия.

       DO 665 I=1,NB
        IF (NFIX(I).EQ.0) GOTO 665
        J = NBC(I)
        X1 = CORD(2*(J-1)+1)
        X2 = CORD(2*(J-1)+2)
        J = NFIX(I)
C исключение разделителя "-1" из возможных данных
       IF(X1.eq.-1) X1=X1+0.001
       IF(X2.eq.-1) X2=X2+0.001
       IF(X3.eq.-1) X3=X3+0.001

        WRITE(33) X1,X2,INT1(J)
665    CONTINUE
       WRITE(33) DBLE(-1)

C   ==============================================================
C               PAЗHECEHИE HAГPУЗKИ
C   ==============================================================
       IF(IPR(26)) WRITE(6,994)
994    FORMAT(/,5X,'*****Start FORCE',/,
     > 10X,'(реализация внешних воздействий)'/)
C ================================================================
      IF (PREP) THEN
       CALL PREP_FORCE(NB,CORD,NRC,DB,IPR,NP,RSUM,R,NDF,DH,NR,
     > PRM1,PRM2,PRM3,PRM4,PRM5,PRM6, INVP) ! Комашенко Н.А. 2010 :-)
      ELSE
       CALL FORCE(NB,CORD,NRC,DB,IPR,NP,RSUM,R,NDF,DH,NR,
     > PRM1,PRM2,PRM3,PRM4,PRM5,PRM6)
      ENDIF



             IF(IPR(26)) WRITE(6,1004)
1004   FORMAT(/,5X,'*****Finish FORCE')
C   Контрольная печать параметров задачи после FORCE
       IF(IPR(17)) then
       WRITE(6,3)NP,NE,NB,NR,NCN,NDF,NMAT
 3     FORMAT(/,13X,'КОНТРОЛЬНАЯ ПЕЧАТЬ ПАРАМЕТРОВ ЗАДАЧИ',
     > /3X,'УЗЛОВ',I5,3X,'ЭЛЕМЕНТОВ',I5,
     > /3X,'ЗАКРЕПЛЕННЫХ УЗЛОВ',I3,3X,'НАГРУЖЕННЫХ УЗЛОВ',I3
     > /3X,'УЗЛОВ В ЭЛЕМЕНТЕ',I2,3X,'СТЕПЕНЕЙ СВОБОДЫ',I2,
     > /3X, 'СВОЙСТВ КОНЕЧНЫХ ЭЛЕМЕНТОВ',I2)
       IK=-6
       DO 166 KK=1, NMAT
      IK=IK+7
166    WRITE(6,144) KK, ORT(IK),ORT(IK+1),ORT(IK+2),ORT(IK+6)
144    FORMAT(2X,'CBOЙCTBО:',I3,2X,'MOДУЛЬ E =',F9.0,2X,
     > 'MЮ =',F4.2/16X,'ДОПУСКАЕМОЕ НАПРЯЖЕНИЕ SB =',
     > F6.0,2X,'ТОЛЩИНА =',F4.2)
       endif
C   ==============================================================
C Записываем в файл 1 координаты узлов, к которым
C     приложены силы, и значения этих сил.
C   ==============================================================
       DO 666 I=1,NP
        X1 = R((I-1)*NDF+1)
        X2 = R((I-1)*NDF+2)
        IF ((X1.EQ.0).AND.(X2.EQ.0)) GOTO 666
        X3 = CORD(2*(I-1)+1)
        X4 = CORD(2*(I-1)+2)
C       исключение разделителя "-1" из возможных данных
       IF(X3.eq.-1) X3=X3+0.001
       IF(X4.eq.-1) X4=X4+0.001
       IF(X1.eq.-1) X1=X1+0.001
       IF(X2.eq.-1) X2=X2+0.001
C
        WRITE(33) X3,X4,X1,X2
666    CONTINUE
       WRITE(33) DBLE(-1)

       IF(IPR(19)) WRITE(6,9)(N,(CORD(2*(N-1)+M),M=1,2),N=1,NP)
c Записываем в файл 1 координаты узлов с учетом новой нумерации.
       DO 667 I=1,NP
        X1 = CORD(2*(I-1)+1)
        X2 = CORD(2*(I-1)+2)
c исключение разделителя "-1" из возможных данных
       IF(X1.eq.-1) X1=X1+0.001
       IF(X2.eq.-1) X2=X2+0.001
c

        WRITE(33) X1,X2
667    CONTINUE
       WRITE(33) DBLE(-1)

9      FORMAT('  KOOPДИHATЫ УЗЛOB'/3(3X,I4,2F7.2))
       GO TO 808
55     WRITE(6,155)
155    FORMAT(5X,'OШИБKA ПPИ CЧИTЫBAHИИ')
808    NSZF=NP*NDF

C   ==============================================================
C   PEAЛИЗУET ПPOФИЛЬHУЮ  CXEMУ XPAHEHИЯ PAЗPEЖEHHOЙ MATPИЦЫ
C   ==============================================================
       IF(IPR(26)) WRITE(6,993)
993    FORMAT(/,5X,'*****Start FNENDD',/,10X,
     > '(реализация модифицированной профильной схемы хранения)'/)
C ================================================================
       CALL FNENDD (NP,NDF,XADJ,ADJNCY,PERM,INVP,
     >  XENV,ENVSZE,BANDW)
       IF(IPR(26))  WRITE(6,992)
992    FORMAT(/,5X,'*****Finish FNENDD')

       IF(IPR(27)) WRITE(6,16) NSZF+1, XENV(1),
     >  (XENV(I+1),I=1,NSZF)
  16   FORMAT (5X,'РАСПРЕДЕЛЕНИЕ ПАМЯТИ (XENV)',
     > 3X,'РАЗМЕР XENV=',I5 /(10I6))

       IF(IPR(28)) WRITE(6,17) ENVSZE,BANDW+1
  17   FORMAT ( '   PAЗMEP OБOЛOЧKИ -',I8,'
     >   ШИPИHA ЛEHTЫ -',I5)
C   ==============================================================
C    В профильной схеме хранения затраты памяти равны:
C     размер оболочки = ENVSZE + диагональ =
C     2NP + размер вектора индексов XENV = nszf+1
        IF(IPR(25)) then
         print*,'begin memory'
       if(((fl.lt.4).and.(fl.ge.0)).or.(fl.eq.-2).or.(fl.eq.21).
     >  or.(fl.eq.-4).or.(fl.eq.11).or.(fl.eq.12).or.(fl.eq.22))then
       print*,''
       print*,'Модифицированная профильная схема хранения '
       print*,''
       print*,'диагональ:',2*np
       print*,'размер оболочки:',ENVSZE
       print*,'размер индесного вектора:',nszf+1
       print*,'затраты памяти профильной схемы хранения:',
     > (nszf+1+ENVSZE+2*np)
       endif
        endif
C   ==============================================================
       print*,''
       print*,'end memory'

C ================================================================
       IF(IPR(20))WRITE (6,101) NP,NE,NB
       IF(IPR(20))WRITE(6,103)(I,(NOP(NCN*(I-1)+J),
     >  J=1,NCN),I=1,NE)
103    FORMAT(/'  NOP ПЕРЕД FORMDD'/3('  *N',I3,'(',3I4,')'))
101    FORMAT(/,3X,'NP=',I5,3X,'NE=',I5,3X,'NB=',I5)
C ================================================================
C ФOPMИPУET MATPИЦУ ЖECTKOCTИ ДЛЯ ПPOФИЛЬHOГO METOДA PEШEHИЯ
C ================================================================
       IF(IPR(26)) WRITE(6,991)
991    FORMAT(/,5X,'*****Start FORMDD',/,
     > 10X,'(формирование матрицы жесткости)'/)
       CALL FORMDD (NP,NE,NCN,NDF,NB,NMAT,BANDW,NOP,
     >       CORD,ORT,IMAT,NBC,NFIX,XENV,DIAG,ENV,BBB,IPR,PREP)
       IF (IPR(26)) WRITE(6,1006)
1006   FORMAT(/,5X,'*****Finish FORMDD')

C   ==============================================================
C   ПEЧATЬ MATPИЦЫ B BИДE:ECЛИ * ,TO ЭЛEMEHT MATPИЦЫ HEHУЛEBOЙ
C   ==============================================================
       IF(IPR(8).or.IPR(9)) GO TO 687
       GO TO 686
687    IF (IPR(26))WRITE(6,688)
688    FORMAT(/,5X,'*****Start PRNTDD',/,
     > 10X,'(распечатка матрицы)'/)
C ================================================================
         WRITE(6,800)
800    FORMAT(/,2(30X,'РАСПЕЧАТКА МАТРИЦЫ А')/)
       CALL PRNTDD(1,NSZF,XENV,ENV,DIAG,IPR)
       IF (IPR(26)) WRITE(6,689)
689    FORMAT(/,5X,'*****Finish PRNTDD')

*----------------Добавлено Насибуллиным Т.Р. 2011г.
*----- для модуля отображения заполненности матрицы

686    OPEN(36,FILE='RESULT3.BIN',FORM='BINARY')
       WRITE(36) INT4(NSZF)
       WRITE(36) INT4(-1)
       DO I =1, NSZF+1
          WRITE(36) INT4(XENV(I))
       ENDDO
       WRITE(36) INT4(-1)
       WRITE(36) INT4(ENVSZE)
       WRITE(36) INT4(-1)
*записываем только наличие записи в ячейке. Сама запись нас не волнует.
       DO COUNTER=1, ENVSZE
        IF(ENV(COUNTER).EQ.0.0) THEN
            WRITE(36) INT4(0)
        ENDIF
        IF(ENV(COUNTER).NE.0.0) THEN
            WRITE(36) INT4(1)
        ENDIF
       ENDDO
       WRITE(36) INT4(-1)
*---------Конец изменений от Насибуллина

C
C   ==============================================================
C      PEШEHИE CИCTEMЫ УPABHEHИЙ ПPOФИЛЬHЫM METOДOM
C   ==============================================================
C
       IF(IPR(26)) WRITE(6,990)
990    FORMAT(/,5X,'*****Start RCMSLV',/,
     > 10X,'(решение системы линейных уравнений)'/)
C ================================================================
       CALL RCMSLV (NSZF,XENV,ENV,DIAG,R,IERR,IPR)
       IF (IPR(26)) WRITE(6,1007)
1007   FORMAT(/,5X,'*****Finish RCMSLV')
C
*----------------Добавлено Насибуллиным Т.Р. 2011г.
*----- для модуля отображения заполненности множителя
*----- ВНИМАНИЕ! Работает в случае, если в подпрограмма RCMSLV не менялась,
*----- иначе нужно проверять корректность работы
       DO I =1, NSZF+1
          WRITE(36) INT4(XENV(I))
       ENDDO
       WRITE(36) INT4(-1)
       WRITE(36) INT4(ENVSZE)
       WRITE(36) INT4(-1)
*записываем только наличие записи в ячейке. Сама запись нас не волнует.
       DO COUNTER=1, ENVSZE
        IF(ENV(COUNTER).EQ.0.0) THEN
            WRITE(36) INT4(0)
        ENDIF
        IF(ENV(COUNTER).NE.0.0) THEN
            WRITE(36) INT4(1)
        ENDIF
       ENDDO
       WRITE(36) INT4(-1)
*--------Конец изменений от Насибуллина

       IF(IERR.NE.0) WRITE(6,10) IERR
10     FORMAT (//'PEШEHИE HE MOЖET БЫTЬ ПOЛУЧEHO, T. K.',
     >   ' MATPИЦA HE ПOЛOЖИTEЛЬHO OПPEДEЛEHA !!!  N = ',I5)
       IF(IPR(31)) WRITE(6,11) (I,(R((I-1)*NDF+J),
     >  J=1,NDF),I=1,NP)

C Записываем в файл 1 перемещения узлов.

       DO 668 I=1,NP
        X1 = R((I-1)*NDF+1)
        X2 = R((I-1)*NDF+2)

c исключение разделителя "-1" из возможных данных
       IF(X1.eq.-1) X1=X1+0.001
       IF(X2.eq.-1) X2=X2+0.001
c

        WRITE(33) X1,X2
668    CONTINUE
       WRITE(33) DBLE(-1)

  11   FORMAT (//' ПEPEMEЩEHИЯ УЗЛOB'/2(I5,2G12.4))
  12   FORMAT (//' CЧИTЫBAHИE ИCXOДHЫX
     > ДAHHЫX  ЗAKOHЧEHO  УCПEШHO')

C   ==============================================================
C            OПPEДEЛEHИE HAПPЯЖEHИЙ И ПEPEMEЩEHИЙ B УЗЛAX
C   ==============================================================

       IF(IPR(26)) WRITE(6,889)
889    FORMAT(/,5X,'*****Start STRSDD',/,
     > 10X,'(расчет напряжений)'/)
C ================================================================
       CALL STRSDD ( 3,NP,NE,NCN,NDF,DD,NOP,R,ESIGMA,IPR,BBB)
       IF(IPR(26)) WRITE(6,1008)
1008   FORMAT(/,5X,'*****Finish STRSDD')

c Записываем в файл 2 значения напряжений к КЭ.

       DO 669 I=1,NE
        X1 = ESIGMA(7*(I-1)+1)
        X2 = ESIGMA(7*(I-1)+2)
        X3 = ESIGMA(7*(I-1)+3)
        X4 = ESIGMA(7*(I-1)+4)
        X5 = ESIGMA(7*(I-1)+5)
        X6 = ESIGMA(7*(I-1)+6)
        X7 = ESIGMA(7*(I-1)+7)
c исключение разделителя "-1" из возможных данных
       IF(X1.eq.-1) X1=X1+0.001
       IF(X2.eq.-1) X2=X2+0.001
       IF(X3.eq.-1) X3=X3+0.001
       IF(X4.eq.-1) X4=X4+0.001
       IF(X5.eq.-1) X5=X5+0.001
       IF(X6.eq.-1) X6=X6+0.001
       IF(X7.eq.-1) X7=X7+0.001

        WRITE(34) X1,X2,X3,X4,X5,X6,X7
669    CONTINUE
       WRITE(34) DBLE(-1)
c Записываем свойства материалов
       DO 701 I=1,21
        X1 = ORT(I)

c исключение разделителя "-1" из возможных данных
       IF(X1.eq.-1) X1=X1+0.001
c

        WRITE(34) X1
701    CONTINUE
       WRITE(34) DBLE(-1)

       DO 700 I=1,NE
        J = IMAT(I)
c исключение разделителя "-1" из возможных данных
       IF(J.eq.-1) J=J+1
c
        WRITE(34) J
700    CONTINUE
       WRITE(34) INT2(-1)
        WRITE(6,188)
188     FORMAT(/,7X,'****good luck****')

* Дополнение от Давыдовой Ю.А. В файл RESULT2 записывается информация об исходном разбиении на зоны.
* Эта информация используется в графическом отображении результатов.
* записываем в файл 2 количество зон
       WRITE (34) INT2(INRG)
       WRITE (34) INT2(-1)
* а теперь записываем для каждой зоны координаты 8ми узлов
       DO I=1, INRG
         DO J=1,8
          X1=XP(NDD(J,I))
          X2=YP(NDD(J,I))
          IF(X1.eq.-1) X1=X1+0.001
          IF(X2.eq.-1) X2=X2+0.001
          WRITE(34)X1
          WRITE(34)X2
         ENDDO
       ENDDO
       WRITE (34) DBLE(-1)

C ================================================================
C подготовка набора данных для считывания программой Sigma Postproc
C и отображения результатов в 3D - графике.
C  Подпрограммы Grid, Sigmas, Delta, Materials, PDensity
C находятся в файле C_dgridd_DGRIDD.for
C ================================================================
       call Grid(CORD,NP,NOP,NE,'ExpGrd.poi')
       call Sigmas (ESIGMA,NE,'ExpGrd.poi')
       call Delta(R,NP,NDF,'ExpGrd.poi')
       call Materials(IMAT,NE,ORT,'ExpGrd.poi')
       call PDensity(Density,NE,'ExpGrd.poi')
C*********************************************
C*********************************************
C********                     ****************
C********  Экспорт в Nastran  ****************
C********                     ****************
C*********************************************
C*********************************************
       OPEN(35,FILE="Nastran.ns1")
       DO I=1,NE
       WRITE(35,442) I,IMAT(I),NOP(NCN*(I-1)+1),
     > NOP(NCN*(I-1)+2),NOP(NCN*(I-1)+3)
       ENDDO
442    FORMAT(' ',I4,'    ',I4,'    ',I4,
     > '    ',I4,'    ',I4)
       CLOSE(35)
C*********************************************

       CLOSE(33)
       CLOSE(36)
       CLOSE(34)
       STOP
       END
C ================ конец кода MAIN ===========================
C ============================================================
C конец файла MAIN.for
