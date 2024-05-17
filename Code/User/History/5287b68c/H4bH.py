class Maze:
    def __init__(self, maze: list) -> None:
        self.maze = maze

    def print_maze(self):
        for row in self.maze:
            print(row)


class Parser:
    def __init__(self, fname) -> None:
        with open(fname) as f:
            self.maze = f.read().splitlines()


    def print_maze(self):
        for row in self.maze:
            print(row)



