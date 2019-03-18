// cmpguiDlg.h : header file
//

#pragma once


// CcmpguiDlg dialog
class CcmpguiDlg : public CDialog
{
// Construction
public:
	CcmpguiDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	enum { IDD = IDD_CMPGUI_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support

	void ErrorExit(char *string);
	void AccessCtl(void);
	void ShowResFiles(char* process_name,char* file1,char* file2, bool, bool);
	BOOL GetFileInput(char* filter,char* fname);
	//void PutFileOut(iostream*fSout);

	char patch1[500];
	char patch2[500];
	char patch3[500];
	char cmdline[2000];
	char buff[1025];
	char str[2001];
	HANDLE	hChildStdoutRd,hChildStdoutWr,hChildStdoutRdDup;
	DWORD br,bw;
	CEdit *edit1;
	CButton	*btnX,*btnY,*btnXY,*btnEq,*btnMax,*btnMin,*btn,*btn2;
	CButton	*btnMX,*btnMY;
	CButton	*btnSD,*btnSR,*btnFE,*btnPR;
	CButton	*btnNoteWrd;
	CButton	*btnOk;
	CEdit		*editSigmaRez,*editNastranRezDef,*editNastranRezStr;
	CEdit		*editEl;
	CProgressCtrl* pogressCtrl;
	CButton	*btnStr[10];
	CButton	*btnDef[10];
	int j;
// Implementation
protected:
	HICON m_hIcon;
	// Generated message map functions
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg void OnClose();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedButton3();
	afx_msg void OnBnClickedOk();
	afx_msg void OnBnClickedCancel();
	afx_msg void OnBnClickedAbout();
	afx_msg void OnBnClickedOk2();
};
