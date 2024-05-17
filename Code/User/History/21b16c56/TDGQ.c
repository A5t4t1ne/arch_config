#include <stdio.h>
#include <termios.h>
#include <unistd.h>
#include <stdbool.h>

#define KEY_ESCAPE 91
#define KEY_UP 'A'
#define KEY_DOWN 'B'
#define KEY_RIGHT 'C'
#define KEY_LEFT 'D'

#define ROWS 6
#define COLS 7
#define EMPTY ' '

#define ROW_OFFSET 7
#define COL_OFFSET 3

#define ERR_SUCCESS 0
#define ERR_COL_FULL 1

#define NO_WINNER 0
#define WINNER_FOUND 1

#define ANIMATION_DELAY_MS 50

/******************************************************
 * Function Headers
 ******************************************************/
void cleanup();
void draw_board(char board[ROWS][COLS]);
void move_col_sel_cursor(int col);
int drop_piece(char board[ROWS][COLS], int col, char player);
int check_winner(char board[ROWS][COLS], int last_insertion);

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
    // Save the original terminal settings
    struct termios old_term, new_term;
    tcgetattr(fileno(stdin), &old_term);

    // Set terminal to raw mode (no buffering)
    new_term = old_term;
    new_term.c_lflag &= ~ICANON;
    new_term.c_lflag &= ~ECHO;
    tcsetattr(fileno(stdin), TCSANOW, &new_term);

    printf("\033[?25l"); // Hide the cursor

    char board[ROWS][COLS];
    for (int i = 0; i < ROWS; i++)
    {
        for (int j = 0; j < COLS; j++)
        {
            board[i][j] = EMPTY;
        }
    }
    draw_board(board);
    

    bool running = true;
    int selected_col = 0;
    char players[2] = {'X', 'O'};
    int curr_player = 0;
    while (running)
    {
        move_col_sel_cursor(selected_col);
        char key;
        int bytes_read = read(fileno(stdin), &key, 1);

        if (bytes_read == 1) {
            // Check for escape sequence
            if (key == KEY_ESCAPE) {
                // Read the next character to identify the arrow key
                char next_char;
                read(fileno(stdin), &next_char, 1);
                
                switch (next_char)
                {
                case KEY_UP:
                    // printf("up arrow\n");
                    break;
                case KEY_DOWN:
                    // printf("down arrow\n");
                    if(drop_piece(board, selected_col, players[curr_player]) == ERR_SUCCESS)
                        curr_player = (curr_player + 1) % 2;

                    check_winner(board, selected_col);
                    break;
                case KEY_LEFT:
                    // printf("left arrow\n");
                    selected_col = (selected_col - 1 + COLS) % COLS;
                    break;
                case KEY_RIGHT:
                    // printf("right arrow\n");
                    selected_col = (selected_col + 1) % COLS;
                    break;
                default:
                    printf("other escape sequence\n");
                }

            } else
            {
                switch (key)
                {
                case 'q':
                    printf("quitting...\n");
                    running = false;
                    break;

                default:
                    break;
                }
            }

        }
    }

    // Restore original terminal settings (important!)
    tcsetattr(fileno(stdin), TCSANOW, &old_term);
    cleanup();

    return 0;
}

void cleanup()
{
    fflush(stdin);
    printf("\033[?25h"); // Show the cursor
}

void draw_board(char board[ROWS][COLS])
{
    // header
    for (size_t i = 0; i < 2; i++)
    {
        printf("                             \n");
    }
    
    for (int i = 0; i < ROWS; i++)
    {
        printf("|");
        for (int j = 0; j < COLS; j++)
        {
            printf(" %c |", board[i][j]);
        }
        printf("\n");
    }

    // lower border
    printf("+---------------------------+\n");
}


void move_col_sel_cursor(int col)
{
    printf("\033[s"); // Save the cursor position

    int y = 4 * col + COL_OFFSET;
    int y_ahead = 4 * ((col + 1) % COLS) + COL_OFFSET;
    int y_behind = 4 * ((col - 1 + COLS) % COLS) + COL_OFFSET;
    int x = ROW_OFFSET - 2;

    int y_poss_prev[2] = {y_ahead, y_behind};

    for (size_t i = 0; i < 2; i++)
    {
        printf("\033[%d;%dH%c", x, y_poss_prev[i], EMPTY);
        printf("\033[%d;%dH%c", x + 1, y_poss_prev[i], EMPTY);
        fflush(stdout); 
    }

    printf("\033[%d;%dH|", x, y);
    printf("\033[%d;%dHv", x + 1, y);
    fflush(stdout);

    printf("\033[u"); // Restore the cursor position
}


int drop_piece(char board[ROWS][COLS], int col, char player)
{
    // Start from the bottom of the column and go up
    for (int row = 0; row < ROWS; row++)
    {
        if (board[row][col] != EMPTY)
        {
            return row == 0 ? ERR_COL_FULL : ERR_SUCCESS;
        }
        else
        {
            board[row][col] = player;
        }

        // Calculate the terminal coordinates
        // (you might need to adjust these depending on how your board is printed)
        int term_row = row + ROW_OFFSET;
        int term_col = 4 * col + COL_OFFSET;

        printf("\033[s"); // Save the cursor position
        
        if ((row == ROWS - 1 || board[row][col] != EMPTY) )
        {
            if (row != 0)
            {
                printf("\033[%d;%dH%c", term_row - 1, term_col, EMPTY);
                fflush(stdout);

                board[row - 1][col] = EMPTY;
            }
            
            printf("\033[%d;%dH%c", term_row, term_col, player);
            fflush(stdout);
        }
        

        // Save the last move
        // board->last_move[0] = row;
        // board->last_move[1] = col;

        printf("\033[u"); // Restore the cursor position

        usleep(ANIMATION_DELAY_MS * 1000); // Sleep for 100ms
    }
}


/**
 * Check if the last move resulted in a win.
 * @param board The game board
 * @param last_insertion The column where the last piece was inserted
 * @return WINNER_CODES
*/
int check_winner(char board[ROWS][COLS], int last_insertion)
{
    int col = last_insertion;

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
            if (count == 4) return WINNER_FOUND;
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
            if (count == 4) return WINNER_FOUND;
        }
        else
        {
            count = 0;
        }
    }

    // Check for a diagonal win
    count = 0;
    for (int i = -3; i <= 3; i++)
    {
        if (row + i >= 0 && row + i < ROWS && col + i >= 0 && col + i < COLS)
        {
            if (board[row + i][col + i] == player)
            {
                count++;
                if (count == 4) return WINNER_FOUND;
            }
            else
            {
                count = 0;
            }
        }
    }
}