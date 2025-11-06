#include <unistd.h>		//read
#include <stdlib.h>		//realloc & free
#include <stdio.h> 		
#include <errno.h>		//perror
#include <string.h>		//memove



#define BUFFER_SIZE 42		//Constante

int main (int argc, char **argv)
{
	 // Variables para el seguimiento general
	char *result = NULL;	//puntero a realloc
	int total_read = 0;		// Contador de bytes leídos


	// Variables para cada bucle de lectura (para cada chunk)
	char temp[BUFFER_SIZE];	// Buffer temporal para lectura por chunks (para cada lectura individual), tamaño fijo.
	char *buffer;			//puntero auxiliar de realloc.
	ssize_t bytes;			//num de bytes leídos en cada operación (chunks)

	if (argc != 2 || argv[1][0] == '\0')
	{
		return 1;
	}

		while ((bytes = read(0, temp, BUFFER_SIZE)) > 0)
		{
			// 3. Reserva de memoria dinámica, voy expandiendo cuando lo voy necesitando
				buffer = realloc (result, total_read + bytes + 1);
				// Verifica error de realloc, libera memoria si falla
				if (!buffer)
				{
					free (result);
					perror ("Error");
					return 1;
				} 
				result = buffer;
				
				// 4. Copiar datos nuevos
				memmove (result + total_read, temp, bytes);	// Copia de temp a la posición correcta de result
				total_read += bytes;						// Actualiza total_read
				result [total_read] = '\0';					// Añade terminador nulo
		}

			// 5. Verificar errores
			if (bytes < 0)					// Comprueba si bytes < 0 (error de lectura)
			{
				perror ("Error");
				free (result);
				return 1;
			}

			if (!result)
				return 0;					// Caso de no leer nada (result es NULL), NO es un error.
	
	int i = 0;
	int target_len = strlen(argv[1]);

	while (i < total_read)
	{
		int match = 1;
		if (i + target_len <= total_read)
		{
			for (int k = 0; k < target_len; k++)
			{
				if (result[i + k] != argv[1][k])
				{
					match = 0;
					break;
				}
			}
			if (match)
			{
				for (int j = 0; j < target_len; j++)
					write (1, "*", 1);
				i += target_len;
				continue;
			}
		}
		write(1, &result[i], 1);
		i++;
	}
	free (result);
	return 0;
}