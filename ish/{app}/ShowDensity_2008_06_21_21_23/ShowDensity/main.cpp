#include "Renderer.h"
#include "commctrl.h"
#include "resource.h"

#pragma comment(lib,"ComCtl32.lib")


using namespace DensityVisualisation;

Camera camera;
Renderer renderer(&camera);
Plate plate;
Loader loader;
bool MouseLook = false;
bool ViewMove = false;
bool ScaleView = false;
POINT pos,cp;
#define RIGHT_PANEL_WIDTH 150
int Width = 500+RIGHT_PANEL_WIDTH+10,Height = 535;
int MousePosX = 0,MousePosY = 0;
HINSTANCE hInst = NULL;
OPENFILENAME LoadDialog;
char FileName[1024];
//содержит параметры для выбора цвета
CHOOSECOLOR cc;
COLORREF acrCustClr[16];
COLORREF resultColor = RGB(255,255,0);

ElementProperties CurrentProperty = DENSITY;

char* NamesOfProperties[] = {"ф-ю плотности",
						   "напр. по Х",
						   "напр. по У",
						   "касательные напр.",
						   "1-е главные напр.",
						   "2-е главные напр.",
						   "эквивалентные напр.",
						   "угол",
						   "толщину мат-лов"};

LPCSTR FileExtFilter = "файлы программы\0*.POI\0";
//состояние - вращать камеру, перемещать камеру, отдалять камеру
//выбирать треугольник или ничего не делать при нажатии левой кнопки мыши
enum CurrentViewState
{
	NONE,
	MOVE,
	ROTATE,
	SCALE,
	SELECT
};
CurrentViewState CurrentState = NONE;
//кнопка, отвечающая за переключения режима изображения поверхности
HWND Toggle3DView = NULL;
HWND ResetView = NULL;
HWND MinValLabel = NULL;
HWND MinVal = NULL;
HWND MaxValLabel = NULL;
HWND MaxVal = NULL;
HWND LoadPlate = NULL;
HWND Canvas = NULL;
HWND InfoMsg = NULL;
HWND MoveButton = NULL;
HWND RotateButton = NULL;
HWND ScaleButton = NULL;
HWND SelectButton = NULL;
HWND SettingsButton = NULL;
HWND ShowWhatLabel = NULL;
HWND ShowWhatCombo = NULL;


void ShowChildren()
{
	ShowWindow(Canvas,SW_SHOW);
	ShowWindow(Toggle3DView,SW_SHOW);
	ShowWindow(ResetView,SW_SHOW);
	ShowWindow(MinValLabel,SW_SHOW);
	ShowWindow(MinVal,SW_SHOW);
	ShowWindow(MaxValLabel,SW_SHOW);
	ShowWindow(MaxVal,SW_SHOW);
	ShowWindow(LoadPlate,SW_SHOW);
	ShowWindow(InfoMsg,SW_SHOW);
	ShowWindow(MoveButton,SW_SHOW);
	ShowWindow(RotateButton,SW_SHOW);
	ShowWindow(ScaleButton,SW_SHOW);
	ShowWindow(SelectButton,SW_SHOW);
	ShowWindow(SettingsButton,SW_SHOW);

	ShowWindow(ShowWhatLabel,SW_SHOW);
	ShowWindow(ShowWhatCombo,SW_SHOW);
	
}
void DestroyChildren()
{
	DestroyWindow(Canvas);
	DestroyWindow(Toggle3DView);
	DestroyWindow(ResetView);
	DestroyWindow(MinValLabel);
	DestroyWindow(MinVal);
	DestroyWindow(MaxValLabel);
	DestroyWindow(MaxVal);
	DestroyWindow(LoadPlate);
	DestroyWindow(InfoMsg);
	DestroyWindow(MoveButton);
	DestroyWindow(RotateButton);
	DestroyWindow(ScaleButton);
	DestroyWindow(SelectButton);
	DestroyWindow(SettingsButton);
	
	DestroyWindow(ShowWhatLabel);
	DestroyWindow(ShowWhatCombo);

	
}

void ChangeChildrenPos(int x,int y,int w)
{
	SetWindowPos(Toggle3DView,HWND_TOP,x,200,RIGHT_PANEL_WIDTH,40,0);
	SetWindowPos(ResetView,HWND_TOP,x,240,RIGHT_PANEL_WIDTH,40,0);
	SetWindowPos(MinValLabel,HWND_TOP,x,40,RIGHT_PANEL_WIDTH,40,0);
	SetWindowPos(MinVal,HWND_TOP,x,80,RIGHT_PANEL_WIDTH,40,0);
	SetWindowPos(MaxValLabel,HWND_TOP,x,120,RIGHT_PANEL_WIDTH,40,0);
	SetWindowPos(MaxVal,HWND_TOP,x,160,RIGHT_PANEL_WIDTH,40,0);
	SetWindowPos(LoadPlate,HWND_TOP,x,0,RIGHT_PANEL_WIDTH,40,0);
	SetWindowPos(MoveButton,HWND_TOP,x,280,RIGHT_PANEL_WIDTH/3,30,0);
	SetWindowPos(RotateButton,HWND_TOP,x+RIGHT_PANEL_WIDTH/3,280,RIGHT_PANEL_WIDTH/3,30,0);
	SetWindowPos(ScaleButton,HWND_TOP,x+2*RIGHT_PANEL_WIDTH/3,280,RIGHT_PANEL_WIDTH/3,30,0);
	SetWindowPos(SelectButton,HWND_TOP,x,310,RIGHT_PANEL_WIDTH,30,0);
	SetWindowPos(SettingsButton,HWND_TOP,x,340,RIGHT_PANEL_WIDTH,30,0);
	SetWindowPos(ShowWhatLabel,HWND_TOP,x,370,RIGHT_PANEL_WIDTH,30,0);
	SetWindowPos(ShowWhatCombo,HWND_TOP,x,400,RIGHT_PANEL_WIDTH,30,0);


	SetWindowPos(InfoMsg,HWND_TOP,0,y,w,35,0);
	
}

//загрузка пластины
void LoadPlateFromFile()
{
	//файл выбран - уничтожаем пластину
	plate.Destroy();
	//загружаем новую пластину
	if(loader.LoadGeometry(FileName,plate))
	{
		for(register int i=DENSITY;i<NUM_PROPERTIES;++i)
		{
			if(plate.GetValues((ElementProperties)i)!=NULL)
			{
				CurrentProperty = (ElementProperties)i;
				break;
			}
		}

		//выводим информацию в правой и ниженй панелях
		char Tmp[512];
		gcvt(plate.GetMinVal(CurrentProperty),10,Tmp);
		Tmp[9] = 0;
		SendMessage(MinVal,WM_SETTEXT,NULL,(LPARAM)Tmp);
			
		gcvt(plate.GetMaxVal(CurrentProperty),10,Tmp);
		Tmp[9] = 0;
		SendMessage(MaxVal,WM_SETTEXT,NULL,(LPARAM)Tmp);

		Vector3D Min,Max;
		plate.GetBounds(Min,Max);
		camera.SetBounds(Min,Max);

		char OutBuf[1024];
		FileName[1023] = 0;
		CutFileName(FileName,(unsigned int)strlen(FileName)+1,Tmp,511);
		strcpy(OutBuf,"Загружена пластина ");
		strncpy(OutBuf+19,Tmp,512);
		OutBuf[1023] = 0;
		SendMessage(InfoMsg,WM_SETTEXT,NULL,(LPARAM)OutBuf);
				

	}
	else
	{
		//невозможно загрузить файл
		FileName[1023] = 0;
		char Tmp[512],OutBuf[1024];
		CutFileName(FileName,(unsigned int)strlen(FileName)+1,Tmp,511);
		strcpy(OutBuf,"Ошибка при загрузке пластины ");
		strncpy(OutBuf+29,Tmp,512);
		OutBuf[1023] = 0;
		SendMessage(InfoMsg,WM_SETTEXT,NULL,(LPARAM)OutBuf);
	}

	//очистка комбо бокса
	SendMessage(ShowWhatCombo,CB_RESETCONTENT,0,0);

	//указание списка возможных свойств КЭ
	for(register int i=DENSITY;i<NUM_PROPERTIES;++i)
	{
		if(plate.GetValues((ElementProperties)i)!=NULL)
		{
			SendMessage(ShowWhatCombo,
						CB_ADDSTRING,0,(LPARAM)NamesOfProperties[i]);
		}
	}
	if(CurrentProperty!=NUM_PROPERTIES)
	{
		LRESULT Res = 
			SendMessage(ShowWhatCombo,
						CB_FINDSTRINGEXACT,-1,
						(LPARAM)NamesOfProperties[CurrentProperty]);
		if(Res!=CB_ERR)
		{
			SendMessage(ShowWhatCombo,
						CB_SETCURSEL,Res,0);
			
		}
	}

}

//обработка сообщений для диалогового окна настроек
LRESULT CALLBACK SettingsDlgCallback(HWND hDlg, 
									 UINT message, 
									 WPARAM wParam, 
									 LPARAM lParam)
{
	switch (message)
	{
	case WM_INITDIALOG:
		{
			//если цветокая шкала рендерится, то установить галочку
			HWND CheckTempHndl = GetDlgItem(hDlg,IDC_SHOW_VALUES);
			if(renderer.GetRenderColorInfoFlag())
			{
				SendMessage(CheckTempHndl,BM_SETCHECK,BST_CHECKED,0);
			}
			else
			{
				SendMessage(CheckTempHndl,BM_SETCHECK,BST_UNCHECKED,0);
			}

			//если оси рендерятся, то установить галочку
			CheckTempHndl = GetDlgItem(hDlg,IDC_SHOW_AXES);
			if(renderer.GetRenderAxesFlag())
			{
				SendMessage(CheckTempHndl,BM_SETCHECK,BST_CHECKED,0);
			}
			else
			{
				SendMessage(CheckTempHndl,BM_SETCHECK,BST_UNCHECKED,0);
			}

			//если отметки на осях рендерятся, то установить галочку
			CheckTempHndl = GetDlgItem(hDlg,IDC_SHOW_AXES_MARKS);
			if(renderer.GetRenderMarksOnAxesFlag())
			{
				SendMessage(CheckTempHndl,BM_SETCHECK,BST_CHECKED,0);
			}
			else
			{
				SendMessage(CheckTempHndl,BM_SETCHECK,BST_UNCHECKED,0);
			}


			//цвет
			Vector3D TmpVec = renderer.GetMaxValueColor();
			resultColor = RGB((int)(TmpVec.x*255.0f),
							  (int)(TmpVec.y*255.0f),
							  (int)(TmpVec.z*255.0f));		


		}
		return TRUE;

	case WM_COMMAND:

		if(LOWORD(wParam) == IDC_CHOOSE_MAX_COLOR)
		{
			
			// Initialize CHOOSECOLOR 
			ZeroMemory(&cc, sizeof(cc));
			cc.lStructSize = sizeof(cc);
			cc.hwndOwner = hDlg;
			cc.lpCustColors = (LPDWORD) acrCustClr;
			cc.rgbResult = resultColor;
			cc.Flags = CC_FULLOPEN | CC_RGBINIT;
 
			if (ChooseColor(&cc)==TRUE) 
			{
			    resultColor = cc.rgbResult;
			}


		}
		else if (LOWORD(wParam) == IDOK) 
		{

			//если галочка установлена, то цветовая шкала должна рендериться
			HWND CheckTempHndl = GetDlgItem(hDlg,IDC_SHOW_VALUES);
			LRESULT Result = SendMessage(CheckTempHndl,BM_GETCHECK,0,0); 
			if(Result==BST_CHECKED)
			{
				renderer.SetRenderColorInfoFlag(true);
			}
			else
			{
				renderer.SetRenderColorInfoFlag(false);
			}

			//если галочка установлена, то оси должны рендериться
			CheckTempHndl = GetDlgItem(hDlg,IDC_SHOW_AXES);
			Result = SendMessage(CheckTempHndl,BM_GETCHECK,0,0); 
			if(Result==BST_CHECKED)
			{
				renderer.SetRenderAxesFlag(true);
			}
			else
			{
				renderer.SetRenderAxesFlag(false);
			}

			//если галочка установлена, то отметки на осях должны рендериться
			CheckTempHndl = GetDlgItem(hDlg,IDC_SHOW_AXES_MARKS);
			Result = SendMessage(CheckTempHndl,BM_GETCHECK,0,0); 
			if(Result==BST_CHECKED)
			{
				renderer.SetRenderMarksOnAxesFlag(true);
			}
			else
			{
				renderer.SetRenderMarksOnAxesFlag(false);
			}

			//цвет
			renderer.SetMaxValueColor(Vector3D((float)GetRValue(resultColor)/255.0f,
											   (float)GetGValue(resultColor)/255.0f,
											   (float)GetBValue(resultColor)/255.0f));


			
			EndDialog(hDlg, LOWORD(wParam));
			return TRUE;
		}
		else if(LOWORD(wParam) == IDCANCEL)
		{
			EndDialog(hDlg, LOWORD(wParam));
			return TRUE;
		}
		break;
	}
	return FALSE;
}

//обработка сообщений для главного окна
LRESULT CALLBACK WndProc(HWND hWnd,UINT uMsg,WPARAM wParam,LPARAM lParam)
{
	switch(uMsg)
	{
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	//при изменении размера окна
	case WM_SIZE:
		//новые ширина и высота окна
		Width = LOWORD(lParam);
		Height = HIWORD(lParam);

		//изменение размеров области для рисования
		SetWindowPos(Canvas,HWND_TOP,0,0,Width-RIGHT_PANEL_WIDTH-10,Height-35,0);
		
		//изменение положения правой панели и нижней панели
        ChangeChildrenPos(Width-RIGHT_PANEL_WIDTH-2,Height-35,Width);

		//изменение размеров окна рендеринга
		if(Width-RIGHT_PANEL_WIDTH-10>=1&&
			Height-35>=1)
		{
			renderer.SetWidth(LOWORD(lParam)-RIGHT_PANEL_WIDTH-10);
			renderer.SetHeight(HIWORD(lParam)-35);
		}
		break;

	//нажата кнопка
	case WM_COMMAND:
		switch(HIWORD(wParam))
		{
			case CBN_SELCHANGE:
			//выбор свойства КЭ, которое нужно отображать
			{
				LRESULT Res = 
				SendMessage(ShowWhatCombo,
									CB_GETCURSEL,0,0);

				if(Res!=CB_ERR)
				{
					char TmpStr[512];
					SendMessage(ShowWhatCombo,
									CB_GETLBTEXT,Res,(LPARAM)TmpStr);
					TmpStr[511] = 0;
					for(register int i=DENSITY;i<NUM_PROPERTIES;++i)
					{
						if(!strcmp(TmpStr,NamesOfProperties[i]))
						{
							if(CurrentProperty!=(ElementProperties)i)
							{
								CurrentProperty = (ElementProperties)i;
								plate.Unselect();

								//выводим информацию в правой и ниженй панелях
								char Tmp[512];
								gcvt(plate.GetMinVal(CurrentProperty),10,Tmp);
								Tmp[9] = 0;
								SendMessage(MinVal,WM_SETTEXT,NULL,(LPARAM)Tmp);
				
								gcvt(plate.GetMaxVal(CurrentProperty),10,Tmp);
								Tmp[9] = 0;
								SendMessage(MaxVal,WM_SETTEXT,NULL,(LPARAM)Tmp);
							}
						}
					}
					
				}
			}
			break;
		}
		//настройки
		if(lParam==(LPARAM)SettingsButton)
		{
			DialogBox(hInst,(LPCTSTR)IDD_SETTINGS, hWnd, (DLGPROC)SettingsDlgCallback);
		}
		//переключение вида
		if(lParam==(LPARAM)Toggle3DView)
		{
			camera.ToggleRender3DView();
		}
		//ресет вида
		else if(lParam==(LPARAM)ResetView)
		{
			camera.ResetCam();
		}
		//нажата кнопка M
		else if(lParam==(LPARAM)MoveButton)
		{
			LRESULT Result = SendMessage(MoveButton,BM_GETCHECK,0,0); 
			if(Result==BST_CHECKED)
			{
				SendMessage(RotateButton,BM_SETCHECK,BST_UNCHECKED,0);
				SendMessage(ScaleButton,BM_SETCHECK,BST_UNCHECKED,0);
				SendMessage(SelectButton,BM_SETCHECK,BST_UNCHECKED,0);
				CurrentState = MOVE;
			}
			else
				CurrentState = NONE;
		}
		//нажата кнопка R
		else if(lParam==(LPARAM)RotateButton)
		{
			LRESULT Result = SendMessage(RotateButton,BM_GETCHECK,0,0); 
			if(Result==BST_CHECKED)
			{
				SendMessage(MoveButton,BM_SETCHECK,BST_UNCHECKED,0);
				SendMessage(ScaleButton,BM_SETCHECK,BST_UNCHECKED,0);
				SendMessage(SelectButton,BM_SETCHECK,BST_UNCHECKED,0);
				CurrentState = ROTATE;
			}
			else
				CurrentState = NONE;
		}
		//нажата кнопка S
		else if(lParam==(LPARAM)ScaleButton)
		{
			LRESULT Result = SendMessage(ScaleButton,BM_GETCHECK,0,0); 
			if(Result==BST_CHECKED)
			{
				SendMessage(MoveButton,BM_SETCHECK,BST_UNCHECKED,0);
				SendMessage(RotateButton,BM_SETCHECK,BST_UNCHECKED,0);
				SendMessage(SelectButton,BM_SETCHECK,BST_UNCHECKED,0);
				CurrentState = SCALE;
			}
			else
				CurrentState = NONE;
		}
		//нажата кнопка "Выбрать КЭ"
		else if(lParam==(LPARAM)SelectButton)
		{
			LRESULT Result = SendMessage(SelectButton,BM_GETCHECK,0,0); 
			if(Result==BST_CHECKED)
			{
				SendMessage(MoveButton,BM_SETCHECK,BST_UNCHECKED,0);
				SendMessage(RotateButton,BM_SETCHECK,BST_UNCHECKED,0);
				SendMessage(ScaleButton,BM_SETCHECK,BST_UNCHECKED,0);
				CurrentState = SELECT;
			}
			else
				CurrentState = NONE;
		}
		//нажата кнопка "загрузить"
		else if(lParam==(LPARAM)LoadPlate)
		{
			//подготовка к выводу диалога выбора файла
			ZeroMemory(&LoadDialog,sizeof(LoadDialog));
			LoadDialog.lStructSize = sizeof (LoadDialog) ;
			LoadDialog.hwndOwner = hWnd;
			LoadDialog.lpstrFilter = FileExtFilter;
			LoadDialog.nMaxFile = 1024 ;
			LoadDialog.Flags = OFN_EXPLORER;
			LoadDialog.lpstrFile = FileName; 
			FileName[0] = 0;
			
			//запрос файла
			if(!GetOpenFileName(&LoadDialog))
			{
				//ничего не выбрано
			}
			else
			{
				LoadPlateFromFile();
			}
		}
		break;
	
	//вкл/выкл поворота камеры
	case WM_LBUTTONDOWN:
			switch(CurrentState)
			{
				case ROTATE:
					MouseLook = true;
					GetCursorPos(&cp);
					break;
				case MOVE:
					ViewMove = true;
					GetCursorPos(&cp);
					break;
				case SCALE:
					ScaleView = true;
					GetCursorPos(&cp);
					break;
			}
		break;

	case WM_MOUSEMOVE:
		MousePosX = ((int)(short)LOWORD(lParam)); 
		MousePosY = ((int)(short)HIWORD(lParam)); 

		break;

	case WM_LBUTTONUP:
			switch(CurrentState)
			{
				case ROTATE:
					MouseLook = false;
					break;
				case MOVE:
					ViewMove = false;
					break;
				case SCALE:
					ScaleView = false;
					break;
				case SELECT:
					{
						int TmpX = MousePosX;
						int TmpY = MousePosY;
						int TmpW = Width-RIGHT_PANEL_WIDTH-10;
						int TmpH = Height-35;

						if(TmpX>TmpW)
							break;

						if(TmpY>TmpH)
							break;

						TmpY = TmpH - TmpY;

						Vector3D SelectionPoint = 
								 camera.ConvertCoordinates(TmpX,TmpY,TmpW,TmpH);
						Vector3D Pt;

						SelectionPoint = SelectionPoint*camera.GetInvertedTransformMatrix();
						Vector3D Direction(0.0f,0.0f,-1.0f);
						Direction = Direction*camera.GetInvertedRotationMatrix();

						plate.SelectTriangle(Pt,SelectionPoint,Direction,CurrentProperty);
					}
					break;
			}
		break;

	//вкл/выкл перемещения камеры
	case WM_RBUTTONDOWN:
			switch(CurrentState)
			{
				case MOVE:
					MouseLook = true;
					GetCursorPos(&cp);
					break;
				case ROTATE:
					ViewMove = true;
					GetCursorPos(&cp);
					break;
			}
		break;

	case WM_RBUTTONUP:
			switch(CurrentState)
			{
				case MOVE:
					MouseLook = false;
					break;
				case ROTATE:
					ViewMove = false;
					break;
			}
		break;

	//обработчик сообщений по умолчанию
	default:
		return  DefWindowProc(hWnd,uMsg,wParam,lParam);
	}
	return 0;
}

//если выставлен флаг, то вращаем, перемещаем или удаляем/приближаем камеру
void MouseMove()
{
	if(MouseLook)
	{
		float rx,ry;
		GetCursorPos(&pos);	
		rx = float(pos.y-cp.y);ry = float(pos.x-cp.x);
		camera.RotateCam(rx,ry);
		SetCursorPos(cp.x,cp.y);
	}
	else if(ViewMove)
	{
		float dx,dy;
		GetCursorPos(&pos);	
		dy = float(pos.y-cp.y);dx = float(pos.x-cp.x);
		camera.MoveCam(dx,dy);
		SetCursorPos(cp.x,cp.y);
	}
	else if(ScaleView)
	{
		float sc;
		GetCursorPos(&pos);	
		sc = -float(pos.y-cp.y);
		camera.Scale(sc);
		SetCursorPos(cp.x,cp.y);
	}
}

//регистрация класса окна
ATOM RegClass(HINSTANCE hInstance)
{
	WNDCLASS wc;
	ZeroMemory(&wc,sizeof(wc));
	wc.hIcon = 0;
	wc.hCursor = LoadCursor(0,IDC_ARROW);
	wc.hInstance = hInstance;
	wc.lpfnWndProc = (WNDPROC) WndProc;
	wc.lpszClassName = "VisClass";
	wc.style = CS_VREDRAW|CS_HREDRAW;
	wc.hbrBackground = (HBRUSH)COLOR_WINDOW;
	return RegisterClass(&wc);
}

int APIENTRY WinMain(HINSTANCE hInstance,
					 HINSTANCE hPrevInstance,
					 LPSTR lpCmdLine,
					 int nCmdShow)
{
	hInst = hInstance;
	//инициализация CommonCtrls
	InitCommonControls();


	if(!RegClass(hInstance))
		return 0;

	//создание окон
	HWND hWnd = CreateWindow("VisClass","Density",WS_OVERLAPPEDWINDOW,0,0,
							 Width,Height,0,0,hInstance,0);

	if(!hWnd)
	{
		UnregisterClass("VisClass",hInstance);
		return 0;
	}

	Canvas = CreateWindow("STATIC","",WS_CHILD,0,0,500,
								500,hWnd,0,hInstance,0);

	Toggle3DView = CreateWindow("BUTTON","2D/3D вид",WS_CHILD|BS_PUSHBUTTON,
								500,200,RIGHT_PANEL_WIDTH,40,hWnd,0,hInstance,0);

	ResetView = CreateWindow("BUTTON","Исходный вид",WS_CHILD|BS_PUSHBUTTON,
								500,240,RIGHT_PANEL_WIDTH,40,hWnd,0,hInstance,0);

	MinValLabel = CreateWindow("STATIC","Минимум:",WS_CHILD,500,40,RIGHT_PANEL_WIDTH,
								40,hWnd,0,hInstance,0);

	MaxValLabel = CreateWindow("STATIC","Максимум:",WS_CHILD,500,120,RIGHT_PANEL_WIDTH,
								40,hWnd,0,hInstance,0);

	MinVal = CreateWindow("STATIC","0.0",WS_CHILD,500,80,RIGHT_PANEL_WIDTH,
								40,hWnd,0,hInstance,0);

	MaxVal = CreateWindow("STATIC","1.0",WS_CHILD,500,160,RIGHT_PANEL_WIDTH,
								40,hWnd,0,hInstance,0);
	LoadPlate = CreateWindow("BUTTON","Загрузить",WS_CHILD|BS_PUSHBUTTON,500,0,RIGHT_PANEL_WIDTH,
								40,hWnd,0,hInstance,0);

	InfoMsg = CreateWindow("STATIC","",WS_CHILD,0,500,Width,
								35,hWnd,0,hInstance,0);
	
	MoveButton = CreateWindow("BUTTON","M",WS_CHILD|BS_AUTOCHECKBOX|BS_PUSHLIKE|BS_ICON ,
								500,280,RIGHT_PANEL_WIDTH/3,30,hWnd,0,hInstance,0);

	RotateButton = CreateWindow("BUTTON","R",WS_CHILD|BS_AUTOCHECKBOX|BS_PUSHLIKE|BS_ICON,
								500+RIGHT_PANEL_WIDTH/3,280,RIGHT_PANEL_WIDTH/3,30,hWnd,0,hInstance,0);

	ScaleButton = CreateWindow("BUTTON","S",WS_CHILD|BS_AUTOCHECKBOX|BS_PUSHLIKE|BS_ICON,
								500+2*RIGHT_PANEL_WIDTH/3,280,RIGHT_PANEL_WIDTH/3,30,hWnd,0,hInstance,0);
	
	SelectButton = CreateWindow("BUTTON","Выбор КЭ",WS_CHILD|BS_AUTOCHECKBOX|BS_PUSHLIKE,
								500,310,RIGHT_PANEL_WIDTH,30,hWnd,0,hInstance,0);
	
	SettingsButton = CreateWindow("BUTTON","Настройки",WS_CHILD|BS_PUSHBUTTON,
								500,340,RIGHT_PANEL_WIDTH,30,hWnd,0,hInstance,0);

	ShowWhatLabel = CreateWindow("STATIC","отображать",WS_CHILD,500,380,RIGHT_PANEL_WIDTH,
								40,hWnd,0,hInstance,0);


	ShowWhatCombo = CreateWindow("COMBOBOX","отображать",WS_CHILD|CBS_DROPDOWNLIST,500,410,RIGHT_PANEL_WIDTH,
								40,hWnd,0,hInstance,0);


	
	//иконки
	HICON Ico = LoadIcon(GetModuleHandle(NULL),MAKEINTRESOURCE(IDI_ICON1));
	SendMessage(MoveButton,BM_SETIMAGE,(WPARAM)IMAGE_ICON,(LPARAM)Ico);

	HICON Ico1 = LoadIcon(GetModuleHandle(NULL),MAKEINTRESOURCE(IDI_ICON2));
	SendMessage(RotateButton,BM_SETIMAGE,(WPARAM)IMAGE_ICON,(LPARAM)Ico1);

	HICON Ico2 = LoadIcon(GetModuleHandle(NULL),MAKEINTRESOURCE(IDI_ICON3));
	SendMessage(ScaleButton,BM_SETIMAGE,(WPARAM)IMAGE_ICON,(LPARAM)Ico2);

	//инициализация рендеринга
	if(!renderer.Init(Canvas,500,500))
	{
		DestroyChildren();
		DestroyWindow(hWnd);
		UnregisterClass("VisClass",hInstance);
		MessageBox(NULL,"Could not init renderer","Error",MB_OK);
		return 0;
	}

	//в поле минимаксных значений ф-ии записать 0
	SendMessage(MinVal,WM_SETTEXT,NULL,(WPARAM)"0");

	SendMessage(MaxVal,WM_SETTEXT,NULL,(WPARAM)"0");


	//загрузка пластины из файла
	if(strlen(lpCmdLine)>0)
	{
		int Start,Stop;
		Start = Stop = 0;
		bool foundStart = false;
		bool foundStop = false;
		for(unsigned int i=0;i<strlen(lpCmdLine);++i)
		{
			if(lpCmdLine[i]=='"')
			{
				Start = i;
				foundStart = true;
				break;
			}
		}
		
		if(foundStart&&Start<(int)strlen(lpCmdLine))
		{
			for(unsigned int i=Start+1;i<strlen(lpCmdLine);++i)
			{
				if(lpCmdLine[i]=='"')
				{
					Stop = i;
					foundStop = true;
					break;
				}
			}
		}

		int sz = Stop-Start-1;
		sz = (sz<512)?sz:0;
		if(foundStart&&foundStop&&sz>0)
		{
			strncpy(FileName,lpCmdLine+Start+1,sz);
			LoadPlateFromFile();
		}
		else
		{
			strncpy(FileName,lpCmdLine,512);
			LoadPlateFromFile();
		}
	}




	//показать окошки
	ShowWindow(hWnd,nCmdShow);
	ShowChildren();
	
	//перерисовать окно
	UpdateWindow(hWnd);

	//запуск цикла приложения
	bool finish = false;
	MSG msg;
	while(!finish)		
	{
		if(PeekMessage(&msg,NULL,0,0,PM_REMOVE))	
		{				
			if (msg.message==WM_QUIT)
			{
				finish = true;
			}
			else
			{	
				TranslateMessage(&msg);
				DispatchMessage(&msg);	
			}							
		}
		else
		{	

			MouseMove();
			camera.UpdateMatrices();
			renderer.Render(plate,CurrentProperty);


			//проверка ошибок OpenGL===DEBUG
			GLenum err = glGetError();
			if(err!=GL_NO_ERROR)
			{
				switch(err)
				{
				case GL_INVALID_ENUM:
					MessageBox(NULL,"GL_INVALID_ENUM","Error",MB_OK);
					break;

				case GL_INVALID_VALUE:
					MessageBox(NULL,"GL_INVALID_VALUE","Error",MB_OK);
					break;

				case GL_INVALID_OPERATION:
					MessageBox(NULL,"GL_INVALID_OPERATION","Error",MB_OK);
					break;

				case GL_STACK_OVERFLOW:
					MessageBox(NULL,"GL_STACK_OVERFLOW","Error",MB_OK);
					break;

				case GL_STACK_UNDERFLOW:
					MessageBox(NULL,"GL_STACK_UNDERFLOW","Error",MB_OK);
					break;

				case GL_OUT_OF_MEMORY:
					MessageBox(NULL,"GL_OUT_OF_MEMORY","Error",MB_OK);
					break;
				}
		
				finish = true;
			}
			//завершение проверки ошибок OpenGL===DEBUG


		}
	}

	//деинициализация рендеринга
	renderer.Destroy();

	DestroyChildren();
	DestroyWindow(hWnd);
	UnregisterClass("VisClass",hInstance);
	
	return (int)msg.wParam;
}
