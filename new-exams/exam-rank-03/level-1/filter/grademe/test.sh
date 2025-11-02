#!/bin/bash

# Test script para filter

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== TESTING FILTER ===${NC}"

# Limpiar archivos previos
rm -f filter test_output expected_output

# Verificar que existe el archivo fuente
if [ ! -f "filter.c" ]; then
    echo -e "${RED}❌ Error: filter.c no encontrado${NC}"
    exit 1
fi

# Compilar
echo -e "${YELLOW}Compilando filter.c...${NC}"
if ! gcc -Wall -Wextra -Werror filter.c -o filter 2>/dev/null; then
    echo -e "${RED}❌ Error de compilación${NC}"
    gcc -Wall -Wextra -Werror filter.c -o filter
    exit 1
fi

echo -e "${GREEN}✅ Compilación exitosa${NC}"

# Test 1: Caso básico
echo -e "${YELLOW}Test 1: Reemplazo básico${NC}"
echo "hello world hello" | ./filter "hello" > test_output
echo "***** world *****" > expected_output
if diff test_output expected_output >/dev/null; then
    echo -e "${GREEN}✅ Test 1 pasado${NC}"
else
    echo -e "${RED}❌ Test 1 fallido${NC}"
    echo "Esperado:"
    cat expected_output
    echo "Obtenido:"
    cat test_output
    exit 1
fi

# Test 2: Sin coincidencias
echo -e "${YELLOW}Test 2: Sin coincidencias${NC}"
echo "hello world" | ./filter "xyz" > test_output
echo "hello world" > expected_output
if diff test_output expected_output >/dev/null; then
    echo -e "${GREEN}✅ Test 2 pasado${NC}"
else
    echo -e "${RED}❌ Test 2 fallido${NC}"
    exit 1
fi

# Test 3: Argumentos incorrectos
echo -e "${YELLOW}Test 3: Manejo de argumentos${NC}"
./filter 2>/dev/null
if [ $? -ne 0 ]; then
    echo -e "${GREEN}✅ Test 3 pasado (manejo correcto de argumentos)${NC}"
else
    echo -e "${RED}❌ Test 3 fallido${NC}"
    exit 1
fi

# Test 4: Cadena completa
echo -e "${YELLOW}Test 4: Cadena completa${NC}"
echo "test" | ./filter "test" > test_output
echo "****" > expected_output
if diff test_output expected_output >/dev/null; then
    echo -e "${GREEN}✅ Test 4 pasado${NC}"
else
    echo -e "${RED}❌ Test 4 fallido${NC}"
    exit 1
fi

# Limpiar archivos temporales
rm -f test_output expected_output filter

echo -e "${GREEN}🎉 ¡Todos los tests pasados!${NC}"
exit 0