#!/bin/bash

# Test script para permutations

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== TESTING PERMUTATIONS ===${NC}"

# Limpiar archivos previos
rm -f permutations

# Verificar que existe el archivo fuente
if [ ! -f "permutations.c" ]; then
    echo -e "${RED}❌ Error: permutations.c no encontrado${NC}"
    exit 1
fi

# Compilar
echo -e "${YELLOW}Compilando permutations.c...${NC}"
if ! gcc -Wall -Wextra -Werror permutations.c -o permutations 2>/dev/null; then
    echo -e "${RED}❌ Error de compilación${NC}"
    gcc -Wall -Wextra -Werror permutations.c -o permutations
    exit 1
fi

echo -e "${GREEN}✅ Compilación exitosa${NC}"

# Test básico
echo -e "${YELLOW}Test básico: ./permutations abc${NC}"
./permutations abc
result=$?

# Limpiar
rm -f permutations

if [ $result -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Test ejecutado correctamente!${NC}"
    echo -e "${YELLOW}Nota: Verificar manualmente que las permutaciones están en orden lexicográfico${NC}"
    exit 0
else
    echo -e "${RED}❌ Error durante la ejecución${NC}"
    exit 1
fi