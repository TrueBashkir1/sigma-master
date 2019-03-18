c   подпрограмма ExportGrid экспортирует геометрию
c   пластины в файл FileName
c      Vertices - содержит вершины
c      NumVertices - кол-во вершин
c      Indices - содержит треугольники
c      NumIndices - кол-во треугольников
c
      subroutine ExportGrid(Vertices,
     *                      NumVertices,
     *               Indices,NumIndices,FileName)
      character  FileName*512
      dimension Vertices(1),Indices(1)
      integer NumVertices,NumIndices
      real Xi,Yi
      data IO/13/
      !проверка имени файла
      if(Len(FileName) == 0)then
         return
      endif
      !открытие файла для записи
      open(UNIT = IO, FILE = FileName)
      write(IO,43)'EXPORT GRID'
      write(IO,44)NumVertices
      write(IO,45)NumIndices
      !пробегаем по всем вершинам и 
      !записываем их координаты в выходной файл
      do i=1,NumVertices
        Xi = Vertices(2*(i-1)+1)
        Yi = Vertices(2*(i-1)+2)
        write(IO,46)Xi,Yi
      enddo
      !пробегаем по треугольникам и
      !выводим индексы вершин
      do i=1,NumIndices 
        Ind1 = Indices(3*(i-1)+1)-1
        Ind2 = Indices(3*(i-1)+2)-1
        Ind3 = Indices(3*(i-1)+3)-1
         
        write(IO,47)Ind1,Ind2,Ind3
      enddo
      close(IO)
      return
   43 format (A11)  
   44 format (I5)
   45 format (I5) 
   46 format ('[',F8.4,',',F8.4,']')
   47 format ('[',I5,',',I5,',',I5,']')
      end
      

c   подпрограмма ExportDensity экспортирует геометрию
c   пластины в файл FileName
c      Vertices - содержит вершины
c      NumVertices - кол-во вершин
c      Indices - содержит треугольники
c      NumIndices - кол-во треугольников
c
      subroutine ExportDensity(Density,
     *                      NumVals,FileName)
      character  FileName*512
      dimension Density(1)
      data IO/66/
      if(Len(FileName) == 0)then
         return
      endif
      !открытие файла для записи
      open(UNIT = IO, FILE = FileName,
     *      POSITION='APPEND')
      write(IO,55)'DENSITY'
      write(IO,57)NumVals
      do i=1,NumVals 
        write(IO,*)Density(i)
      enddo
      
      close(IO)
      return
   55 format (A7)
c   56 format (F9.6)
   57 format (I5)
       
      end
      
c     подпрограмма ExportSigmas экспортирует значения напряжений
c     для всех КЭ
c     ESIGMA - содержит напряжения
c     NumElements - количество КЭ
c     FileName - имя файла
      subroutine ExportSigmas(ESIGMA,NumElements,
     *                        FileName)
      character  FileName*512
      dimension ESIGMA(1)
      data IO/66/
      if(Len(FileName) == 0)then
         return
      endif
      !открытие файла для записи
      open(UNIT = IO, FILE = FileName,
     *      POSITION='APPEND')
      write(IO,65)'SIGMAS '
      !экспорт напряжений
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
   65 format (A7)
   67 format ('[',F11.5,',',F11.5,',',F11.5,
     * ',',F11.5,',',F11.5,',',F11.5,',',F11.5,']')
      end 
      
c     подпрограмма ExportMaterials экспортирует толщины материалов
c     для всех КЭ
c     IMAT - массив характеристик материалов
c     NumElements - количество КЭ
c     ORT - массив характеристик материалов
c     FileName - имя файла     
      subroutine ExportMaterials(IMAT,NumElements,
     *                           ORT,FileName)
      
      character  FileName*512
      dimension IMAT(1),ORT(1)
      data IO/66/
      if(Len(FileName) == 0)then
         return
      endif
      !открытие файла для записи
      open(UNIT = IO, FILE = FileName,
     *      POSITION='APPEND')
      
      write(IO,75)'WIDTH  '
      
      do i=1,NumElements
        write(IO,*) ORT(7*IMAT(i))
      enddo
      
      close(IO)
      return
   75 format (A7)
      end