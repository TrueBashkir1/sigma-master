#ifndef __RENDERER__
#define __RENDERER__

#include "windows.h"
#include "Font.h"

#pragma comment(lib,"opengl32.lib")

namespace DensityVisualisation
{
	#define NUM_INTERVALS 4
	//класс для рисования
	class Renderer
	{
		//указатель на камеру
		Camera *pCamera;
		//цвета
		Vector3D ColorMaxVal,ColorMinVal,ColorSelect,ColorSelectedPt;
		//флаг,показывающий, нужно ли рисовать шкалу знчений ф-ии
		bool RenderColorInfoFlag;
		//флаг,показывающий, нужно ли рисовать оси координат
		bool RenderAxesFlag;
		//флаг, аоказывающий, нужно ли рисовать отметки на осях
		bool RenderMarksOnAxesFlag;
	private:
		unsigned int Width,Height;
		HGLRC hrc;
		HDC   dc;
		HWND hWnd;
		Font font;
	private:
		//установка формата пиксела устройства
		BOOL SetPFD(HDC& dc)
		{
			PIXELFORMATDESCRIPTOR pfd;
			int fmt;
			ZeroMemory(&pfd,sizeof(PIXELFORMATDESCRIPTOR));
			pfd.nSize = sizeof(PIXELFORMATDESCRIPTOR);
			pfd.dwFlags = PFD_DOUBLEBUFFER|PFD_DRAW_TO_WINDOW|PFD_SUPPORT_OPENGL;
			fmt = ChoosePixelFormat(dc,&pfd);
			
			return SetPixelFormat(dc,fmt,&pfd);
		}

		//вывод координатный осей
		void RenderAxes(Plate& plate,ElementProperties Property)
		{
			if(Property==NUM_PROPERTIES)
				return;

			if(plate.GetFaces()!=NULL)
			{
				Vector3D MaxVec,MinVec;
				plate.GetBounds(MinVec,MaxVec);
				float TmpVal = pCamera->GetOrthoSize()/5.0f;
				//рисование линий
				glColor3f(0.0f,0.0f,0.0f);
				glBegin(GL_LINES);
					glVertex3f(0.0f,MaxVec.y+TmpVal,0.0f);
					glVertex3f(0.0f,MinVec.y-TmpVal,0.0f);

					glVertex3f(MinVec.x-TmpVal,0.0f,0.0f);
					glVertex3f(MaxVec.x+TmpVal,0.0f,0.0f);
				
					glVertex3f(0.0f,0.0f,MinVec.z-TmpVal);
					glVertex3f(0.0f,0.0f,MaxVec.z+TmpVal);
				glEnd();
				//рисование стрелок
				float ArrowSz = pCamera->GetOrthoSize()/50.0f; 
				float ArrowLen = ArrowSz*3.5f;

				glBegin(GL_TRIANGLES);
					//ось X
					glVertex3f(MaxVec.x+TmpVal,-0.707106f*ArrowSz,-0.707106f*ArrowSz);
					glVertex3f(MaxVec.x+TmpVal,0.707106f*ArrowSz,-0.707106f*ArrowSz);
					glVertex3f(MaxVec.x+TmpVal,0.0f,ArrowSz);
					
					glVertex3f(MaxVec.x+TmpVal,-0.707106f*ArrowSz,-0.707106f*ArrowSz);
					glVertex3f(MaxVec.x+TmpVal,0.0f,ArrowSz);
					glVertex3f(MaxVec.x+TmpVal+ArrowLen,0.0f,0.0f);

					glVertex3f(MaxVec.x+TmpVal,0.707106f*ArrowSz,-0.707106f*ArrowSz);
					glVertex3f(MaxVec.x+TmpVal,0.0f,ArrowSz);
					glVertex3f(MaxVec.x+TmpVal+ArrowLen,0.0f,0.0f);
					
					glVertex3f(MaxVec.x+TmpVal,-0.707106f*ArrowSz,-0.707106f*ArrowSz);
					glVertex3f(MaxVec.x+TmpVal,0.707106f*ArrowSz,-0.707106f*ArrowSz);
					glVertex3f(MaxVec.x+TmpVal+ArrowLen,0.0f,0.0f);

					//ось Y
					glVertex3f(-0.707106f*ArrowSz,MaxVec.y+TmpVal,-0.707106f*ArrowSz);
					glVertex3f(0.707106f*ArrowSz,MaxVec.y+TmpVal,-0.707106f*ArrowSz);
					glVertex3f(0.0f,MaxVec.y+TmpVal,ArrowSz);
					
					glVertex3f(-0.707106f*ArrowSz,MaxVec.y+TmpVal,-0.707106f*ArrowSz);
					glVertex3f(0.0f,MaxVec.y+TmpVal,ArrowSz);
					glVertex3f(0.0f,MaxVec.y+TmpVal+ArrowLen,0.0f);

					glVertex3f(0.707106f*ArrowSz,MaxVec.y+TmpVal,-0.707106f*ArrowSz);
					glVertex3f(0.0f,MaxVec.y+TmpVal,ArrowSz);
					glVertex3f(0.0f,MaxVec.y+TmpVal+ArrowLen,0.0f);
					
					glVertex3f(-0.707106f*ArrowSz,MaxVec.y+TmpVal,-0.707106f*ArrowSz);
					glVertex3f(0.707106f*ArrowSz,MaxVec.y+TmpVal,-0.707106f*ArrowSz);
					glVertex3f(0.0f,MaxVec.y+TmpVal+ArrowLen,0.0f);

					//ось Z
					if(pCamera->GetRender3DViewFlag())
					{
						glVertex3f(-0.707106f*ArrowSz,-0.707106f*ArrowSz,MaxVec.z+TmpVal);
						glVertex3f(0.707106f*ArrowSz,-0.707106f*ArrowSz,MaxVec.z+TmpVal);
						glVertex3f(0.0f,ArrowSz,MaxVec.z+TmpVal);
						
						glVertex3f(-0.707106f*ArrowSz,-0.707106f*ArrowSz,MaxVec.z+TmpVal);
						glVertex3f(0.0f,ArrowSz,MaxVec.z+TmpVal);
						glVertex3f(0.0f,0.0f,MaxVec.z+TmpVal+ArrowLen);

						glVertex3f(0.707106f*ArrowSz,-0.707106f*ArrowSz,MaxVec.z+TmpVal);
						glVertex3f(0.0f,ArrowSz,MaxVec.z+TmpVal);
						glVertex3f(0.0f,0.0f,MaxVec.z+TmpVal+ArrowLen);
					
						glVertex3f(-0.707106f*ArrowSz,-0.707106f*ArrowSz,MaxVec.z+TmpVal);
						glVertex3f(0.707106f*ArrowSz,-0.707106f*ArrowSz,MaxVec.z+TmpVal);
						glVertex3f(0.0f,0.0f,MaxVec.z+TmpVal+ArrowLen);
					}
				glEnd();

				font.BeginRenderingIn3D();
					font.Draw(Vector3D(MaxVec.x+TmpVal+ArrowLen,0.0f,0.0f),"X",Vector3D(0.0f,0.0f,0.0f));
					font.Draw(Vector3D(0.0f,MaxVec.y+TmpVal+ArrowLen,0.0f),"Y",Vector3D(0.0f,0.0f,0.0f));
					if(pCamera->GetRender3DViewFlag())
					{
						font.Draw(Vector3D(0.0f,0.0f,MaxVec.z+TmpVal+ArrowLen),"Z",Vector3D(0.0f,0.0f,0.0f));
					}
				font.EndRenderingIn3D();

				if(!RenderMarksOnAxesFlag)
					return;
				
				
				float MarkSz = pCamera->GetOrthoSize()/30.0f;
				float _rx,_rz;
				pCamera->GetRotation(_rx,_rz);
				//рисование отметок на осях
				glLineWidth(2.5f);
				glBegin(GL_LINES);
					//отметки на оси X
					if(((_rx>225.0f&&_rx<315.0f)||
					   (_rx>45.0f&&_rx<135.0f))&&pCamera->GetRender3DViewFlag())
					{
						glVertex3f(MaxVec.x,0.0f,0.0f);
						glVertex3f(MaxVec.x,0.0f,MarkSz);
					}
					else
					{
						glVertex3f(MaxVec.x,0.0f,0.0f);
						glVertex3f(MaxVec.x,MarkSz,0.0f);
					}

					//отметки на оси Y
					if(((_rx>225.0f&&_rx<315.0f)||
					   (_rx>45.0f&&_rx<135.0f))&&pCamera->GetRender3DViewFlag())
					{
						glVertex3f(0.0f,MaxVec.y,0.0f);
						glVertex3f(0.0f,MaxVec.y,MarkSz);
					}
					else
					{
						glVertex3f(0.0f,MaxVec.y,0.0f);
						glVertex3f(MarkSz,MaxVec.y,0.0f);
					}

					if(pCamera->GetRender3DViewFlag())
					{
						//отметки на оси Z
						if((_rz>225.0f&&_rz<315.0f)||
						   (_rz>45.0f&&_rz<135.0f))
						{
							glVertex3f(0.0f,-MarkSz,MaxVec.z);
							glVertex3f(0.0f,0.0f,MaxVec.z);
						}
						else
						{
							glVertex3f(MarkSz,0.0f,MaxVec.z);
							glVertex3f(0.0f,0.0f,MaxVec.z);
						}
					}
				glEnd();
				//рисование дополнительных отметок на осях
				glLineWidth(0.5f);
				glBegin(GL_LINES);
					//отметки на оси X
					if(((_rx>225.0f&&_rx<315.0f)||
					   (_rx>45.0f&&_rx<135.0f))&&pCamera->GetRender3DViewFlag())
					{
						float DistInterval = (MaxVec.x-MinVec.x)/(float)NUM_INTERVALS;
						float CurrentMark = MinVec.x;
						for(register int i=0;i<NUM_INTERVALS;++i)
						{
							glVertex3f(CurrentMark,0.0f,0.0f);
							glVertex3f(CurrentMark,0.0f,MarkSz);
							CurrentMark+=DistInterval;
						}
					}
					else
					{
						float DistInterval = (MaxVec.x-MinVec.x)/(float)NUM_INTERVALS;
						float CurrentMark = MinVec.x;
						for(register int i=0;i<NUM_INTERVALS;++i)
						{
							glVertex3f(CurrentMark,0.0f,0.0f);
							glVertex3f(CurrentMark,MarkSz,0.0f);
							CurrentMark+=DistInterval;
						}
					}

					//отметки на оси Y
					if(((_rx>225.0f&&_rx<315.0f)||
					   (_rx>45.0f&&_rx<135.0f))&&pCamera->GetRender3DViewFlag())
					{
						float DistInterval = (MaxVec.y-MinVec.y)/(float)NUM_INTERVALS;
						float CurrentMark = MinVec.y;
						for(register int i=0;i<NUM_INTERVALS;++i)
						{
							glVertex3f(0.0f,CurrentMark,0.0f);
							glVertex3f(0.0f,CurrentMark,MarkSz);
							CurrentMark+=DistInterval;
						}
					}
					else
					{
						float DistInterval = (MaxVec.y-MinVec.y)/(float)NUM_INTERVALS;
						float CurrentMark = MinVec.y;
						for(register int i=0;i<NUM_INTERVALS;++i)
						{
							glVertex3f(0.0f,CurrentMark,0.0f);
							glVertex3f(MarkSz,CurrentMark,0.0f);
							CurrentMark+=DistInterval;
						}
					}

					if(pCamera->GetRender3DViewFlag())
					{
						//отметки на оси Z
						if((_rz>225.0f&&_rz<315.0f)||
						   (_rz>45.0f&&_rz<135.0f))
						{
							float DistInterval = (MaxVec.z-MinVec.z)/(float)NUM_INTERVALS;
							float CurrentMark = MinVec.z;
							for(register int i=0;i<NUM_INTERVALS;++i)
							{
								glVertex3f(0.0f,-MarkSz,CurrentMark);
								glVertex3f(0.0f,0.0f,CurrentMark);
								CurrentMark+=DistInterval;
							}
						}
						else
						{
							float DistInterval = (MaxVec.z-MinVec.z)/(float)NUM_INTERVALS;
							float CurrentMark = MinVec.z;
							for(register int i=0;i<NUM_INTERVALS;++i)
							{
								glVertex3f(0.0f,0.0f,CurrentMark);
								glVertex3f(MarkSz,0.0f,CurrentMark);
								CurrentMark+=DistInterval;
							}
						}
					}
				glEnd();
				glLineWidth(1.0f);
				
				//рисование текста на осях
				char Tmp[64];
				Matrix RotMat = pCamera->GetInvertedRotationMatrix();
				float Koeff = pCamera->GetOrthoSize()/(float)Height;
				float DeltaOffset = (-15.0f/pCamera->GetScaling())*Koeff;
				float DeltaOffsetX = (3.0f/pCamera->GetScaling())*Koeff;
				Vector3D PtTxt;
				font.BeginRenderingIn3D();
					gcvt((double)MaxVec.x,7,Tmp);
					Tmp[63] = 0;
					PtTxt = Vector3D(DeltaOffsetX,DeltaOffset,0.0f)*RotMat;
					PtTxt.x+=MaxVec.x;
					font.Draw(PtTxt,Tmp,Vector3D(0.0f,0.0f,0.0f));
					
					
					gcvt((double)MaxVec.y,7,Tmp);
					Tmp[63] = 0;
					PtTxt = Vector3D(DeltaOffsetX,DeltaOffset,0.0f)*RotMat;
					PtTxt.y+=MaxVec.y;
					font.Draw(PtTxt,Tmp,Vector3D(0.0f,0.0f,0.0f));

					if(pCamera->GetRender3DViewFlag())
					{
						gcvt((double)plate.GetMaxVal(Property),7,Tmp);
						Tmp[63] = 0;
						PtTxt = Vector3D(DeltaOffsetX,DeltaOffsetX,0.0f)*RotMat;
						PtTxt.z+=MaxVec.z;
						font.Draw(PtTxt,Tmp,Vector3D(0.0f,0.0f,0.0f));
					}
				font.EndRenderingIn3D();

			}
			else
			{
				glColor3f(0.0f,0.0f,0.0f);
				glBegin(GL_LINES);
					glVertex3f(0.0f,500.0f,0.0f);
					glVertex3f(0.0f,-500.0f,0.0f);

					glVertex3f(-500.0f,0.0f,0.0f);
					glVertex3f(500.0f,0.0f,0.0f);
				
					glVertex3f(0.0f,0.0f,-500.0f);
					glVertex3f(0.0f,0.0f,500.0f);
				glEnd();
			}
		}

		//вывод окошка с координатами выбранной точки и
		//номером треугольника
		void RenderOutputWindow(Vector3D Pt,int Index,float XPos,float YPos)
		{
			char Tmp[64];
			char OutBuf[256];
			//начало вывода текста
			font.BeginRendering(Width,Height);

			glEnable(GL_BLEND);
			glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
			glColor4f(0.8f,0.8f,0.8f,0.7f);
			glBegin(GL_QUADS);
				glVertex2f(XPos,YPos);
				glVertex2f(XPos+105.0f,YPos);
				glVertex2f(XPos+105.0f,YPos+54.0f);
				glVertex2f(XPos,YPos+54.0f);
			glEnd();

			glColor4f(0.0f,0.0f,0.0f,0.7f);
			glLineWidth(5.0f);
			glBegin(GL_LINES);
				glVertex2f(XPos+107.5f,YPos+2.5f);
				glVertex2f(XPos+107.5f,YPos+59.5f);

				glVertex2f(XPos+105.0f,YPos+56.5f);
				glVertex2f(XPos+2.5f,YPos+56.5f);
			glEnd();
			glLineWidth(1.0f);
			glDisable(GL_BLEND);
					
			//вывод координаты X
			gcvt((double)Pt.x,10,Tmp);
			Tmp[63] = 0;
			strcpy(OutBuf,"X = ");
			strncpy(OutBuf+4,Tmp,128);
			OutBuf[128] = 0;
			font.Draw(XPos+2.0f,YPos+14.0f,OutBuf,Vector3D(0.0f,0.0f,0.0f));

			//вывод координаты Y
			gcvt((double)Pt.y,10,Tmp);
			Tmp[63] = 0;
			strcpy(OutBuf,"Y = ");
			strncpy(OutBuf+4,Tmp,128);
			OutBuf[128] = 0;
			font.Draw(XPos+2.0f,YPos+26.0f,OutBuf,Vector3D(0.0f,0.0f,0.0f));

			//вывод координаты Z
			gcvt((double)Pt.z,10,Tmp);
			Tmp[63] = 0;
			strcpy(OutBuf,"Z = ");
			strncpy(OutBuf+4,Tmp,128);
			OutBuf[128] = 0;
			font.Draw(XPos+2.0f,YPos+38.0f,OutBuf,Vector3D(0.0f,0.0f,0.0f));

			//вывод номера КЭ
			itoa(Index+1,Tmp,10);
			Tmp[63] = 0;
			strcpy(OutBuf,"КЭ = ");
			strncpy(OutBuf+5,Tmp,128);
			OutBuf[128] = 0;
			font.Draw(XPos+2.0f,YPos+50.0f,OutBuf,Vector3D(0.0f,0.0f,0.0f));

			//завершение вывода текста
			font.EndRendering();
		}

		//вывод цветовой шкалы
		void RenderColorInfo(float MinVal,float MaxVal)
		{
			float Delta = 13.0f/(float)Height;
			font.BeginRendering(1,1);

			glBegin(GL_QUADS);
				glColor3fv(ColorMaxVal);
				glVertex3f(0.02f,0.1f,0.0f);
				glVertex3f(0.07f,0.1f,0.0f);

				glColor3fv(ColorMinVal);
				glVertex3f(0.07f,0.9f,0.0f);
				glVertex3f(0.02f,0.9f,0.0f);
			glEnd();

			glColor3fv(0.3f*ColorMaxVal);
			glBegin(GL_LINES);
				glVertex3f(0.02f,0.1f,0.0f);
				glVertex3f(0.07f,0.1f,0.0f);

				glVertex3f(0.07f,0.1f,0.0f);
				glVertex3f(0.07f,0.9f,0.0f);

				glVertex3f(0.07f,0.9f,0.0f);
				glVertex3f(0.02f,0.9f,0.0f);

				glVertex3f(0.02f,0.9f,0.0f);
				glVertex3f(0.02f,0.1f,0.0f);
			glEnd();
			
			
			char Tmp[128];
			gcvt((double)MinVal,7,Tmp);
			Tmp[64] = 0;

			font.Draw(0.021f,0.9f+Delta,Tmp,Vector3D(0.0f,0.0f,0.0f));


			gcvt((double)MaxVal,7,Tmp);
			Tmp[64] = 0;
			font.Draw(0.021f,0.09f,Tmp,Vector3D(0.0f,0.0f,0.0f));


			font.EndRendering();
		}

	public:
		//конструктор
		Renderer(Camera* _pCamera = NULL) 
		{
			Width = Height = 400;
			hrc = 0;
			dc = 0;
			hWnd = 0;
			pCamera = _pCamera;

			ColorMaxVal = Vector3D(1.0f,1.0f,0.0f);
			ColorSelect = Vector3D(1.0f,0.0f,0.0f);
			ColorSelectedPt = Vector3D(0.1f,0.7f,0.2f);
			ColorMinVal = Vector3D(0.2f,0.2f,0.0f);
			RenderColorInfoFlag = true;
			RenderAxesFlag = true;
			RenderMarksOnAxesFlag = true;
		}
		//деструктор
		~Renderer()
		{
			Destroy();
		}

		//уничтожает контекст рендеринга
		void Destroy()
		{
			if(hrc==NULL||hWnd==NULL||dc==NULL)
				return;

			//уничтожение шрифта OpenGL
			font.Destroy();
			//уничтожение контекста OpenGL 
			wglMakeCurrent(0,0);
			wglDeleteContext(hrc);
			//освобождение контекста устройства
			ReleaseDC(hWnd,dc);
			DeleteDC(dc);
			//обNULLение
			hrc = 0;
			dc = 0;
			hWnd = 0;
		}

		//инициализация рендеринга
		bool Init(HWND _hWnd,unsigned int _Width,unsigned int _Height)
		{
			hWnd = _hWnd;
			if(hWnd==NULL)
				return false;
			//получение контекста устройства
			dc = GetDC(hWnd);
			
			//установка формата пиксела
			if(!SetPFD(dc))
				return false;

			//создание контекста воспроизведения
			hrc = wglCreateContext(dc);
			if(hrc==NULL)
				return false;

			//начальное состояние
			wglMakeCurrent(dc,hrc);

			//инициализация шрифта
			font.Init(dc,5,12);
			//инициализация сервера OpenGL
			glEnable(GL_DEPTH_TEST);
			glDisable(GL_CULL_FACE);
			
			Width = _Width;
			Height = _Height;
			return true;
		}

		//утановить камеру
		void SetCamera(Camera* _pCamera)
		{
			pCamera = _pCamera;
		}

		//установка флага, показывающего, рисовать ли шкалу значений
		void SetRenderColorInfoFlag(bool Flag)
		{
			RenderColorInfoFlag = Flag;
		}

		//возвращает значение флага RenderColorInfoFlag
		bool GetRenderColorInfoFlag()
		{
			return RenderColorInfoFlag;
		}

		//установка флага, показывающего, рисовать ли оси
		void SetRenderAxesFlag(bool Flag)
		{
			RenderAxesFlag = Flag;
		}

		//возвращает значение флага RenderAxesFlag
		bool GetRenderAxesFlag()
		{
			return RenderAxesFlag;
		}

		//установка флага, показывающего, рисовать ли отметки на осях
		void SetRenderMarksOnAxesFlag(bool Flag)
		{
			RenderMarksOnAxesFlag = Flag;
		}

		//возвращает значение флага RenderMarksOnAxesFlag
		bool GetRenderMarksOnAxesFlag()
		{
			return RenderMarksOnAxesFlag;
		}

		//устанавливает цвет максимального значения функции
		void SetMaxValueColor(Vector3D Color)
		{
			ColorMaxVal = Color;
			ColorMinVal = 0.2f*ColorMaxVal;
		}

		//возвращает цвет максимального значения функции
		Vector3D GetMaxValueColor()
		{
			return ColorMaxVal;
		}

		//устанавливает ширину экрана
		void SetWidth(unsigned int _Width)
		{
			if(_Width==0)
				return;

			Width = _Width;
		}

		//устанавливает высоту экрана
		void SetHeight(unsigned int _Height)
		{
			if(_Height==0)
				return;

			Height = _Height;
		}

		//рендеринг
		void Render(Plate& plate,ElementProperties Property)
		{
			if(Property==NUM_PROPERTIES)
				return;

			if(hrc==NULL||hWnd==NULL||dc==NULL||pCamera==NULL)
				return;

			

			glClearColor(1.0f,1.0f,1.0f,1.0f);
			glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

			glViewport(0,0,Width,Height);
			glScissor(0,0,Width,Height);

			//установка матриц проекции и модели
			glMatrixMode(GL_PROJECTION);
			pCamera->SetupMatrices();

			//рисование самой модели			
			glMatrixMode(GL_MODELVIEW);
			glLoadIdentity();
			

			//рисование осей
			if(RenderAxesFlag)
				RenderAxes(plate,Property);
			//
			Vector3D* pVrt = plate.GetVertices();
			Face* pFace = plate.GetFaces();
			
			glColor3f(0.0f,0.0f,0.0f);
			if(pVrt&&pFace&&plate.GetValues(Property))
			{
				//рисуем плоское изображение ф-ии
				glBegin(GL_TRIANGLES);
				for(register unsigned int i=0;i<plate.GetNumFaces();++i)
				{
					//цвет треугольника зависит от значения 
					//ф-ии
					float a = plate.GetMinVal(Property);
					float b = plate.GetMaxVal(Property);
					float d = b-a;
					float x = (plate.GetValues(Property)[i]-a)/d;
					
					Vector3D TmpColVec = ColorMaxVal - ColorMinVal;
					

					if(plate.GetSelectedTriangleIndex()==(int)i)
					{
						glColor3fv(ColorSelect);
					}
					else
					{
						glColor3fv(ColorMinVal + x*TmpColVec);
					}

					glVertex3fv((float*)pVrt[pFace[i].a]);	
					glVertex3fv((float*)pVrt[pFace[i].b]);
					glVertex3fv((float*)pVrt[pFace[i].c]);
				
				}
				glEnd();

				//запрещение записи в буффер глубины
				glDepthMask(0);
				
				//вывод контура треугольника
				glDepthFunc(GL_LEQUAL);
				glColor3fv(0.3f*ColorMaxVal);
				glBegin(GL_LINES);
				for(register unsigned int i=0;i<plate.GetNumFaces();++i)
				{
					glVertex3fv((float*)pVrt[pFace[i].a]);
					glVertex3fv((float*)pVrt[pFace[i].b]);

					glVertex3fv((float*)pVrt[pFace[i].b]);
					glVertex3fv((float*)pVrt[pFace[i].c]);

					glVertex3fv((float*)pVrt[pFace[i].c]);
					glVertex3fv((float*)pVrt[pFace[i].a]);

				}
				glEnd();
				glDepthFunc(GL_LESS);
				
				//разрешение записи в буффер глубины				
				glDepthMask(1);

				
				//рендеринг выбранной точки(если таковая имеется)
				if(plate.GetSelectedTriangleIndex()>=0)
				{
					Vector3D PtOnTri = plate.GetSelectedPoint();
					float sz = pCamera->GetOrthoSize()/(100.0f*pCamera->GetScaling());
					float szz = 2.0f*sz;
					glColor3fv(ColorSelectedPt);
					glBegin(GL_QUADS);
						//верх
						glVertex3f(PtOnTri.x-sz,PtOnTri.y-sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x-sz,PtOnTri.y+sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x+sz,PtOnTri.y+sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x+sz,PtOnTri.y-sz,PtOnTri.z+szz);

						//лево
						glVertex3f(PtOnTri.x-sz,PtOnTri.y-sz,PtOnTri.z);
						glVertex3f(PtOnTri.x-sz,PtOnTri.y-sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x-sz,PtOnTri.y+sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x-sz,PtOnTri.y+sz,PtOnTri.z);

						//право
						glVertex3f(PtOnTri.x+sz,PtOnTri.y-sz,PtOnTri.z);
						glVertex3f(PtOnTri.x+sz,PtOnTri.y-sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x+sz,PtOnTri.y+sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x+sz,PtOnTri.y+sz,PtOnTri.z);

						//перед
						glVertex3f(PtOnTri.x-sz,PtOnTri.y+sz,PtOnTri.z);
						glVertex3f(PtOnTri.x-sz,PtOnTri.y+sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x+sz,PtOnTri.y+sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x+sz,PtOnTri.y+sz,PtOnTri.z);

						//
						glVertex3f(PtOnTri.x-sz,PtOnTri.y-sz,PtOnTri.z);
						glVertex3f(PtOnTri.x-sz,PtOnTri.y-sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x+sz,PtOnTri.y-sz,PtOnTri.z+szz);
						glVertex3f(PtOnTri.x+sz,PtOnTri.y-sz,PtOnTri.z);
					glEnd();
				}



				//рендеринг 3D изображения ф-ии плотности
				Face* p3DFace = plate.Get3DViewFaces();
				Vector3D* p3DVrt = plate.Get3DViewVertices(Property);
				if(p3DFace&&p3DVrt&&pCamera->GetRender3DViewFlag())
				{
					//рендеринг треугольников
					glBegin(GL_TRIANGLES);
					for(register unsigned int i=0;i<plate.GetNumFaces();++i)
					{
						float a = plate.GetMinVal(Property);
						float b = plate.GetMaxVal(Property);
						float d = b-a;
						float x = (plate.GetValues(Property)[i]-a)/d;
					
						Vector3D TmpColVec = ColorMaxVal - ColorMinVal;

						if(plate.GetSelectedTriangleIndex()==(int)i)
						{
							glColor3fv(ColorSelect);
						}
						else
						{
							glColor3fv(ColorMinVal + x*TmpColVec);
						}
						glVertex3fv((float*)p3DVrt[p3DFace[i].a]);	
						glVertex3fv((float*)p3DVrt[p3DFace[i].b]);
						glVertex3fv((float*)p3DVrt[p3DFace[i].c]);
				
					}
					glEnd();

					//рендеринг четырехугольников, придающих
					//картинке объемность
					glColor3f(0.7f,0.7f,0.5f);
					glBegin(GL_QUADS);
					for(register unsigned int i=0;i<plate.GetNumFaces();++i)
					{
						glVertex3f(p3DVrt[p3DFace[i].a].x,p3DVrt[p3DFace[i].a].y,0.0f);
						glVertex3f(p3DVrt[p3DFace[i].b].x,p3DVrt[p3DFace[i].b].y,0.0f);
						glVertex3fv((float*)p3DVrt[p3DFace[i].b]);
						glVertex3fv((float*)p3DVrt[p3DFace[i].a]);

						
						glVertex3f(p3DVrt[p3DFace[i].b].x,p3DVrt[p3DFace[i].b].y,0.0f);
						glVertex3f(p3DVrt[p3DFace[i].c].x,p3DVrt[p3DFace[i].c].y,0.0f);
						glVertex3fv((float*)p3DVrt[p3DFace[i].c]);
						glVertex3fv((float*)p3DVrt[p3DFace[i].b]);


						glVertex3f(p3DVrt[p3DFace[i].a].x,p3DVrt[p3DFace[i].a].y,0.0f);
						glVertex3f(p3DVrt[p3DFace[i].c].x,p3DVrt[p3DFace[i].c].y,0.0f);
						glVertex3fv((float*)p3DVrt[p3DFace[i].c]);
						glVertex3fv((float*)p3DVrt[p3DFace[i].a]);
				
					}
					glEnd();

					//рендеринг линий, очерчивающих контуры 
					//четырехугольников
					glDepthFunc(GL_LEQUAL);
					glColor3f(0.4f,0.4f,0.4f);
					glBegin(GL_LINES);
					for(register unsigned int i=0;i<plate.GetNumFaces();++i)
					{
						glVertex3f(p3DVrt[p3DFace[i].a].x,p3DVrt[p3DFace[i].a].y,0.0f);
						glVertex3fv((float*)p3DVrt[p3DFace[i].a]);

						
						glVertex3f(p3DVrt[p3DFace[i].b].x,p3DVrt[p3DFace[i].b].y,0.0f);
						glVertex3fv((float*)p3DVrt[p3DFace[i].b]);


						glVertex3f(p3DVrt[p3DFace[i].c].x,p3DVrt[p3DFace[i].c].y,0.0f);
						glVertex3fv((float*)p3DVrt[p3DFace[i].c]);
					}
					glEnd();
					glDepthFunc(GL_LESS);
					
				}
		

				//вывод текста - если выбран треугольник, то выводятся координаты
				//выбранной точки и индекс треугольника
				if(plate.GetSelectedTriangleIndex()>=0)
				{
					int SelectedTriIndex = plate.GetSelectedTriangleIndex();
					Vector3D PtOnTri = plate.GetSelectedPoint();
					RenderOutputWindow(Vector3D(PtOnTri.x,PtOnTri.y,
												plate.GetValues(Property)[SelectedTriIndex]),
												SelectedTriIndex,(float)Width-112.0f,3.0f);
				}

				//рендеринг цветовой шкалы
				if(RenderColorInfoFlag)
				{
					RenderColorInfo(plate.GetMinVal(Property),plate.GetMaxVal(Property));
				}

			}
			 
			//вывод кадра
			SwapBuffers(dc);
		}

	};

}

#endif
