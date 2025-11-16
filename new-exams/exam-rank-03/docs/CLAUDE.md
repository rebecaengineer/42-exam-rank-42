# Exam Rank 03 - 42

## Estructura del proyecto
```
exam-rank-03/
├── level-1/              # Ejercicios nivel 1 (subjects, tests, grademe)
├── level-2/              # Ejercicios nivel 2 (subjects, tests, grademe)
├── rendu/                # Espacio de trabajo para hacer los ejercicios
├── rendu3/               # Soluciones de referencia permanentes
├── exam_progress/        # Archivos de progreso por nivel
├── exam.sh               # Sistema de práctica principal
└── init.sh               # Script de inicialización
```

## Sistema de Práctica (exam.sh)

### Características principales
- **Carpeta rendu/**: Espacio de trabajo donde crearás y editarás tus soluciones
- **Carpeta rendu3/**: Soluciones de referencia permanentes (no se borran nunca)
- **Tracking de progreso**: Mantiene registro de ejercicios completados por nivel
- **Permite rehacer ejercicios**: Opción 4 permite seleccionar y repetir ejercicios completados
- **Validación automática**: Ejecuta tests de grademe/ automáticamente
- **Copia de headers**: Si existe .h, se copia automáticamente a tu espacio de trabajo
- **Bucle de reintentos**: Permite reintentar validación sin salir del ejercicio
- **Preparación automática**: Crea archivos vacíos en rendu/ al seleccionar ejercicio

### Modos de práctica
1. **Aleatorio general**: Ejercicios de todos los niveles no completados
2. **Aleatorio por nivel**: Solo ejercicios de un nivel específico
3. **Aleatorio de nivel**: Práctica enfocada en un nivel
4. **Selección específica**: Elige manualmente cualquier ejercicio (incluidos completados)

### Uso
```bash
./exam.sh
# Opción 4: Seleccionar ejercicio específico (permite rehacer completados)
```

### Flujo de trabajo
1. **Selecciona ejercicio**: El sistema muestra el subject
2. **Crea tu espacio de trabajo**:
   ```bash
   cd rendu
   mkdir nombre_ejercicio
   cd nombre_ejercicio
   touch nombre_ejercicio.c
   # Si necesitas .h: touch nombre_ejercicio.h
   ```
3. **Edita tu solución**: Trabaja en los archivos que creaste en `rendu/ejercicio/`
4. **Valida**: El sistema copia tus archivos (.c y .h) al directorio del ejercicio y ejecuta los tests
5. **Si pasa**: Tu solución se guarda en `rendu3/` como referencia permanente
6. **Si falla**: Puedes corregir y reintentar sin límites

### Sistema de Reintentos
Cuando trabajas en un ejercicio, tienes un menú interactivo con opciones:
1. **Validar ejercicio** - Ejecuta los tests con tu código de rendu/
2. **Marcar como completado sin validar** - Guarda sin testear
3. **Ver subject de nuevo** - Remuestra el enunciado
4. **Limpiar ejercicio (empezar de cero)** - Elimina tu código en rendu/ para reempezar
5. **Siguiente ejercicio / Volver al menú** - Sale del ejercicio actual

**Si los tests fallan**: El sistema NO te saca del ejercicio. Puedes:
- Editar tu código en `rendu/ejercicio/ejercicio.c`
- Volver a validar (opción 1)
- Repetir tantas veces como necesites hasta que pase

**Para rehacer ejercicios completados**:
- Selecciona el ejercicio con opción 4 del menú principal
- Usa la opción 4 "Limpiar ejercicio" para borrar tu código en rendu/
- Empieza de cero para practicar
- Las soluciones de referencia están siempre disponibles en `rendu3/`

Esto simula el comportamiento real del examen, donde puedes reintentar hasta completar correctamente.

### Carpetas importantes

#### rendu/ (Espacio de trabajo)
- Aquí trabajas en tus ejercicios
- Se crea automáticamente al seleccionar un ejercicio
- Puedes limpiar y rehacer ejercicios
- **No se commitea a git** (está en .gitignore)

#### rendu3/ (Soluciones de referencia)
- Soluciones que ya pasaron los tests
- Material de estudio y referencia permanente
- Código para consultar si te atascas
- **Nunca se borra**

#### level-1/ y level-2/
- Contienen subjects, tests y grademe/
- **NO contienen carpetas solutions/** (se eliminaron)
- Solo material de enunciados y validación

### Archivos de progreso
- `exam_progress/level1_done.txt`: Ejercicios completados de Level 1
- `exam_progress/level2_done.txt`: Ejercicios completados de Level 2

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

#### broken_gnl ✅
- **Ubicación**: `level-1/broken_gnl/`
- **Descripción**: Detectar y reparar errores en implementación de get_next_line
- **Funciones**: read, malloc, free, ft_strchr, ft_memcpy, ft_memmove, ft_strlen
- **Compilación**: `gcc -Wall -Wextra -Werror broken_gnl.c -D BUFFER_SIZE=10 -o gnl`
- **Errores identificados y reparados**: 
  - ✅ `ft_strchr()` - Bucle infinito sin protección '\0'
  - ✅ `ft_memcpy()` - Copia incompleta con condición --n > 0
  - ✅ `str_append_mem()` - Crash con NULL pointer
  - ✅ `ft_memmove()` - Uso incorrecto de ft_strlen() vs n
  - ✅ `ft_memmove()` - Bucle infinito con size_t unsigned
  - ✅ `get_next_line()` - No maneja EOF (read_ret == 0)
  - ✅ `get_next_line()` - No actualiza tmp después de leer
  - ✅ `get_next_line()` - Crash con tmp NULL al final
- **Conceptos**: Debugging, static variables, buffer management, memory leaks, tipos signed/unsigned
- **Archivo reparado**: `reparired/repaired_gnl_mio.c` - versión completamente funcional
- **Estado**: Completado - todos los errores identificados y reparados

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
- Proteger contra punteros NULL
- Cuidado con tipos unsigned en bucles decrementales
- Manejar EOF correctamente en read()
- Actualizar variables de control en bucles


