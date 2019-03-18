// cmpguiDlg.cpp : implementation file
//
//-------------------------------------------------------------------------------------------------
//
//   Description:  Используется как дополнение к программе Сигма (САПР СИГМА)
//                 Позволяет извлечь данные из файла результатов Сигма (*.res)                 
//                 и файлов результатов Nastran (comma separated - CSV) и
//                 затем произвести расчет погрешностей с экспортом нужных
//                 данных в Excel
//
//   *********************************************************************
//		Version History                                                   
//   *********************************************************************
//		Rev   Date            Details
//   ---------------------------------------------------------------------
//		1.0  11.Февраль.2005  - Первый релиз(ассемблер) использование внешней консольной
//                             утилиты Пеняева Р.М. в качестве базы.
//		1.1  18.Февраль.2005  - Последняя версия основанная на консольной. Не удается
//                             устранить ошибку с остановкой дочернего процесса, засорение
//                             памяти.
//		1.2  22.Февраль.2005  - Полная переделка включение сортировку и выдачу отчета по параметрам.
//
//		1.4  14.December.2005 - 1. Fix problem in percentage ratio calculation.
//                             2. Fix order of using columns from stress Femap data.
//                             3. Minor tweaks: rename all CmdGui names to CmpGui.
//
//		1.5  11.January.2007  - 1. Minor GUI fixes.
//
//		1.6	 Декабрь 2012 - 1. исправлен подсчет процента отклонения относительно Сигма;
//							2. добавлен экспорт данных в Excel
//
//-------------------------------------------------------------------------------------------------
#include "stdafx.h"
#include "cmpgui.h"
#include "cmpguiDlg.h"
#include "datafile.h"
#include "cmpguidlg.h"
#include <string>
#include <iostream>
#include <iomanip>
#include <math.h>
#include <locale>
#include <shlwapi.h>

#define STRESS_PRECISION 2
#define DISP_PRECISION 5
#define DISP_PERCENT_PRECISION 2
#define DISP_DIFF_PRECISION 6
#define DISP_SQUARE_DIFF_PRECISION 4
#define F_DIVIDER	',' //знак используемый в качестве разделителя
#define SIGMA_FLT "Sigma result files (*.res)\0*.res\0"//фильтр файлов Сигма
#define NAS_FLT "Nastran CSV files (*.csv)\0*.csv\0"//фильтр файлов Nastran
#define SET_FILE "cmpguif.ini"//файл с настройками
#define STRESS_FILE "sStress.txt"//файл с конвертированными исходными напряжениями из RES файла Сигма
#define DEFORM_FILE "sDeform.txt"//файл с конвертированными исходными деформациями из RES файла Сигма

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

//импорт Excel
#import "C:\Program Files\Common Files\microsoft shared\OFFICE14\MSO.DLL"\
    rename("RGB", "ExcelRGB") \
    rename("DocumentProperties", "ExcelDocumentProperties")
#import "C:\Program Files\Common Files\microsoft shared\VBA\VBA6\VBE6EXT.OLB"
#import "C:\Program Files\Microsoft Office\Office14\EXCEL.EXE" \
    rename( "DialogBox", "ExcelDialogBox" ) \
    rename( "RGB", "ExcelRGB" ) \
    rename( "CopyFile", "ExcelCopyFile" ) \
    rename( "ReplaceText", "ExcelReplaceText" ) \
    rename( "Rectangle", "ExcelRectangle" ) \
    rename( "Arc", "ExcelArc" ) \
    rename( "Picture", "ExcelPicture" ) \
    rename( "Font", "ExcelFont" ) 

using  namespace Excel;

//------------------------------------------------------------------------------------------------------------
// CAboutDlg dialog used for App About
class CAboutDlg : public CDialog
{
public:
	CAboutDlg();
// Dialog Data
	enum { IDD = IDD_ABOUTBOX };
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
// Implementation
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD){}

void CAboutDlg::DoDataExchange(CDataExchange* pDX){
	CDialog::DoDataExchange(pDX);
}
BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()
// CcmpguiDlg dialog
CcmpguiDlg::CcmpguiDlg(CWnd* pParent /*=NULL*/):CDialog(CcmpguiDlg::IDD, pParent){
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CcmpguiDlg::DoDataExchange(CDataExchange* pDX){
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CcmpguiDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_CLOSE()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_BUTTON1, OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON3, OnBnClickedButton3)
	ON_BN_CLICKED(IDOK, OnBnClickedOk)
	ON_BN_CLICKED(IDCANCEL, OnBnClickedCancel)
	ON_BN_CLICKED(IDABOUT, OnBnClickedAbout)
	ON_BN_CLICKED(IDOK2, &CcmpguiDlg::OnBnClickedOk2)
END_MESSAGE_MAP()

// CcmpguiDlg message handlers
//------------------------------------------------------------------------------------------------------------
BOOL CcmpguiDlg::OnInitDialog(){
	CDialog::OnInitDialog();

	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);



	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL){
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty()){
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

    // radio button
    btnNoteWrd = (CButton*)GetDlgItem(IDC_RADIO_WORDPAD);//radio button
	//checkboxes группы <отчет(перемещения)>
	btnMX = (CButton*)GetDlgItem(IDC_CHECK11);//checkbox X (правый)
	btnMY = (CButton*)GetDlgItem(IDC_CHECK12);//checkbox Y	(правый)
	//checkboxes группы <управление>
	btnSD = (CButton*)GetDlgItem(IDC_CHECK8);//checkbox Исходные данные
	btnSR = (CButton*)GetDlgItem(IDC_CHECK9);//checkbox Показывать Результаты
	btnFE = (CButton*)GetDlgItem(IDC_CHECK10);//checkbox Быстрый Выход
	btnPR = (CButton*)GetDlgItem(IDC_CHECK7);//checkbox Проценты
	//кнопки
	btnOk = (CButton*)GetDlgItem(IDOK);//кнопка Расчет
	//edit boxes
	editSigmaRez = (CEdit*)GetDlgItem(IDC_EDIT4);//результаты Сигма
	editNastranRezDef = (CEdit*)GetDlgItem(IDC_EDIT5);//результаты Nastran(деформация)
	editNastranRezStr = (CEdit*)GetDlgItem(IDC_EDIT6);//результаты Nastran(смещения)
	editEl = (CEdit*)GetDlgItem(IDC_EDIT1);//номера узлов
	//progress bar
	pogressCtrl = (CProgressCtrl*)GetDlgItem(IDC_PROGRESS1);
	
	//инициализируем контролы,checkboxes группы <отчет(напряжения)>
	btnStr[0] = (CButton*)GetDlgItem(IDC_CHECK1);//checkbox X
	btnStr[1] = (CButton*)GetDlgItem(IDC_CHECK2);//checkbox Y
	btnStr[2] = (CButton*)GetDlgItem(IDC_CHECK3);//checkbox XY
	btnStr[3] = (CButton*)GetDlgItem(IDC_CHECK5);//checkbox 1 гл
	btnStr[4] = (CButton*)GetDlgItem(IDC_CHECK6);//checkbox 2 гл
	btnStr[5] = (CButton*)GetDlgItem(IDC_CHECK4);//checkbox Экв
	//checkboxes группы <отчет(перемещения)>
	btnDef[0] = (CButton*)GetDlgItem(IDC_CHECK11);//checkbox X (правый)
	btnDef[1] = (CButton*)GetDlgItem(IDC_CHECK12);//checkbox Y	(правый)


	ZeroMemory(&patch1,500);
	ZeroMemory(&patch2,500);
	ZeroMemory(&patch3,500);
	ZeroMemory(&str, 2001);
	char	yn[4][20];
	ZeroMemory(&yn,20*4);
	//получение настроек из файла	
	GetPrivateProfileString("Path","SigmaResults"," ",(LPSTR)&patch1,100,SET_FILE);
	GetPrivateProfileString("Path","NastranResults1"," ",(LPSTR)&patch2,100,SET_FILE);
	GetPrivateProfileString("Path","NastranResults2"," ",(LPSTR)&patch3,100,SET_FILE);
	GetPrivateProfileString("Settings","FastExit"," ",(LPSTR)&yn[0][0],20,SET_FILE);
	GetPrivateProfileString("Settings","ShowResults"," ",(LPSTR)&yn[1][0],20,SET_FILE);	
	GetPrivateProfileString("Settings","SourceData"," ",(LPSTR)&yn[2][0],20,SET_FILE);
	GetPrivateProfileString("Settings","Procent"," ",(LPSTR)&yn[3][0],20,SET_FILE);
	GetPrivateProfileString("Elements","Elem"," ",(LPSTR)&str,20,SET_FILE);

	if(strcmp(&yn[0][0],"yes")) btnFE->SetCheck(BST_CHECKED);	
	if(strcmp(&yn[1][0],"yes"))	btnSR->SetCheck(BST_CHECKED);
	if(strcmp(&yn[2][0],"yes"))	btnSD->SetCheck(BST_CHECKED);
	if(strcmp(&yn[3][0],"yes"))	btnPR->SetCheck(BST_CHECKED);

    btnNoteWrd->SetCheck(BST_CHECKED);

	editSigmaRez->SetWindowText(patch1);
	editNastranRezDef->SetWindowText(patch2);
	editNastranRezStr->SetWindowText(patch3);
	editEl->SetWindowText(str);

	AccessCtl();

	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);
	return TRUE;
}
//------------------------------------------------------------------------------------------------------------
void CcmpguiDlg::OnSysCommand(UINT nID, LPARAM lParam){
	if ((nID & 0xFFF0) == IDM_ABOUTBOX){
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else CDialog::OnSysCommand(nID, lParam);
}
//------------------------------------------------------------------------------------------------------------
void CcmpguiDlg::OnPaint() {
	if (IsIconic()){
		CPaintDC dc(this); // device context for painting
		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);
		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;
		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else CDialog::OnPaint();
}
//------------------------------------------------------------------------------------------------------------
void CcmpguiDlg::OnClose() { /* обработка события  on_close */
	WritePrivateProfileString ("Path","SigmaResults",patch1,SET_FILE); 
	WritePrivateProfileString ("Path","NastranResults1",patch2,SET_FILE); 
	WritePrivateProfileString ("Path","NastranResults2",patch3,SET_FILE); 
	WritePrivateProfileString ("Settings","FastExit",(btnFE->GetState()&0x0003)?"no":"yes",SET_FILE);
	WritePrivateProfileString ("Settings","ShowResults",(btnSR->GetState()&0x0003)?"no":"yes",SET_FILE);
	WritePrivateProfileString ("Settings","SourceData",(btnSD->GetState()&0x0003)?"no":"yes",SET_FILE);
	WritePrivateProfileString ("Settings","Procent",(btnPR->GetState()&0x0003)?"no":"yes",SET_FILE);
	editEl->GetWindowText(str,2000);
	WritePrivateProfileString ("Elements","Elem",str,SET_FILE);

	if(btnFE->GetState()&0x0003) OnCancel();
	else if(MessageBox("Вы точно хотите выйти?","->Выход",MB_YESNO)==IDYES) OnCancel();
}
//------------------------------------------------------------------------------------------------------------
HCURSOR CcmpguiDlg::OnQueryDragIcon(){
	return static_cast<HCURSOR>(m_hIcon);
}
//------------------------------------------------------------------------------------------------------------
/* открываем файл с данными Сигма*/
void CcmpguiDlg::OnBnClickedButton1(){
	ZeroMemory(&patch1,500);
	if(GetFileInput(SIGMA_FLT,patch1)){
		editSigmaRez->SetWindowText(patch1);
		AccessCtl();
	}
}
//------------------------------------------------------------------------------------------------------------
/* открываем файл с данными Nastran(смещения)*/
void CcmpguiDlg::OnBnClickedButton2(){
	ZeroMemory(&patch2,500);
	if(GetFileInput(NAS_FLT,patch2)){
		editNastranRezDef->SetWindowText(patch2);
		AccessCtl();
	}
}
//------------------------------------------------------------------------------------------------------------
/* открываем файл с данными Nastran(напряжения)*/
void CcmpguiDlg::OnBnClickedButton3(){
	ZeroMemory(&patch3,500);
	if(GetFileInput(NAS_FLT,patch3)){
		editNastranRezStr->SetWindowText(patch3);
		AccessCtl();
	}
}
//------------------------------------------------------------------------------------------------------------
/* Обработка нажатия кнопки "Расчет" */
void CcmpguiDlg::OnBnClickedOk(){
// получение текста из EditBox в массив с обработкой возможых ошибок
ZeroMemory( str, sizeof(str) );
editEl->GetWindowText(str,3000);
int s=0,elem[3000],nel=0;
CString zn;
zn.Empty();
while(str[s]!=0){
	if(str[s]<='9'&&str[s]>='0'){
		zn = zn + str[s];
		if(str[s+1]==' '||str[s+1]==0){
			elem[nel++]=StrToInt(zn);
			zn.Empty();
		}
	}
	else{
		if(str[s]!=' '){
			MessageBox("Недопустимый символ в строке списка элементов");
			return;
		}
	}
	s++;
}
std::string word,num,x,y,xy,max_n,min_n,eq,angle,a,b;
std::fstream  fD(DEFORM_FILE,std::ios::out);
std::fstream  fS(STRESS_FILE,std::ios::out);
std::fstream  fR(patch1,std::ios::in);
do fR>>word;
while(word!="RCMSLV");
fR>>word;
fR>>word;
fR>>word;
fD<<"Узел #,перемещение x,перемещение y"<<std::endl;
int nD=0;
while(1){
	fR>>num;
	if(num=="PAБOTAET") break;
	fR>>a>>b;
	fD<<num<<","<<a<<","<<b<<std::endl;
	nD++;
}
fR>>word;
int i,nS=0;
while(1){
	fR>>num;
	if(num=="STRSDD") break;
	fR>>x>>y>>xy>>max_n>>min_n>>eq>>angle;
	nS++;
	fS<<num<<","<<x<<","<<y<<","<<xy<<","<<max_n<<","<<min_n<<","<<eq<<","<<angle<<std::endl;
}
fD.close();
fS.close();
fR.close();
for(s=0;s<nel;s++){
	if(elem[s]<=0||elem[s]>=nS){
		pogressCtrl->SetPos(0);
		MessageBox("Недопустимое значение элемента");
		return;
	}
	elem[s]--;
}
if(!nel){
	for(s=0;s<nS-1;s++)
		elem[s]=s;
	nel = nS-1;
}
//-------------------------- загрука из файлов csv формата
CDataFile mD("sDeform.txt"),mDn(patch2),mS("sStress.txt"),mSn(patch3);
std::fstream  fDout("rezDeform.txt",std::ios::out);
std::fstream  fSout("rezStress.txt",std::ios::out);

std::string name_of_stress[10];
name_of_stress[0] = "X";
name_of_stress[1] = "Y";
name_of_stress[2] = "XY";
name_of_stress[3] = "1гл";
name_of_stress[4] = "2гл";
name_of_stress[5] = "Экв";

double	averageStressValues[3][10] = {0};
double	averageDispValues[3][10] = {0};
const int strS[10]={1,2,3,4,5,6},strN[10]={1,2,3,6,7,11};
double raz = 0, ns_str = 0, sg_str = 0;

bool stressIsUsed = false;
bool deformIsUsed = false;

double dispXSumPercent = 0;
double dispYSumPercent = 0;

fDout.setf(std::ios::fixed,std::ios::floatfield);
fDout.precision(DISP_PRECISION);

fSout.setf(std::ios::fixed,std::ios::floatfield);
fSout.precision(STRESS_PRECISION);

//-------------------------- creating header for displacement report

	fDout<<"[сравнительные результаты по ПЕРЕМЕЩЕНИЯМ Sigma и Nastran]"<<std::endl;
	fDout<<"[файл перемещений Sigma \""<<patch1<<"\""<<std::endl;
	fDout<<"[файл перемещений Nastran \""<<patch2<<"\""<<std::endl<<std::endl;
    
	fDout<<std::endl;

    fDout<<std::setw(5)<<std::left<<"[#Num]";
	if(btnMX->GetState()&0x0003){        
        deformIsUsed = true;
        if(btnSD->GetState()&0x0003) 
            fDout<<std::setw(13)<<std::right<<"[X (sigma)]"<<std::setw(13)<<std::right<<"[X (nastr)]";
        if(btnPR->GetState()&0x0003) 
            fDout<<std::setw(13)<<std::right<<"[% отличия]";
        fDout<<std::setw(13)<<std::right<<"[Разность X]"<<std::setw(13)<<std::right<<"[Кв. разности X]";
	}
	if(btnMY->GetState()&0x0003){
        deformIsUsed = true;
		if(btnSD->GetState()&0x0003) 
            fDout<<std::setw(13)<<std::right<<"[Y (sigma)]"<<std::setw(13)<<std::right<<"[Y (nastr)]";
        if(btnPR->GetState()&0x0003) 
            fDout<<std::setw(13)<<std::right<<"[% отличия]";
		fDout<<std::setw(13)<<std::right<<"[Разность Y]"<<std::setw(13)<<std::right<<"[Кв. разности Y]";
	}
	fDout<<std::endl;

//-------------------------- creating header for stress report

    fSout<<"[сравнительные результаты по НАПРЯЖЕНИЯМ Sigma и Nastran]"<<std::endl;
    fSout<<"[файл напряжений Sigma \""<<patch1<<"\""<<std::endl;
    fSout<<"[файл напряжений Nastran \""<<patch3<<"\""<<std::endl << std::endl;
    
    fSout<<std::endl;
    fSout<<std::setw(5)<<std::left<<"[#Num]";
    for(i=0;i<6;i++)
        if(btnStr[i]->GetState()&0x0003){
            stressIsUsed = true;
            if(btnSD->GetState()&0x0003) 
                fSout<<std::setw(13)<<std::right<<"[" + name_of_stress[i] + " (sigma)]"<<std::setw(13)<<std::right<<"["+name_of_stress[i]+" (nastr)]";
            if(btnPR->GetState()&0x0003) 
                fSout<<std::setw(13)<<std::right<<"[% отличия]";
            fSout<<std::setw(13)<<std::right<<"[Разность " + name_of_stress[i]+"]"<<std::setw(13)<<std::right<<"[Кв. разности "+name_of_stress[i]+"]";
        }
        fSout<<std::endl;

//-------------------------- minor check

    if ( !stressIsUsed && !deformIsUsed ) {
        MessageBox ( "Выберите поля сравнения.", "Ошибка", MB_ICONEXCLAMATION);
        return;
    }

    pogressCtrl->SetPos(50);
    Sleep(100);

//-------------------------- creating body for displacement report

    for(i=0;i<nD;i++){
			fDout<<std::setw(5)<<std::left<<i+1;
			if(btnMX->GetState()&0x0003){
                sg_str = mD[1][i];
                ns_str = mDn[1][i];
                raz = fabs(sg_str-ns_str);
                double ratio = fabs(raz/ (sg_str == 0.0 ? 1 : sg_str) );

				if(btnSD->GetState()&0x0003) 
                    fDout<<std::setw(13)<<std::right<<sg_str<<std::setw(13)<<std::right<<ns_str;
                if(btnPR->GetState()&0x0003) {
                    std::streamsize oldPrec = fDout.precision(DISP_PERCENT_PRECISION);
                    /*if( ratio > 1. )
                        ratio = 100.0;
                    else 
                        ratio = 100 * ratio;
					*/
					ratio = 100 * ratio;

                    fDout<<std::setw(13)<<std::right<< ratio;

                    fDout.precision( oldPrec );

                    averageDispValues[2][0] += ratio;
                }

                averageDispValues[0][0] += raz;
                averageDispValues[1][0] += raz*raz;

                fDout.precision(DISP_DIFF_PRECISION);
                fDout<<std::setw(13)<<std::right<<raz;                
                fDout.setf(std::ios::scientific,std::ios::floatfield);
                fDout.setf(std::ios::uppercase);
                fDout.precision(DISP_SQUARE_DIFF_PRECISION);
				fDout<<std::setw(13)<<std::right<<raz*raz;
                fDout.unsetf(std::ios::uppercase);
                fDout.setf(std::ios::fixed,std::ios::floatfield);
                fDout.precision(DISP_PRECISION);
			}
			if(btnMY->GetState()&0x0003){
				sg_str = mD[2][i];
				ns_str = mDn[2][i];
				raz = fabs(sg_str-ns_str);
                double ratio = fabs(raz/ (sg_str == 0.0 ? 1 : sg_str) );

				if(btnSD->GetState()&0x0003) 
                    fDout<<std::setw(13)<<std::right<<sg_str<<std::setw(13)<<std::right<<ns_str;
                if(btnPR->GetState()&0x0003) {
                    std::streamsize oldPrec = fDout.precision(DISP_PERCENT_PRECISION);
                    /*if( ratio > 1. )
                        ratio = 100.0;
                    else 
                        ratio = 100 * ratio;
                     */
					ratio = 100 * ratio;
                    fDout<<std::setw(13)<<std::right<< ratio;

                    fDout.precision( oldPrec );

                    averageDispValues[2][1] += ratio;
                }

                averageDispValues[0][1] += raz;
                averageDispValues[1][1] += raz*raz;

                fDout.precision(DISP_DIFF_PRECISION);
                fDout<<std::setw(13)<<std::right<<raz;                
                fDout.setf(std::ios::scientific,std::ios::floatfield);
                fDout.setf(std::ios::uppercase);
                fDout.precision(DISP_SQUARE_DIFF_PRECISION);
                fDout<<std::setw(13)<<std::right<<raz*raz;
                fDout.unsetf(std::ios::uppercase);
                fDout.setf(std::ios::fixed,std::ios::floatfield);
                fDout.precision(DISP_PRECISION);
			}
			fDout<<std::endl;
	}

    if(btnPR->GetState()&0x0003) {
        fDout<<"----------------------------------------"<<std::endl<<"Средний процент отличия"<<std::endl;
        for(i=0;i<2;i++)
            if(btnDef[i]->GetState()&0x0003)
                fDout<<std::setw(30)<<std::left<<"\""+name_of_stress[i]+"\" "<<averageDispValues[2][i]/nel<<std::endl;
    }
    fDout<<"----------------------------------------"<<std::endl<<"Среднее абсолютное отклонение"<<std::endl;
    for(i=0;i<2;i++)
        if(btnDef[i]->GetState()&0x0003)
            fDout<<std::setw(30)<<std::left<<"\"" + name_of_stress[i]+"\" "<<averageDispValues[0][i]/nel<<std::endl;
    fDout<<"----------------------------------------"<<std::endl<<"Среднее квадратическое отклонение"<<std::endl;
    for(i=0;i<2;i++)
        if(btnDef[i]->GetState()&0x0003)
            fDout<<std::setw(30)<<std::left<<"\""+name_of_stress[i]+"\" "<<sqrtl(averageDispValues[1][i]/nel)<<std::endl;


//-------------------------- creating body for stress report

	for (i=0;i<nel;i++) {
		fSout<<std::setw(5)<<std::left<<elem[i]+1;
        for(j=0;j<6;j++) {
			if(btnStr[j]->GetState()&0x0003){
				sg_str = mS[strS[j]][elem[i]];
				ns_str = mSn[strN[j]][elem[i]];
                raz	= fabs(sg_str - ns_str);
                double ratio = fabs( raz/ (sg_str == 0.0 ? 1 : sg_str) );
				if(btnSD->GetState()&0x0003)
                    fSout<<std::right<<std::setw(13)<<sg_str<<std::right<<std::setw(13)<<ns_str;
				if(btnPR->GetState()&0x0003) {
                    /*if( ratio > 1. )
                        ratio = 100.0;
                    else 
                        ratio = 100 * ratio;
						*/
					ratio = 100 * ratio;
                    fSout<<std::setw(13)<<std::right<< ratio;

                    averageStressValues[2][j] += ratio;
				}
				averageStressValues[0][j] += raz;
				averageStressValues[1][j] += raz*raz;
				fSout<<std::setw(13)<<std::right<<raz;
				fSout<<std::setw(13)<<std::right<<raz*raz;
			}
		}
		fSout<<std::endl;

    }
        if(btnPR->GetState()&0x0003) {
            fSout<<"----------------------------------------"<<std::endl<<"Средний процент отличия"<<std::endl;
            for(i=0;i<6;i++)
                if(btnStr[i]->GetState()&0x0003)
                    fSout<<std::setw(30)<<std::left<<"\""+name_of_stress[i]+"\" "<<averageStressValues[2][i]/nel<<std::endl;
        }
        fSout<<"----------------------------------------"<<std::endl<<"Среднее абсолютное отклонение"<<std::endl;
		for(i=0;i<6;i++)
			if(btnStr[i]->GetState()&0x0003)
				fSout<<std::setw(30)<<std::left<<"\"" + name_of_stress[i]+"\" "<<averageStressValues[0][i]/nel<<std::endl;
		fSout<<"----------------------------------------"<<std::endl<<"Среднее квадратическое отклонение"<<std::endl;
		for(i=0;i<6;i++)
			if(btnStr[i]->GetState()&0x0003)
				fSout<<std::setw(30)<<std::left<<"\""+name_of_stress[i]+"\" "<<sqrtl(averageStressValues[1][i]/nel)<<std::endl;

//-------------------------- finit

fDout.close();
fSout.close();

pogressCtrl->SetPos(100);
Sleep(200);
pogressCtrl->SetPos(0);

if ( !stressIsUsed && !deformIsUsed ) {
    MessageBox ( "Выберите поля сравнения.", "Ошибка", MB_ICONEXCLAMATION);
    return;
}

if(btnSR->GetState()&0x0003) { 

    if ( btnNoteWrd->GetState() & 0x0003 )
        ShowResFiles("write.exe",
                     "rezStress.txt","rezDeform.txt",
                     stressIsUsed, deformIsUsed);
    else
        ShowResFiles("notepad.exe",
                     "rezStress.txt","rezDeform.txt",
                     stressIsUsed, deformIsUsed);
}
}
//------------------------------------------------------------------------------------------------------------
void CcmpguiDlg::OnBnClickedCancel(){/* Обработка нажатия кнопки "Выход" */
	OnClose();
}
//------------------------------------------------------------------------------------------------------------
void CcmpguiDlg::ErrorExit(char *string){/* Обработка ошибок */
	MessageBox(string,"Ошибка",MB_ICONEXCLAMATION);
	ExitProcess(0);
}
//------------------------------------------------------------------------------------------------------------
void CcmpguiDlg::OnBnClickedAbout(){/* Обработка нажатия кнопки "About.." */
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
}
//------------------------------------------------------------------------------------------------------------
void CcmpguiDlg::AccessCtl(){/* проверка видимости контролов */
	if(!patch1[0]||!patch2[0]||!patch3[0]){	
		btnOk->EnableWindow(0);
	}
	else{
		btnOk->EnableWindow(1);
	}
}
//------------------------------------------------------------------------------------------------------------
void CcmpguiDlg::ShowResFiles (char* process_name,char* file1, char* file2,bool stressIsUsed,bool deformIsUsed ) 
{/* показываем результаты */

		STARTUPINFO si,si1;
    PROCESS_INFORMATION pi,pi1;
		HANDLE	proc[2];
		char pname1[500],pname2[500];

		strcpy(pname1,process_name);
		strcat(pname1," ");
		strcat(pname1,file1);
		strcpy(pname2,process_name);
		strcat(pname2," ");
		strcat(pname2,file2);
    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );
    ZeroMemory( &si1, sizeof(si1) );
    si.cb = sizeof(si1);
    ZeroMemory( &pi1, sizeof(pi1) );
		this->ShowWindow(SW_HIDE);
    if( stressIsUsed && !CreateProcess( NULL,pname1,NULL,NULL,FALSE,0,NULL,NULL,&si,&pi ))
			ErrorExit( "CreateProcess: Не удалось запустить процесс" );
    if( deformIsUsed && !CreateProcess( NULL,pname2,NULL,NULL,FALSE,0,NULL,NULL,&si1,&pi1 ))
			ErrorExit( "CreateProcess: Не удалось запустить процесс" );
		proc[0] = pi.hProcess;
		proc[1] = pi1.hProcess;
		WaitForMultipleObjects(2,proc,TRUE,INFINITE); 
    CloseHandle( pi.hProcess ); CloseHandle( pi.hThread );
    CloseHandle( pi1.hProcess ); CloseHandle( pi1.hThread );
		this->ShowWindow(SW_RESTORE);//показать окно основного приложения
}
//------------------------------------------------------------------------------------------------------------
BOOL CcmpguiDlg::GetFileInput(char* filter,char* fname){/* открываем файл */
OPENFILENAME ofn;
char szFile[260];
BOOL	status;

ZeroMemory(&ofn, sizeof(ofn));
ofn.lStructSize = sizeof(ofn);
ofn.hwndOwner = NULL;
ofn.lpstrFile = szFile;
ofn.lpstrFile[0] = '\0';
ofn.nMaxFile = sizeof(szFile);
ofn.lpstrFilter = filter;
ofn.nFilterIndex = 1;
ofn.lpstrFileTitle = NULL;
ofn.nMaxFileTitle = 0;
ofn.lpstrInitialDir = NULL;
ofn.Flags = OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST;
if(status = GetOpenFileName(&ofn))
	strcpy(fname,ofn.lpstrFile);
return status;
}


/*Обработка нажатия на кнопку экспорта в Excel*/
void CcmpguiDlg::OnBnClickedOk2()
{

/*
	Создаем эвземпляр приложения Excel
*/
  // Иницилизация COM объекта
  CoInitialize(NULL);
  // Использовать именное пространство Excel
  using namespace Excel;
  // Соединение с MS Excel
 _ApplicationPtr pXL;
 try {
  pXL.CreateInstance(L"Excel.Application");
  // Показать приложение VARIANT_TRUE или не показывать VARIANT_FALSE
  pXL->Visible[0] = VARIANT_FALSE;
  // Подключение книги
  WorkbooksPtr pBooks = pXL->Workbooks;
  // Создание новой книги
  _WorkbookPtr pBook  = pBooks->Add((long)xlWorksheet);
  // Указатель на активную страницу
  _WorksheetPtr pSheet = pXL->ActiveSheet;

  // Доступ ко всем ячейкам
  RangePtr pRange = pSheet->Cells;

  RangePtr pCell;

/*
	Закончили создание Excel, снова треш из прошлой версии
*/

// получение текста из EditBox в массив с обработкой возможых ошибок
ZeroMemory( str, sizeof(str) );
editEl->GetWindowText(str,2000);
int s=0,elem[2000],nel=0;
CString zn;
zn.Empty();
while(str[s]!=0){
	if(str[s]<='9'&&str[s]>='0'){
		zn = zn + str[s];
		if(str[s+1]==' '||str[s+1]==0){
			elem[nel++]=StrToInt(zn);
			zn.Empty();
		}
	}
	else{
		if(str[s]!=' '){
			MessageBox("Недопустимый символ в строке списка элементов");
			return;
		}
	}
	s++;
}
std::string word,num,x,y,xy,max_n,min_n,eq,angle,a,b;
std::fstream  fD(DEFORM_FILE,std::ios::out);
std::fstream  fS(STRESS_FILE,std::ios::out);
std::fstream  fR(patch1,std::ios::in);
do fR>>word;
while(word!="RCMSLV");
fR>>word;
fR>>word;
fR>>word;
fD<<"Узел #,перемещение x,перемещение y"<<std::endl;
int nD=0;
while(1){
	fR>>num;
	if(num=="PAБOTAET") break;
	fR>>a>>b;
	fD<<num<<","<<a<<","<<b<<std::endl;
	nD++;
}
fR>>word;
int i,nS=0;
while(1){
	fR>>num;
	if(num=="STRSDD") break;
	fR>>x>>y>>xy>>max_n>>min_n>>eq>>angle;
	nS++;
	fS<<num<<","<<x<<","<<y<<","<<xy<<","<<max_n<<","<<min_n<<","<<eq<<","<<angle<<std::endl;
}
fD.close();
fS.close();
fR.close();
for(s=0;s<nel;s++){
	if(elem[s]<=0||elem[s]>=nS){
		pogressCtrl->SetPos(0);
		MessageBox("Недопустимое значение элемента");
		return;
	}
	elem[s]--;
}
if(!nel){
	for(s=0;s<nS-1;s++)
		elem[s]=s;
	nel = nS-1;
}
//-------------------------- загрука из файлов csv формата
CDataFile mD("sDeform.txt"),mDn(patch2),mS("sStress.txt"),mSn(patch3);


char *name_of_stress[10];
name_of_stress[0] = "X";
name_of_stress[1] = "Y";
name_of_stress[2] = "XY";
name_of_stress[3] = "1гл";
name_of_stress[4] = "2гл";
name_of_stress[5] = "Экв";

double	averageStressValues[3][10] = {0};
double	averageDispValues[3][10] = {0};
const int strS[10]={1,2,3,4,5,6},strN[10]={1,2,3,6,7,11};
double raz = 0, ns_str = 0, sg_str = 0;

bool stressIsUsed = false;
bool deformIsUsed = false;

double dispXSumPercent = 0;
double dispYSumPercent = 0;



/*
	Создание заголовка Excel для результата сравнения перемещений
*/

	int column = 1;
	pCell = pRange->Item[1][1];
	pCell->Value2 = "Сравнение результатов расчета перемещений узлов в Sigma и Nastran";


	pCell = pRange->Item[3][column++]; pCell->Value2 = "№ узла";
	// в зависимости от выбранных опций формируем шапку таблице
		if(btnMX->GetState()&0x0003){        
			deformIsUsed = true;
			if(btnSD->GetState()&0x0003) 
				pCell = pRange->Item[3][column++]; pCell->Value2 = "X (sigma)";
				pCell = pRange->Item[3][column++]; pCell->Value2 = "X (nastr)";
			if(btnPR->GetState()&0x0003) 
				pCell = pRange->Item[3][column++]; pCell->Value2 = "% отличия";
				pCell = pRange->Item[3][column++]; pCell->Value2 = "Разность X";
				pCell = pRange->Item[3][column++]; pCell->Value2 = "Кв. разности X";
		}
		if(btnMY->GetState()&0x0003){
			deformIsUsed = true;
			if(btnSD->GetState()&0x0003) 
				pCell = pRange->Item[3][column++]; pCell->Value2 = "Y (sigma)";
				pCell = pRange->Item[3][column++]; pCell->Value2 = "Y (nastr)";
			if(btnPR->GetState()&0x0003) 
				pCell = pRange->Item[3][column++]; pCell->Value2 = "% отличия";
				pCell = pRange->Item[3][column++]; pCell->Value2 = "Разность Y";
				pCell = pRange->Item[3][column++]; pCell->Value2 = "Кв. разности Y";
		}


		/*
	Заполнение таблицы сравнения перемещений
*/
	j = 4;
    for(i=0;i<nD;i++){
			++j;
			column = 1;
			//номер КЭ в первый столбец
			pCell = pRange->Item[j][column++]; pCell->Value2 = i+1;
			if(btnMX->GetState()&0x0003){
                sg_str = mD[1][i];
                ns_str = mDn[1][i];
                raz = fabs(sg_str-ns_str);
                double ratio = fabs(raz/ (sg_str == 0.0 ? 1 : sg_str) );

				// в зависимости от выбранных опций заполняем неоходимые столбцы
				if(btnSD->GetState()&0x0003) 
					pCell = pRange->Item[j][column++]; pCell->Value2 = sg_str;
					pCell = pRange->Item[j][column++]; pCell->Value2 = ns_str;
                if(btnPR->GetState()&0x0003) {
                   
					ratio = 100 * ratio;

                    pCell = pRange->Item[j][column++]; pCell->Value2 = ratio;
					
                    averageDispValues[2][0] += ratio;
                }

                averageDispValues[0][0] += raz;
                averageDispValues[1][0] += raz*raz;

                pCell = pRange->Item[j][column++]; pCell->Value2 = raz;                
				pCell = pRange->Item[j][column++]; pCell->Value2 = raz*raz;

			}
			if(btnMY->GetState()&0x0003){
				sg_str = mD[2][i];
				ns_str = mDn[2][i];
				raz = fabs(sg_str-ns_str);
                double ratio = fabs(raz/ (sg_str == 0.0 ? 1 : sg_str) );

				if(btnSD->GetState()&0x0003) 
                    pCell = pRange->Item[j][column++]; pCell->Value2 = sg_str;
					pCell = pRange->Item[j][column++]; pCell->Value2 = ns_str;
                if(btnPR->GetState()&0x0003) {
                   
					ratio = 100 * ratio;
                    pCell = pRange->Item[j][column++]; pCell->Value2 = ratio;

                    averageDispValues[2][1] += ratio;
                }

                averageDispValues[0][1] += raz;
                averageDispValues[1][1] += raz*raz;

                pCell = pRange->Item[j][column++]; pCell->Value2 = raz;  
                pCell = pRange->Item[j][column++]; pCell->Value2 = raz*raz;
			}
	}

	 if(btnPR->GetState()&0x0003) {
        pCell = pRange->Item[++j][1]; pCell->Value2 = "Средний процент отличия";
        for(i=0;i<2;i++)
            if(btnDef[i]->GetState()&0x0003){

                pCell = pRange->Item[++j][1]; pCell->Value2 = name_of_stress[i];
				pCell = pRange->Item[j][2]; pCell->Value2 = averageDispValues[2][i]/nel;
				
			}
    }
    pCell = pRange->Item[++j][1]; pCell->Value2 = "Среднее абсолютное отклонение";
    for(i=0;i<2;i++)
        if(btnDef[i]->GetState()&0x0003){
			pCell = pRange->Item[++j][1]; pCell->Value2 = name_of_stress[i];
			pCell = pRange->Item[j][2]; pCell->Value2 = averageDispValues[0][i]/nel;
			
		}
    pCell = pRange->Item[++j][1]; pCell->Value2 = "Среднее квадратическое отклонение";
    for(i=0;i<2;i++)
        if(btnDef[i]->GetState()&0x0003){
				pCell = pRange->Item[++j][1]; pCell->Value2 = name_of_stress[i];
				pCell = pRange->Item[j][2]; pCell->Value2 = sqrt(averageDispValues[1][i]/nel);		
		}
  _variant_t vname, vnull, vformat, vamode, vconflict;

//флаг несохраненного файла а делаем его видимым
	pBook->Saved[0] = VARIANT_FALSE;
	

  pXL->Visible[0] = VARIANT_TRUE;


/*
	Инициализируем pXl для сравнения напряжений
*/
  pXL.CreateInstance("Excel.Application");
  // Показать приложение VARIANT_TRUE или не показывать VARIANT_FALSE
  pXL->Visible[0] = VARIANT_FALSE;
  // Подключение книги
  pBooks = pXL->Workbooks;
  // Создание новой книги
  pBook  = pBooks->Add((long)xlWorksheet);
  // Указатель на активную страницу
  pSheet = pXL->ActiveSheet;

  // Доступ ко всем ячейкам
  pRange = pSheet->Cells;


	pCell = pRange->Item[1][1];
	pCell->Value2 = "Сравнение расчета напряжений Sigma и Nastran";
	
	column = 1;

	pCell = pRange->Item[3][column++]; 
	pCell->Value2 = "№ КЭ";

	 for(i=0;i<6;i++)
        if(btnStr[i]->GetState()&0x0003){
            stressIsUsed = true;
            if(btnSD->GetState()&0x0003){
				switch(i){
				case 0:
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "X (sigma)";
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "X (nastr)";
					break;
				case 1:
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "Y (sigma)";
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "Y (nastr)";
					break;
				case 2:
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "XY (sigma)";
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "XY (nastr)";
					break;
				case 3:
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "1-е гл. (sigma)";
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "1-е гл. (nastr)";
					break;
				case 4:
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "2-е гл. (sigma)";
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "2-е гл. (nastr)";
					break;
				case 5:
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "Касат. (sigma)";
					pCell = pRange->Item[3][column++]; 
					pCell->Value2 = "Касат. (nastr)";
					break;
				}
			}
            if(btnPR->GetState()&0x0003){
                pCell = pRange->Item[3][column++]; 
				pCell->Value2 = "% отличия";
				pCell = pRange->Item[3][column++]; 
				pCell->Value2 = "Разность ";
				pCell = pRange->Item[3][column++]; 
				pCell->Value2 = "Кв. разности";
			}
        }

		//заполнение данных по напряжениям
		int k;
		k = 4;
		for (i=0;i<nel;i++) {
			++k;
			column = 1;
			pCell = pRange->Item[k][column++]; 
			pCell->Value2 = elem[i]+1;

			for(j=0;j<6;j++) {
				if(btnStr[j]->GetState()&0x0003){
					sg_str =  mS[strS[j]][elem[i]];
					ns_str =  mSn[strN[j]][elem[i]];
					raz	= fabs(sg_str - ns_str);
					double ratio = fabs( raz/ (sg_str == 0.0 ? 1 : sg_str) );
					if(btnSD->GetState()&0x0003){
						pCell = pRange->Item[k][column++]; 
						pCell->Value2 = sg_str;
						pCell = pRange->Item[k][column++]; 
						pCell->Value2 = ns_str;
					}
					if(btnPR->GetState()&0x0003) {
						ratio = 100 * ratio;
						pCell = pRange->Item[k][column++]; 
						pCell->Value2 = ratio;
						averageStressValues[2][j] += ratio;
					}
					averageStressValues[0][j] += raz;
					averageStressValues[1][j] += raz*raz;
					pCell = pRange->Item[k][column++]; 
					pCell->Value2 =raz;
					pCell = pRange->Item[k][column++]; 
					pCell->Value2 = raz*raz;
				}
			}
		}
			if(btnPR->GetState()&0x0003) {
				pCell = pRange->Item[++k][1]; 
				pCell->Value2 = "Средний процент отличия";
				for(i=0;i<6;i++)
					if(btnStr[i]->GetState()&0x0003){
						pCell = pRange->Item[++k][1]; 
						pCell->Value2 = name_of_stress[i];
						pCell = pRange->Item[k][2]; 
						pCell->Value2 = averageStressValues[2][i]/nel;
					}
			}
			pCell = pRange->Item[++k][1]; 
			pCell->Value2 = "Среднее абсолютное отклонение";
			for(i=0;i<6;i++)
				if(btnStr[i]->GetState()&0x0003){
					pCell = pRange->Item[++k][1]; 
					pCell->Value2 = name_of_stress[i];
					pCell = pRange->Item[k][2]; 
					pCell->Value2 = averageStressValues[0][i]/nel;
				}
			pCell = pRange->Item[++k][1]; 
			pCell->Value2 = "Среднее квадратическое отклонение";
			for(i=0;i<6;i++)
				if(btnStr[i]->GetState()&0x0003){
					pCell = pRange->Item[++k][1]; 
					pCell->Value2 = name_of_stress[i];
					pCell = pRange->Item[k][2]; 
					pCell->Value2 = sqrt(averageStressValues[1][i]/nel);
				}
	  /*
		Завершение работы с Excel
	  */

		//ставим фалаг несохраненного файла и делаем его видимым
		pBook->Saved[0] = VARIANT_FALSE;
		pXL->Visible[0] = VARIANT_TRUE;

	  DeleteFile("sDeform.txt");
	  DeleteFile("sStress.txt");

	  if ( !stressIsUsed && !deformIsUsed ) {
    MessageBox ( "Выберите поля сравнения.", "Ошибка", MB_ICONEXCLAMATION);
    return;
}

}catch (_com_error& er)
 {
    char buf[1024];
    sprintf(buf,"_com_error:\n"
                "Error       : %08lX\n"
                "ErrorMessage: %s\n"
                "Description : %s\n"
                "Source      : %s\n",
                er.Error(),
                (LPCTSTR)_bstr_t(er.ErrorMessage()),
                (LPCTSTR)_bstr_t(er.Description()),
                (LPCTSTR)_bstr_t(er.Source()));

    printf(buf);
  }
}
