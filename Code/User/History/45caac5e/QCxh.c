#include <stdio.h>

/* The binary tree is an array of char arrays, which hold the name of the node
* Every name is unique and the tree is sorted alphabetically.
* The tree is balanced and every name has at most 20 characters.
*/
char* binary_tree[] = {
    "Matthews",
    "Marshall",
    "McCarthy",
    "Lawrence",
    "McDonald",
    "Johnston",
    "Mitchell",
    "Hutchins",
"Nicholls",
"Henderso",
    "Nicholso",
    "Harrison",
    "Phillips",
    "Hamilton",
    "Reynolds",
    "Griffith",
    "Robertso",
    "Greenwoo",
    "Robinson",
    "Fletcher",
    "Saunders",
    "Chambers",



    "Anderson",
    "Armstron",
    "Atkinson",
    "Campbell",

    
    "Shepherd",
    "Stevenso",
    "Thompson",
    "Whitehea",
    "Wilkinso",
    "Williams",
    
    "Anderson",
    "Armstron",
    "Atkinson",
    "Campbell",
    "Chambers",
    "Fletcher",
    "Greenwoo",
    "Griffith",
    "Hamilton",
    "Harrison",
    "Henderso",
    "Hutchins",
    "Johnston",
    "Lawrence",
    "Marshall",
    "Matthews",
    "McCarthy",
    "McDonald",
    "Mitchell",
    "Nicholls",
    "Nicholso",
    "Phillips",
    "Reynolds",
    "Robertso",
    "Robinson",
    "Saunders",
    "Shepherd",
    "Stevenso",
    "Thompson",
    "Whitehea",
    "Wilkinso",
    "Williams",
};


/** Search binary tree for a child node and return depth.
 * @param name Name of the child node to search for.
 * @return Depth of the child node in the binary tree. 
*/
int find_child(char* name)
{
    /* copilot generated */
    int depth = 0;
    int index = 0;
    while (binary_tree[index] != NULL)
    {
        int cmp = strcmp(name, binary_tree[index]);
        if (cmp == 0)
        {
            return depth;
        }
        else if (cmp < 0)
        {
            index = 2 * index + 1;
        }
        else
        {
            index = 2 * index + 2;
        }
        depth++;
    }
    return -1;
}


int main(int argc, char const *argv[])
{

    return 0;
}
