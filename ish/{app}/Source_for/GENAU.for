C=============================================================================
C  файл GENAU.for
C  Содержит подпрограммы GENAU, FIND_BETTA, FIND_NEW_BETTA,COUNT_NUM,CHANGE
C  Вызывается из модуля RENMDD 
C             Парамонов М.В. - 2012 -      
c-----------------------------------------------------------------------------
c       Алгоритм Эйкиуза и Утку (ленточный метод определение вектора перестановки узлов графа)
C-----------------------------------------------------------------------------        
C  Входные данные:
C          NP - количество узлов
C          XADJ, ADJNCY - структура смежности графа
C  Выходные данные:
C           Perm - вектор перестановки  
C-----------------------------------------------------------------------------
C-----------------------------------------------------------------------------
        SUBROUTINE GENAU(NP,XADJ,ADJNCY,PERM)
        INTEGER NP,ADJNCY(1),XADJ(1),PERM(1)
        INTEGER ADJLST(NP,NP-1),COUNT(NP),QLST(NP)
        INTEGER BETTA,COUNT_LE,COUNT_EQ,COUNT_EQ_N
C-----------------------------------------------------------------------------
C       создаем исходный вектор перестановок        
        DO I=1,NP
           PERM(I)=I
        ENDDO        
c       Заполняем список смежности вершин                
        DO I=1,NP
           N=0       !ТАК КАК ГРАФ СВЯЗНЫЙ, ТО У ВЕРШИНЫ КАК МИНИМУМ 2 СМЕЖНЫХ
           DO J=XADJ(I),XADJ(I+1)-1
              ADJLST(I,N+1)=ADJNCY(J)
              N=N+1
           ENDDO
           COUNT(I)=N !заполняем список ширины ленты по строкам
           IF(ADJLST(I,1).LT.I)THEN
              QLST(I)=I-ADJLST(I,1)
           ELSE 
              QLST(I)=0
           ENDIF 
        ENDDO 
C-----------------------------------------------------------------------------        
50      COUNT_LE=0    ! кол-во перестановок для уменьшения средней ширины
        COUNT_EQ=0    ! кол-во перестановок при сохранении средней ширины
        BETTA=FIND_BETTA(NP,QLST)  !текущая средняя ширина 
100     J=1
        K=NP
        FLAG=0   ! флаг для обхода матрицы с краев к середине  
C-----------------------------------------------------------------------------               
        DO 200 I=1,NP-1
           IF(FLAG.EQ.0) THEN ! проход с верхней строки
           !подпрограмма определения возможности престановки текущих строк
               CALL CHANGE(NP,ADJLST,COUNT,QLST,J,J+1,
     >                           BETTA,COUNT_LE,COUNT_EQ,PERM)                                  
               J=J+1
               FLAG=1     !меняем флаг для смены направления обхода
               GOTO 200
           ENDIF
           IF(FLAG.EQ.1) THEN  ! проход с нижней строки            
           !подпрограмма определения возможности престановки текущих строк
               CALL CHANGE(NP,ADJLST,COUNT,QLST,K,K-1,
     >                           BETTA,COUNT_LE,COUNT_EQ,PERM)                                      
               K=K-1
               FLAG=0       !меняем флаг для смены направления обхода
               GOTO 200
           ENDIF
200     CONTINUE  
C-----------------------------------------------------------------------------
        IF(COUNT_LE.EQ.0) THEN  !если есть перестановки для уменьш. ср. ширины
           IF (COUNT_EQ.EQ.0) GOTO 300  !есть ли перест. при сохранении
           COUNT_EQ_N=COUNT_EQ_N+1
           ! проверка на кол-во циклов не уменьшающих ср. ширину
           IF (COUNT_EQ_N.GT.INT(3+NP/100)) GOTO 300
           GOTO 50  ! к сл. проходу
        ENDIF
        COUNT_EQ_N=0
        GOTO  50  ! к сл. проходу
300     RETURN
        END
C-----------------------------------------------------------------------------
C-----------------------------------------------------------------------------        
C     Подпрограмма перестановки строк        
        SUBROUTINE CHANGE(NP,ADJLST,COUNT,QLST,
     >                        X1,X2,BETTA,COUNT_LE,COUNT_EQ,PERM)
        INTEGER NP,ADJLST(NP,NP-1),COUNT(NP),QLST(NP),X1,X2,BETTA
        INTEGER COUNT_LE,COUNT_EQ,PERM(NP),TEMP
        ! поменяем строки и столбцы местами
        CALL FIND_NEW_BETTA (NP,QLST,ADJLST,COUNT,X1,X2)
        ! если новая ср. ширины больше старой 
        IF (FIND_BETTA(NP,QLST).GT.BETTA) THEN
           ! тогда поменяем строки и столбцы обратно
           CALL FIND_NEW_BETTA (NP,QLST,ADJLST,COUNT,X1,X2)            
           RETURN   
        ENDIF
        ! если новая ср. ширина меньше старой
        IF (FIND_BETTA(NP,QLST).LT.BETTA) THEN
           ! тогда меняем текущую ср. ширину на новую
           BETTA=FIND_BETTA(NP,QLST)
           ! увеличим счетчик перестановок для уменьшения ср. ширины
           COUNT_LE=COUNT_LE+1
           ! меняем узлы в векторе перестановок
           TEMP=PERM(X1)
           PERM(X1)=PERM(X2)
           PERM(X2)=TEMP
           RETURN
        ENDIF
         ! если строка с меньши кол-вом едицин стоит ближе к центральной
        IF (COUNT_NUM(NP,ADJLST,COUNT,X1).GE.
     >            COUNT_NUM(NP,ADJLST,COUNT,X2))THEN     
            !переставим обратно       
           CALL FIND_NEW_BETTA (NP,QLST,ADJLST,COUNT,X1,X2)
           RETURN 
        ENDIF
        ! иначе строка с меньшим кол-вом единиц стоит дальше от центральной
        BETTA=FIND_BETTA(NP,QLST)
        ! увеличим счетчик коло-ва перестановок неуменьшающих ср. ширину
        COUNT_EQ=COUNT_EQ+1
        ! запомним перестановку в векторе престановок
        TEMP=PERM(X1)
        PERM(X1)=PERM(X2)
        PERM(X2)=TEMP
        RETURN 
        END
C-----------------------------------------------------------------------------        
C-----------------------------------------------------------------------------
C       Функция нахождения средней ширины ленты матрицы
        FUNCTION FIND_BETTA(NP,QLST)
        INTEGER NP,QLST(NP)        
        FIND_BETTA=0
        DO I=1,NP
           FIND_BETTA=FIND_BETTA+QLST(I)   
        ENDDO     
        RETURN
        END 
C-----------------------------------------------------------------------------
C-----------------------------------------------------------------------------
C       Подпрограмма перестановки строк и изменения структуры смежности
        SUBROUTINE FIND_NEW_BETTA (NP,QLST,ADJLST,COUNT,X1,X2)
        INTEGER NP,QLST(NP),ADJLST(NP,NP-1),COUNT(NP),X1,X2       
         ! меняем структуру смежности
        CALL CHANGEADJLST(ADJLST,NP,COUNT,X1,X2)
         ! меняем структуры вектора ширины ленты
        DO I=1,NP
           IF(ADJLST(I,1).LT.I)THEN
              QLST(I)=I-ADJLST(I,1)
           ELSE 
              QLST(I)=0
           ENDIF 
        ENDDO   
        RETURN
        END
C-----------------------------------------------------------------------------
C-----------------------------------------------------------------------------        
C       Подпрограмма подсчета кол-ва единиц в ленте       
        FUNCTION COUNT_NUM(NP,ADJLST,COUNT,N)
        INTEGER NP,ADJLST(NP,NP-1),COUNT(NP),N
        COUNT_NUM=0
        DO I=1,COUNT(N)
           IF (ADJLST(N,I).GE.N) RETURN 
           COUNT_NUM=COUNT_NUM+1       
        ENDDO       
        RETURN 
        END 
C-----------------------------------------------------------------------------
C==============================================================================
C  конец файла GENAU.for 