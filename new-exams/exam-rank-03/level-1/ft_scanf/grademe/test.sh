#!/bin/bash

# Test script para ft_scanf

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== TESTING FT_SCANF ===${NC}"

# Limpiar archivos previos
rm -f ft_scanf test_program

# Verificar que existe el archivo fuente
if [ ! -f "ft_scanf.c" ]; then
    echo -e "${RED}❌ Error: ft_scanf.c no encontrado${NC}"
    exit 1
fi

# Crear archivo de test temporal
cat > test_main.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declarar ft_scanf
int ft_scanf(const char *format, ...);

int main(void)
{
    char str[100];
    int num;
    char c;
    int result;
    
    // Test 1: Leer string
    printf("=== Test 1: String ===\n");
    printf("Input: Hello\n");
    FILE *f1 = fopen("test1.txt", "w");
    fprintf(f1, "Hello");
    fclose(f1);
    freopen("test1.txt", "r", stdin);
    
    result = ft_scanf("%s", str);
    printf("Result: %d, String: '%s'\n", result, str);
    
    // Test 2: Leer entero
    printf("\n=== Test 2: Integer ===\n");
    printf("Input: 42\n");
    FILE *f2 = fopen("test2.txt", "w");
    fprintf(f2, "42");
    fclose(f2);
    freopen("test2.txt", "r", stdin);
    
    result = ft_scanf("%d", &num);
    printf("Result: %d, Number: %d\n", result, num);
    
    // Test 3: Leer carácter
    printf("\n=== Test 3: Character ===\n");
    printf("Input: A\n");
    FILE *f3 = fopen("test3.txt", "w");
    fprintf(f3, "A");
    fclose(f3);
    freopen("test3.txt", "r", stdin);
    
    result = ft_scanf("%c", &c);
    printf("Result: %d, Character: '%c'\n", result, c);
    
    // Limpiar archivos temporales
    remove("test1.txt");
    remove("test2.txt");
    remove("test3.txt");
    
    return 0;
}
EOF

# Compilar
echo -e "${YELLOW}Compilando ft_scanf.c...${NC}"
if ! gcc -Wall -Wextra -Werror test_main.c ft_scanf.c -o test_program 2>/dev/null; then
    echo -e "${RED}❌ Error de compilación${NC}"
    gcc -Wall -Wextra -Werror test_main.c ft_scanf.c -o test_program
    rm -f test_main.c
    exit 1
fi

echo -e "${GREEN}✅ Compilación exitosa${NC}"

# Ejecutar tests
echo -e "${YELLOW}Ejecutando tests...${NC}"
./test_program

# Verificar que no haya errores críticos
if [ $? -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Tests ejecutados correctamente!${NC}"
    rm -f test_program test_main.c
    exit 0
else
    echo -e "${RED}❌ Error durante la ejecución${NC}"
    rm -f test_program test_main.c
    exit 1
fi