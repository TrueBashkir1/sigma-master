C Файл DGRIDD.for
C Содержит подпрограммы DGRIDD, Grid, Sigmas, Delta, Materials,  
C  PDensity - считывания исходных данных и подготовки 
C   результирующих данных
C ============================================================
C Подпрограмма DGRIDD осуществляет чтение файла с координатами  
C  узлов пластины. BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.      
C ============================================================
C ================== начало кода DGRIDD ======================
       subroutine DGRIDD(INRG,INBP,XP,YP,ZP,JT,NDD,NCN)
       DIMENSION XP(1),YP(1),ZP(1),JT(20,4),NDD(8,20)
       REAL N
       integer count,k
       DATA IN/5/,IO/6/,IP/6/,NBW/0/,NB/0/,NEL/0/
       DATA PI/3.1415926/
            Do I=1,40
                  XP(I)=0
                  YP(I)=0
            EndDo
             Do I=1,4
                 Do J=1,3
                     JT(J,I)=0  
                 EndDo
             EndDo
           count=(NCN-1)*4
           open(55,file='form_xy')
           read(55,*,err=666) INRG
           read(55,*,err=666) INBP
             Do i=1,INRG
                 Do j=1,count
                     read(55,*,err=666) NDD(j,i)
                      k=NDD(j,i)
                      read(55,*,err=666) XP(k)
                      read(55,*,err=666) YP(k)
                 EndDo
             EndDo
             Do i=1,INRG
               Do j=1,4
                  read(55,*,err=666) JT(i,j)
               EndDo
             EndDo
              goto 333
 666           write(6,*)'Error: Файл в DGRIDD не дочитан до конца.'
 333           close(55)
        RETURN
        END
C =============== конец кода DGRIDD  ===========================
C ============================================================
C  Далее cодержатся программы   Grid,  PDensity, Sigmas, 
C  Materials, Delta, формирующие данные  для считывания программой 
C  Sigma Postproc и отображения результатов в 3D - графике.
C ============================================================
C   подпрограмма Grid экспортирует геометрию
C   пластины в файл FileName
C     Vertices - содержит вершины
C     NumVertices - кол-во вершин
C      Indices - содержит треугольники
C      NumIndices - кол-во треугольников
C     BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.  
C ============================================================
C ============  начало кода  Grid ======================
       subroutine Grid(Vertices,
     > NumVertices,Indices,NumIndices,FileName)
                  
        character  FileName*512
       dimension Vertices(1),Indices(1)
       integer NumVertices,NumIndices
       real Xi,Yi
       data IO/13/
C      проверка имени файла
       if(Len(FileName) == 0)then
         return
       endif
C      открытие файла для записи
       open(UNIT = IO, FILE = FileName)
       write(IO,43)'EXPORT GRID'
       write(IO,44)NumVertices
       write(IO,45)NumIndices
C      пробегаем по всем вершинам и 
C      записываем их координаты в выходной файл
       do i=1,NumVertices
        Xi = Vertices(2*(i-1)+1)
        Yi = Vertices(2*(i-1)+2)
        write(IO,46)Xi,Yi
       enddo
C     пробегаем по треугольникам и
C      выводим индексы вершин
       do i=1,NumIndices 
        Ind1 = Indices(3*(i-1)+1)-1
        Ind2 = Indices(3*(i-1)+2)-1
        Ind3 = Indices(3*(i-1)+3)-1
         
        write(IO,47)Ind1,Ind2,Ind3
       enddo
       close(IO)
       return
43     format (A11)  
44     format (I5)
45     format (I5) 
46     format ('[',F8.4,',',F8.4,']')
47     format ('[',I5,',',I5,',',I5,']')
       end
C ============  конец кода  Grid ======================      
C ============================================================
C  подпрограмма PDensity экспортирует значения функции плотности  для 
C   каждого КЭ пластины в файл FileName
C      Vertices - содержит вершины
C      NumVertices - кол-во вершин
C      Indices - содержит треугольники
C      NumIndices - кол-во треугольников
C     BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.    
C ============  начало кода  PDensity ====================
       subroutine PDensity(Density,
     >            NumVals,FileName)
       character  FileName*512
       dimension Density(1)
       data IO/66/
       if(Len(FileName) == 0)then
         return
       endif
C     открытие файла для записи
       open(UNIT = IO, FILE = FileName,
     >      POSITION='APPEND')
       write(IO,55)'DENSITY'
C       write(IO,57)NumVals
       do i=1,NumVals 
        write(IO,*)Density(i)
       enddo
      
       close(IO)
       return
55     format (A7)
C   56 format (F9.6)
57     format (I5)
       end
C ============  конец кода  PDensity ==================== 
C  ============================================================     
C     подпрограмма Sigmas экспортирует значения напряжений
C     для всех КЭ
C     ESIGMA - содержит напряжения
C     NumElements - количество КЭ
C     FileName - имя файла
C     BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.  
C ============  начало  кода  Sigmas ==================== 
       subroutine Sigmas(ESIGMA,NumElements,
     >                      FileName)
       character  FileName*512
       dimension ESIGMA(1)
       data IO/66/
       if(Len(FileName) == 0)then
         return
       endif
C      открытие файла для записи
       open(UNIT = IO, FILE = FileName,
     >      POSITION='APPEND')
       write(IO,65)'SIGMAS '
C          экспорт напряжений
       do i=1,NumElements
        X1 = ESIGMA(7*(I-1)+1)
        X2 = ESIGMA(7*(I-1)+2)
        X3 = ESIGMA(7*(I-1)+3)
        X4 = ESIGMA(7*(I-1)+4)
        X5 = ESIGMA(7*(I-1)+5)
        X6 = ESIGMA(7*(I-1)+6)
        X7 = ESIGMA(7*(I-1)+7) 
        
        IF(X1.eq.-1) X1=X1+0.001
        IF(X2.eq.-1) X2=X2+0.001
        IF(X3.eq.-1) X3=X3+0.001
        IF(X4.eq.-1) X4=X4+0.001
        IF(X5.eq.-1) X5=X5+0.001
        IF(X6.eq.-1) X6=X6+0.001
        IF(X7.eq.-1) X7=X7+0.001
        
        write(IO,67) X1,X2,X3,X4,X5,X6,X7
       enddo
       close(IO)
       return
65     format (A7)
67     format ('[',F11.5,',',F11.5,',',F11.5,
     > ',',F11.5,',',F11.5,',',F11.5,',',F11.5,']')
       end 
C ============  конец кода  Sigmas ==================== 
C ==============================================================      
C     подпрограмма Materials экспортирует толщины материалов
C     для всех КЭ
C     IMAT - массив характеристик материалов
C     NumElements - количество КЭ
C     ORT - массив характеристик материалов
C     FileName - имя файла
C     BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.  
C ============  начало  кода  Materials ====================      
       subroutine Materials(IMAT,NumElements,
     >                           ORT,FileName)
      
       character  FileName*512
       dimension IMAT(1),ORT(1)
       data IO/66/
       if(Len(FileName) == 0)then
         return
       endif
C      открытие файла для записи
       open(UNIT = IO, FILE = FileName,
     >      POSITION='APPEND')
      
       write(IO,75)'WIDTH  '
      
       do i=1,NumElements
        write(IO,*) ORT(7*IMAT(i))
       enddo
      
       close(IO)
       return
75      format (A7)
       end
C ============  конец  кода  Materials ====================
C ===============================================================        
C    подпрограмма Delta экспортирует значения перемещений
C     для всех узлов
C     R - содержит перемещения
C     NumVertices - количество узлов
C     FileName - имя файла
C     BЫЗЫBAETCЯ ИЗ MAIN , BЫЗЫBAEMЫX MOДУЛEЙ HET.  
C ============  начало  кода  Delta ==================== 
       subroutine Delta(R,NumVertices,NDF,
     >                        FileName)
       character  FileName*512
       dimension R(1)
       data IO/66/
       if(Len(FileName) == 0)then
         return
       endif
C      открытие файла для записи
       open(UNIT = IO, FILE = FileName,
     >      POSITION='APPEND')
       write(IO,85)'DELTAS '
C         экспорт напряжений
       do i=1,NumVertices
        X1 = R((i-1)*NDF+1)
        X2 = R((i-1)*NDF+2)

        if(X1.eq.-1) X1=X1+0.001
        if(X2.eq.-1) X2=X2+0.001
        
        write(IO,87) X1,X2
       enddo
       close(IO)
       return
85     format (A7)
87      format ('[',F11.5,',',F11.5,']')
       end
C ============  конец  кода  Delta ====================
C =========================================================== 
C Конец файла DGRIDD.for