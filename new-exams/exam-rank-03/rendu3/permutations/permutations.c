#include "permutations.h"

int	ft_strlen(char *str)
{
	int	len;

	len = 0;
	while (str[len])
		len++;
	return (len);
}

void	ft_putstr(char *str)
{
	write(1, str, ft_strlen(str));
	write(1, "\n", 1);
}

void	ft_swap(char *a, char *b)
{
	char	tmp;

	tmp = *a;
	*a = *b;
	*b = tmp;
}

void	sort_str(char *str, int len)
{
	int	i;
	int	j;

	i = 0;
	while (i < len - 1)
	{
		j = i + 1;
		while (j < len)
		{
			if (str[i] > str[j])
				ft_swap(&str[i], &str[j]);
			j++;
		}
		i++;
	}
}

int	next_permutation(char *str, int len)
{
	int	i;
	int	j;
	int	left;
	int	right;
                                            // Buscar punto de ruptura (12345)
                                            // 
	i = len - 2;                            // Empieza en el penúltimo caracter/digito.
	while (i >= 0 && str[i] >= str[i + 1])  // mientras el penúltimo >= al siguiente. retrocede.
		i--;                                //si no cumple -> STOP (i actual)
	
    if (i < 0)                              //Ahora todos están cambiados (54321)
		return (0);                         //no hay más permutaciones.
	
    j = len - 1;                            //busca sucesor más pequeño
	while (str[i] >= str[j])
		j--;
	
    ft_swap(&str[i], &str[j]);              //intercambia
	
    left = i + 1;                           //invierte el sufijo después de i
	right = len - 1;                        //sufijo = los número que quedan despues del punto de ruptura
	while (left < right)                    //da la ss permutación más pequeña.
	{
		ft_swap(&str[left], &str[right]);
		left++;
		right--;
	}
	return (1);
}

int	main(int ac, char **av)
{
	int		i;
	int		len;
	char	*str;

	if (ac != 2)
	{
		write(1, "\n", 1);
		return (0);
	}
	len = ft_strlen(av[1]);
	str = malloc(len + 1);
	if (!str)
		return (1);
	i = 0;
	while (i < len)
	{
		str[i] = av[1][i];
		i++;
	}
	str[len] = '\0';
	sort_str(str, len);         //para que estén en orden alfabético.
	ft_putstr(str);             //escribimos la primera permutación
	while (next_permutation(str, len)) //escribimos las siguientes permutaciones
		ft_putstr(str);
	free(str);
	return (0);
}

/*

Lógica del main
___________________________
1. Comprobar argumentos ✓
2. Leer el string ✓
3. Contar caracteres (strlen) ✓
4. Reservar memoria (malloc) ✓
5. Copiar string a memoria ✓
6. Ordenar el string ✓ (para empezar desde la primera permutación)
7. Imprimir primera permutación ✓ (la ordenada)
8. While (next_permutation):
   - Generar siguiente permutación
   - Imprimir
9. Liberar memoria ✓




*/