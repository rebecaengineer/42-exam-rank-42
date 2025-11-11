#!/bin/bash

# Test script para broken_gnl

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== TESTING BROKEN_GNL ===${NC}"

# Limpiar archivos previos
rm -f gnl_test test_file.txt

# Verificar que existen los archivos necesarios
if [ ! -f "get_next_line.c" ]; then
    echo -e "${RED}❌ Error: get_next_line.c no encontrado${NC}"
    exit 1
fi

if [ ! -f "get_next_line.h" ]; then
    echo -e "${RED}❌ Error: get_next_line.h no encontrado${NC}"
    exit 1
fi

# Crear archivo de test
cat > test_main.c << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "get_next_line.h"

int main(void)
{
    int fd;
    char *line;
    int count = 0;
    
    // Crear archivo de test
    fd = open("test_file.txt", O_CREAT | O_WRONLY | O_TRUNC, 0644);
    if (fd == -1) {
        printf("Error creando archivo de test\n");
        return 1;
    }
    
    write(fd, "Línea 1\nLínea 2\nLínea 3\n", 24);
    close(fd);
    
    // Abrir para lectura
    fd = open("test_file.txt", O_RDONLY);
    if (fd == -1) {
        printf("Error abriendo archivo de test\n");
        return 1;
    }
    
    printf("=== Test: Lectura línea por línea ===\n");
    
    // Leer líneas
    while ((line = get_next_line(fd)) != NULL)
    {
        count++;
        printf("Línea %d: %s", count, line);
        free(line);
    }
    
    close(fd);
    
    printf("\n=== Test completado ===\n");
    printf("Líneas leídas: %d\n", count);
    
    if (count == 3) {
        printf("✅ Test pasado - Se leyeron 3 líneas correctamente\n");
        remove("test_file.txt");
        return 0;
    } else {
        printf("❌ Test fallido - Se esperaban 3 líneas, se leyeron %d\n", count);
        remove("test_file.txt");
        return 1;
    }
}
EOF

# Compilar
echo -e "${YELLOW}Compilando get_next_line.c...${NC}"
if ! gcc -Wall -Wextra -Werror -D BUFFER_SIZE=42 test_main.c get_next_line.c -o gnl_test 2>/dev/null; then
    echo -e "${RED}❌ Error de compilación${NC}"
    gcc -Wall -Wextra -Werror -D BUFFER_SIZE=42 test_main.c get_next_line.c -o gnl_test
    rm -f test_main.c
    exit 1
fi

echo -e "${GREEN}✅ Compilación exitosa${NC}"

# Ejecutar test
echo -e "${YELLOW}Ejecutando tests...${NC}"
./gnl_test

result=$?

# Limpiar archivos temporales
rm -f gnl_test test_main.c test_file.txt

if [ $result -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Test pasado correctamente!${NC}"
    exit 0
else
    echo -e "${RED}❌ Test fallido${NC}"
    exit 1
fi