!        Название модуля: Метод Эйкиуза (Акьюца) и Утку для уменьшения ширины ленты
!        Автор: Булавлев А.С., 06-422  
!        Дата: май, 2010 г.
!        Справочная литература: Тьюарссон "Разреженные матрицы", М,Мир,1977, стр.96, 3-ий метод
!        Данные на вход:
!               NEQNS - число уравнений
!               XADJ - массив, хранящий структуру смежности упорядоченного графа.  
!               ADJNCY - массив, хранящий структуру смежности упорядоченного графа.        
!        Данные на выход:
!               PERM - упорядочение минимальной степени.
!        Вызывается из:  RENMDD
!        Вызывает:  --
! =============================== Начало модуля ========================================        
      subroutine GENAU (N, XADJ, ADJNCY, PERM)                      
      integer ADJNCY(1), XADJ(1), PERM(1), N  
      integer ADJNCY_backup(XADJ(N+1)-1),
     > XADJ_backup(N),ADJNCY_size
      integer i, j, beta1, beta2, ai, aj, counti, countj
      integer step_flag, change_count, beta_no_change_count
      step_flag = 1
      change_count = 1
      beta_no_change_count = 0
! инициализируем переменные  
      ADJNCY_size = XADJ(N+1)-1
      do i = 1, n
        PERM(i) = i 
      enddo
! бекап данных    
      do i = 1, N
         PERM(i) = i
      enddo  
      do i = 1, ADJNCY_size
         ADJNCY_backup(i) = ADJNCY(i)
      enddo 
      do i = 1, N+1
         XADJ_backup(i) = XADJ(i)
      enddo  
      do while ((change_count.NE.0).AND.
     > (beta_no_change_count.LE.(3+N/100)))
     
      i = 1
      change_count = 0
      
      do while(i.LE.N-1)
      
         if (step_flag.EQ.1) then
            ai = i
            aj = i+1
            step_flag = 2
         elseif (step_flag.EQ.2) then
            ai = N-i
            aj = N-i+1
            step_flag = 1
         endif          
            
         beta1 = get_beta(N, XADJ, ADJNCY)  
         call replace (N, XADJ, ADJNCY, PERM, ai, aj)
         beta2 = get_beta(N, XADJ, ADJNCY) 
         call replace (N, XADJ, ADJNCY, PERM, ai, aj)
      
         if (beta2.LT.beta1) then
         
            call replace (N, XADJ, ADJNCY, PERM, ai, aj)
            change_count = change_count+1
            beta_no_change_count = 0
            
         elseif (beta2.EQ.beta1) then
         
            beta_no_change_count = beta_no_change_count+1
            counti = get_count_of_one(XADJ, ADJNCY, ai)
            countj = get_count_of_one(XADJ, ADJNCY, aj) 
               
            if ((step.EQ.2).AND.(counti.GT.countj)) then  
              
               call replace (N, XADJ, ADJNCY, PERM, ai, aj)
               change_count = change_count+1
               
            elseif ((step.EQ.1).AND.(counti.LT.countj)) then
            
               call replace (N, XADJ, ADJNCY, PERM, ai, aj)
               change_count = change_count+1
               
            endif
            
         else
             beta_no_change_count = beta_no_change_count+1
         endif
         
         if (step_flag.EQ.1) then
            i = i + 1
         endif
         
      enddo  
      enddo
   
C      call print_array (perm, n)
! рестор данных
      do i = 1, ADJNCY_size
         ADJNCY(i) = ADJNCY_backup(i)
      enddo 
      do i = 1, N+1
         XADJ(i) = XADJ_backup(i)
      enddo     
! выходим       
      return               
      end 
      
! --------------------> считает кол-во едениц в строке  

      function get_count_of_one (XADJ, ADJNCY, num)
      integer ADJNCY(1), XADJ(1) 
      get_count_of_one = abs(XADJ(num)-XADJ(num+1))              
      end 
      

! --------------------> считает коэффициент beta   

      function get_beta (N, XADJ, ADJNCY)
      integer ADJNCY(1), XADJ(1)  
      integer i, qi, bi  
      get_beta = 0
      do i = 1, N
         qi = ADJNCY(XADJ(i))
         bi = i - qi
         if (qi.LE.i) then             
            get_beta = get_beta + bi
         endif   
C         print *,i,qi,bi,get_beta
      enddo
C      get_beta = get_beta / N              
      end 
      
! -------------------> выполняет перестановку строк и столбцов с номерками num1 и num2 
      
      subroutine replace (N, XADJ, ADJNCY, PERM, num1, num2)
      integer ADJNCY(1), XADJ(1), PERM(1)
      integer i, j, tmp, vector(N), size  
      call rep_elment(PERM, num1, num2)
C      print *,XADJ(num1)-1,XADJ(num2+1), XADJ(N+1)-1 
C      call print_ADJNCY (XADJ, ADJNCY, n)
      if (num1.GT.1) then
         do i = 1, num1-1
            call check_for_replace(XADJ, ADJNCY, i, num1, num2)            
         enddo    
      endif
      if (num2.LT.N) then
         do i = num2+1, N
            call check_for_replace(XADJ, ADJNCY, i, num1, num2)            
         enddo    
      endif
C      call print_ADJNCY (XADJ, ADJNCY, n)
      j = 1
      size = 0
      do i = XADJ(num1), XADJ(num1+1)-1
         vector(j) = ADJNCY(i)
         j = j + 1 
         size = size + 1
      enddo
      j = XADJ(num1) 
      do i = XADJ(num2), XADJ(num2+1)-1
         ADJNCY(j) = ADJNCY(i)
         j = j + 1 
      enddo 
      XADJ(num2) = j
      do i = 1, size
         ADJNCY(j) = vector(i)
         j = j + 1 
      enddo 
      return
      end
      
! -------------------> что то то же делает
      
      subroutine check_for_replace (XADJ, ADJNCY, num, num1, num2)
      integer ADJNCY(1), XADJ(1) 
      integer i, change_flag
      change_flag = 0
      do i = XADJ(num), XADJ(num+1)-1 
         if (ADJNCY(i).EQ.num1) then
            ADJNCY(i) = num2 
            change_flag = 1       
         elseif ((f.EQ.0).AND.(ADJNCY(i).EQ.num2)) then
            ADJNCY(i) = num1
            change_flag = 1 
         endif             
      enddo 
      if (change_flag.EQ.1) then
         call sort_for_replace(XADJ, ADJNCY, num) 
      endif   
      return
      end
      
! -------------------> что то то же делает
      
      subroutine sort_for_replace (XADJ, ADJNCY, num)
      integer ADJNCY(1), XADJ(1) 
      integer i, j, a, b, min, min_num 
      a = XADJ(num)
      b = XADJ(num+1)-1   
      do i = a, b
         min = ADJNCY(i)
         min_num = i
         do j = i+1, b
            if (ADJNCY(j).LT.min) then
               min = ADJNCY(j)
               min_num = j
            endif
         enddo 
         if (min.NE.ADJNCY(i)) then
            call rep_elment(ADJNCY, i, min_num)
         endif
      enddo
      return
      end
     
! -------------------> выполняет перестановку элементов с номерками x1 и x2
      
      subroutine rep_elment (A, num1, num2)
      integer A(1), tmp  
      tmp = A(num1)
      A(num1) = A(num2)
      A(num2) = tmp       
      return
      end
      
! -------------------> печатает массив A
      
      subroutine print_array (A, n)
      integer A(1), i
      print *,(A(i), i = 1, n)
      return    
      end
      
! -------------------> печатает массив ADJNCY
      
      subroutine print_ADJNCY (XADJ, ADJNCY, n)
      integer ADJNCY(1), XADJ(1),i,j
      do i = 1, n
         print *,i," -> ",(ADJNCY(j), j = XADJ(i), XADJ(i+1)-1)
      enddo
      return
      end

! ================================ Конец модуля ========================================