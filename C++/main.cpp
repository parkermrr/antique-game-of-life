#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <cmath>

int main(int argc, char **argv)
{
	const int rows = 100;
	const int cols = 100;
	const int outImgScale = 10;
	const int _width = cols * outImgScale;
	const int _height = rows * outImgScale;
	const int numIter = 300;
	std::vector<int*> states;

	for(int i = 0; i < numIter + 1; i++)
	{
		int *grid = (int *) calloc(rows * cols, sizeof(int));
		states.push_back(grid);
	}

	std::ifstream inFile;
	inFile.open("../start.txt");

	for (int i = 0; i < rows; i++)
	{
		for (int j = 0; j < cols; j++)
		{
			int val = 0;
			inFile >> val;
			val = val > 0 ? 1 : 0;
			int idx = i * cols + j;
			states[0][idx] = val;
		}
	}

	for(int iter = 1; iter < numIter + 1; iter++)
	{
		int* grid = states[iter - 1];
		int* grid_buf = states[iter];
		for(int i = 0; i < rows; i++)
		{
			for(int j = 0; j < cols; j++)
			{
				int neighborSum = 0;
				int idx = i * cols + j;
				int cellValue = grid[idx];

				neighborSum = grid[((i - 1) % rows) * cols + ((j - 1) % cols)] + grid[i * cols + ((j - 1) % cols)] + grid[((i + 1) % rows) * cols + ((j - 1) % cols)] +
				grid[((i - 1) % rows) * cols + ((j + 1) % cols)] + grid[i * cols + ((j + 1) % cols)] + grid[((i + 1) % rows) * cols + ((j + 1) % cols)] +
				grid[((i - 1) % rows) * cols + j] + grid[((i + 1) % rows) * cols + j];

				grid_buf[idx] = ((cellValue == 0) * (neighborSum == 3)) + ((cellValue == 1) * ((neighborSum == 2) + (neighborSum == 3)));
			}
		}
	}

	for(int iter = 0; iter < states.size(); iter++)
	{
		std::string path = "out/" + std::to_string(iter) + ".ppm";
		std::ofstream outFile;
		outFile.open(path);

		if(!outFile.is_open())
		{
			std::cout << "File " << path << " could not be opened" << std::endl;
			return 1;
		}

		outFile << "P1" << std::endl;
		outFile << _height << " " << _width << std::endl;
		for (int i = 0; i < _height; i++)
		{
			for (int j = 0; j < _width; j++)
			{
				int i_scale = floor(i / outImgScale);
				int j_scale = floor(j / outImgScale);
				int idx = i_scale * (_width / outImgScale) + j_scale;
				outFile << states[iter][idx];
			}
			outFile << std::endl;
		}
		outFile.close();
	}

	return 0;
}

