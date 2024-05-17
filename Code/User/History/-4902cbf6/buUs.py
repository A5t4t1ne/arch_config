from maze_parser import Parser


if __name__ == '__main__':
    m = Parser.parse_text('maze.txt')
    m.print_maze()