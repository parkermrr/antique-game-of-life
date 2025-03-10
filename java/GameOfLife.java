import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

public class GameOfLife {
    private int rows, cols;
    private int[] states;
    private int[] nextStates;

    public GameOfLife(String filename, int rows, int cols) {
        this.rows = rows;
        this.cols = cols;
        states = new int[rows * cols];
        nextStates = new int[rows * cols];
        initializeState(filename);
    }

    private void initializeState(String filename) {
        try (Scanner inFile = new Scanner(new File(filename))) {
            for (int i = 0; i < rows; i++) {
                for (int j = 0; j < cols; j++) {
                    int idx = i * cols + j;
                    int val = inFile.nextInt();
                    states[idx] = val > 0 ? 1 : 0; // Thresholding to binary
                }
            }
        } catch (FileNotFoundException e) {
            System.err.println("Error: File not found!");
            System.exit(1);
        }
    }

    private int getNeighborCount(int i, int j) {
        int count = 0;
        int[] dx = {-1, -1, -1, 0, 0, 1, 1, 1};
        int[] dy = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int d = 0; d < 8; d++) {
            int ni = i + dx[d], nj = j + dy[d];
            if (ni >= 0 && ni < rows && nj >= 0 && nj < cols) {
                count += states[ni * cols + nj];
            }
        }
        return count;
    }

    private void updateState() {
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                int idx = i * cols + j;
                int neighbors = getNeighborCount(i, j);

                if (states[idx] == 1) {
                    nextStates[idx] = (neighbors == 2 || neighbors == 3) ? 1 : 0;
                } else {
                    nextStates[idx] = (neighbors == 3) ? 1 : 0;
                }
            }
        }
        // Swap state arrays
        int[] temp = states;
        states = nextStates;
        nextStates = temp;
    }

    public void playGame(int numIter) {
        // Create the output directory if it doesn't exist
        File outDir = new File("out");
        if (!outDir.exists()) {
            outDir.mkdir();
        }

        try (FileWriter writer = new FileWriter("out/record.txt")) {
            for (int iter = 0; iter < numIter; iter++) {
                writeState(writer);
                updateState();
            }
        } catch (IOException e) {
            System.err.println("Error writing to file!");
            e.printStackTrace();
        }
    }

    private void writeState(FileWriter writer) throws IOException {
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                writer.write(states[i * cols + j] + " ");
            }
            writer.write("\n");
        }
        writer.write("\n");
    }

    public static void main(String[] args) {
        int rows = 100, cols = 100; // Adjust as needed
        int numIter = 2000;       // Number of iterations
        GameOfLife game = new GameOfLife("../start.txt", rows, cols);
        game.playGame(numIter);
    }
}
