C Файл DATA.for
C Содержит подпрограмму DATA
C ===================================================================
C          ПОДПPOГPAMMA DATA BBOДA ИCXOДHЫX ДAHHЫX                
C  Считывает данные по модели из файла DATA и флаг подключения 
C  подпрограммы REGULARIZATION оптимизации сетки конечных элементов
C          BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.          
C ===================================================================
C ===================== начало кода DATA =============================
       subroutine DATA (NFP,IPR,ORT,NMAT,NCN,NDF,NRC,DD,DB,DH,
     >PRM1,PRM2,PRM3,PRM4,PRM5,PRM6,FL)
C
       DIMENSION TITLE(20),ORT(1),IMAT(1) 
C   
       INTEGER FL
C      INTEGER   XADJ,ADJNCY,PERM,GoFL
      INTEGER*2 YES,COM,JPR,FORM(40),END
      LOGICAL*1 IPR(50)
      DATA YES/' Y'/,COM/'* '/,END/' E'/
C  ПPEДBAPИTEЛЬHO B MAIN ДOЛЖHЫ БЫTЬ ИHИЦИAЛИЗИPOBAHЫ
C       R/2000*0.0/, IPR/50*.FALSE./, 
C  BBOД MACCИBA ПEЧATИ  IPMAX - MAX KOЛИЧECTBO EГO ЭЛEMEHTOB
      IPMAX=50
      I=1
      OPEN(10,FILE='printit.npf')    
65     READ(10,11,END=66) JPR
       IF(JPR.EQ.COM) GO TO 65
       IF(JPR.EQ.YES) IPR(I)=.TRUE.
       IF(JPR.EQ.END) GO TO 66
       IF(I.GE. IPMAX) GO TO 66
       I=I+1
       GO TO  65
66    CONTINUE

C *****CЧИTЫBAHИE ДAHHЫX ПO KOHCTPУKЦИИ ИЗ ФAЙЛA DATA****
        READ(5,7,ERR=55)TITLE
C       WRITE(6,100)TITLE 
c-------------------------------------      
c      Мусолов 30.12.2006
c      Считываем флаг оптимизации сетки конечных элементов
       read (5,124,err=55) FL
124    format (I3)
c-------------------------------------   
       READ(5,77,err=55) NTIP,NVAR,NRC,DB,DH,PRM6
77     FORMAT(3(I3/),2(F7.2/),F9.0)
       READ(5,8,ERR=55)ort(7),PRM5,PRM4,nld,ndf,ncn,nmat
     > ,ort(1),ort(2),ort(3),TIN
     > ,ort(8),ort(9),ort(10),ort(14)
     > ,ort(15),ort(16),ort(17),ort(21)
     > ,PRM1,PRM2,PRM3
c-перспектива---,PRM4,PRM5
8      FORMAT(3(F10.7/),4(I3/),12(F10.7/),3(F10.7/))
C     > F7.0/,F7.0/,F7.0/,F7.0/,
C     > F7.0/,F7.0/,F7.0/,F7.0/,
C     > F7.0/,F7.0/,F7.0/,F7.0/,
C     > F9.0/,F9.0/,F9.0)
c-перспектива---/F7.0/F7.0)
C        Print*,TIN
      IF(IPR(1))WRITE(6,10) NTIP,NVAR,NRC,DB,DH,PRM1,
     >PRM2,PRM3, PRM4,PRM5,PRM6,NMAT
7      FORMAT(20A4)
11     FORMAT   (A2) 
10     FORMAT(3X,'TИП ЗАДАЧИ=',I2,2X,'BAPИAHT =',I3,
     > 2X,'ПAPAMETP PAЗБИEHИЯ NRC=',I2 /
     > 8X, ' ШИPИHA(DB) =',F7.2,2X,' BЫCOTA(DH) =',F7.2/
     >/ 17X,'СВОБОДНЫЕ ПАРАМЕТРЫ'/
     > 3X,'PRM1=',F11.4,5X,'PRM2 =',F11.4,5X,'PRM3 =',F11.4/
     > 3X,'PRM4=',F11.4,5X,'PRM5 =',F11.4,5X,'PRM6 =',F11.4/
     > /17X, ' ЧИСЛО СВОЙСТВ КЭ = ',I2 )
C
100    FORMAT(1H1,20A4)
C      ort(5)=0.0
C      ort(6)=0.0
C      ort(7)=DD
      
      IF(IPR(1))then
       IK=-6
      DO 16 KK=1, NMAT
      IK=IK+7
16     WRITE(6,144) KK, ORT(IK),ORT(IK+1),ORT(IK+2),ORT(IK+6)
       endif
144   FORMAT(2X,'CBOЙCTBО:',I3,2X,'MOДУЛЬ E =',F9.0,2X,'MЮ =',F4.2/
     >16X,'ДОПУСКАЕМОЕ НАПРЯЖЕНИЕ SB =',F6.0,2X,'ТОЛЩИНА =',F4.2)
       IF(IPR(26).AND.FL.EQ.1) write(6,176)
176    FORMAT(/11X,'СООБЩЕНИЕ:',/,11X,'оптимизация сетки ВКЛЮЧЕНА',/) 
       IF(IPR(26).AND.FL.EQ.0) write(6,177)
177    FORMAT(/11X,'СООБЩЕНИЕ:',/,11X,'оптимизация сетки ОТКЛЮЧЕНА',/) 
C       IF(IPR(26))write(6,17) FL 
C17     FORMAT(/6X,'ОПТИМИЗАЦИЯ СЕТКИ (ВКЛЮЧЕНА-1,ВЫКЛЮЧЕНА-0)=',I3/)  
C*********************************************
C*********************************************
C********                     ****************
C********  Экспорт в Nastran  ****************
C********                     ****************
C*********************************************
C*********************************************
      OPEN(36,FILE="Nastran.ns0")        
C материал 1
      WRITE(36,601) ORT(1)
      WRITE(36,602) ORT(2)
      WRITE(36,603) ORT(3)
      WRITE(36,604) ORT(7)
C материал 2
      if (nmat.ge.2) then
      WRITE(36,601) ORT(8)
      WRITE(36,602) ORT(9)
      WRITE(36,603) ORT(10)
      WRITE(36,604) ORT(14)
      endif
C материал 3
      if (nmat.ge.3) then
      WRITE(36,601) ORT(15)
      WRITE(36,602) ORT(16)
      WRITE(36,603) ORT(17)
      WRITE(36,604) ORT(21)
      endif  
C Модуль E
601   FORMAT(F8.0)
C МЮ
602   FORMAT(F3.2)
C SB
603   FORMAT(F7.0)
C ТОЛЩИНА
604   FORMAT(F5.2)
      CLOSE(36)
C*****************************************
C************ КОНЕЦ **********************
C*****************************************

      RETURN
55    WRITE(6,155)
155   FORMAT(' OШИБKA B ИCXOДHЫX ДAHHЫX ')
      STOP
C     DEBUG UNIT(9),INIT(IPR,JPR),SUBTRACE
      END
C ===================================================================
C ======================== конец кода DATA  ============================
C ===================================================================
C Конец файла DATA.for