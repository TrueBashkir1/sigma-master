C=============================================================================
C  ТЮИК SMBFCT.for
C  бШГШБЮЕРЯЪ ХГ ЛНДСКЪ RENMDD  
C             оЮПЮЛНМНБ л.б. - 2012 -      
C-----------------------------------------------------------------------------
C       яХЛБНКХВЕЯЙНЕ ПЮГКНФЕМХЕ
C-----------------------------------------------------------------------------        
C  бУНДМШЕ ДЮММШЕ:
C          NP - ЙНКХВЕЯРБН СГКНБ
C          XADJ, ADJNCY - ЯРПСЙРСПЮ ЯЛЕФМНЯРХ ЦПЮТЮ
C  бШУНДМШЕ ДЮММШЕ:
C           Perm - БЕЙРНП ОЕПЕЯРЮМНБЙХ  
C-----------------------------------------------------------------------------
C  нОХЯЮМХЕ ПЮАНРШ ЮКЦНПХРЛЮ:
C  ОНДОПНЦПЮЛЛЮ НЯСЫЕЯРБКЪЕР ЯХЛБНКХВЕЯЙНЕ ПЮГКНФЕМХЕ ОЕПЕСОНПЪДНВЕММНИ КХМЕИМНИ 
C  ЯХЯРЕЛШ Х ТНПЛХПСЕР ЙНЛОЮЙРМСЧ ЯРПСЙРСПС ДЮММШУ ДКЪ МЕ╦.
C-----------------------------------------------------------------------------
C      хглемъелши оюпюлерп-
C        MAXSUB - пюглеп люяяхбю NZSUB. мю бшунде пюбем вхякс
C      хяонкэгнбюммшу хмдейянб.C
C      бшундмше оюпюлерпш -
C          XLNZ - хмдейяш дкъ бейрнпю мемскебшу щкелемрнб LNZ.
C       (XNZSUB, NZSUB) - хмдейямше бейрнпш йнлоюйрмни яуелш .
C       MAXLNZ - вхякн мюидеммшу мемскебшу щкелемрнб.
C       FLAG - хмдхйюрнп ньхайх . онкнфхрекэмне гмювемхе
C       сйюгшбюер, врн пюглеп NZSUB меднярюрнвем.     C
C      пюанвхе оюпюлерпш -
C       MRGLNK - бейрнп дкхмш NEQNS . мю й - нл ьюце яохянй
C       MRGLNK (й), MRGLNKI(MRGLNK(K)) ,...........
C       яндепфхр мнлепю бяеу ярнкажнб L(*,J), дкъ
C       йнрнпшу J< й х оепбши мемскебни
C        бмедхюцнмюкэмши щкелемр - L(K,J). р.н.,
C        ярпсйрспс мемскебшу щкелемрнб ярнкажю L(*, й)
C        лнфмн нопедекхрэ якхъмхел ярпсйрсп рюйху
C        ярнкажнб L(*, J) ян ярпсйрспни ю(*, й).
C        RCHLNK - бейрнп дкхмш NEQNS. хяонкэгсеряъ дкъ
C        мюйюокхбюмхъ ярпсйрспш нвепедмнцн ярнкажю
C        L(*, й). б йнмже й-цн ьюцю яохянй RCHLNK(K),
C        RCHLNK(RCHLNK(K)) ,.........
C        яндепфхр онгхжхх мемскебшу щкелемрнб
C        Й-нцн ярнкажю лмнфхрекъ L.
C        MARKER - жекши бейрнп дкхмш NEQNS дкъ опнбепйх
C        бнглнфмнярх цпсоонбнцн яхлбнкхвеяйнцн
C        хяйкчвемхъ . р.е. , я ецн онлныэч опнбепъеряъ,
C        асдер кх ярпсйрспю напюаюршбюелнцн б дюммши
C        лнлемр й-нцн ярнкажю онкмнярэч нопедекемю
C        едхмярбеммшл ярнкажнл я мнлепнл MRGLNK(K).      
C-----------------------------------------------------------------------------
         SUBROUTINE SMBFCT (NEQNS, XADJ, ADJNCY, PERM, INVP, 
     >    XLNZ, MAXLNZ, XNZSUB, NZSUB, MAXSUB,
     >    RCHLNK, MRGLNK, MARKER, FLAG )
C-----------------------------------------------------------------------------
        INTEGER ADJNCY(1), INVP(1), MRGLNK(1), NZSUB(1), 
     >    PERM(1), RCHLNK(1), MARKER(1)
        INTEGER XADJ(1), XLNZ(1), XNZSUB(1), 
     >    FLAG, I, INZ, J, JSTOP, JSTRT, K, KNZ,
     >     KXSUB, MRGK, LMAX, M, MAXLNZ, MAXSUB,
     >    NABOR, NEQNS, NODE, NP1, NZBEG, NZEND,
     >    RCHM, MRKFLG
C-----------------------------------------------------------------------------
C       хмхжхюкхгюжхъ...
        NZBEG = 1 
        NZEND = 0 
        XLNZ(1) = 1 
        DO 100 K = 1, NEQNS 
           MRGLNK(K) = 0 
           MARKER(K) = 0 
100     CONTINUE
C-------------------------------------------------------------------                 
C       дкъ йюфднцн ярнкажю... . KNZ ондявхршбюер вхякн мемскебшу
C        щкелемрнб й-нцн ярнкажю, мюйюокхбюелнцн б RCHLNK.
C-------------------------------------------------------------------        
        NP1= NEQNS + 1 
        DO 1500 K =1, NEQNS
           KNZ = 0
           MRGK = MRGLNK(K) 
           MRKFLG = 0 
           MARKER(K) = K
           IF (MRGK. NE. 0 ) MARKER(K) = MARKER(MRGK)
           XNZSUB(K) = NZEND
           NODE = PERM(K)
           JSTRT = XADJ(NODE)
           JSTOP = XADJ(NODE+1) - 1
           IF (JSTRT.GT.JSTOP) GOTO 1500
C----------------------------------------------------------------        
C       хяонкэгсъ RCHLNK, янярюбхрэ яохянй мемскебшу
C        онддхюцнмюкэмшу щкелемрнб ярнкажю ю(* ,й) .
C----------------------------------------------------------------        
           RCHLNK(K) = NP1 
           DO 300 J = JSTRT, JSTOP
           NABOR = ADJNCY(J) 
           NABOR = INVP(NABOR) 
           IF ( NABOR .LE. K ) GOTO 300 
              RCHM = K 
200              M = RCHM
              RCHM = RCHLNK(M)
              IF ( RCHM .LE. NABOR ) GOTO 200 
                 KNZ = KNZ+1 
                 RCHLNK(M) = NABOR 
                 RCHLNK(NABOR) = RCHM
                 IF ( MARKER(NABOR) .NE. MARKER(K) ) MRKFLG = 1
300        CONTINUE 
C-------------------------------------------------------------        
C          бнглнфмн кх цпсоонбне яхлбнкхвеяйне хяйкчвемхе . . .
C-------------------------------------------------------------        
           LMAX = 0
           IF ( MRKFLG.NE.0.OR.MRGK.EQ.0 ) GOTO 350
           IF ( MRGLNK(MRGK) .NE. 0 ) GOTO 350
           XNZSUB(K) = XNZSUB(MRGK) + 1
           KNZ = XLNZ(MRGK+1) - (XLNZ(MRGK) + 1)
           GOTO 1400
C-------------------------------------------------------------        
C       дкъ йюфднцн ярнкажю X, бнгдеиярбсчыецн мю L(*,K),
C-------------------------------------------------------------        
350           I = K
400           I = MRGLNK(I)
           IF (I.EQ.0) GOTO 800
              INZ = XLNZ(I+1) - (XLNZ(I)+1) 
              JSTRT = XNZSUB(I) + 1 
              JSTOP = XNZSUB(I) + INZ 
              IF (INZ.LE.LMAX) GOTO 500 
                 LMAX =INZ 
                 XNZSUB(K) =JSTRT
C-----------------------------------------------------------        
C       опхянедхмхрэ й RCHLNK ярпсйрспс L(*,I) хг NZSUB.
C-----------------------------------------------------------                
500           RCHM = K
           DO 700 J = JSTRT, JSTOP
              NABOR = NZSUB(J) 
600           M = RCHM
              RCHM = RCHLNK(M) 
              IF (RCHM.LT.NABOR) GOTO 600 
              IF (RCHM.EQ.NABOR) GOTO 700 
                 KNZ = KNZ+1 
                 RCHLNK(M) = NABOR 
                 RCHLNK(NABOR) = RCHM 
                 RCHM = NABOR 
700           CONTINUE    
           GOTO 400  
C------------------------------------------------------
C    дсакхпсчр кх хмдейяш хмдейяш дпсцнцн ярнкажю
C------------------------------------------------------  
800     IF (KNZ.EQ.LMAX) GOTO 1400
C-------------------------------------------------
C    яннрб. кх йнмеж (й-1)-нцн ярнкажю мювюкс й-нцн.
C--------------------------------------------------
            IF (NZBEG.GT.NZEND) GOTO 1200 
               I = RCHLNK(K) 
               DO 900 JSTR=NZBEG,NZEND
                  IF (NZSUB(JSTRT)-I) 900, 1000, 1200 
900               CONTINUE
               GOTO 1200 
1000           XNZSUB(K) = JSTRT
               DO 1100 J=JSTRT,NZEND
                  IF (NZSUB(J).NE.I) GOTO 1200 
                  I = RCHLNK(I)
                  IF (I.GT.NEQNS) GOTO 1400 
1100           CONTINUE
               NZEND = JSTRT - 1 
C----------------------------------------
C    оепемеярх ярпсйрспс L(*, й) хг RCHLNK
C    б ярпсйрспс дюммшу (XNZSUB, NZSUB).
C----------------------------------------
1200        NZBEG = NZEND + 1
            NZEND = NZEND + KNZ 
            IF (NZEND.GT.MAXSUB) GOTO 1600 
            I = K
            DO 1300 J=NZBEG,NZEND 
               I = RCHLNK(I) 
               NZSUB(J)= I 
               MARKER(I) =K 
1300        CONTINUE 
            XNZSUB(K) = NZBEG 
            MARKER(K) = K
C--------------------------------------------------------
C    лндхтхжхпнбюрэ MRGLNK. мюидеммши L(*, й) онрпеасеряъ
C    опх нопедекемхх ярнкажю L(*,J), цде L(J, й) "оепбши
C    мемскебни онддхюцнмюкэмши щкелемр б L(*,K).
C--------------------------------------------------------              
1400      IF (KNZ.LE.1) GOTO 1500
           KXSUB = XNZSUB(K) 
           I = NZSUB(KXSUB) 
           MRGLNK(K) = MRGLNK(I) 
           MRGLNK(I) = K 
1500    XLNZ(K+1) = XLNZ(K) + KNZ
        MAXLNZ =XLNZ(NEQNS) - 1
        MAXSUB = XNZSUB ( NEQNS ) 
        XNZSUB(NEQNS+1) = XNZSUB(NEQNS) 
        FLAG = 0 
        RETURN
C-----------------------------------------------------------
C    ньхайю- люкн оюлърх дкъ хмдейянб мемскебшу щкелемрнб.
C---------------------------------------------------------
1600    FLAG = 1 
        RETURN 
        END        
C-----------------------------------------------------------------------------
C===================================================================
C      оНДЯВЕР ГЮРПЮР ОЮЛЪРХ ДКЪ ГЮДНММНЦН СОНПЪДНВЕМХЪ
      subroutine FNENV (NEQNS,XADJ,ADJNCY,PERM,INVP,XENV,ENVSZE,
     >                   BANDW)

      INTEGER ADJNCY(1),INVP(1),PERM(1),XADJ(1),XENV(1),BANDW,ENVSZE
      integer str
      dimension str(100)
      integer pr/' '/,zn/'*'/
      
      BANDW=0
      ENVSZE=1
      DO 200 I=1,NEQNS
         XENV(I)=ENVSZE
         IPERM=PERM(I)
         JSTRT=XADJ(IPERM)
         JSTOP=XADJ(IPERM+1)-1
         IF(JSTOP.LT.JSTRT) GO TO 200
            IFIRST=I
            DO 100 J=JSTRT,JSTOP
               NABOR=ADJNCY(J)
               NABOR=INVP(NABOR)
               IF(NABOR.LT.IFIRST) IFIRST=NABOR
 100        CONTINUE
          IBAND=(I-IFIRST)
          ENVSZE=ENVSZE+IBAND
          IF (BANDW.LT.IBAND) BANDW=IBAND
 200  CONTINUE
      XENV(NEQNS+1)=ENVSZE
      ENVSZE=ENVSZE-1

      RETURN
      END
C==============================================================================
C  ЙНМЕЖ ТЮИКЮ SMBFCT.for  
