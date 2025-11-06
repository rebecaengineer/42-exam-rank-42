#include <string.h>
#include <errno.h>
#include <fcntl.h>

 #define BUFFER_SIZE 42

int main (int argc, char **argv)
{
    if (argc != 2 && argv [1][0] != '/0')
        return (1);
    
    ssize_t bytes;
    
    ssize_t bytes = read (0, temp, BUFFER_SIZE);






    return (0);
}