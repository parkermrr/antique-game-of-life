import numpy as np


def read_initial_state(file_path, rows, cols):
    grid = np.zeros((rows, cols), dtype=int)
    with open(file_path, 'r') as f:
        data = list(map(int, f.read().split()))
        if len(data) != rows * cols:
            raise ValueError("Input data size does not match the specified grid dimensions.")
        grid = np.array(data, dtype=int).reshape(rows, cols)
    return grid


def get_next_state(grid):
    rows, cols = grid.shape
    new_grid = np.zeros((rows, cols), dtype=int)

    for i in range(rows):
        for j in range(cols):
            neighbors = (
                    grid[(i - 1) % rows, (j - 1) % cols] + grid[(i - 1) % rows, j] + grid[
                (i - 1) % rows, (j + 1) % cols] +
                    grid[i, (j - 1) % cols] + grid[i, (j + 1) % cols] +
                    grid[(i + 1) % rows, (j - 1) % cols] + grid[(i + 1) % rows, j] + grid[
                        (i + 1) % rows, (j + 1) % cols]
            )

            if grid[i, j] == 1:
                new_grid[i, j] = 1 if neighbors in (2, 3) else 0
            else:
                new_grid[i, j] = 1 if neighbors == 3 else 0

    return new_grid


def save_states(states, out_dir="out/"):
    import os
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)

    file_path = f"{out_dir}record.txt"
    with open(file_path, 'w') as f:
        for state in states:
            np.savetxt(f, state, fmt='%d')
            f.write("\n")

def game_of_life(file_path, num_iter=300, rows=100, cols=100):
    states = []
    grid = read_initial_state(file_path, rows, cols)
    states.append(grid.copy())

    for _ in range(num_iter):
        grid = get_next_state(grid)
        states.append(grid.copy())

    save_states(states)


if __name__ == "__main__":
    game_of_life("/Users/ericli/PycharmProjects/pythonProject/antique-game-of-life/start.txt", num_iter=300, rows=100, cols=100)
