# Exam Rank 03 - 42

## Estructura del proyecto
```
exam-rank-03/
├── level-1/
├── level-2/
└── exam-practice/
```

## Ejercicios completados

### Level 1

#### Filter ✅
- **Ubicación**: `level-1/filter/`
- **Descripción**: Lee de stdin y reemplaza ocurrencias de una cadena por asteriscos
- **Funciones**: read, write, strlen, memmem, memmove, malloc, calloc, realloc, free, printf, fprintf, stdout, stderr, perror
- **Compilación**: `gcc -Wall -Wextra -Werror filter.c -o filter`
- **Conceptos**: Lectura dinámica, gestión de memoria, búsqueda de patrones
- **Estado**: Completado y funcionando

#### ft_scanf ✅
- **Ubicación**: `level-1/scanf/`
- **Descripción**: Implementar scanf que maneja conversiones %s, %d, %c
- **Funciones**: fgetc, ungetc, ferror, feof, isspace, isdigit, stdin, va_start, va_arg, va_copy, va_end
- **Compilación**: `gcc -Wall -Wextra -Werror ft_scanf.c -o ft_scanf`
- **Progreso**: 
  - ✅ `match_space()` - Saltar espacios en blanco
  - ✅ `match_char()` - Verificar coincidencia de carácter
  - ✅ `scan_char()` - Leer carácter
  - ✅ `scan_int()` - Leer entero con construcción dígito por dígito
  - ✅ `scan_string()` - Leer cadena hasta espacio
  - ✅ `ft_vfscanf()` - Función motor de parsing
  - ✅ `ft_scanf()` - Función principal con argumentos variables
- **Conceptos**: Argumentos variables, parsing de formato, manejo de streams, construcción de números
- **Testing**: Carpeta `tester/` con tests específicos para examen
- **Estado**: Completado y funcionando - pasa 9/10 tests automáticos

## Comandos útiles

### Compilación estándar
```bash
gcc -Wall -Wextra -Werror archivo.c -o programa
```

### Testing
```bash
# Probar con diferentes inputs
echo "texto" | ./programa arg
```

## Notas generales
- Siempre validar argumentos
- Manejar errores con perror()
- Liberar memoria correctamente
- Usar solo funciones permitidas


