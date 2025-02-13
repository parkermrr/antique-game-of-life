#include "bitmap.h"

PPMImage::PPMImage(int width, int height, std::vector<int> values)
{
	_width = width * 10;
	_height = height * 10;
	_values = values;
}

void BitmapImage::exportImage(std::string path)
{
	std::ofstream outFile;
	outFile.open(path);

	if(!outFile.is_open())
	{
		std::cout << "File " << path << " could not be opened" << std::endl;
		return;
	}

	outFile << "P1" << std::endl;
	outFile << height << " " << width << std::endl;
	for (int i = 0; i < height; i++)
	{
		for (int j = 0; j < width; j++)
		{
			i_scale = floor(i / 10);
			j_scale = floor(j / 10);
			idx = i_scale * width + j_scale;
			outFile << _values[idx];
		}
		outFile << std::endl;
	}
	outFile.close();

}


