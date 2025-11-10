#include <unistd.h>
#include <stdlib.h>

// Función para imprimir cadena con write
void ft_putstr(char *str) {
    int len = 0;
    while (str[len] != '\0')
        len++;
    write(1, str, len);
    write(1, "\n", 1);
}

// Swap de dos caracteres
void ft_swap(char *a, char *b) {
    char temp = *a;
    *a = *b;
    *b = temp;
}

// Ordenamiento simple (burbuja o selección)
void sort_str(char *str, int len) {
    int i, j;
    for (i = 0; i < len -1; i++) {
        for (j = i + 1; j < len; j++) {
            if (str[i] > str[j])
                ft_swap(&str[i], &str[j]);
        }
    }
}

// Backtracking para permutaciones
void permute(char *str, int start, int end) {
    if (start == end) {
        ft_putstr(str);
        return;
    }
    for (int i = start; i <= end; i++) {
        ft_swap(&str[start], &str[i]);
        permute(str, start + 1, end);
        ft_swap(&str[start], &str[i]); // Backtrack
    }
}

int main(int argc, char **argv) {
    if (argc != 2)
        return 1;

    // Calcular longitud manualmente
    int len = 0;
    while (argv[1][len] != '\0')
        len++;

    // Reservar memoria
    char *copy = malloc(len + 1);
    if (!copy)
        return 1;

    // Copiar manualmente
    for (int i = 0; i < len; i++)
        copy[i] = argv[1][i];
    copy[len] = '\0';

    sort_str(copy, len);
    permute(copy, 0, len - 1);

    free(copy);
    return 0;
}