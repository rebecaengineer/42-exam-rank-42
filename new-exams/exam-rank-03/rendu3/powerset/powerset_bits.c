#include "powerset_bits.h"

int	main(int ac, char **av)
{
	if (ac < 2)
		return (0);
	
	int				k = ac - 2;
	int				target = atoi(av[1]);
	unsigned long	total = 1UL << k;
	int				found = 0;

	unsigned long	mask = 1;
	while (mask < total)
	{
		int			sum = 0;
		int			i = 0;
		while (i < k)
		{
			if (mask & (1UL << i))
				sum += atoi(av[i + 2]); //i+2 -> salta los 1ªs args (./a.out y target);
			++i;
		}

		if (sum == target)
		{
			int		first = 1;
			i = 0;
			while (i < k)
			{
				if (mask & (1UL << i))
				{
					if (!first)
						printf(" ");
					printf("%s", av[i + 2]);
					first = 0;
				}
				++i;
			}
			printf("\n");
			found = 1;
		}
		++mask;
	}
	if (!found)
		printf("\n");
	return (0);
}