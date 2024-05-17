#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    char *yup = "\
         / \\n\
        |\_/|\n\
        |---|\n\
        |   |\n\
        |   |\n\
      _ |=-=| _\n\
  _  / \|   |/ \\n\
 / \|   |   |   ||\\n\
|   |   |   |   | \>\n\
|   |   |   |   |   \\n\
| -   -   -   - |)   )\n\
|                   /\n\
 \                 /\n\
  \               /\n\
   \             /\n\
    \           /\n";

    if (strncmp(argv[1], "mami", 4) == 0)
    {
        printf("%s\n", yup);
    }

    return 0;
}
