C=============================================================================
C  файл GENRZN.for
C  Содержит подпрограммы GENRZN, CHANGEADJLST, SORT
C  Вызывается из модуля RENMDD  
C             Парамонов М.В. - 2012 -      
c-----------------------------------------------------------------------------
c       Алгоритм Розена  (ленточный мкетодопределение вектора перестановки узлов графа)
C-----------------------------------------------------------------------------        
C  Входные данные:
C          NP - количество узлов
C          XADJ, ADJNCY - структура смежности графа
C  Выходные данные:
C           Perm - вектор перестановки  
C-----------------------------------------------------------------------------      
        SUBROUTINE GENRZN(NP,XADJ,ADJNCY,PERM) 
        INTEGER NP,XADJ(1),ADJNCY(1),PERM(1)
        INTEGER I,J,ADJLST(NP,NP-1),COUNT(NP),PMAX,PMIN,TOSWAP,TRY ,BETTA
C-----------------------------------------------------------------------------
C      COUNT(i) - хранит число смежных вершин для i-того узла
C      ADJLST(i,j) - массив хранящий смежные узлы, для i-того узла смежные ADJLST(i,j),j=1,СOUNT(i)        
C      PMAX - узел с большим номером из пары узлов приводящих к максимальной ширине ленты
C      PMIN - узел с меньшим номером из пары узлов приводящих к максимальной ширине ленты        
C      TOSWAP - выбранный номер для перестановки
C      TRY - число оставшихся непрерывных перестановок
C      BETTA - ширина ленты для определенного узла
C-----------------------------------------------------------------------------        
        TRY=100000   !кол-во разрещенных непрерывных перестановок        
        DO I=1,NP
           PERM(I)=I   !иходный вектор вершин
        ENDDO
c       Заполняем список смежности вершин                
        DO I=1,NP
           N=0       !ТАК КАК ГРАФ СВЯЗНЫЙ, ТО У ВЕРШИНЫ КАК МИНИМУМ 2 СМЕЖНЫХ
           DO J=XADJ(I),XADJ(I+1)-1
              ADJLST(I,N+1)=ADJNCY(J)
              N=N+1
           ENDDO
           COUNT(I)=N 
        ENDDO  
C---------------ПУНКТ 1 
c        Находим макимальную ширину ленты и узлы приводящие к ней     
1       MAXLNT=0     !максимальная ширина
        PMAX=0       !узел с большим номером
        PMIN=0       !узел с меньшим номером         
        DO I=1,NP           
           IF ((ADJLST(I,1).LE.I).AND.((MAXLNT).LT.(I-ADJLST(I,1))))THEN
              MAXLNT=I-ADJLST(I,1)
              PMAX=I
              PMIN=ADJLST(I,1)
           ENDIF
        ENDDO          
c       Если узел с большим номером можно переставить с меньшим то к п.7        
        TOSWAP=0    !переменная для хранения узла для перемены
        ! просматириваем все узлы до узла с большим номером 
        DO 11 I=1,PMAX-1 
           IF (ADJLST(I,1).LT.I) THEN    !ширина ленты для очередного узла
              BETTA=I-ADJLST(I,1)
           ELSE
              BETTA=0
           ENDIF  
           !если новая ширина меньше макисмальной то меняем метамиузлы  
           !новая ширина = ширина очередного узла + разница их номеров
           IF (((BETTA+(PMAX-I)).LT.MAXLNT))THEN  
              TOSWAP=I
           ENDIF  
11      CONTINUE         
        IF (TOSWAP.NE.0) GOTO 7
C-----------------ПУНКТ 2
C        Если узел с меньшим номером можно переставить с большим то в п.7                    
2       TOSWAP=0 
        ! смотрим узлы начиная с меньшенго до конца
        DO 21 I=PMIN+1,NP
           IF (ADJLST(I,COUNT(I)).GT.I) THEN
              BETTA=ADJLST(I,COUNT(I))-I  !ширина фронта
           ELSE
              BETTA=0
           ENDIF                   
           IF ((BETTA+(I-PMIN)).LT.
     >        (ADJLST(PMIN,COUNT(PMIN))-PMIN).AND.
     >        ((I-ADJLST(PMIN,1)).LT.
     >        (ADJLST(PMIN,COUNT(PMIN))-PMIN))) THEN
                   TOSWAP=I 
                   GOTO 22
               ENDIF       
21      CONTINUE
22      PMAX=PMIN         
        IF (TOSWAP.NE.0) GOTO 7
        PMAX=OLDPMAX
C---------------- ПУНКТ 3
c        Ищем узел с меньшим номером при перестоновки которого с большим 
c        ширина ленты останентся прежней
3       TOSWAP=0
        DO 31 I=1,PMAX-1 
           IF (ADJLST(I,1).LT.I) THEN   !ширина ленты узла
              BETTA=I-ADJLST(I,1)
           ELSE
              BETTA=0
           ENDIF       
           IF (((BETTA+(PMAX-I)).EQ.MAXLNT))THEN
               TOSWAP=I 
           ENDIF  
31      CONTINUE          
        !если нашли, то в п.6
        IF (TOSWAP.NE.0) GOTO 6 
CC---------------- ПУНКТ 4
c       Ищем узел с большим номером при перестановке которого с меньшим
c       ширина ленты останется преждней 
        TOSWAP=0
        DO 41 I=PMIN+1,NP
           IF (ADJLST(I,COUNT(I)).GT.I) THEN
              BETTA=ADJLST(I,COUNT(I))-I
           ELSE
              BETTA=0
           ENDIF
           IF ((BETTA+(I-PMIN)).EQ.
     >    (ADJLST(PMIN,COUNT(PMIN))-PMIN).AND.
     >    ((I-ADJLST(PMIN,1)).LE.
     >     (ADJLST(PMIN,COUNT(PMIN))-PMIN))) THEN
              TOSWAP=I 
              GOTO 42
              ENDIF       
41      CONTINUE  
42      PMAX=PMIN  
        !если такой имеется то в п.6      
        IF (TOSWAP.NE.0) GOTO 6
        PMAX=OLDPMAX
C---------------- ПУНКТ 5
5       GOTO 8    !Все возможные перестановки сделаны: матрица - ленточная
C---------------- Пункт 6
!       если в п. 3 и п.4 были выбраны теже узлы, что и на предыдущем щаге - останов
6       IF (OLDI.EQ.TOSWAP.AND.OLDP.EQ.PMAX) GOTO  5                  
        OLDI=TOSWAP    !запомним переставленные узлы
        OLDP=PMAX 
C----------------ПУНКТ 7 
!        меняем структуру смежности pmax и toswap - узлы для обмена       
7       CALL CHANGEADJLST(ADJLST,NP,COUNT,PMAX,TOSWAP)
        !меняем узлы в векторе переупорядочения
        TEMP=PERM(PMAX)
        PERM(PMAX)=PERM(TOSWAP)
        PERM(TOSWAP)=TEMP 
        TRY=TRY-1      ! отсчет непрерывных перестановок
        IF (TRY.EQ.0) GOTO 5        
        GOTO 1   !все заново
C----------------------- 
8       RETURN
        END
C-----------------------------------------------------------------------------        
C-----------------------------------------------------------------------------        
C       Подпрограмма для изменения структуры смежности графа
        SUBROUTINE CHANGEADJLST(ADJLST,NP,COUNT,P,II)
        INTEGER NP,ADJLST(NP,NP-1),COUNT(NP),P,II
        INTEGER COUNTCHG,TEMP ,I,J          
        ! поменяем номера смежных узлов 
        IF (COUNT(P).GE.COUNT(II)) THEN
           COUNTCHG=COUNT(P)
        ELSEIF (COUNT(P).LT.COUNT(II))  THEN
           COUNTCHG=COUNT(II)  
        ENDIF           
        DO J=1,COUNTCHG
           TEMP=ADJLST(P,J)
           ADJLST(P,J)=ADJLST(II,J)
           ADJLST(II,J)=TEMP
        ENDDO  
          !поменяем кол-во смеж. узлов в массиве count
        TEMP=COUNT(P)
        COUNT(P)=COUNT(II)
        COUNT(II)=TEMP  
          !поменяем местами сами узлы и отсортируем новую структуру смежности
        DO I=1,NP
           COUNTCHG=0
           DO J=1,COUNT(I)
              IF (ADJLST(I,J).EQ.P) THEN
                 ADJLST(I,J)=II
                 COUNTCHG=1
              ELSEIF (ADJLST(I,J).EQ.II) THEN
                 ADJLST(I,J)=P
                 COUNTCHG=1
              ENDIF  
           ENDDO
           IF (COUNTCHG.EQ.1) THEN
              CALL SORT(ADJLST,I,COUNT(I),NP) !если список изменился, то на сортировку
           ENDIF
        ENDDO     
        RETURN
        END
C-----------------------------------------------------------------------------        
C       Подпрограмма сортировки массива
        SUBROUTINE SORT(M,II,JJ,NP)
        INTEGER M(NP,NP-1),II,JJ,I,J,T        
        DO I=1,JJ
           DO J=1,JJ+1-I              
              IF(M(II,J).GE.M(II,JJ+1-I)) THEN
                  T=M(II,J)
                  M(II,J)=M(II,JJ+1-I)
                  M(II,JJ+1-I)=T
              ENDIF
           ENDDO
        ENDDO 
        RETURN
        END
C-----------------------------------------------------------------------------
C==============================================================================
C  конец файла GENRZN.for 