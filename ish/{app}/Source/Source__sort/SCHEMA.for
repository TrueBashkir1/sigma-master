C Файл SCHEMA.for
C Содержит подпрограмму SCHEMA
C ===================================================================
C Подпрограмма производит преобразование модифицированной профильной схемы хранения
C в классическую схему хранения
C Входные данные:
C Матрица упакованная в модифицированную профильную схему
C DIAG – массив хранящий значения диагональных элементов матрицы
C ЕNV – массив хранящий недиагональные элементы профиля
C XENV – индексный вектор
C SIZ – размер матрицы
C ===================================================================
C ================ начало кода TRANSFORMATION =================================
C ===================================================================

      subroutine SCHEMA (DIAG, ENV, XENV, SIZ)

      REAL LN2, LNZ3, DIAG3, tmp1, tmp2
      INTEGER XENV1
      INTEGER XENV, CIP2, RI2, NZ3, NZSUB3, XNZSUB3, XL2, NZ2, PD,XLNZ3
      DIMENSION DIAG(1),ENV(1),XENV(1)
      DIMENSION TMP(100000)
      DIMENSION SCHEMA1(10000)
      DIMENSION VE2(10000),RI2(10000),CIP2(10000)
      DIMENSION VE3(10000),LD3(10000)
      DIMENSION VE(10000), PD(10000)
      DIMENSION BAND(10000,10000)
      DIMENSION DIAG2(10000),NZ2(10000),LN2(10000),XL2(10000)
      DIMENSION DIAG3(10000),LNZ3(10000),XLNZ3(10000),NZSUB3(10000)
      DIMENSION XNZSUB3(10000),NZ3(10000)
      DIMENSION DIAG1(10000), ENV1(10000), XENV1(10000)
      INTEGER k,l,m,n,BANDSIZ
      INTEGER SIZ
      INTEGER row_number, col_number
      INTEGER nzsubsize, xnzsubsize,iln,nullInVe
C Представления:
C Массив TMP - для представления матрицы в виде длинной строки
C Массив SCHEMA1 - для представления матрицы в виде Схемы 1
C Массивы VE2, RI2, CIP2 - для представления матрицы в виде Схемы 2
C Массивы VE3 и LD3 - для представления матрицы в виде Схемы 3
C Массивы DIAG3, XLNZ3, NZSUB3, XNZSUB3, LNZ3 - для представления в виде компактной схемы. NZ3 - вспомогательный массив для построения компактной схемы (используется аналогично массиву NZ2 в обычной схеме)
C Массивы DIAG2, NZ2, LN2, XL2 - для представления в виде обычной схемы
C Массив BAND для представления в виде диагональной схемы. BANDSIZ - вспомогательная переменная для оценки размера профиля
C Массивы VE и PD - для представления профильной схемы


C Заполняем матрицу нулями
      do i= 1, SIZ
      do j= 1, SIZ
      TMP((i-1)*SIZ+j)=0
      enddo
      enddo

C Заполняем диагональные элементы
      do i = 1, SIZ
      TMP((i-1)*SIZ+i)=DIAG(i)
      enddo

C Восстанавливаем профиль по XENV и ENV
      do i= 1,SIZ
      J1 = XENV(I)
      J2=XENV(I+1)-1
      IF(J2.GE.J1) then
      do j= J1,J2
      TMP((i-1)*SIZ + i - J2+j-1) = ENV(j)
      enddo
      endif
      enddo

C Далее идет преобразование к схеме хранения 1
      k=1;
      do col_number = 1, SIZ
      SCHEMA1(k)=0
      k=k+1
      SCHEMA1(k) = col_number
      k=k+1
        do row_number = 1, SIZ
          if (abs(TMP((row_number-1)*SIZ+col_number)).gt.0) then
            SCHEMA1(k) = row_number
            k=k+1
            SCHEMA1(k) = TMP((row_number-1)*SIZ+col_number)
            k=k+1
          endif
        enddo
      enddo
      SCHEMA1(k)=0
      k=k+1
      SCHEMA1(k)=0

C Вывод в файл
      WRITE(6,*)
      WRITE(6,110)
110   FORMAT ("******Схема хранения 1*****")
      WRITE(6,*) "Затраты памяти = ", k
      WRITE(6,*) "Число ненулевых элементов = ", (k/2)-1-SIZ

C Далее идет преобразование к схеме 2
      k=1
      do col_number = 1, SIZ
      CIP2(col_number)=k
      do row_number = 1, SIZ
      if (abs(TMP((row_number-1)*SIZ + col_number)).gt.0.0005) then
      VE2(k) = TMP((row_number-1)*SIZ + col_number)
      RI2(k) = row_number
      k=k+1
      endif
      enddo
      enddo
      k=k-1

C Далее идет вывод матрицы в виде схемы 2
      WRITE(6,*)
      WRITE(6,210)
210   FORMAT ("******Схема хранения 2*****")
      WRITE(6,*) "Общие затраты памяти = ", SIZ+k*2
      WRITE(6,*) "Затраты памяти на массив VE = ", k
      WRITE(6,*) "Затраты памяти на массив RI = ", k
      WRITE(6,*) "Затраты памяти на массив CIP = ", SIZ

C Далее идет преобразование к схеме 3
      k=1
      do col_number = 1,SIZ
        do row_number = 1,SIZ
        if (abs(TMP((row_number-1)*SIZ + col_number)).gt.0.0005)then
          VE3(k)=TMP((row_number-1)*SIZ + col_number)
          LD3(k)= row_number + (col_number-1)*SIZ
          k=k+1
        endif
      enddo
      enddo
      k=k-1
C Вывод в файл
      WRITE(6,*)
      WRITE(6,310)
310   FORMAT ("******Схема хранения 3*****")
      WRITE(6,*) "Общие затраты памяти = ", k*2
      WRITE(6,*) "Затраты памяти на массив VE = ", k
      WRITE(6,*) "Затраты памяти на массив LD = ", k

C Далее идет преобразование в компактную схему
      k=1
      do col_number=1,SIZ
      XLNZ3(col_number)=k
      l=0
      do row_number=col_number,SIZ
      if(col_number.eq.row_number) then
      DIAG3(col_number)=TMP((col_number-1)*SIZ +row_number)
      else if (abs(TMP((col_number-1)*SIZ + row_number))
     &.gt.0.005) then
      LNZ3(k)=TMP((col_number-1)*SIZ + row_number)
      NZ3(k)=row_number
      k=k+1
      l=1
      endif
      enddo
      if (l.eq.0) then
      LNZ3(k)=0
      NZ3(k)=NZ3(k-1)
      k=k+1
      endif
      enddo
      k=k-2

      XNZSUB3(1) = 1
      nzsubsize=k-1
      do i=1,k
        NZSUB3(i)=NZ3(i)
      enddo
      m=1
      do i = 1, SIZ
        l=0
        do j=i,SIZ
          if (j.gt.i+1) then
            tmp1=TMP((j)*SIZ + i)
            tmp2=TMP((j)*SIZ + i+1)
          else
            tmp1=0
            tmp2=0
          endif
          if ((tmp1.gt.0.005).and.(tmp2.gt.0.005)) then
          else if ((tmp1.lt.0.005).and.(tmp2.lt.0.005)) then
          else
            l=1
          endif
        enddo
        if (l.eq.1)then
          XNZSUB3(m)=XLNZ3(i)
          m=m+1
        else
          if (m.gt.1) then
            XNZSUB3(m)=XNZSUB3(m-1)
          endif
          m=m+1
          do n=1,k-XLNZ3(j)
            NZSUB3(n)=NZSUB3(n+1)
          enddo
          if (XLNZ3(i+1).ne.0) then
            nzsubsize=nzsubsize-(XLNZ3(i+1)-XLNZ3(i))
          endif
        endif
      enddo
      k=k-1
        i=nzsubsize+(SIZ*3)+(k*2)

C Вывод в файл
      WRITE(6,410)
410   FORMAT ("******Компактная схема хранения*****")
      WRITE(6,*) "NOT DONE"
      WRITE(6,*) "Затраты памяти = ", i
      WRITE(6,*)

C Далее идет преобразование в обычную схему
      k=1
      iln=0 ! Число ненулевых элементов массива LN
      do col_number=1,SIZ
        XL2(col_number)=k
        l=0
        do row_number=col_number,SIZ
          if(col_number.eq.row_number) then
            DIAG2(col_number)=TMP((row_number-1)*SIZ + col_number)
      else if (ABS(TMP((row_number-1)*SIZ + col_number)).gt.0.005)then
        LN2(k)=TMP((row_number-1)*SIZ + col_number)
        iln=iln+1
        NZ2(k)=row_number
        k=k+1
        l=1
      endif
      enddo

      if (l.eq.0) then
        LN2(k)=0
        NZ2(k) = NZ2(k-1)
        k=k+1
      endif
      enddo
      k=k-1
C Вывод в файл
      WRITE(6,*)
      WRITE(6,510)
510   FORMAT ("******Обычная схема хранения*****")
      WRITE(6,*) "Затраты памяти = ", (k-1)+k + SIZ*2
      WRITE(6,*) "Размер массива DIAG = ", SIZ
      WRITE(6,*) "Число ненулевых элементов массива LN = ", iln

C Далее идет преобразование в профильную схему
      k=1
      nullInVe = 0
      do row_number = 1,SIZ
        do col_number= 1,row_number
          if (((abs(TMP((row_number-1)*SIZ + col_number)).gt.0.005))
     &.and.(col_number.ne.row_number)) then
       VE(k)=TMP((row_number-1)*SIZ + col_number)
       k=k+1
       do l = col_number+1, row_number
         VE(k)=TMP((row_number-1)*SIZ + l)
         if(ABS(VE(k)).LT.0.005) nullInVe = nullInVe +1
         k=k+1
       enddo
       PD(row_number)=k-1
       goto 131
      else if (col_number.eq.row_number) then
        VE(k) = TMP((row_number-1)*SIZ + col_number)
        PD(row_number)=k
        k=k+1
      else
      endif
      enddo
131   enddo
      k=k-1
C Вывод в файл
      WRITE(6,*)
      WRITE(6,610)
610   FORMAT ("******Профильная схема хранения*****")
      WRITE(6,*) "Размер VE =", k
      WRITE(6,*) "Число ненулевых элементов в массиве VE =",k-nullInVe
      WRITE(6,*) "Размер PD =", SIZ
      WRITE(6,*) "Затраты памяти = ", k + SIZ

C Далее идет преобразование в диагональную схему
      k=1
      BANDSIZ = 1;
      iln=0
      DO row_number=2, SIZ
        DO col_number=1, row_number
          if(( TMP((row_number-1)*SIZ + col_number).ne.0)
     &.and.(BANDSIZ.le.(row_number-col_number))) then
      BANDSIZ = row_number-col_number
      endif
      ENDDO
      ENDDO
      do row_number=1,SIZ
        do col_number=1,BANDSIZ+1
          BAND(col_number,row_number) =
     &TMP((row_number-1)*SIZ + row_number-BANDSIZ+col_number-1)
      if((row_number-1)*SIZ + row_number-BANDSIZ+col_number-1.lt.0)
     & BAND(col_number,row_number) = 0
      if(abs(BAND(col_number,row_number)).lt.0.005) then
        iln=iln+1
      endif
      enddo
      enddo
C Вывод в файл
      WRITE(6,*)
      WRITE(6,710)
710   FORMAT ("******Диагональная схема хранения*****")
      WRITE(6,*) "Затраты памяти = ", SIZ*(BANDSIZ+1)
      WRITE(6,*) "Ширина ленты = ", BANDSIZ
      WRITE(6,*) "Число ненулевых элементов  = ", SIZ*(BANDSIZ+1)-iln

C Далее идет преобразование в модифицированную профильную схему
      do row_number=1,SIZ
        DIAG1(row_number) = TMP((row_number-1)*SIZ + row_number)
      enddo
      iln=0;
      k=1
      XENV1(1)=1
      do row_number = 1, SIZ
        XENV1(row_number)=k
        do col_number = 1, row_number
          if ((abs(TMP((row_number-1)*SIZ + col_number)).gt.0.005)
     &.and.(col_number.ne.row_number)) then
      do l = col_number,row_number-1
        ENV1(k)=TMP((row_number-1)*SIZ + l)
        if(abs(ENV1(k)).lt.0.005) iln = iln+1
        k=k+1
      enddo
      goto 153
      endif
      enddo
153    enddo
      XENV1(SIZ+1)=k
      k=k-1

C Вывод в файл
      WRITE(6,*)
      WRITE(6,810)
810   FORMAT ("******Модифицированная профильная схема хранения*****")
      WRITE(6,*) "Число ненулевых элементов ENV = ",k-iln
      WRITE(6,*) "Размер ENV =", k
      WRITE(6,*) "Размер XENV =", SIZ+1
      WRITE(6,*) "Общие затраты памяти = ",SIZ*2+k+1

      RETURN
      END
