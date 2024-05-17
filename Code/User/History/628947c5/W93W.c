#include <stdio.h>
#include <termios.h>
#include <string.h>
#include <unistd.h>
#include <stdbool.h>
#include <ncurses.h>

#define COLOR_PAIR_RED 1
#define COLOR_PAIR_GREEN 2

#define ASCII_RED "\033[31m"
#define ASCII_GREEN "\033[32m"
#define ASCII_RESET "\033[0m"

#define ROWS 6
#define COLS 7
#define EMPTY ' '
#define CELL_WIDTH 4

#define ROW_OFFSET 3
#define COL_OFFSET 2

#define ERR_SUCCESS 0
#define ERR_COL_FULL 1

#define NO_WINNER 0
#define WINNER_FOUND 1

#define ANIMATION_DELAY_MS 50

/******************************************************
 * Function Headers
 ******************************************************/
void field_start_pos(int *x, int *y);
void draw_board(char board[ROWS][COLS], int selected_col);
int drop_piece(char board[ROWS][COLS], int col, char player);
int check_winner(const char const board[ROWS][COLS], const int col);
void reset_board(char board[ROWS][COLS]);

/******************************************************
 * Types
 ******************************************************/
typedef struct
{
    char cells[ROWS][COLS];
    int last_move[2];

} Board;

/******************************************************
 * Main Function
 ******************************************************/
int main()
{
    initscr();
    noecho();
    curs_set(FALSE);
    keypad(stdscr, TRUE);
    start_color();
    init_pair(1, COLOR_RED, COLOR_BLACK);
    init_pair(2, COLOR_GREEN, COLOR_BLACK);

    char board[ROWS][COLS] = {0};
    reset_board(board);

    int selected_col = 0;
    draw_board(board, selected_col);

    char players[2] = {'X', 'O'};
    int curr_player = 0;
    int ch;
    bool running = true;
    while ((ch = getch()) != 'q' && running)
    {
        switch (ch)
        {
        case KEY_UP:
            // printw("Up arrow key pressed\n");
            break;
        case KEY_DOWN:
            drop_piece(board, selected_col, players[curr_player]);
            if (check_winner(board, selected_col) == WINNER_FOUND)
            {
                int x, y;
                field_start_pos(&x, &y);
                mvprintw(y - 3, x-10, "Player %c wins! Press 'q' to quit or 'r' to restart.", players[curr_player]);
                refresh();
                running = false;
                while ((ch = getch()) != 'q' && ch != 'r');
                if (ch == 'q')
                {
                    endwin();
                    return 0;
                }else if (ch == 'r')
                {
                    reset_board(board);
                    curr_player = 0;
                    running = true;
                }
            }else{
                curr_player = (curr_player + 1) % 2;
            }
            break;
        case KEY_LEFT:
            selected_col = (selected_col - 1 + COLS) % COLS;
            break;
        case KEY_RIGHT:
            selected_col = (selected_col + 1) % COLS;
            break;
        case 'r':
            reset_board(board);
            curr_player = 0;
            draw_board(board, 0);
            break;
        default:
            break;
        }
        draw_board(board, selected_col);
    }

    endwin();

    return 0;
}

void reset_board(char board[ROWS][COLS])
{
    for (int row = 0; row < ROWS; row++)
    {
        for (int col = 0; col < COLS; col++)
        {
            board[row][col] = EMPTY;
        }
    }

    clear();
    draw_board(board, 0);
}

void draw_board(char board[ROWS][COLS], int selected_col)
{
    int max_y = 0, max_x = 0;
    getmaxyx(stdscr, max_y, max_x);

    int start_y = (max_y - ROWS) / 2;
    int start_x = (max_x - COLS * CELL_WIDTH) / 2;

    // clear first two lines
    for (int i = 0; i < 2; i++)
    {
        mvprintw(start_y - 2 + i, start_x, "                              ");
    }

    selected_col = (selected_col + COLS) % COLS; // insurance
    int curr_cursor_x = start_x + selected_col * CELL_WIDTH + 2;
    mvprintw(start_y - 2, curr_cursor_x, "|");
    mvprintw(start_y - 1, curr_cursor_x, "v");

    for (int i = 0; i < ROWS; i++)
    {
        for (int j = 0, col = 0; j < COLS * CELL_WIDTH; j += CELL_WIDTH, col++)
        {
            mvprintw(start_y + i, start_x + j, "|");
            if (board[i][col] == 'X')
            {
                attron(COLOR_PAIR(1));
                mvprintw(start_y + i, start_x + j + 2, "%c ", board[i][col]);
                attroff(COLOR_PAIR(1));
            }
            else if (board[i][col] == 'O')
            {
                attron(COLOR_PAIR(2));
                mvprintw(start_y + i, start_x + j + 2, "%c ", board[i][col]);
                attroff(COLOR_PAIR(2));
            }
            else
            {
                mvprintw(start_y + i, start_x + j + 2, "%c ", board[i][col]);
            }

            mvprintw(start_y + i, start_x + j + 4, "|");
        }
    }

    mvprintw(start_y + ROWS, start_x, "+---------------------------+");

    refresh();
}

void field_start_pos(int *x, int *y)
{
    int max_y = 0, max_x = 0;
    getmaxyx(stdscr, max_y, max_x);

    *x = (max_x - COLS * CELL_WIDTH) / 2;
    *y = (max_y - ROWS) / 2;
}

int drop_piece(char board[ROWS][COLS], int col, char piece)
{
    int i;
    for (i = 0; i < ROWS; i++)
    {
        if (board[i][col] != EMPTY)
        {
            break;
        }
        board[i][col] = piece;
        draw_board(board, col);
        refresh();
        usleep(ANIMATION_DELAY_MS * 1000) ;
        board[i][col] = ' ';
    }
    if (i == 0)
    {
        return ERR_COL_FULL;
    }
    else
    {
        board[i - 1][col] = piece; // Place the piece at the final position
        return ERR_SUCCESS;
    }
}

/**
 * Check if the last move resulted in a win.
 * @param board The game board
 * @param last_insertion The column where the last piece was inserted
 * @return WINNER_CODES
 */
int check_winner(const char const board[ROWS][COLS], const int col)
{
    // Get the row and Player symbol of the last move
    char player = ' ';
    int row = 0;
    for (; row < ROWS; row++)
    {
        if (board[row][col] != EMPTY)
        {
            player = board[row][col];
            break;
        }
    }

    // Check for a horizontal win
    int count = 0;
    for (int i = 0; i < COLS; i++)
    {
        if (board[row][i] == player)
        {
            count++;
            if (count == 4)
            {
                return WINNER_FOUND;
            }
        }
        else
        {
            count = 0;
        }
    }

    // Check for a vertical win
    count = 0;
    for (int i = 0; i < ROWS; i++)
    {
        if (board[i][col] == player)
        {
            count++;
            if (count == 4)
            {
                return WINNER_FOUND;
            }
        }
        else
        {
            count = 0;
        }
    }

    // Check for a diagonal win
    count = 0;
    for (int d = -3; d <= 3; ++d)
    {
        int i = row + d;
        int j = col + d; // Diagonal from top-left to bottom-right
        if (i >= 0 && i < ROWS && j >= 0 && j < COLS)
        {
            if (board[i][j] == player)
            {
                count++;
                if (count == 4){
                    return WINNER_FOUND;
                }
            }
            else
            {
                count = 0;
            }
        }
    }

    count = 0;
    for (int d = -3; d <= 3; ++d)
    {
        int i = row + d;
        int j = col - d; // Diagonal from top-right to bottom-left
        if (i >= 0 && i < ROWS && j >= 0 && j < COLS)
        {
            if (board[i][j] == player)
            {
                count++;
                if (count == 4){
                    return WINNER_FOUND;
                }
            }
            else
            {
                count = 0;
            }
        }
    }
    return NO_WINNER;
}