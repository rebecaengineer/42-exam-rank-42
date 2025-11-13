/*
 * TEST PARA EXAMEN - ft_scanf
 * Solo casos que aparecen en exámenes reales
 * 
 * Compilar: gcc exam_test.c -o exam_test
 * Ejecutar: ./exam_test
 */

#include <stdio.h>
#include <stdarg.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

// Códigos de color
#define GREEN "\033[32m"
#define RED "\033[31m"
#define BLUE "\033[34m"
#define RESET "\033[0m"
#define BOLD "\033[1m"

// Incluir implementación sin main
#include "create_test_version.c"

void exam_test(const char* test_name, const char* input, const char* format, 
               const char* expected_output, int expected_return) {
    
    printf(BLUE "%s:" RESET " ", test_name);
    
    // Crear archivo temporal
    FILE *temp = fopen("temp.txt", "w");
    fprintf(temp, "%s", input);
    fclose(temp);
    freopen("temp.txt", "r", stdin);
    
    // Variables
    int n = -999;
    char c = '?';
    char s[100] = "ERROR";
    int result = -1;
    char output[200] = "";
    
    // Ejecutar según formato
    if (strcmp(format, "%d") == 0) {
        result = ft_scanf("%d", &n);
        sprintf(output, "%d", n);
    }
    else if (strcmp(format, "%c") == 0) {
        result = ft_scanf("%c", &c);
        sprintf(output, "%c", c);
    }
    else if (strcmp(format, "%s") == 0) {
        result = ft_scanf("%s", s);
        strcpy(output, s);
    }
    else if (strcmp(format, "%d %c %s") == 0) {
        result = ft_scanf("%d %c %s", &n, &c, s);
        sprintf(output, "%d %c %s", n, c, s);
    }
    
    // Verificar resultado
    if (result == expected_return && strcmp(output, expected_output) == 0) {
        printf(GREEN BOLD "PASS" RESET "\n");
    } else {
        printf(RED BOLD "FAIL" RESET " (expected: %s, got: %s)\n", expected_output, output);
    }
    
    // Limpiar
    freopen("/dev/tty", "r", stdin);
    remove("temp.txt");
}

int main() {
    printf(BOLD BLUE "🎓 EXAM TEST - ft_scanf\n");
    printf("=======================" RESET "\n\n");
    
    // Test 1: Caso más común en examen
    exam_test("Test 1 (%d)", "42", "%d", "42", 1);
    
    // Test 2: Carácter simple
    exam_test("Test 2 (%c)", "a", "%c", "a", 1);
    
    // Test 3: String simple  
    exam_test("Test 3 (%s)", "hello", "%s", "hello", 1);
    
    // Test 4: Combinación típica de examen
    exam_test("Test 4 (multi)", "123 x world", "%d %c %s", "123 x world", 3);
    
    // Test 5: Números con espacios (muy común)
    exam_test("Test 5 (spaces)", "  456", "%d", "456", 1);
    
    // Test 6: Input inválido para %d (caso típico)
    exam_test("Test 6 (invalid)", "abc", "%d", "-999", 0);
    
    printf("\n" BOLD "RESULTADO:" RESET "\n");
    printf("Si todos los tests muestran " GREEN BOLD "PASS" RESET ", \n");
    printf("tu implementación pasará el examen! 🎉\n\n");
    
    return 0;
}