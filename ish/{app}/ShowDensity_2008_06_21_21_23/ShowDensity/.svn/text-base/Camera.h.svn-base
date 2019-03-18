#ifndef __CAMERA__
#define __CAMERA__

#include "Loader.h"
#include <GL/gl.h>
#include <GL/glu.h>

namespace DensityVisualisation
{
	//класс камеры
	class Camera
	{
		//вращение, перемещение и масштаб
		float rx,ry,dx,dy,sc;
		//флаг, показывающий как рисовать - в 3D/2D
		bool Render3DView;
		//размеры пространства рендеринга и
		//координаты центра вращения
		float LRes,DXC,DYC,DZC;

		//матрицы
		Matrix RotX,RotY;
		Matrix ScaleMatrix,T,T_1,Res,Res_1,ResRotAround,
		       ResRotation,ResRotation_1,Ortho,Trans;
	public:
		//конструктор
		Camera() 
		{
			rx = ry = dx = dy = 0.0f;
			LRes = sc = 1.0f;
			DXC = DYC = DZC = 0.0f;
			Render3DView = true;
		}

		//вращает камеру вокруг
		void RotateCam(float _rx,float _ry)
		{
			//вращать камеру,только если разрешено рисовать 3D
			if(Render3DView)
			{
				rx+=_rx;
				if(rx>360.0f)
					rx-=360.0f;
				if(rx<0.0f)
					rx = 360.0f+rx;

				ry+=_ry;
				if(ry>360.0f)
					ry-=360.0f;
				if(ry<0.0f)
					ry = 360.0f+ry;
			}
			
		}

		//возвращает камеру в исходное положение
		void ResetCam()
		{
			rx = ry = 0.0f;
			dx = dy = 0.0f;
			sc = 1.0f;
		}

		//перемещение камеры
		void MoveCam(float _dx,float _dy)
		{
			dx+=_dx;
			dy+=_dy;
		}

		//масштабирование изображения
		void Scale(float _sc)
		{
			sc+=_sc/LRes;
			if(sc<=0.001f*LRes)
				sc = 0.001f*LRes;

			if(sc>=1000.0f*LRes)
				sc = 1000.0f*LRes;
		}

		//устанавливает флаг, который показывает, нужно ли
		//рисовать 3д поверхность
		void SetRender3DView(bool _Render3DView)
		{
			Render3DView = _Render3DView;
		}

		//изменяет флаг, который показывает, нужно ли
		//рисовать 3д поверхность
		void ToggleRender3DView()
		{
			Render3DView = !Render3DView;
		}

		//возвращает флаг Render3DView
		bool GetRender3DViewFlag()
		{
			return Render3DView;
		}

		//устанавливает объем, который будет видим
		void SetBounds(Vector3D& Min,Vector3D& Max)
		{
			float lx = Max.x-Min.x;
			float ly = Max.y-Min.y;
			float lz = Max.z-Min.z;

			float lres = lx;
			lres=lres<ly?ly:lres;
			lres=lres<lz?lz:lres;

			LRes = lres/2.0f+lres*0.05f;

			DXC = lx/2.0f;
			DYC = ly/2.0f;
			DZC = lz/2.0f;
		}

		void UpdateMatrices()
		{
			//проекция
			Ortho.Ortho(-LRes,LRes,-LRes,LRes,-3.f*LRes,3.f*LRes);

			//масштаб
			ScaleMatrix.Scale(Vector3D(sc,sc,1.0f));
			//смотреть в центр объекта
			T.Translation(Vector3D(-DXC,-DYC,-DZC));

			//если рендерить в 3D
			if(this->Render3DView)
			{
				//вращение
				RotX.RotationX(3.14159f*rx/180.0f);
				RotY.RotationZ(-3.14159f*ry/180.0f);
				//обратный перенос
				T_1.Translation(Vector3D(DXC,DYC,DZC));
				//матрица вращения
				ResRotation = RotY*RotX;

				//матрица вращения вокруг центра объекта
				ResRotAround = T*ResRotation*T_1;

				//обратное преобразование (вращение)
				ResRotation_1 = ResRotation;
				ResRotation_1.Invert();
			}
			else
			{
				//вращения нет
				ResRotAround.Identity();
				ResRotation.Identity();
				ResRotation_1.Identity();
			}

			//перемещение камеры вверх
			Vector3D Up(0.0f,1.0f,0.0f);
			Up = Up*dy;
			Up = Up*ResRotation_1;
			
			//перемещение камеры влево
			Vector3D Left(-1.0f,0.0f,0.0f);
			Left = Left*dx;
			Left = Left*ResRotation_1;
			
			//суммарное перемецение (вверх и влево)
			Vector3D Delta = Up + Left;
			Trans.Translation(Delta);

			//общее преобразование
			Res = Trans*ResRotAround*T*ScaleMatrix;
			//обратное преобразование
			Res_1 = Res;
			Res_1.Invert();
		}

		//устанавливает матрицы
		void SetupMatrices()
		{
			glLoadMatrixf(Ortho);
			glMultMatrixf(Res);
		}

		//возвращает матрицу обратного преобразования
		Matrix GetInvertedTransformMatrix()
		{
			return Res_1;
		}

		//возвращает обратную матрицу поворота
		Matrix GetInvertedRotationMatrix()
		{
			return ResRotation_1;
		}

		//преобразует из одной системы координат в другую
		Vector3D ConvertCoordinates(int x,int y,unsigned int Width,unsigned int Height)
		{
			Vector3D Pt;
			Pt.x = (2*LRes*(float)x)/((float)Width) - LRes;
			Pt.y = (2*LRes*(float)y)/((float)Height) - LRes;
			Pt.z = 3*LRes-LRes*0.01f;
			return Pt;
		}

		//возвращает значение границы рендеринга
		float GetOrthoSize() 
		{
			return LRes;
		}

		//возвращает масштаб
		float GetScaling()
		{
			return sc;
		}

		//возвращает углы вращения вокруг осей X и Z
		void GetRotation(float& _rx,float& _rz)
		{
			_rx = rx;
			_rz = ry;
		}

	};

}

#endif
