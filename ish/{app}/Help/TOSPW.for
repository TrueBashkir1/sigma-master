c     Подпрограммы, обеспечивающие формирование файла с результатами для текущего NRC.
c     Автор: Черемушкин Ю.А. Июнь 2011.
c     ------------------------------------------------------------------------ 
c     ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
c     ------------------------------------------------------------------------

      subroutine inittospw(filepointer,nrc)
      integer status,filepointer,nrc
      character*9 name
      logical fileexist
      name='SPW'//CHAR(45+nrc)//'.txt'
      inquire (FILE=name,EXIST=fileexist)
      if (fileexist) then
       open(filepointer,status='OLD',file=name)
       close(filepointer,status='DELETE')
       open(filepointer,status='NEW',file=name)
      endif
      if (.not.fileexist) then
       open(filepointer,status='NEW',file=name)
      endif
      end subroutine  

      subroutine writeR(filepointer,R,NP)
      REAL R(10000)
      INTEGER NP,filepointer
      real sumx, sumy, sum     
      sumx=0
      sumy=0
      sum=0
      do i=1,np
       sumx=sumx+R(2*i-1)
       sumy=sumy+r(2*i)
       sum=sum+sqrt(R(2*i-1)**2+R(2*i)**2)
      enddo
      write(filepointer,111) sumx, sumy, sum
111   format (F12.5,' ',F12.5,' ',f12.5,1x)
      end subroutine
      
      subroutine writeESIGMA(filepointer,ESIGMA,Ne)
      REAL ESIGMA(20000)
      INTEGER Ne,k,filepointer
      real MAX(6),MIN(6)
      data max/6*0.0/, min/6*0.0/     
      do i=1,ne
       do k=1,6
       if (esigma(7*(i-1)+k).lt.min(k)) then
        min(k)=esigma(7*(i-1)+k)
       endif
       if (esigma(7*(i-1)+k).gt.max(k)) then
        max(k)=esigma(7*(i-1)+k)
       endif       
       enddo
      enddo 
      write(filepointer,131) (min(k),k=1,6)
      write(filepointer,131) (max(k),k=1,6)
131   format (7(F10.2,' '),1x)
      end subroutine

      subroutine endTOSPW(filepointer)
      integer filepointer
      close(filepointer)
      end subroutine
