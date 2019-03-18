C  файл QMDMRG .for   
C —одержит подпрограмму QMDMRG 
C ===============================================================
**************************************************************************************
***************                        —ли€ние в алгоритме минимальной степени       ************
*************************************************************************************************
*   ѕодпрограмма сливает неразличимые узлы в алгоритме минимальной степени и вычисл€ет
*   новые степени новых суперузлов.
* 
*   ¬ходные параметры -
*   (XADJ,ADJNCY) - структура смежности
*   DEG0 - число узлов в заданном множестве
*   (NHDSZE,NBRHD) - множество исключенных суперузлов, смежных с узлами данного множества.
*
*   »змен€емые параметры  - 
*   DEG -вектор степеней.
*   QSIZE - размеры неразличимых суперузлов
*   QLINK -  св€занный список дл€ неразличимых узлов
*   MARKER -  в заданное множество вход€т узлы, которым в marker соответствует значение 1. 
*           степень которых изменена, будет установлено значение 2.
*
*   –абочие параметры - 
*   RCHEST - достижимое множество
*   OVRLP - вектор, хран€щий пересечение двух достижимых множеств.
C =================================================================
C =============== начало кода   QMDMRG ==============================
C ================================================================
      SUBROUTINE QMDMRG(XADJ,ADJNCY,DEG,QSIZE,QLINK,MARKER
     1                    DEG0,NHDSZE,NBRHD,RCHSET,OVRLP)
**************************************************************************************************
*
      integer adjncy(1),deg(1),qsize(1),qlink(1),
     1            marker(1),rchset(1),nbrhd(1),ovrlp(1)
      integer xadj(1),deg0,deg1,head,inhd,iov,irch,
     1            j,jstrt,jstop,link,lnode,mark,mrgsze,
     1            nabor,nhdsze,node,novrlp,rchsze,root
*
**************************************************************************************************
*
*        ѕрисвоение начальных значений
*
      if (nhdsze.le.0) return
      do 100 inhd =1, nhdsze
             root=nbrhd(inhd)
             marker(root)=0
100   continue
*
*        ÷икл по исключенным суперузлам пары (nhdsze,nbrhd)
*                        
      do 1400 inhd=1,nhdsze
              root=nbrhd(inhd)
              marker(root)=-1
              rchsze=0
              novrlp=0
              deg1=0
200           jstrt=xadj(root)
              jstop=xadj(root+1)-1
*
*        ќпределить достижимое множество и его пересечение с входным достижимым множеством
*                            
              do 600 j=jstrt,jstop
                     nabor=adjncy(j)
                     root=-nabor
                     if (nabor) 200, 700, 300
300                  mark=marker(nabor)
                     if (mark) 600, 400, 500 
400                  rchsze = rchsze+1
                     rchset(rchsze)=nabor
                     deg1=deg1+qsize(nabor)
                     marker(nabor)=1
                     goto 600
500                  if (mark.gt.1) goto 600
                     novrlp=novrlp+1
                     ovrlp(novrlp)=nabor
                     marker(nabor)=2
600            continue
*
*        Ќайти в пересечении узлы, которые могут быть слиты
*
700            head=0
               mrgsze=0
               do 1100 iov=1,novrlp
                       node=ovrlp(iov)
                       jstrt=xadj(node)
                       jstop=xadj(node+1)-1
                       do 800 j=jstrt,jstop
                              nabor=adjncy(j)
                              if (marker(nabor).ne.0) goto 800
                              marker(node)=1
                              goto 1100
800                    continue
*
*        ”зел принадлежит новому слитому суперузлу. ћодифицировать qlink,qsize
*                            
                       mrgsze=mrgsze+qsize(node)
                       marker(node)=-1
                       lnode=node
900                    link=qlink(lnode)
                       if (link.le.0) goto 1000
                       lnode=link
                       goto 900
1000                   qlink(lnode)=head
                       head=node
1100           continue
               if (head.le.0) goto 1200
               qsize(head)=mrgsze
*  возможно в конце +1
               deg(head)=deg0+deg1+1
!               print*,'@@',deg(head)
               marker(head)=2
!               print*,'######',head
*
*        ”зел принадлежит новому слитому суперузлу. ћодифицировать qlink,qsize
*                            
1200           root=nbrhd(inhd)
               marker(root)=0
               if (rchsze.le.0) goto 1400
               do 1300 irch =1, rchsze
                       node=rchset(irch)
                       marker(node)=0
1300           continue
1400  continue
      return
      end
C =================================================================
C =================== конец кода QMDMRG ============================
C =================================================================
C конец файла QMDMRG .for        