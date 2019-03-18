#include "Common.h"
#include <string.h>

namespace DensityVisualisation
{

	#define EPSILON 0.001f

	//оператор присваивания
	Matrix& Matrix::operator =(const Matrix& Mat)
	{
		a[0][0] = Mat.a[0][0];a[0][1] = Mat.a[0][1];a[0][2] = Mat.a[0][2];a[0][3] = Mat.a[0][3];
		a[1][0] = Mat.a[1][0];a[1][1] = Mat.a[1][1];a[1][2] = Mat.a[1][2];a[1][3] = Mat.a[1][3];
		a[2][0] = Mat.a[2][0];a[2][1] = Mat.a[2][1];a[2][2] = Mat.a[2][2];a[2][3] = Mat.a[2][3];
		a[3][0] = Mat.a[3][0];a[3][1] = Mat.a[3][1];a[3][2] = Mat.a[3][2];a[3][3] = Mat.a[3][3];
		return *this;
	}

	//сумма двух матриц
	Matrix Matrix::operator +(const Matrix& Mat)
	{
		return Matrix(a[0][0] + Mat.a[0][0],a[0][1] + Mat.a[0][1],a[0][2] + Mat.a[0][2],a[0][3] + Mat.a[0][3],
					  a[1][0] + Mat.a[1][0],a[1][1] + Mat.a[1][1],a[1][2] + Mat.a[1][2],a[1][3] + Mat.a[1][3],
					  a[2][0] + Mat.a[2][0],a[2][1] + Mat.a[2][1],a[2][2] + Mat.a[2][2],a[2][3] + Mat.a[2][3],
					  a[3][0] + Mat.a[3][0],a[3][1] + Mat.a[3][1],a[3][2] + Mat.a[3][2],a[3][3] + Mat.a[3][3]);
	}

	//сложение матрицы и скаляра
	Matrix Matrix::operator +(float Value)
	{
		return Matrix(a[0][0] + Value,a[0][1] + Value,a[0][2] + Value,a[0][3] + Value,
					  a[1][0] + Value,a[1][1] + Value,a[1][2] + Value,a[1][3] + Value,
					  a[2][0] + Value,a[2][1] + Value,a[2][2] + Value,a[2][3] + Value,
					  a[3][0] + Value,a[3][1] + Value,a[3][2] + Value,a[3][3] + Value);
	}

	//разность матриц
	Matrix Matrix::operator -(const Matrix& Mat)
	{
		return Matrix(a[0][0] - Mat.a[0][0],a[0][1] - Mat.a[0][1],a[0][2] - Mat.a[0][2],a[0][3] - Mat.a[0][3],
					  a[1][0] - Mat.a[1][0],a[1][1] - Mat.a[1][1],a[1][2] - Mat.a[1][2],a[1][3] - Mat.a[1][3],
					  a[2][0] - Mat.a[2][0],a[2][1] - Mat.a[2][1],a[2][2] - Mat.a[2][2],a[2][3] - Mat.a[2][3],
					  a[3][0] - Mat.a[3][0],a[3][1] - Mat.a[3][1],a[3][2] - Mat.a[3][2],a[3][3] - Mat.a[3][3]);
	}	

	//вычитание из матрицы скаляра
	Matrix Matrix::operator -(float Value)
	{
		return Matrix(a[0][0] - Value,a[0][1] - Value,a[0][2] - Value,a[0][3] - Value,
					  a[1][0] - Value,a[1][1] - Value,a[1][2] - Value,a[1][3] - Value,
					  a[2][0] - Value,a[2][1] - Value,a[2][2] - Value,a[2][3] - Value,
					  a[3][0] - Value,a[3][1] - Value,a[3][2] - Value,a[3][3] - Value);
	}

	//выполнение a[i][j] = -a[i][j]
	Matrix Matrix::operator -()
	{
		return Matrix(-a[0][0],-a[0][1],-a[0][2],-a[0][3],
					  -a[1][0],-a[1][1],-a[1][2],-a[1][3],
                      -a[2][0],-a[2][1],-a[2][2],-a[2][3],
                      -a[3][0],-a[3][1],-a[3][2],-a[3][3]);
	}

	//умножение матриц
	Matrix Matrix::operator *(const Matrix& Mat)
	{
		Matrix c;

		for ( register int i = 0; i < 4; i++ )
			for ( register int j = 0; j < 4; j++ )
				c.a [i][j] = a [i][0]*Mat.a [0][j]+a [i][1]*Mat.a [1][j]+a [i][2]*Mat.a [2][j]+a [i][3]*Mat.a [3][j];

		return c;
	}

	//умножение матрицы на вектор
	Vector3D operator *(const Vector3D& Vec,const Matrix& Mat)
	{
		return Vector3D(Vec.x*Mat.a[0][0] + Vec.y*Mat.a[1][0] + Vec.z*Mat.a[2][0] + Mat.a[3][0],
						Vec.x*Mat.a[0][1] + Vec.y*Mat.a[1][1] + Vec.z*Mat.a[2][1] + Mat.a[3][1],
						Vec.x*Mat.a[0][2] + Vec.y*Mat.a[1][2] + Vec.z*Mat.a[2][2] + Mat.a[3][2]);
	}
	
	//умножение матрицы на вектор
	Vector3D operator *(const Matrix& Mat,const Vector3D& Vec)
	{
		return Vector3D(Vec.x*Mat.a[0][0] + Vec.y*Mat.a[1][0] + Vec.z*Mat.a[2][0] + Mat.a[3][0],
						Vec.x*Mat.a[0][1] + Vec.y*Mat.a[1][1] + Vec.z*Mat.a[2][1] + Mat.a[3][1],
						Vec.x*Mat.a[0][2] + Vec.y*Mat.a[1][2] + Vec.z*Mat.a[2][2] + Mat.a[3][2]);
	}

	//задание элементов матрицы
	void Matrix::Define(float _11,float _12,float _13,float _14,
						float _21,float _22,float _23,float _24,
						float _31,float _32,float _33,float _34,
						float _41,float _42,float _43,float _44)
	{
		a[0][0] = _11;a[0][1] = _12;a[0][2] = _13;a[0][3] = _14;
		a[1][0] = _21;a[1][1] = _22;a[1][2] = _23;a[1][3] = _24;
		a[2][0] = _31;a[2][1] = _32;a[2][2] = _33;a[2][3] = _34;
		a[3][0] = _41;a[3][1] = _42;a[3][2] = _43;a[3][3] = _44;
	}

	//создание единичной матрицы
	void Matrix::Identity()
	{
		a[0][0] = 1.0f;a[0][1] = 0.0f;a[0][2] = 0.0f;a[0][3] = 0.0f;
		a[1][0] = 0.0f;a[1][1] = 1.0f;a[1][2] = 0.0f;a[1][3] = 0.0f;
		a[2][0] = 0.0f;a[2][1] = 0.0f;a[2][2] = 1.0f;a[2][3] = 0.0f;
		a[3][0] = 0.0f;a[3][1] = 0.0f;a[3][2] = 0.0f;a[3][3] = 1.0f;
	}

	//создание матрицы переноса
	void Matrix::Translation(const Vector3D& Vec)
	{
		a[0][0] =   1.0f;a[0][1] =   0.0f;a[0][2] =   0.0f;a[0][3] = 0.0f;
		a[1][0] =   0.0f;a[1][1] =   1.0f;a[1][2] =   0.0f;a[1][3] = 0.0f;
		a[2][0] =   0.0f;a[2][1] =   0.0f;a[2][2] =   1.0f;a[2][3] = 0.0f;
		a[3][0] = Vec.x;a[3][1] = Vec.y;a[3][2] = Vec.z;a[3][3] = 1.0f;
	}

	//создание матрицы масштабирования
	void Matrix::Scale(const Vector3D& Vec)
	{
		a[0][0] = Vec.x;a[0][1] =   0.0f;a[0][2] =   0.0f;a[0][3] = 0.0f;
		a[1][0] =   0.0f;a[1][1] = Vec.y;a[1][2] =   0.0f;a[1][3] = 0.0f;
		a[2][0] =   0.0f;a[2][1] =   0.0f;a[2][2] = Vec.z;a[2][3] = 0.0f;
		a[3][0] =   0.0f;a[3][1] =   0.0f;a[3][2] =   0.0f;a[3][3] = 1.0f;
	}

	//вращение вокруг оси X
	void Matrix::RotationX(float Value)
	{
		float c = cos(Value),s = sin(Value);
		a[0][0] =   1.0f;a[0][1] = 0.0f;a[0][2] =	0.0f;a[0][3] = 0.0f;
		a[1][0] =   0.0f;a[1][1] =   c;a[1][2] =	  s;a[1][3] = 0.0f;
		a[2][0] =   0.0f;a[2][1] =  -s;a[2][2] =   c;a[2][3] = 0.0f;
		a[3][0] =   0.0f;a[3][1] = 0.0f;a[3][2] =	0.0f;a[3][3] = 1.0f;
	}

	//вращение вокруг оси Y
	void Matrix::RotationY(float Value)
	{
		float c = cos(Value),s = sin(Value);
		a[0][0] =     c;a[0][1] = 0.0f;a[0][2] =	 -s;a[0][3] = 0.0f;
		a[1][0] =   0.0f;a[1][1] = 1.0f;a[1][2] =	0.0f;a[1][3] = 0.0f;
		a[2][0] =     s;a[2][1] = 0.0f;a[2][2] =   c;a[2][3] = 0.0f;
		a[3][0] =   0.0f;a[3][1] = 0.0f;a[3][2] =	0.0f;a[3][3] = 1.0f;
	}

	//вращение вокруг оси Z
	void Matrix::RotationZ(float Value)
	{
		float c = cos(Value),s = sin(Value);
		a[0][0] =     c;a[0][1] =   s;a[0][2] =	0.0f;a[0][3] = 0.0f;
		a[1][0] =    -s;a[1][1] =   c;a[1][2] =	0.0f;a[1][3] = 0.0f;
		a[2][0] =   0.0f;a[2][1] = 0.0f;a[2][2] = 1.f;a[2][3] = 0.0f;
		a[3][0] =   0.0f;a[3][1] = 0.0f;a[3][2] =	0.0f;a[3][3] = 1.0f;
	}

	//Yaw Pitch Roll
	void Matrix::Rotation(const Vector3D& Vec)
	{
		Matrix yaw,pitch,roll;	
		yaw.RotationX(Vec.x);
		pitch.RotationY(Vec.y);
		roll.RotationZ(Vec.z);
		*this = yaw * pitch * roll;
	}

	//создает матрицу перспективного преобразования
	void Matrix::Perspective(float fovy,float Aspect,float Znear,float Zfar)
	{
		float tg = 0.7f;//tan(fovy/2.f);
		float xScale = Aspect*tg,yScale = 1.f/tg;

		a[0][0] =   xScale;a[0][1] =    0.0f;a[0][2] =           0.0f;a[0][3] = 0.0f;
		a[1][0] =      0.0f;a[1][1] = yScale;a[1][2] =           0.0f;a[1][3] = 0.0f;
		a[2][0] =      0.0f;a[2][1] =    0.0f;a[2][2] =    Zfar/(Znear-Zfar);a[2][3] = -1.0f;
		a[3][0] =      0.0f;a[3][1] =    0.0f;a[3][2] = Znear*Zfar/(Znear-Zfar);a[3][3] = 0.0f;
	}
	
	//Look at
	void Matrix::LookAt(const Vector3D& Eye,const Vector3D& Target,const Vector3D& Up)
	{
		Vector3D zaxis = Eye - Target;
		zaxis.Normalize();

		Vector3D xaxis = Up*zaxis;
		xaxis.Normalize();

	    Vector3D yaxis = zaxis*xaxis;

		a[0][0] =		  xaxis.x;a[0][1] =			yaxis.x;a[0][2] =		  zaxis.x;a[0][3] = 0.0f;
		a[1][0] =		  xaxis.y;a[1][1] =			yaxis.y;a[1][2] =		  zaxis.y;a[1][3] = 0.0f;
		a[2][0] =	  	  xaxis.z;a[2][1] =			yaxis.z;a[2][2] =		  zaxis.z;a[2][3] = 0.0f;
		a[3][0] = -xaxis.Dot(Eye);a[3][1] = -yaxis.Dot(Eye);a[3][2] = -zaxis.Dot(Eye);a[3][3] = 1.0f;
	}
 
	//создает матрицу ортографической проекции
	void Matrix::Ortho(float Left,float Right,
					   float Bottom,float Top,
					   float Near,float Far)
	{

		float RML = Right - Left;
		float TMB = Top - Bottom;
		float FMN = Far - Near;

		float tx = - (Right + Left)/RML;
		float ty = - (Top + Bottom)/TMB;
		float tz = - (Far + Near)/FMN;

		a[0][0] = 2.0f/RML;a[0][1] =     0.0f;a[0][2] =	     0.0f;a[0][3] =    tx;
		a[1][0] =	  0.0f;a[1][1] = 2.0f/TMB;a[1][2] =	     0.0f;a[1][3] =    ty;
		a[2][0] =	  0.0f;a[2][1] =	 0.0f;a[2][2] =	-1.0f/FMN;a[2][3] =    tz;
		a[3][0] =     0.0f;a[3][1] =     0.0f;a[3][2] =   Far/FMN;a[3][3] =  1.0f;
	}

	//находит обратную матрицу
	//Compute inverse of 4x4 transformation SINGLE-PRECISION matrix.
	//Code contributed by Jacques Leroy <jle@star.be>
	//Code lifted from Brian Paul's Mesa freeware OpenGL implementation.
	//Return true for success, false for failure (singular matrix)
	bool Matrix::Invert()
	{
		#define SWAP_ROWS(a, b) {  float * _tmp = a; (a)=(b); (b)=_tmp; }
		#define MAT(m,r,c)     m [r][c]

		float	wtmp [4][8];
		float	m0, m1, m2, m3, s;
		float	* r0, * r1, * r2, * r3;

		r0 = wtmp [0];
		r1 = wtmp [1];
		r2 = wtmp [2];
		r3 = wtmp [3];
	
		r0 [0] = MAT(a,0,0);
		r0 [1] = MAT(a,0,1);
		r0 [2] = MAT(a,0,2);
		r0 [3] = MAT(a,0,3);
		r0 [4] = 1;
		r0 [5] =
		r0 [6] =
		r0 [7] = 0;

		r1 [0] = MAT(a,1,0);
		r1 [1] = MAT(a,1,1);
		r1 [2] = MAT(a,1,2);
		r1 [3] = MAT(a,1,3);
		r1 [5] = 1;
		r1 [4] =
		r1 [6] =
		r1 [7] = 0,

		r2 [0] = MAT(a,2,0);
		r2 [1] = MAT(a,2,1);
		r2 [2] = MAT(a,2,2);
		r2 [3] = MAT(a,2,3);
		r2 [6] = 1;
		r2 [4] =
		r2 [5] =
		r2 [7] = 0;

		r3 [0] = MAT(a,3,0);
		r3 [1] = MAT(a,3,1);
		r3 [2] = MAT(a,3,2);
		r3 [3] = MAT(a,3,3);
		r3 [7] = 1;
		r3 [4] =
		r3 [5] =
		r3 [6] = 0;

		// choose pivot - or die
		if ( fabs (r3 [0] )> fabs ( r2 [0] ) )
			SWAP_ROWS ( r3, r2 );
	
		if ( fabs ( r2 [0] ) > fabs ( r1 [0] ) )
			SWAP_ROWS ( r2, r1 );

		if ( fabs ( r1 [0] ) > fabs ( r0 [0 ] ) )
			SWAP_ROWS ( r1, r0 );

		if ( r0 [0] == 0 )
			return false;

		// eliminate first variable
		m1 = r1[0]/r0[0];
		m2 = r2[0]/r0[0];
		m3 = r3[0]/r0[0];

		s = r0[1];
		r1[1] -= m1 * s;
		r2[1] -= m2 * s;
		r3[1] -= m3 * s;

		s = r0[2];
		r1[2] -= m1 * s;
		r2[2] -= m2 * s;
		r3[2] -= m3 * s;

		s = r0[3];
		r1[3] -= m1 * s;
		r2[3] -= m2 * s;
		r3[3] -= m3 * s;

		s = r0[4];

		if ( s != 0 )
		{
			r1[4] -= m1 * s; r2[4] -= m2 * s; r3[4] -= m3 * s;
		}

		s = r0[5];

		if ( s != 0.0 )
		{
			r1[5] -= m1 * s; r2[5] -= m2 * s; r3[5] -= m3 * s;
		}

		s = r0[6];

		if ( s != 0 )
		{
			r1[6] -= m1 * s; r2[6] -= m2 * s; r3[6] -= m3 * s;
		}

		s = r0[7];

		if ( s != 0 )
		{
			r1[7] -= m1 * s; r2[7] -= m2 * s; r3[7] -= m3 * s;
		}

		// choose pivot - or die
		if ( fabs (r3 [1] ) > fabs ( r2 [1] ) )
			SWAP_ROWS ( r3, r2 );

		if ( fabs ( r2 [1] ) > fabs ( r1 [1] ) )
			SWAP_ROWS ( r2, r1 );

		if ( r1 [1] == 0 )
			return false;


		// eliminate second variable
		m2     = r2[1]/r1[1]; m3     = r3[1]/r1[1];
		r2[2] -= m2 * r1[2];  r3[2] -= m3 * r1[2];
		r2[3] -= m2 * r1[3];  r3[3] -= m3 * r1[3];

		s = r1[4];

		if ( 0 != s )
		{
			r2[4] -= m2 * s; r3[4] -= m3 * s;
		}

		s = r1[5];
	
		if ( 0 != s )
		{
			r2[5] -= m2 * s; r3[5] -= m3 * s;
		}

		s = r1[6];

		if ( 0 != s )
		{
			r2[6] -= m2 * s; r3[6] -= m3 * s;
		}

		s = r1[7];
	
		if ( 0 != s )
		{
			r2[7] -= m2 * s; r3[7] -= m3 * s;
		}

		// choose pivot - or die
		if ( fabs ( r3 [2] ) > fabs ( r2 [2] ) )
			SWAP_ROWS ( r3, r2 );

		if ( r2 [2] == 0)
		    return false;

		// eliminate third variable
		m3     = r3[2]/r2[2];
		r3[3] -= m3 * r2[3], r3[4] -= m3 * r2[4],
		r3[5] -= m3 * r2[5], r3[6] -= m3 * r2[6],
		r3[7] -= m3 * r2[7];

		// last check
		if ( r3 [3] == 0 )
			return false;


		// now back substitute row 3
		s      = 1.f/r3[3];
		r3[4] *= s; r3[5] *= s; r3[6] *= s; r3[7] *= s;

		// now back substitute row 2
		m2    = r2[3];
		s     = 1.f/r2[2];
		r2[4] = s * (r2[4] - r3[4] * m2), r2[5] = s * (r2[5] - r3[5] * m2),
		r2[6] = s * (r2[6] - r3[6] * m2), r2[7] = s * (r2[7] - r3[7] * m2);

		m1     = r1[3];
		r1[4] -= r3[4] * m1, r1[5] -= r3[5] * m1,
		r1[6] -= r3[6] * m1, r1[7] -= r3[7] * m1;

		m0     = r0[3];
		r0[4] -= r3[4] * m0, r0[5] -= r3[5] * m0,
		r0[6] -= r3[6] * m0, r0[7] -= r3[7] * m0;

		// now back substitute row 1
		m1    = r1[2];
		s     = 1.f/r1[1];
		r1[4] = s * (r1[4] - r2[4] * m1), r1[5] = s * (r1[5] - r2[5] * m1),
		r1[6] = s * (r1[6] - r2[6] * m1), r1[7] = s * (r1[7] - r2[7] * m1);

		m0     = r0[2];
		r0[4] -= r2[4] * m0, r0[5] -= r2[5] * m0,
		r0[6] -= r2[6] * m0, r0[7] -= r2[7] * m0;

		// now back substitute row 0
		m0    = r0[1];
		s     = 1.f/r0[0];
		r0[4] = s * (r0[4] - r1[4] * m0), r0[5] = s * (r0[5] - r1[5] * m0),
		r0[6] = s * (r0[6] - r1[6] * m0), r0[7] = s * (r0[7] - r1[7] * m0);

		MAT(a,0,0) = r0[4]; MAT(a,0,1) = r0[5],
		MAT(a,0,2) = r0[6]; MAT(a,0,3) = r0[7],
		MAT(a,1,0) = r1[4]; MAT(a,1,1) = r1[5],
		MAT(a,1,2) = r1[6]; MAT(a,1,3) = r1[7],
		MAT(a,2,0) = r2[4]; MAT(a,2,1) = r2[5],
		MAT(a,2,2) = r2[6]; MAT(a,2,3) = r2[7],
		MAT(a,3,0) = r3[4]; MAT(a,3,1) = r3[5],
		MAT(a,3,2) = r3[6]; MAT(a,3,3) = r3[7];

		#undef MAT
		#undef SWAP_ROWS

		return true;
	}

	//транспонирует матрицу
	void Matrix::Transpose()
	{
		Matrix tmp;

		for ( register int i = 0; i < 4; i++ )
			for ( register int j = 0; j < 4; j++ )
				tmp.a [i][j] = a [j][i];
		*this = tmp;
	}

	//ф-я для нахождения площади треугольника
	float ComputeSOfTriangle(const Vector3D& v1,const Vector3D& v2,const Vector3D& v3)
	{
		//стороны треугольника
		float a,b,c;
		a = Vector3D(v2-v1).Length();
		b = Vector3D(v3-v1).Length();
		c = Vector3D(v3-v2).Length();

		//полупериметр
		float p = (a+b+c)*0.5f;

		//вычисление полупериметра по формуле Герона
		return (float)sqrt(p*(p-a)*(p-b)*(p-c));
	}

	//ф-я возвращает имя файла без пути к нему
	void CutFileName(const char* FileName,unsigned int Size,
					 char* NewFileName,unsigned int MaxSize)
	{
		int L = Size-1;
		bool Flag = false;
		char c = '\\';
		register unsigned int i;
		for(i=L;i>0;--i)
		{
			if(FileName[i]==c)
			{
				Flag = true;
				break;
			}
		}

		if(Flag)
			strncpy(NewFileName,FileName+i+1,MaxSize);
		else
			strncpy(NewFileName,FileName,MaxSize);

		NewFileName[MaxSize-1] = 0;
		return;
	}

	//проверка, находятся ли точки на одной стороне от линии
	inline bool PNTSOnTheSameSideOfTheLine(const Vector3D& v0,
										   const Vector3D& v1,
										   const Vector3D& A,
										   const Vector3D& B)
	{
		Vector3D dv1 = (B - A)*(v0 - A);
		Vector3D dv2 = (B - A)*(v1 - A);
		if(dv1.Dot(dv2)>=0.0f) 
			return true;

		return false;
	}

	//проверка, находится ли точка внутри треугольника
	bool PointInTriangle(const Vector3D& v0,
						 const Vector3D& v1,
						 const Vector3D& v2,
						 Vector3D& Pt)
	{
		if (PNTSOnTheSameSideOfTheLine(Pt, v0, v1, v2)&&
			PNTSOnTheSameSideOfTheLine(Pt, v1, v0, v2)&&
	        PNTSOnTheSameSideOfTheLine(Pt, v2, v0, v1))
			return true;
	    else 
			return false;
	}

	//пересечение плоскости с лучем
	bool RayIntersectsPlane(const Vector3D& Origin,const Vector3D& Direction,
							const Vector3D& Pt,const Vector3D& Normal,
							float *pDist)
	{
		float D = Normal.Dot(Pt);
 
		float Numer = Normal.Dot(Origin) - D;
		float Denom = Normal.Dot(Direction);
	  
		//нормаль ортогональна вектору, нет пересечения
		if (Denom<=EPSILON&&Denom>=-EPSILON)
			return false;

		if(pDist)
			*pDist = -(Numer/Denom);

		return true;	
	}


	//находит пересечение луча с треугольником
	bool RayIntersectsTriangle(const Vector3D& Origin,Vector3D Direction,
							   const Vector3D &v0,
							   const Vector3D &v1,
							   const Vector3D &v2,
							   Vector3D *pPt,float* pDist)
	{
		float Dist;
		Vector3D Normal,PlanePt;
		Normal = -((v1 - v0) * (v2 - v0));
		Normal.Normalize();
		Direction.Normalize();
		
		if(RayIntersectsPlane(Origin,Direction,v0,Normal,&Dist))
		{
			PlanePt.x = Origin.x + Direction.x * Dist;
			PlanePt.y = Origin.y + Direction.y * Dist;
			PlanePt.z = Origin.z + Direction.z * Dist;

			if(PointInTriangle(v0,v1,v2,PlanePt))
			{
				if(pDist)
					*pDist = Dist;
				if(pPt)
					*pPt = PlanePt;
				return true;
			}
		}
		return false;

	}

}
