#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    char yup[] = " \n\
         / \\ \n\
        |\\_/| \n\
        |---| \n\
        |   | \n\
        |   | \n\
      _ |=-=| _ \n\
  _  / \\|   |/ \\ \n\
 / \\|   |   |   ||\\ \n\
|   |   |   |   | \\> \n\
|   |   |   |   |   \\ \n\
| -   -   -   - |)   ) \n\
|                   / \n\
 \\                 / \n\
  \\               / \n\
   \\             / \n\
    \\           /\n";
    -- -- -- -- --

                if (argc > 1 && strncmp(argv[1], "mami", 4) == 0)
    {
        printf("%s", yup);
    }

    return 0;
}
