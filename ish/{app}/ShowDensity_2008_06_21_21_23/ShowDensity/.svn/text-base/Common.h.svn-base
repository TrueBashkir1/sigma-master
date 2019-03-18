#ifndef __COMMON__
#define __COMMON__

#include <cmath>

#define SafeDelete(x) {if((x)) delete(x);(x)=NULL;}
#define SafeDeleteArray(x) {if((x)) delete[](x);(x)=NULL;}

namespace DensityVisualisation
{
	
	//вектор в 3D пространстве
	struct Vector3D
	{
		union
		{
			struct
			{
				float x, y, z;
			};
			float v[3];
		};

		//конструктор
		Vector3D(float _x=0.0f,
				 float _y=0.0f,
				 float _z=0.0f)
		{
			x = _x;
			y = _y;
			z = _z;
		}
		
		//конструктор копий
		Vector3D(const Vector3D& vec)
		{
			x = vec.x;
			y = vec.y;
			z = vec.z;
		}

		//возвращает длину вектора
		float Length()
		{
			return sqrt(x*x+y*y+z*z);
		}
		

		//вычисляет скалярное произведение двух векторов
		float Dot(const Vector3D& vec) const
		{
			return (x*vec.x+y*vec.y+z*vec.z);
		}

		//нормализует вектор
		void Normalize()
		{
			float l = sqrt(x*x+y*y+z*z);
			l = 1.0f/l;
			x*=l;
			y*=l;
			z*=l;
		}

		//отрицание
		friend Vector3D operator -(const Vector3D& vec)
		{
			return Vector3D(-vec.x,-vec.y,-vec.z);
		}

		//вычитает один вектор из другого
		friend Vector3D operator -(const Vector3D& vec,const Vector3D& vec1)
		{
			return Vector3D(vec.x - vec1.x,vec.y - vec1.y,vec.z - vec1.z);
		}

		//суммирует два вектора
		friend Vector3D operator +(const Vector3D& Vec,const Vector3D& Vec1)
		{
			return Vector3D(Vec.x + Vec1.x,Vec.y + Vec1.y,Vec.z + Vec1.z);
		}

		//векторное произведение двух векторов
		friend Vector3D operator *(const Vector3D& Vec,const Vector3D& Vec1)
		{
			return Vector3D(Vec.y*Vec1.z-Vec.z*Vec1.y, 
							Vec.z*Vec1.x-Vec.x*Vec1.z, 
							Vec.x*Vec1.y-Vec.y*Vec1.x);
		}

		//умножение вектора на число
		friend Vector3D operator *(const Vector3D& Vec,float Val)
		{
			return Vector3D(Vec.x*Val,Vec.y*Val,Vec.z*Val);
		}

		//умножение вектора на число
		friend Vector3D operator *(float Val,const Vector3D& Vec)
		{
			return Vector3D(Vec.x*Val,Vec.y*Val,Vec.z*Val);
		}

		operator float * ()
		{
			return &x;
		}

		operator const float * () const
		{
			return &x;
		}

	};

	//треугольник
	struct Face
	{
		unsigned int a,b,c;
		//конструктор
		Face(unsigned int _a=0,
			 unsigned int _b=0,
			 unsigned int _c=0)
		{
			a = _a;
			b = _b;
			c = _c;
		}
	};

	//матрица 4х4
	class Matrix
	{
	public:
		//элементы матрицы
		float a[4][4];
	public:
		//конструктор
		Matrix (float _11 = 0.0f,float _12 = 0.0f,float _13 = 0.0f,float _14 = 0.0f,
				float _21 = 0.0f,float _22 = 0.0f,float _23 = 0.0f,float _24 = 0.0f,
				float _31 = 0.0f,float _32 = 0.0f,float _33 = 0.0f,float _34 = 0.0f,
				float _41 = 0.0f,float _42 = 0.0f,float _43 = 0.0f,float _44 = 0.0f)
		{
			Define(_11,_12,_13,_14,
				   _21,_22,_23,_24,
				   _31,_32,_33,_34,
				   _41,_42,_43,_44);
		}

		//оператор присваивания
		Matrix& operator =(const Matrix& Mat);
		
		//сумма двух матриц
		Matrix operator +(const Matrix& Mat);
		
		//сложение матрицы и скаляра
		Matrix operator +(float Value);
		
		//разность матриц
		Matrix operator -(const Matrix& Mat);

		//вычитание из матрицы скаляра
		Matrix operator -(float Value);

		//выполнение a[i][j] = -a[i][j]
		Matrix operator -();

		//умножение матриц
		Matrix operator *(const Matrix& Mat);
		
		//умножение матрицы на вектор
		friend Vector3D operator *(const Vector3D& Vec,const Matrix& Mat);

		//умножение матрицы на вектор
		friend Vector3D operator *(const Matrix& Mat,const Vector3D& Vec);

		//возвращает указатель на массив элементов
		operator float * ()
		{
			return &a[0][0];
		}

		//возвращает указатель на массив элементов
		operator const float * () const
		{
			return &a[0][0];
		}

		//задание элементов матрицы
		void Define(float _11,float _12,float _13,float _14,
					float _21,float _22,float _23,float _24,
					float _31,float _32,float _33,float _34,
					float _41,float _42,float _43,float _44);

		//создание единичной матрицы
		void Identity();

		//создание матрицы переноса
		void Translation(const Vector3D& Vec);

		//создание матрицы масштабирования
		void Scale(const Vector3D& Vec);

		//вращение вокруг оси X
		void RotationX(float Value);

		//вращение вокруг оси Y
		void RotationY(float Value);

		//вращение вокруг оси Z
		void RotationZ(float Value);

		//Yaw Pitch Roll
		void Rotation(const Vector3D& Vec);

		//создает матрицу перспективного преобразования
		void Perspective(float Fovy,float Aspect,float Znear,float Zfar);
		
		//Look at
		void LookAt(const Vector3D& Eye,const Vector3D& Target,const Vector3D& Up);
		
		//создает матрицу ортографической проекции
		void Ortho(float Left,float Right,
				   float Bottom,float Top,
				   float Near,float Far);

		//находит обратную матрицу
		//Compute inverse of 4x4 transformation SINGLE-PRECISION matrix.
		//Code contributed by Jacques Leroy <jle@star.be>
		//Code lifted from Brian Paul's Mesa freeware OpenGL implementation.
		//Return true for success, false for failure (singular matrix)
		bool Invert();

		//транспонирует матрицу
		void Transpose();

	};

	//ф-я для нахождения площади треугольника
	float ComputeSOfTriangle(const Vector3D& v1,const Vector3D& v2,const Vector3D& v3);
	
	//ф-я возвращает имя файла без пути к нему
	void CutFileName(const char* FileName,unsigned int Size,
					 char* NewFileName,unsigned int MaxSize);

	//проверка, находятся ли точки на одной стороне от линии
	inline bool PNTSOnTheSameSideOfTheLine(const Vector3D& v0,
										   const Vector3D& v1,
										   const Vector3D& A,
										   const Vector3D& B);

	//проверка, находится ли точка внутри треугольника
	bool PointInTriangle(const Vector3D& v0,
						 const Vector3D& v1,
						 const Vector3D& v2,
						 Vector3D& Pt);

	//пересечение плоскости с лучем
	bool RayIntersectsPlane(const Vector3D& Origin,const Vector3D& Direction,
							const Vector3D& Pt,const Vector3D& Normal,
							float *pDist);

	//находит пересечение луча с треугольником
	bool RayIntersectsTriangle(const Vector3D& Origin,Vector3D Direction,
							   const Vector3D &v0,
							   const Vector3D &v1,
							   const Vector3D &v2,
							   Vector3D *pPt,float* pDist);
	
}

#endif
