#include "broken_gnl.h"
#include <stdio.h>

char	*ft_strchr(char *s, int c)
{
	int	i = 0;
	while (s[i] != c && s[i] != '\0')
		i++;
	if (s[i] == c)
		return (s + i);
	else
		return (NULL);
}

void	*ft_memcpy(void *dest, const void *src, size_t n)
{
	size_t i = 0;
	while (i < n)
	{
		((char *)dest)[i] = ((char *)src)[i];
		i++;
	}
	return (dest);
}

size_t	ft_strlen(char *s)
{
	size_t	ret = 0;
	while (*s)
	{
		s++;
		ret++;
	}
	return (ret);
}

int	str_append_mem(char **s1, char *s2, size_t size2)
{
	size_t size1 = (*s1) ? ft_strlen(*s1) : 0;
	char	*tmp = malloc(size2 + size1 + 1);
	if (!tmp)
		return (0);
    if (*s1)
	    ft_memcpy(tmp, *s1, size1);
	ft_memcpy(tmp + size1, s2, size2);
	tmp [size1 + size2] = 0;
	free(*s1);
	*s1 = tmp;
	return (1);
}

int	str_append_str(char **s1, char *s2)
{
	return (str_append_mem(s1, s2, ft_strlen(s2)));
}

void	*ft_memmove(void *dest, const void *src, size_t n)
{
	if (dest > src)
		return (ft_memcpy(dest, src, n));
	else if (dest == src)
		return (dest);

	int i = n - 1;
	while (i >= 0)
	{
		((char *)dest)[i] = ((char *)src)[i];
		i--;
	}
	return (dest);
}

char	*get_next_line(int fd)
{
	static char	b[BUFFER_SIZE + 1] = "";
	char	*ret = NULL;
	static int call_count = 0;
	call_count++;

	printf("\n=== CALL #%d ===\n", call_count);
	printf("Buffer inicial: [%s]\n", b);

	char	*tmp = ft_strchr(b, '\n');
	printf("tmp inicial: %s\n", tmp ? "FOUND" : "NULL");

	while (!tmp)
	{
		printf("  Añadiendo buffer a ret: [%s]\n", b);
		if (!str_append_str(&ret, b))
			return (NULL);

		int	read_ret = read(fd, b, BUFFER_SIZE);
		printf("  read() devolvió: %d bytes\n", read_ret);
		if (read_ret == -1)
			return (NULL);
        if (read_ret == 0)
        {
        	printf("  EOF detectado\n");
            break;
        }
		b[read_ret] = 0;
		printf("  Buffer después de read: [%s]\n", b);
        tmp = ft_strchr(b, '\n');
        printf("  tmp actualizado: %s\n", tmp ? "FOUND" : "NULL");
    }

    if (tmp)
    {
    	printf("Caso 1: Encontrado \\n\n");
    	printf("  Añadiendo hasta \\n: %ld bytes\n", tmp - b + 1);
        if (!str_append_mem(&ret, b, tmp - b + 1))
        {
            free(ret);
            return (NULL);
        }
        printf("  Moviendo resto del buffer...\n");
        ft_memmove(b, tmp + 1, ft_strlen(tmp + 1) + 1);
        printf("  Buffer después de memmove: [%s]\n", b);
        printf("Devolviendo: [%s]\n", ret);
        return (ret);
    }
    else
    {
    	printf("Caso 2: EOF sin \\n\n");
        b[0] = '\0';
        if (ret && *ret)
        {
        	printf("Devolviendo ret: [%s]\n", ret);
            return (ret);
        }
        else
        {
        	printf("Devolviendo NULL\n");
            free(ret);
            return (NULL);
        }
    }
}

#include <fcntl.h>
int main(void)
{
	int fd = open("test.txt", O_RDONLY);
	char *line;

	while ((line = get_next_line(fd)) != NULL)
	{
		printf(">>> OUTPUT: %s", line);
		free(line);
	}
	close(fd);
	return (0);
}
