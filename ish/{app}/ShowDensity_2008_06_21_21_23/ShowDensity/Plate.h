#ifndef __PLATE__
#define __PLATE__

#include "Common.h"

namespace DensityVisualisation
{
	enum ElementProperties
	{
		DENSITY,
		X_SIGMA,
		Y_SIGMA,
		TAU_SIGMA,
		FIRST_SIGMA,
		SECOND_SIGMA,
		EQ_SIGMA,
		ANGLES,
		MAT_WIDTH,
		NUM_PROPERTIES
	};
	//класс, содержащий методы для обработки геометрии пластины
	class Plate
	{
	private:
		//триугольники
		Face* Faces;
		//вершины
		Vector3D* Vertices;
		//значения ф-ий в КЭ
		float* Values[NUM_PROPERTIES];
		//кол-во триугольников и вершин
		unsigned int NumFaces,NumVertices;
		//мин/макс значение ф-ии
		float MaxVal[NUM_PROPERTIES],MinVal[NUM_PROPERTIES];

		//триугольники в 3D изображении
		Face* Faces43DView;
		//вершины в 3D
		Vector3D* Vertices43DView[NUM_PROPERTIES];
		//кол-во вершин в 3D
		unsigned int NumVertices43DView;
		
		//AABB пластины
		Vector3D MinBounds,MaxBounds;
		
		//индекс выбранного триугольника
		int SelectedTri;
		//точка, в которой произошел выбор
		Vector3D SelectedPt;
	public:
		//конструктор
		Plate() 
		{
			for(register int i=0;i<NUM_PROPERTIES;++i)
				MaxVal[i] = MinVal[i] = 0.0f;
			NumFaces = NumVertices = 0;
			Faces = NULL;
			Vertices = NULL;
			for(register int i=0;i<NUM_PROPERTIES;++i)
				Values[i] = NULL;
			for(register int i=0;i<NUM_PROPERTIES;++i)
				Vertices43DView[i] = NULL;
			Faces43DView = NULL;
			NumVertices43DView = 0;
			MinBounds = MaxBounds = Vector3D(0.0f,0.0f,0.0f);
			SelectedTri = -1;
		}
		
		//деструктор
		~Plate() 
		{
			Destroy();
		}

		//создание пластины - выделение памяти под массивы
		bool Create(unsigned int _NumFaces,unsigned int _NumVertices)
		{
			if(_NumFaces==0||_NumVertices==0
			   ||NumFaces!=0||NumVertices!=0)
			   return false;
			
			NumFaces = _NumFaces;
			NumVertices = _NumVertices;

			Faces = new Face[NumFaces];
			if(Faces==NULL)
			{
				NumFaces = NumVertices = 0;
				return false;
			}

			Vertices = new Vector3D[NumVertices];
			if(Vertices==NULL)
			{
				SafeDeleteArray(Faces);
				NumFaces = NumVertices = 0;
				return false;
			}

			return true;
		}

		//уничтожение платины
		void Destroy()
		{
			for(register int i=0;i<NUM_PROPERTIES;++i)
				MaxVal[i] = MinVal[i] = 0.0f;
			NumFaces = NumVertices = 0;
			SafeDeleteArray(Faces);
			SafeDeleteArray(Vertices);
			for(register int i=0;i<NUM_PROPERTIES;++i)
				SafeDeleteArray(Values[i]);

			SafeDeleteArray(Faces43DView);
			for(register int i=0;i<NUM_PROPERTIES;++i)
				SafeDeleteArray(Vertices43DView[i]);

			NumVertices43DView = 0;
			MinBounds = MaxBounds = Vector3D(0.0f,0.0f,0.0f);
			SelectedTri = -1;
		}

		//убирает выбор с треугольника
		void Unselect()
		{
			SelectedTri = -1;
		}

		//выбор треугольника по его индексу
		int SelectTriangle(unsigned int Index)
		{
			SelectedTri = -1;
			//выбор треугольника по индексу
			if(Index<NumFaces)
				SelectedTri = (int)Index;

			return SelectedTri;
		}

		//выбор треугольника, который пересекается с лучем
		int SelectTriangle(Vector3D& _SelectionPoint,
						   const Vector3D& Origin,const Vector3D& Direction,
						   ElementProperties Property)
		{
			SelectedTri = -1;

			if(Property==NUM_PROPERTIES)
				return SelectedTri;

			if(Faces==NULL||Vertices==NULL||Values[Property]==NULL||
			   NumVertices==0||NumFaces==0||Vertices43DView[Property]==NULL||
			   Faces43DView==NULL||NumVertices43DView==0)
			   return SelectedTri;

			float Dist = (float)3.4e38; 

			//пробегаем по всем треугольникам
			for(register unsigned int i=0;i<NumFaces;++i)
			{
				float NewDist;
				Vector3D Pt;
				
				//если найдено пересечение
				if(RayIntersectsTriangle(Origin,Direction,
										 Vertices43DView[Property][Faces43DView[i].a],
										 Vertices43DView[Property][Faces43DView[i].b],
										 Vertices43DView[Property][Faces43DView[i].c],
										 &Pt,&NewDist))
				{
					//если точка ближе, чем предыдущая
					if(NewDist>Dist)
						continue;
					
					//найдено пересечение
					SelectedPt = Pt;
					Dist = NewDist;
					SelectedTri = (int)i;
				}
	
			}
			
			_SelectionPoint = SelectedPt;
			return SelectedTri;
		}

		//возвращает точку пересечения
		Vector3D GetSelectedPoint() 
		{
			return SelectedPt;
		}

		//возвращает индекс выделенного треугольника
		int GetSelectedTriangleIndex()
		{
			if(SelectedTri>=(int)NumFaces)
				SelectedTri = -1;

			return SelectedTri; 
		}

		//возвращает максимальное значение ф-ии
		void ComputeMaxVal(ElementProperties Property)
		{
			if(Property==NUM_PROPERTIES)
				return;

			if(Faces==NULL||Vertices==NULL||Values[Property]==NULL||
			   NumVertices==0||NumFaces==0)
			   return;

			MaxVal[Property] = Values[Property][0];
			for(register unsigned int i=1;i<NumFaces;++i)
			{
				if(MaxVal[Property]<=Values[Property][i])
					MaxVal[Property] = Values[Property][i];
			}
			return;
		}

		//возвращает минимальное значение ф-ии
		void ComputeMinVal(ElementProperties Property)
		{
			if(Property==NUM_PROPERTIES)
				return;
			
			if(Faces==NULL||Vertices==NULL||Values[Property]==NULL||
			   NumVertices==0||NumFaces==0)
			   return;

			MinVal[Property] = Values[Property][0];
			for(register unsigned int i=1;i<NumFaces;++i)
			{
				if(MinVal[Property]>=Values[Property][i])
					MinVal[Property] = Values[Property][i];
			}
			return;
		}

		//получение мин. значения ф-ии плотности
		float GetMinVal(ElementProperties Property)
		{
			if(Property==NUM_PROPERTIES)
				return 0.0f;
			return MinVal[Property];
		}

		//получение макс. значения ф-ии плотности
		float GetMaxVal(ElementProperties Property)
		{
			if(Property==NUM_PROPERTIES)
				return 0.0f;
			return MaxVal[Property];
		}

		//получение ограничивающего прямоугольника пластины
		void GetBounds(Vector3D& Min,Vector3D& Max)
		{
			Min = MinBounds;
			Max = MaxBounds;
		}

		//получение массива вершин
		Vector3D* GetVertices() {return Vertices;}

		//получение массива индексов триугольников
		Face* GetFaces() {return Faces;}
		
		//получение ф-ии плотности
		float* GetValues(ElementProperties Property) 
		{
			if(Property==NUM_PROPERTIES)
				return NULL;

			return Values[Property];
		}

		//получение числа вершин
		unsigned int GetNumVertices() {return NumVertices;}

		//получение числа триугольников
		unsigned int GetNumFaces() {return NumFaces;}

		//строит ф-ю плотности.
		bool BuildDensityFunction()
		{
			if(Faces==NULL||Vertices==NULL||
			   NumVertices==0||NumFaces==0)
			   return false;

			if(Values[DENSITY]==NULL)
			{
				Values[DENSITY] = new float[NumFaces];
				if(Values[DENSITY]==NULL)
					return false;
			}

			float S = 0.0f;
			//вычисляем общую площадь
			for(register unsigned int i=0;i<NumFaces;++i)
			{
				S += ComputeSOfTriangle(Vertices[Faces[i].a],
										Vertices[Faces[i].b],
										Vertices[Faces[i].c]);
			}
			
			//вычиляем ф-ю плотности для каждого треугольника
			for(register unsigned int i=0;i<NumFaces;++i)
			{
				Values[DENSITY][i] = 1.0f - ComputeSOfTriangle(Vertices[Faces[i].a],
							  		  						   Vertices[Faces[i].b],
															   Vertices[Faces[i].c])/S;
			}

			return true;
		}

		//вычисляет ограничивающий паралеллепипед
		bool ComputeBounds(float HeightKoeff = 0.25f)
		{

			if(Faces==NULL||Vertices==NULL||
			   NumVertices==0||NumFaces==0||HeightKoeff<=0.0f)
			   return false;
			//вычисляем ограничивающий прямоугольник пластины
			MinBounds = MaxBounds = Vector3D(0.0f,0.0f,0.0f);
			MinBounds.z = 0.0f;
			MaxBounds.z = 0.0f;
			
			MinBounds.x = MaxBounds.x = Vertices[0].x;
			MinBounds.y = MaxBounds.y = Vertices[0].y;


			for(register unsigned int i=1;i<NumVertices;++i)
			{
				if(Vertices[i].x<MinBounds.x)
					MinBounds.x = Vertices[i].x;
				
				if(Vertices[i].x>MaxBounds.x)
					MaxBounds.x = Vertices[i].x;

				if(Vertices[i].y<MinBounds.y)
					MinBounds.y = Vertices[i].y;

				if(Vertices[i].y>MaxBounds.y)
					MaxBounds.y = Vertices[i].y;
			}

			//вычисление высоты по максимальному размеру (по Х или по У)
			float TmpVal = MaxBounds.x - MinBounds.x;
			TmpVal = TmpVal>(MaxBounds.y - MinBounds.y)?TmpVal:(MaxBounds.y - MinBounds.y);
			MaxBounds.z = TmpVal*HeightKoeff;
			return true;
		}

		//строит 3D изображение ф-ий
		bool Build3DView(float HeightCoeff = 0.25f)
		{
			if(Faces==NULL||Vertices==NULL||
			   NumVertices==0||NumFaces==0||HeightCoeff<=0.0f)
			   return false;

			//выделение памяти под вершины и триугольники
			SafeDeleteArray(Faces43DView);
			for(register int i=0;i<NUM_PROPERTIES;++i)
				SafeDeleteArray(Vertices43DView[i]);

			NumVertices43DView = 3*NumFaces;
			Faces43DView = new Face[NumFaces];
			if(Faces43DView==NULL)
			{
				return false;
			}

			unsigned int VIndex = 0;
			//пробегаем по всем триугольникам
			for(register unsigned int i=0;i<NumFaces;++i)
			{
				
				//a
				Faces43DView[i].a = VIndex;
				++VIndex;
				
				//b
				Faces43DView[i].b = VIndex;
				++VIndex;

				//c
				Faces43DView[i].c = VIndex;
				++VIndex;

			}

			//вычисление ограничивающего паралеллепипеда платины
			if(!ComputeBounds(HeightCoeff))
				return false;

			//высота
			float Height = MaxBounds.z;

			//пробегаем по всем возможным значениям в КЭ
			for(register int i=0;i<NUM_PROPERTIES;++i)
			{
				//если нет данных для данного свойства КЭ, то берем
				//следующее свойство
				if(GetValues((ElementProperties)i)==NULL)
					continue;

				//вычисление максимального и минимального значений ф-ии
				ComputeMaxVal((ElementProperties)i);
				ComputeMinVal((ElementProperties)i);
				

				Vertices43DView[i] = new Vector3D[NumVertices43DView];
				if(Vertices43DView[i]==NULL)
				{
					return false;
				}

				float a = GetMinVal((ElementProperties)i);
				float b = GetMaxVal((ElementProperties)i);
				float d = b-a;
				VIndex = 0;
				for(register unsigned int j=0;j<NumFaces;++j)
				{
					//каждый триугольник находится 
					//на своей высоте - по оси Z
					
					float x = Height*(Values[i][j]-a)/d + 1.0f;
					//a
					Vertices43DView[i][VIndex] = Vertices[Faces[j].a];
					Vertices43DView[i][VIndex].z = x;
					++VIndex;
				
					//b
					Vertices43DView[i][VIndex] = Vertices[Faces[j].b];
					Vertices43DView[i][VIndex].z = x;
					++VIndex;

					//c
					Vertices43DView[i][VIndex] = Vertices[Faces[j].c];
					Vertices43DView[i][VIndex].z = x;
					++VIndex;
				}

			}
			//все вычислено
			return true;
		}

		//выделяет память под свойства КЭ
		//начинает выделять память со свойства Start до свойства
		//End
		bool AllocateMemoryForValues(ElementProperties Start,
									 ElementProperties End)
		{
			//проверка на ошибки
			if(Faces==NULL||Vertices==NULL||
			   NumVertices==0||NumFaces==0||Start==NUM_PROPERTIES||
			   End==NUM_PROPERTIES)
			   return false;

			//выделение памяти
			for(register int i=Start;i<=End;++i)
			{
				Values[i] = new float[NumFaces];
				if(Values[i]==NULL)
				{
					return false;
				}
			}

			return true;
		}

		//получение массива вершин для 3D изображения
		Vector3D* Get3DViewVertices(ElementProperties Property)
		{
			if(Property==NUM_PROPERTIES)
				return NULL;

			return Vertices43DView[Property];
		}

		//получение массива индексов треугольников
		Face* Get3DViewFaces() {return Faces43DView;}
	};
}

#endif
