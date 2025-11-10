
#include "permutations.h"




int ft_strlen (char *str)
{
    int i = 0;
    while (str[i])
        i++;
    return (i);
}

void perm (int *cnt, int len, int current_pos, char *str)
{
    //Caso base

    if (len == current_pos)
    {
        str[len] = '\0';
        puts(str);
        return ;
    }

    int c = 0;
    while (c < 256)
    {
        if (cnt[c])
        {
            str[current_pos] = (char)c;
            --cnt[c];
            perm (cnt, len, current_pos + 1, str);
            ++cnt[c];
        }
        c++;
    }
   
}





int main (int ac, char **av)
{
    if (ac == 2)
    {
        int cnt [256] = {0};

        int len = ft_strlen (av[1]);
        char *str = malloc(sizeof(char) * len + 1);
        if (!str)
            return 1;
        
        int i = 0;
        while (i < len)
        {
            ++cnt[(unsigned char)av[1][i]];
            i++;
        }

        int current_pos = 0;
        perm (cnt, len, current_pos ,str);
        free(str);
    }
    return 0;
}