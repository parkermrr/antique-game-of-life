#ifndef ppm_h
#define ppm_h

#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <cmath>

class PPMImage 
{
	private:
		int _width;
		int _height;
		std::vector<int> _values;
	public:
		PPMImage(int width, int height, int* values);

		void exportImage(std::string path);
}

#endif