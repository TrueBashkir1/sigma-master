#ifndef __LOADER__
#define __LOADER__

#include "Plate.h"
#include <fstream>

namespace DensityVisualisation
{
	//класс дл€ загрузки геометрии пластины
	class Loader
	{
	protected:
		//загружает напр€жни€ из файла
		bool LoadSigmas(Plate& plate,std::fstream& file)
		{
			char buf[1024],c;
			float* pVal = NULL;
			//выделение пам€ти под напр€жени€
			if(!plate.AllocateMemoryForValues(X_SIGMA,ANGLES))
				return false;

			//пробегаем по всем треугольникам
			for(unsigned register int i=0;i<plate.GetNumFaces();++i)
			{

				file.get(c);
			
				//загружаем все напр€жени€
				for(register int j=0;j<=(ANGLES-X_SIGMA)-1;++j)
				{
					file.get(buf,512,',');
					buf[512] = 0;
					file.get(c);

					pVal = plate.GetValues((ElementProperties)(j+X_SIGMA));
					if(pVal==NULL)
						continue;

					pVal[i] = (float)atof(buf);
				}
				
				file.get(buf,512,']');
				buf[512] = 0;
				file.get(c);
				file.get(c);
				
				pVal = plate.GetValues(ANGLES);
				if(pVal)
					pVal[i] = (float)atof(buf);
			}
			
			return true;
		}

		//загружает ф-ю плотности
		bool LoadDensity(Plate& plate,std::fstream& file)
		{
			char buf[1024],c;
			float* pVal = NULL;
			//выделение пам€ти под ф-ю плотности
			if(!plate.AllocateMemoryForValues(DENSITY,DENSITY))
				return false;

			pVal = plate.GetValues(DENSITY);
			if(pVal==NULL)
				return false;

			file.get(c);
			//пробегаем по всем треугольникам
			for(unsigned register int i=0;i<plate.GetNumFaces();++i)
			{
				//загружаем ф-ю плотности
				file.get(buf,512,'\n');
				buf[512] = 0;
				pVal[i] = (float)atof(buf);
				file.get(c);
			}
			
			return true;
		}

		//загружает толщину материала
		bool LoadMatWidth(Plate& plate,std::fstream& file)
		{
			char buf[1024],c;
			float* pVal = NULL;
			//выделение пам€ти под толщины материалов  Ё
			if(!plate.AllocateMemoryForValues(MAT_WIDTH,MAT_WIDTH))
				return false;

			pVal = plate.GetValues(MAT_WIDTH);
			if(pVal==NULL)
				return false;

			file.get(c);
			//пробегаем по всем треугольникам
			for(unsigned register int i=0;i<plate.GetNumFaces();++i)
			{
				
				//загружаем ф-ю плотности
				file.get(buf,512,'\n');
				buf[512] = 0;
				pVal[i] = (float)atof(buf);
				file.get(c);
			}
			
			return true;
		}
	public:
		//загружает геометрию пластины и свойства  Ё
		bool LoadGeometry(const char* FileName,Plate& plate)
		{
			//нет имени файла
			if(!FileName)
				return false;
			
			std::fstream file(FileName);
			
			//невозможно открыть файл
			if(!file)
				return false;

			char buf[1024],c;
			unsigned int NumVertices,NumFaces;
			NumVertices = NumFaces = 0;
			file.read(buf,11);
			file.get(c);
			buf[11] = 0;
			//считывание заголовка
			if(strcmp(buf,"EXPORT GRID"))
			{
				file.close();
				return false;
			}
			
			//считывание кол-ва вершин
			file.get(buf,512,'\n');
			file.get(c);
			buf[512] = 0;

			NumVertices = atoi(buf);
			
			
			//считывание кол-ва треугольников
			file.get(buf,512,'\n');
			file.get(c);
			buf[512] = 0;
			
			NumFaces = atoi(buf);
			
			plate.Destroy();
			if(!plate.Create(NumFaces,NumVertices))
			{
				file.close();
				return false;
			}
			
			
			//считывание вершин
			Vector3D* pVertices = plate.GetVertices();
			for(unsigned register int i=0;i<NumVertices;++i)
			{
				file.get(c);
				file.get(buf,512,',');
				buf[512] = 0;
				file.get(c);

				pVertices[i].x = (float)atof(buf);
				
				file.get(buf,512,']');
				buf[512] = 0;
				file.get(c);
				file.get(c);
				pVertices[i].y = (float)atof(buf);
			}
			
			//считывание треугольников
			Face* pFaces = plate.GetFaces();
			for(unsigned register int i=0;i<NumFaces;++i)
			{
				file.get(c);
				file.get(buf,512,',');
				buf[512] = 0;
				file.get(c);

				pFaces[i].a = atoi(buf);
				
				file.get(buf,512,',');
				buf[512] = 0;
				file.get(c);
				pFaces[i].b = atoi(buf);


				file.get(buf,512,']');
				buf[512] = 0;
				file.get(c);
				file.get(c);
				pFaces[i].c = atoi(buf);
				
				//проверка, возможны ли такие индексы
				if(pFaces[i].a>=NumVertices||pFaces[i].b>=NumVertices
					||pFaces[i].c>=NumVertices)
				{
					plate.Destroy();
					file.close();
					return false;
				}
			}


			for(register int i=0;i<3;++i)
			{
				buf[0] = 0;
				file.read(buf,7);
				file.get(c);
				buf[7] = 0;
				//считывание заголовка
				if(!strcmp(buf,"SIGMAS "))
				{
					//загрузка напр€жений
					bool ShouldLoad = true;
					for(register int j=X_SIGMA;j<=ANGLES;++j)
					{
						if(plate.GetValues((ElementProperties)j)!=NULL)
						{
							ShouldLoad = false;
							break;
						}
					}
					if(ShouldLoad)
						LoadSigmas(plate,file);
				}
				else if(!strcmp(buf,"DENSITY"))
				{
					//загрузка ф-ии плотности
					if(plate.GetValues(DENSITY)==NULL)
						LoadDensity(plate,file);
				}
				else if(!strcmp(buf,"WIDTH  "))
				{
					//загрузка толщин материалов  Ё
					if(plate.GetValues(MAT_WIDTH)==NULL)
						LoadMatWidth(plate,file);
				}

				if(file.eof())
					break;
			}
			file.close();
			
			//построение ф-ии плотности
			if((plate.GetValues(DENSITY)==NULL))
			{
				if(!plate.BuildDensityFunction())
				{
					plate.Destroy();
					return false;
				}
			}

			//построение 3D изображени€ поверхностей
			if(!plate.Build3DView())
			{
				plate.Destroy();
				return false;
			}

			return true;
		}
		
	};

}

#endif
