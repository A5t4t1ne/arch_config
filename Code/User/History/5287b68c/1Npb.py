class Parser:
    def __init__(self, fname) -> None:
        with open(fname) as f:
            self.maze = f.read().splitlines()


    def print_maze(self):
        for row in self.maze:
            print(row)



