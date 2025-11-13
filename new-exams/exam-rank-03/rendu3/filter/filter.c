#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define BUFFER_SIZE 42
int main (int ac, char **av)
{

	char *result = NULL;
	int total_bytes = 0;

	char tmp[BUFFER_SIZE];
	ssize_t bytes;
	char *buffer;

	if (ac != 2 || av[1][0] == '\0')
		return 1;

	while ((bytes = read(0, tmp, BUFFER_SIZE)) > 0)
	{
		buffer =realloc(result, total_bytes + bytes + 1);
		if (!buffer)
		{
			free(result);
			perror ("Error");
			return 1;
		}
		result = buffer;
		memmove(result + total_bytes, tmp, bytes);
		total_bytes += bytes;
	}

	if (bytes < 0)
	{
		free(result);
		perror ("Error");
		return 1;
	}
	
	if (!result)
	{
		free(result);
		perror ("Error");
		return 1;
	}


	int len_filter = strlen (av[1]);
	int i = 0;
	
	while (i < total_bytes)
	{
		char *filter = memmem(result + i, total_bytes - i, av[1], len_filter);
			
		if (filter == NULL)
		{
			write (1, result + i, total_bytes - i);
			break;
		}
		write (1, result + i, filter - (result + i));

		for (int j = 0; j < len_filter; j++)
			write (1, "*", 1);
	
		i = (filter - result) + len_filter;

	}
	free (result);

	return 0;
}