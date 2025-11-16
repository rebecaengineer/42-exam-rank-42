# EXAM RANK 03 - PROGRESS TRACKER

## ESTADO ACTUAL: 🎆 LEVEL 1 COMPLETADO - PREPARANDO LEVEL 2

---

## PLAN DE ESTUDIO

### **LEVEL 1 - EJERCICIOS BÁSICOS**

#### 1. **FILTER** ✅ COMPLETADO
**Estado:** Implementado y funcionando
**Conceptos necesarios:**
- [x] Manejo de argumentos (argc/argv)
- [x] Lectura con buffer dinámico
- [x] Función memmem() - Buscar substring
- [x] Función memmove() - Mover memoria
- [x] Gestión de memoria dinámica
- [x] **EJERCICIO PRÁCTICO:** Programa básico de lectura stdin
- [x] Implementar búsqueda y reemplazo
- [x] Completar ejercicio filter (pruebas finales)

#### 2. **FT_SCANF** ✅ COMPLETADO
**Conceptos necesarios:**
- [x] Variadic functions (va_list, va_start, va_arg, va_end)
- [x] Parsing de formato strings
- [x] Funciones de E/S (fgetc, ungetc, ferror, feof)
- [x] Implementación de conversores (%s, %d, %c)
- [x] Manejo de espacios en blanco
- [x] **EJERCICIO PRÁCTICO:** Implementación completa funcional

#### 3. **BROKEN_GNL** ✅ COMPLETADO
**Conceptos necesarios:**
- [x] Debugging técnicas
- [x] Static variables
- [x] File descriptors
- [x] Buffer management
- [x] Memory leak detection
- [x] Tipos signed vs unsigned
- [x] Manejo de EOF
- [x] Gestión de buffer estático
- [x] **EJERCICIO PRÁCTICO:** 8 errores identificados y reparados

---

### **LEVEL 2 - EJERCICIOS AVANZADOS**

#### 4. **PERMUTATIONS** ⏸️ PENDIENTE
**Conceptos necesarios:**
- [ ] Recursión básica
- [ ] Backtracking
- [ ] Algoritmos de permutación
- [ ] Ordenamiento lexicográfico

#### 5. **POWERSET** ⏸️ PENDIENTE
**Conceptos necesarios:**
- [ ] Recursión con múltiples parámetros
- [ ] Combinaciones y subconjuntos
- [ ] Algoritmos de suma
- [ ] Optimización de memoria

#### 6. **N_QUEENS** ⏸️ PENDIENTE
**Conceptos necesarios:**
- [ ] Backtracking avanzado
- [ ] Validación de restricciones
- [ ] Representación de tablero
- [ ] Optimización de algoritmos

#### 7. **RIP** ⏸️ PENDIENTE
**Conceptos necesarios:**
- [ ] Algoritmos de balanceo
- [ ] Stack simulation
- [ ] String manipulation avanzada
- [ ] Generación de soluciones múltiples

#### 8. **TSP** ⏸️ PENDIENTE
**Conceptos necesarios:**
- [ ] Algoritmos de grafos
- [ ] Permutaciones con optimización
- [ ] Cálculo de distancias
- [ ] Matemáticas básicas (sqrtf)

---

## NOTAS Y OBSERVACIONES

### Conceptos transversales importantes:
- **Gestión de memoria:** malloc, calloc, realloc, free
- **Manejo de errores:** return codes, stderr output
- **I/O operations:** read, write, printf, fprintf
- **String operations:** strlen, memmem, memmove

### Próximos pasos:
1. **AHORA:** Comenzar LEVEL 2 - Ejercicios avanzados
2. **SIGUIENTE:** Estudiar algoritmos de recursion y backtracking
3. **DESPUÉS:** Implementar PERMUTATIONS como primer ejercicio de Level 2

---

## HISTORIAL DE SESIONES

### Sesión 1 - [FECHA ANTERIOR]
- ✅ Análisis inicial de estructura del examen
- ✅ Identificación de ejercicios y niveles
- ✅ Creación de plan de estudio
- ✅ Comenzando explicación de conceptos FILTER

### Sesión 2 - [FECHA ANTERIOR]
- ✅ Implementación de práctica para FILTER
- ✅ Comprensión de lectura dinámica con buffer
- ✅ Implementación de búsqueda y reemplazo (dos métodos)
- ✅ Creación de Makefile y documentación
- ✅ Prácticas adicionales con diferentes casos de uso

### Sesión 3 - [2025-11-01]
- ✅ Completado ejercicio BROKEN_GNL
- ✅ Identificación de 8 errores críticos:
  - ft_strchr: bucle infinito sin protección '\0'
  - ft_memcpy: copia incompleta con --n > 0
  - str_append_mem: crash con NULL pointer
  - ft_memmove: uso incorrecto de ft_strlen vs n
  - ft_memmove: bucle infinito con size_t unsigned
  - get_next_line: no maneja EOF correctamente
  - get_next_line: no actualiza tmp después de leer
  - get_next_line: crash con tmp NULL al final
- ✅ Creación de archivo APUNTES_BROKEN_GNL.md
- ✅ Implementación completa en repaired_gnl_mio.c

---

**INSTRUCCIONES PARA PRÓXIMAS SESIONES:**
1. Leer este documento para ver el progreso actual
2. Continuar desde el punto marcado como "EN PROGRESO"
3. Actualizar checkboxes conforme se completen conceptos
4. Añadir notas en "HISTORIAL DE SESIONES"