#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*Escribir un byte con todas sus combinaciones*/


void	imprimir(int *tablero, int n)
{
	int i = 0;
	while(i < n)
	{
		printf("%d", tablero[i]);
		if(i < n - 1)
			printf(" ");
		i++;
	}
	printf("\n");
}

int	es_valido(int *tablero, int linea, int columna)
{
	int i = 0;
	while (i < linea)
	{
		if(tablero[i] == columna || tablero[i] - i == columna - linea || tablero[i] + i == columna + linea)
			return(0);
		i++;
	}

	return (1);
}

void	back(int *tablero, int n, int linea)
{
	if (linea == n)
	{
		imprimir(tablero, n);
		return;
	}
	int columna = 0;
	while( columna < n)
	{
		if (es_valido(tablero, linea, columna))
		{
			tablero[linea] = columna;
			back(tablero, n, linea + 1);
		}
		columna++;
	}
	return;
}

int	main(int argc, char **argv)
{
	if (argc != 2)
	{
		fprintf(stderr, "ERROR\n");
		return(EXIT_FAILURE);
	}
	int n = atoi(argv[1]);
	if (n <= 0)
	{
		fprintf(stderr, "Error\n");
		return (EXIT_FAILURE);
	}
	int *tablero = malloc (sizeof(int) * n);
	if (!tablero)
	{
		fprintf(stderr, "ERROR\n"); 
		return (EXIT_FAILURE);
	}
	back(tablero, n, 0);
	free(tablero);
	return(EXIT_SUCCESS);
}