#include "stdafx.h"
#include <stdio.h>
#include <math.h>

#define DLLExport extern "C" __declspec(dllexport)


BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
    return TRUE;
}


DLLExport void __stdcall BOUND(int *NFP, char IPR[50], float ORT[1000], int *NMAT, int *NCN, int *NDF, int *NRC, float *DD, float *DB,
					 float *DH, float *DR, float *RSUMX, float *RSUMY, int *INRG, int *INBP, float XP[40], float YP[40],
					 float ZP[40], float JT[4][20], int NDD[20][8], int NOP[3000], int *NP, int *NE, float CORD[6000],
					 int PERM[2000], int INVP[2000], int XADJ[1000], int ADJNCY[6000], int *NB, int NBC[1000], 
					 int NFIX[1000], float *RSUM, float R[3000], int XENV[2000], int *ENVSZE, int *BANDW, int *NSTRT, 
					 int *NSZF, float PSIGMA[30000], float DIAG[1000], int IMAT[1000], float ENV[30000], float BBB[6][3],
					 int *IERR,int *NFL, float ESIGMA[4200], float CORDP[6000], int NFIXP[1000], float RP[3000], int NOPP[3000])

{ 
	FILE *fl;
    int I = 0;
	float X1,Y1;
	double ft2;
    *NB = 0;
 
	fl = fopen("result.res","a");
	fprintf(fl,"\n    PAÁOTAET BOUND********\n");
    fprintf(fl,"\n    ÑÎÇÄÀÍ Â MVS C++********\n");
	fprintf(fl,"  ÃPAHÈ×HÛE ÓCËOBÈß\r\n\tÓÇEË\tX\tY\tÇÀÊÐ\n");

	
 for(I=1;I <= *NP;I++)
 {
  X1 = CORD[2*(I-1)];
  Y1 = CORD[2*(I-1)+1];

  if(abs(X1-0) < 0.01)
  {
    *NB=*NB+1;
    NBC[*NB-1]=I;
    NFIX[*NB-1]=10;
    fprintf(fl,"\t%d\t%3.2f\t%3.2f\t%d\n",I,CORD[2*(I-1)],CORD[2*(I-1)+1],(int)NFIX[*NB-1]);
  }
  if(abs(Y1-0) < 0.01)
  {
    *NB=*NB+1;
    NBC[*NB-1]=I;
    NFIX[*NB-1]=1;
    fprintf(fl,"\t%d\t%3.2f\t%3.2f\t%d\n",I,CORD[2*(I-1)],CORD[2*(I-1)+1],(int)NFIX[*NB-1]);
  }
 }

	fprintf(fl,"\n    BOUND OTPAÁOTAË\n");
    fclose(fl);

	for(I=0; I<= *NB-1;I++)
	{
   	 NFIXP[I] = NFIX[I];
	}

}
