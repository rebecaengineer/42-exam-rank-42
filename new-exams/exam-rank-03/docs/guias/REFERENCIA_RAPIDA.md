# Referencia Rápida - Conceptos C

Documento de consulta rápida con conceptos que necesito repasar frecuentemente.

---

## Malloc y sizeof

### Regla fundamental

**`sizeof(char)` siempre es 1 byte** (definido por el estándar C)

Por eso, para `char*` no necesitas multiplicar por `sizeof(char)`.

### Comparación con otros tipos

```c
// CHAR - sizeof(char) = 1 byte
char *str = malloc(sizeof(char) * len);  // Opcional (verbose)
char *str = malloc(len);                 // Equivalente (más común)

// INT - sizeof(int) = 4 bytes (típicamente)
int *arr_int = malloc(sizeof(int) * len);  // ✅ NECESARIO

// DOUBLE - sizeof(double) = 8 bytes (típicamente)
double *arr_dbl = malloc(sizeof(double) * len);  // ✅ NECESARIO

// STRUCT
typedef struct s_data {
    int x;
    char c;
} t_data;
t_data *arr = malloc(sizeof(t_data) * len);  // ✅ NECESARIO
```

### ¿Cuál usar?

#### Para `char*` (cadenas)
```c
int len = ft_strlen(str);
char *new_str = malloc(len + 1);  // ✅ Más común y simple
//                         ^^^^^ +1 para el '\0'
```

#### Para otros tipos
```c
// Opción 1: Especificar tipo explícitamente
int *arr = malloc(sizeof(int) * n);  // ✅ Correcto

// Opción 2: Usar sizeof con el puntero (MÁS RECOMENDADO)
int *arr = malloc(sizeof(*arr) * n);  // ✅ Mejor (independiente del tipo)
```

### ¿Por qué `sizeof(*arr)` es mejor?

```c
// Si cambias el tipo de dato, no tienes que cambiar el malloc
int *arr = malloc(sizeof(*arr) * n);    // Funciona
double *arr = malloc(sizeof(*arr) * n); // Funciona
char *arr = malloc(sizeof(*arr) * n);   // Funciona

// Vs. versión explícita:
int *arr = malloc(sizeof(int) * n);     // Si cambias a double, tienes que
                                         // recordar cambiar sizeof(int) también
```

### Resumen rápido

| Tipo | Sintaxis recomendada | ¿Por qué? |
|------|---------------------|-----------|
| `char*` | `malloc(len + 1)` | sizeof(char) = 1, el +1 es para '\0' |
| `int*` | `malloc(sizeof(int) * n)` | sizeof(int) = 4 bytes (típico) |
| Cualquier tipo | `malloc(sizeof(*ptr) * n)` | Independiente del tipo, más seguro |

**Regla de oro:** Para `char` usa `malloc(len + 1)`, para todo lo demás usa `sizeof()`.

---

## [Agregar más conceptos aquí conforme los vayas necesitando]
