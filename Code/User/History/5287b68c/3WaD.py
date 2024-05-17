from enum import Enum

# create ENUM for different node types
class NodeType(Enum):
    WALL = '#'
    OPEN = '.'
    START = 'A'
    GOAL = 'B'


class Node:
    def __init__(self, type: NodeType, neighbours: list = []) -> None:
        self.type = type
        self.symbol = type.value
        self.neighbors = neighbours





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

    def parse_text(self):
        return Maze(self.maze)



