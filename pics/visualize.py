import numpy as np
import matplotlib.pyplot as plt
import imageio

# File path
input_file = "../java/out/record.txt"
output_gif = "conway_animation.gif"

def read_conway_states(filename, grid_size=100, num_states=2000):
    """Read Conway's Game of Life states from a text file."""
    states = []
    with open(filename, 'r') as file:
        lines = file.readlines()
        for i in range(num_states):
            start = i * (grid_size + 1)  # Each state is 100 lines + 1 empty line
            grid = [list(map(int, lines[j].split())) for j in range(start, start + grid_size)]
            states.append(np.array(grid))
    return states

def create_gif(states, output_file, duration=0.1):
    """Generate and save a GIF from Conway's Game of Life states."""
    images = []
    fig, ax = plt.subplots(figsize=(8, 8))  # 20cm x 20cm ~ 8in x 8in
    for state in states:
        ax.clear()
        ax.imshow(state, cmap='gray_r', vmin=0, vmax=1)
        ax.set_xticks([])
        ax.set_yticks([])
        fig.canvas.draw()
        image = np.array(fig.canvas.renderer.buffer_rgba())
        images.append(image)
    plt.close(fig)
    imageio.mimsave(output_file, images, duration=duration)

# Read states from file
states = read_conway_states(input_file)

# Create GIF
create_gif(states, output_gif)

print("GIF created successfully: conway_animation.gif")
