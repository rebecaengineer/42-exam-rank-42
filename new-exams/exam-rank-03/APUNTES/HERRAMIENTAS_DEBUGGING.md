# Herramientas de Debugging para el Examen

## 🔧 1. GDB (GNU Debugger) - Para segfaults y bugs complejos

### Compilar con símbolos de debug
```bash
gcc -Wall -Wextra -Werror -g archivo.c -o programa
```

### Iniciar gdb
```bash
gdb ./programa
```

### Comandos básicos dentro de gdb

| Comando | Descripción | Ejemplo |
|---------|-------------|---------|
| `run <args>` | Ejecutar programa con argumentos | `run 3 1 2` |
| `backtrace` o `bt` | Ver pila de llamadas (dónde crasheó) | `bt` |
| `print <var>` | Ver valor de variable | `print index` |
| `list` | Ver código fuente alrededor del crash | `list` |
| `break <línea>` | Poner breakpoint en línea | `break 40` |
| `break <función>` | Poner breakpoint en función | `break main` |
| `next` o `n` | Ejecutar siguiente línea (sin entrar en funciones) | `n` |
| `step` o `s` | Ejecutar siguiente línea (entrando en funciones) | `s` |
| `continue` o `c` | Continuar hasta siguiente breakpoint | `c` |
| `info locals` | Ver todas las variables locales | `info locals` |
| `backtrace full` | Ver stack completo con variables | `bt full` |
| `quit` o `q` | Salir de gdb | `q` |

### Ejemplo de uso cuando hay segfault

```bash
$ gdb ./powerset
(gdb) run 3 1 2
# → Programa crashea

(gdb) backtrace
# Muestra:
#0  backtrack (set=0x..., subset=0x..., index=10, ...) at powerset.c:40
#1  main (argc=4, argv=0x...) at powerset.c:102

(gdb) print index
$1 = 10

(gdb) print set_size
$2 = 2

# ¡Aha! index=10 pero set_size=2 → acceso fuera de límites
```

### Debugging paso a paso

```bash
$ gdb ./programa
(gdb) break main          # Breakpoint al inicio de main
(gdb) run 3 1 2          # Ejecutar con argumentos
(gdb) next               # Ejecutar siguiente línea
(gdb) print target       # Ver valor de variable
(gdb) step               # Entrar en función
(gdb) continue           # Continuar hasta siguiente breakpoint
```

---

## 🔧 2. Valgrind - Para memory leaks y accesos inválidos

### Ejecutar con valgrind

```bash
# Compilar (con o sin -g, pero -g ayuda)
gcc -Wall -Wextra -Werror -g archivo.c -o programa

# Ejecutar con valgrind (básico)
valgrind ./programa 3 1 2

# Versión detallada (RECOMENDADO)
valgrind --leak-check=full --show-leak-kinds=all ./programa 3 1 2
```

### Qué buscar en la salida

#### Error de acceso inválido
```
==12345== Invalid read of size 4
==12345==    at 0x401234: backtrack (powerset.c:40)
                                          ↑
                                    Línea exacta del error
==12345==  Address 0x... is 0 bytes after a block of size 8 alloc'd
```

**Significado**: Intentas acceder a memoria fuera del array (línea 40).

#### Memory leak
```
==12345== HEAP SUMMARY:
==12345==     in use at exit: 8 bytes in 1 blocks
==12345==   total heap usage: 2 allocs, 1 frees, 16 bytes allocated
                                          ↑      ↑
                                    2 malloc  1 free → ¡LEAK!
```

**Significado**: Hiciste 2 `malloc()` pero solo 1 `free()`. Falta liberar memoria.

#### Todo correcto
```
==12345== HEAP SUMMARY:
==12345==     in use at exit: 0 bytes in 0 blocks
==12345==   total heap usage: 2 allocs, 2 frees, 16 bytes allocated
==12345==
==12345== All heap blocks were freed -- no leaks are possible
```

**Significado**: ✅ No hay leaks.

---

## 🔧 3. Printf Debugging - Rápido y simple

Cuando no tienes gdb/valgrind o quieres algo rápido.

### Usar stderr (no interfiere con stdout)

```c
void backtrack(int *set, int *subset, int set_size, int subset_size,
               int index, int current_sum, int target, int *found)
{
    fprintf(stderr, "DEBUG: index=%d, subset_size=%d, set_size=%d, sum=%d\n",
            index, subset_size, set_size, current_sum);

    if (index == set_size)
    {
        fprintf(stderr, "DEBUG: Caso base alcanzado\n");
        // ...
    }

    fprintf(stderr, "DEBUG: Antes de primer backtrack\n");
    backtrack(...);

    fprintf(stderr, "DEBUG: Antes de segundo backtrack\n");
    subset[subset_size] = set[index];
    backtrack(...);
}
```

### Ver solo los debug messages

```bash
./programa 3 1 2 2>&1 | grep DEBUG
```

### Técnica: Checkpoint debugging

```c
int main(int argc, char **argv)
{
    fprintf(stderr, "[CHECKPOINT 1] Inicio main\n");

    if (argc == 1)
    {
        fprintf(stderr, "[CHECKPOINT 2] argc==1\n");
        return 0;
    }

    fprintf(stderr, "[CHECKPOINT 3] Validando argumentos\n");
    if (!check_args(argc, argv))
        return 1;

    fprintf(stderr, "[CHECKPOINT 4] malloc\n");
    int *set = malloc(...);

    fprintf(stderr, "[CHECKPOINT 5] Antes de backtrack\n");
    backtrack(...);

    fprintf(stderr, "[CHECKPOINT 6] Después de backtrack\n");
    free(set);

    fprintf(stderr, "[CHECKPOINT 7] Final\n");
    return 0;
}
```

**Si crashea**: El último checkpoint que viste te dice dónde está el problema.

---

## 🔧 4. Compilador con Warnings - Primera línea de defensa

### Flags obligatorios

```bash
gcc -Wall -Wextra -Werror archivo.c -o programa
```

- `-Wall`: Warnings básicos
- `-Wextra`: Warnings extra
- `-Werror`: Trata warnings como errores (no compila si hay warnings)

### Flags extra útiles

```bash
gcc -Wall -Wextra -Werror -Wshadow -Wconversion archivo.c -o programa
```

- `-Wshadow`: Avisa de variables que ocultan otras
- `-Wconversion`: Avisa de conversiones implícitas peligrosas

### Ejemplos de warnings útiles

```c
int i = 0;
while (i < size - 1)  // Warning si size es unsigned y puede ser 0
{
    i++;
}
```

```c
int value = atoi(argv[1]);
char c = value;  // Warning: conversión de int a char (pérdida de datos)
```

---

## 🎯 Estrategia para el examen (Orden recomendado)

### Si tu programa crashea:

```
1. Compilar y ver warnings
   ↓
   gcc -Wall -Wextra -Werror -g programa.c -o programa

2. Si crashea, usar valgrind primero (más rápido)
   ↓
   valgrind ./programa <args>

3. Si valgrind no está claro, usar gdb
   ↓
   gdb ./programa
   (gdb) run <args>
   (gdb) backtrace
   (gdb) print <variables_sospechosas>

4. Si aún no es claro, printf debugging
   ↓
   fprintf(stderr, "DEBUG: var=%d\n", var);
```

---

## 📋 Comandos de gdb más útiles (cheatsheet)

| Situación | Comando |
|-----------|---------|
| Programa crashea | `run <args>` → `backtrace` → `print <vars>` |
| Seguir ejecución paso a paso | `break main` → `run` → `next` (repetir) |
| Ver qué pasa en una función | `break función` → `run` → `step` |
| Ver el código | `list` |
| Ver todas las variables locales | `info locals` |
| Ver el stack completo | `backtrace full` |
| Salir de gdb | `quit` o `q` |

---

## 📋 Comandos de valgrind (cheatsheet)

| Comando | Uso |
|---------|-----|
| `valgrind ./programa` | Detectar errores de memoria |
| `valgrind --leak-check=full ./programa` | Detectar memory leaks (detallado) |
| `valgrind --show-leak-kinds=all ./programa` | Mostrar todos los tipos de leaks |
| `valgrind --track-origins=yes ./programa` | Rastrear origen de valores no inicializados |

---

## 💡 Tips para el examen

1. **Siempre compila con `-g`** cuando debuggees
2. **Valgrind primero**, gdb si necesitas más detalle
3. **Printf debugging** es lo más rápido para bugs simples
4. **Revisa warnings** antes que nada
5. **`backtrace`** te dice exactamente dónde crasheó
6. **No te olvides de `free()`** - valgrind te lo recordará
7. **Usa `stderr` para debug**, no `stdout`

---

## 🧪 Ejemplo práctico: Bug intencional

```c
// test.c
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int *arr = malloc(5 * sizeof(int));
    arr[10] = 42;  // Bug: acceso fuera de límites
    printf("%d\n", arr[10]);
    free(arr);
    return 0;
}
```

### Detectar con valgrind

```bash
$ gcc -Wall -Wextra -Werror -g test.c -o test
$ valgrind ./test

==12345== Invalid write of size 4
==12345==    at 0x109158: main (test.c:7)
==12345==  Address 0x4a9d068 is 20 bytes after a block of size 20 alloc'd
                                              ↑
                                    arr[10] está fuera del array
```

### Detectar con gdb

```bash
$ gdb ./test
(gdb) run
(gdb) backtrace
#0  main () at test.c:7
(gdb) print arr
$1 = (int *) 0x555555559260
(gdb) print &arr[10]
$2 = (int *) 0x555555559288  # Fuera del espacio alocado
```

---

## 📝 RESUMEN RÁPIDO (Para uso en el examen)

### Programa crashea (segfault)

```bash
# 1. Compilar con -g
gcc -Wall -Wextra -Werror -g programa.c -o programa

# 2. Valgrind (identifica línea del error)
valgrind ./programa <args>

# 3. Si no es claro, gdb
gdb ./programa
(gdb) run <args>
(gdb) backtrace
(gdb) print <var>
```

### Memory leaks

```bash
valgrind --leak-check=full ./programa <args>
# Busca: "X bytes in Y blocks"
# Si Y > 0 → hay leak
```

### Debugging rápido

```c
// Añadir en puntos clave:
fprintf(stderr, "DEBUG: var=%d\n", var);
```

### Warnings del compilador

```bash
gcc -Wall -Wextra -Werror programa.c
# Corrige TODOS los warnings antes de ejecutar
```

---

## 🎯 Flujo de trabajo recomendado

```
1. Escribe código
   ↓
2. Compila con -Wall -Wextra -Werror
   ↓ (si hay warnings)
3. Corrige warnings
   ↓
4. Ejecuta programa
   ↓ (si crashea)
5. Valgrind (identifica problema)
   ↓ (si necesitas más info)
6. gdb (analiza en detalle)
   ↓ (si sigue sin estar claro)
7. Printf debugging (paso a paso)
   ↓
8. Corrige bug
   ↓
9. Vuelve a paso 2
```

---

## ⚡ CHEATSHEET ULTRA RÁPIDO

```bash
# Compilar para debugging
gcc -Wall -Wextra -Werror -g programa.c -o programa

# Segfault - opción 1 (rápido)
valgrind ./programa <args>

# Segfault - opción 2 (detallado)
gdb ./programa
(gdb) run <args>
(gdb) backtrace
(gdb) print <var>

# Memory leaks
valgrind --leak-check=full ./programa <args>

# Printf debugging
fprintf(stderr, "DEBUG: %d\n", var);
```

**Orden**: Warnings → Valgrind → gdb → Printf
