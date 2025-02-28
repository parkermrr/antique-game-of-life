#include <stdio.h>
#include <stdlib.h>
#include <cstring>
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
};

PPMImage::PPMImage(int width, int height, int* values)
{
	_width = width * 100;
	_height = height * 100;
	_values.insert(_values.end(), &values[0], &values[width * height]);
}

void PPMImage::exportImage(std::string path)
{
	std::ofstream outFile;
	outFile.open(path);

	if(!outFile.is_open())
	{
		std::cout << "File " << path << " could not be opened" << std::endl;
		return;
	}

	outFile << "P1" << std::endl;
	outFile << _height << " " << _width << std::endl;
	for (int i = 0; i < _height; i++)
	{
		for (int j = 0; j < _width; j++)
		{
			int i_scale = floor(i / 100);
			int j_scale = floor(j / 100);
			int idx = i_scale * (_width / 100) + j_scale;
			outFile << _values[idx];
		}
		outFile << std::endl;
	}
	outFile.close();

}

void initGrid(int *grid, int len)
{
	for(int i = 0; i < len; i++)
	{
		grid[i] = rand() % 2;
	}
}

void updateCell(int *grid, int *grid_buf, int i, int j, int rows, int cols)
{
	int neighborSum = 0;
	int idx = i * cols + j;
	int cellValue = grid[idx];

	neighborSum = grid[((i - 1) % rows) * cols + ((j - 1) % cols)] + grid[i * cols + ((j - 1) % cols)] + grid[((i + 1) % rows) * cols + ((j - 1) % cols)] +
	grid[((i - 1) % rows) * cols + ((j + 1) % cols)] + grid[i * cols + ((j + 1) % cols)] + grid[((i + 1) % rows) * cols + ((j + 1) % cols)] +
	grid[((i - 1) % rows) * cols + j] + grid[((i + 1) % rows) * cols + j];

	grid_buf[idx] = ((cellValue == 0) * (neighborSum == 3)) + ((cellValue == 1) * ((neighborSum == 2) + (neighborSum == 3)));
}

int main(int argc, char **argv)
{
	const int rows = 100;
	const int cols = 100;
	
	int *grid = (int *) calloc(rows * cols, sizeof(int));
	int *grid_buf = (int *) calloc(rows * cols, sizeof(int));

	initGrid(grid, rows * cols);
	
	for(int i = 0; i < rows; i++)
	{
		for(int j = 0; j < cols; j++)
		{
			updateCell(grid, grid_buf, i, j, rows, cols);
		}
	}

	memcpy(grid, grid_buf, sizeof(int) * rows * cols);

	PPMImage outImage = PPMImage(cols, rows, grid);
	outImage.exportImage("out.ppm");
	 	
	free(grid);
	free(grid_buf);
	return 0;
}

