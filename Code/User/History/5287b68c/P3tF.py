from enum import Enum

# create ENUM for different node types
class NodeType(Enum):
    WALL = '#'
    OPEN = ' '
    START = 'S'
    GOAL = 'G'


class Node:
    pass


class Wall(Node):
    def __init__(self) -> None:
        self.symbol = '#'


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

    def get_maze(self):
        return Maze(self.maze)



