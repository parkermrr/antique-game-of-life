#include <stdio.h>
#include <stdlib.h>
#include "ppm.h"

void initGrid(int *grid, int len);

void updateCell(int *grid, int *grid_buf, int i, int j, int rows, int cols);

int main(int argc, char **argv)
{
	const int rows = 10;
	const int cols = 10;
	
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

	memcpy(grid_buf, grid, sizeof(int) * rows * cols);

	PPMImage outImage = PPMImage()
	 	
	free(grid);
	free(grid_buf);
	return 0;
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