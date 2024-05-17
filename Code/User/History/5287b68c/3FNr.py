class Parser:
    def __init__(self, fname) -> None:
        with open(fname) as f:
            self.maze = f.read().splitlines()



