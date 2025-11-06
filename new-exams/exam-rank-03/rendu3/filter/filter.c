#include <unistd.h>		//read
#include <stdlib.h>		//realloc & free
#include <stdio.h> 		
#include <errno.h>		//perror
#include <string.h>		//memove



#define BUFFER_SIZE 42		//Constante

int main (int argc, char **argv)
{
	// VARIBLES PARA EL SEGUIMIENTO GENERAL
	char *result = NULL;	//puntero a realloc
	int total_read = 0;		// Contador de bytes leídos


	// VARIABLES PARA EL BUCLE DE LECTURA (para cada chunk)
	char temp[BUFFER_SIZE];	//Buffer temporal para lectura por chunks 
							//(para cada lectura individual), tamaño fijo.
	char *buffer;			//puntero auxiliar de realloc.
	ssize_t bytes;			//num de bytes leídos en cada operación (chunks)

	if (argc != 2 || argv[1][0] == '\0')
		return 1;
	
	while ((bytes = read(0, temp, BUFFER_SIZE)) > 0)
	{
		// 3. Reserva de memoria dinámica.
		buffer = realloc (result, total_read + bytes + 1);	
		if (!buffer)										
		{
			free (result);
			perror ("Error");
			return 1;
		} 
		result = buffer;
		
		// 4. Copia datos nuevos de temp a la posición correcta de result
		memmove (result + total_read, temp, bytes);	
		total_read += bytes;						// Actualiza total_read
		result [total_read] = '\0';					// Añade terminador nulo
		}

		// 5. Verificar errores
		if (bytes < 0)								// (error de lectura)
		{
			perror ("Error");
			free (result);
			return 1;
		}

		if (!result)								// Caso de no leer nada 
			return 0;								//(result es NULL), NO es un error.
	
	int target_len = strlen(argv[1]);  	// Vemos que longitud tiene argv[1]
	int i = 0;

	// Recorremos la cadena result
    while (i < total_read) 
	{
        char *pos = memmem(result + i, total_read - i, argv[1], target_len);
        if (pos == NULL) 
		{
            // No quedan más coincidencias: escribimos el resto
            write(1, result + i, total_read - i);
            break;
        }

        // Escribimos los caracteres entre i y la aparición encontrada
        write(1, result + i, pos - (result + i));

        // Escribimos asteriscos en lugar de la cadena encontrada
        for (int j = 0; j < target_len; j++)
            write(1, "*", 1);

        // Avanzamos i más allá de la cadena encontrada
        i = (pos - result) + target_len;
    }

    free(result);
    return 0;
}
