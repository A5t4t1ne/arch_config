from enum import Enum
from collections import namedtuple

# create ENUM for different node types
class NodeType(Enum):
    WALL = '#'
    OPEN = '.'
    START = 'A'
    GOAL = 'B'


class Node:
    def __init__(self, type: NodeType, x: int, y: int, neighbours: list = []) -> None:
        self.type = type
        self.symbol = type.value
        self.neighbors = neighbours
        Pos = namedtuple('Pos', ['x', 'y'])
        self.pos = Pos(x, y)


    def __str__(self) -> str:
        return f"Node({self.type}, {self.pos.x}, {self.pos.y})"


class Maze:
    def __init__(self, maze: list[list[Node]], start: Node, goal: Node) -> None:
        self.maze = maze
        self.start = start
        self.goal = goal

    def print_maze(self):
        for row in self.maze:
            print(row)


class Parser:
    maze = []
    def __init__(self, fname) -> None:
        with open(fname) as f:
            maze = f.read().splitlines()

    @staticmethod
    def parse_text(self):
        maze = []
        for y, row in enumerate(maze):
            maze_row = []
            for x, symbol in enumerate(row):
                if symbol == NodeType.WALL.value:
                    maze_row.append(Node(NodeType.WALL), x, y)
                elif symbol == NodeType.OPEN.value:
                    maze_row.append(Node(NodeType.OPEN), x, y)
                elif symbol == NodeType.START.value:
                    start = Node(NodeType.START, x, y)
                    maze_row.append(start)
                elif symbol == NodeType.GOAL.value:
                    goal = Node(NodeType.GOAL, x, y)
                    maze_row.append(goal)
            maze.append(maze_row)
        return Maze(maze)



