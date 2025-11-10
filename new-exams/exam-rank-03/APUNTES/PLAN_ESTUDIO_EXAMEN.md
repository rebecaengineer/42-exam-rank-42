# Plan de Estudio para el Examen - Rank 03

## ⏰ Información del Examen

- **Fecha**: Martes 11 de diciembre, 18:00
- **Inicio del plan**: Domingo 9 de diciembre, 10:00 AM
- **Tiempo disponible**: ~56 horas (realista: 25-30h de estudio)

---

## 📚 Ejercicios a Estudiar

| Ejercicio | Nivel | Prioridad | Estado |
|-----------|-------|-----------|--------|
| **Powerset** | 2 | ⭐⭐⭐⭐⭐ | ✅ Estudiado (Sábado) |
| **Permutations** | 2 | ⭐⭐⭐⭐⭐ | ⏳ Por estudiar |
| **Filter** | 1 | ⭐⭐⭐⭐ | 🔄 Repasar |
| **Broken_gnl** | 1 | ⭐⭐⭐ | 🔄 Repasar |
| **N-queens** | 2 | ⭐⭐ | ⏳ Por estudiar |

---

## 📅 DOMINGO 9 (Hoy - desde 10:00 AM)

### ✅ 10:00-13:00 (3h) - PERMUTATIONS (primera vez)

**Ubicación**: `level-2/permutations/`

**Tareas**:
- [ ] Leer `subject-es.txt` (15min)
- [ ] Estudiar solución en `rendu3/permutations/` si existe (45min)
- [ ] Cerrar todo y hacer desde cero (1.5h)
- [ ] Compilar y probar
- [ ] Comparar con solución (30min)

**Meta**: Entender el algoritmo y tener primera versión funcionando.

**Conceptos clave**:
- Backtracking (similar a powerset)
- Array de "usados" para evitar repeticiones
- Generar todas las permutaciones

```bash
cd level-2/permutations/
cat subject-es.txt
# Estudiar solución
# Cerrar todo
cd ~/rendu/
mkdir permutations
cd permutations
touch permutations.c permutations.h
# Implementar
gcc -Wall -Wextra -Werror permutations.c -o permutations
./permutations 1 2 3
```

---

### 🍽️ 13:00-14:00 - COMIDA Y DESCANSO

---

### ✅ 14:00-15:00 (1h) - POWERSET (repaso rápido)

**Objetivo**: Refrescar lo aprendido ayer.

**Tareas**:
- [ ] Borrar carpeta `rendu/powerset/`
- [ ] Hacer desde cero SIN MIRAR (45min)
- [ ] Si te atascas >10min, consultar `rendu3/powerset/`
- [ ] Compilar y probar

```bash
cd rendu/
rm -rf powerset/
mkdir powerset
cd powerset
touch powerset.c powerset.h
# Implementar desde cero
gcc -Wall -Wextra -Werror powerset.c -o powerset
./powerset 3 1 0 2 4 5 3
```

**Meta**: Terminarlo en <45min

---

### ✅ 15:00-17:00 (2h) - FILTER (repaso activo)

**Ubicación**: `level-1/filter/`

**Tareas**:
- [ ] Leer `subject-es.txt` (10min)
- [ ] Leer apuntes si existen (10min)
- [ ] Estudiar solución en `rendu3/filter/` (30min)
- [ ] Hacer desde cero (1h)
- [ ] Comparar con solución (10min)

**Conceptos clave**:
- `read()` dinámico de stdin
- `memmem()` para buscar substring
- Reemplazo de strings con asteriscos
- Gestión de memoria dinámica

```bash
cd level-1/filter/
cat subject-es.txt
# Estudiar solución en rendu3/
cd ~/rendu/
mkdir filter
cd filter
touch filter.c
# Implementar
gcc -Wall -Wextra -Werror filter.c -o filter
echo "hello world" | ./filter "world"
```

---

### ☕ 17:00-17:30 - DESCANSO

---

### ✅ 17:30-19:30 (2h) - BROKEN_GNL (repaso activo)

**Ubicación**: `level-1/broken_gnl/`

**Tareas**:
- [ ] Leer `APUNTES_BROKEN_GNL.md` si existe (15min)
- [ ] Leer `subject-es.txt` (10min)
- [ ] Leer código buggy (20min)
- [ ] Identificar los 8 bugs SIN MIRAR (30min)
- [ ] Repararlos (30min)
- [ ] Comparar con `reparired/` (15min)

**Los 8 bugs principales**:
1. ❌ `ft_strchr()` - Bucle infinito (falta protección `\0`)
2. ❌ `ft_memcpy()` - Copia incompleta (`--n > 0` en lugar de `n--`)
3. ❌ `str_append_mem()` - Crash con NULL pointer
4. ❌ `ft_memmove()` - Uso incorrecto de `ft_strlen()` vs `n`
5. ❌ `ft_memmove()` - Bucle infinito con `size_t` unsigned
6. ❌ `get_next_line()` - No maneja EOF (`read_ret == 0`)
7. ❌ `get_next_line()` - No actualiza `tmp` después de leer
8. ❌ `get_next_line()` - Crash con `tmp` NULL al final

```bash
cd level-1/broken_gnl/
cat subject-es.txt
# Leer broken_gnl.c
# Identificar bugs
# Reparar en rendu/
```

---

### 🍽️ 19:30-20:00 - CENA

---

### ✅ 20:00-22:30 (2.5h) - N-QUEENS (primera aproximación)

**Ubicación**: `level-2/n-queens/`

**IMPORTANTE**: NO intentes hacerlo desde cero todavía.

**Tareas**:
- [ ] Leer `subject-es.txt` MUY BIEN (20min)
- [ ] Entender el concepto del problema (20min)
- [ ] Estudiar la solución comentada (1.5h)
- [ ] Escribir pseudocódigo (30min)

**Objetivo**: Entender la lógica, NO dominarlo. Mañana lo practicas.

**Conceptos clave**:
- Backtracking avanzado
- Validación de posiciones (fila, columna, diagonales)
- Array para marcar columnas ocupadas
- Validación de diagonales

```bash
cd level-2/n-queens/
cat subject-es.txt
# Estudiar solución (NO hacer desde cero hoy)
# Tomar notas del algoritmo
```

---

### 📖 22:30-23:00 - Repaso de apuntes antes de dormir

**Tareas**:
- [ ] Leer `EXPLICACION_BACKTRACKING.md`
- [ ] Leer `HERRAMIENTAS_DEBUGGING.md`
- [ ] Repasar conceptos clave

---

## 📅 LUNES 10 (Día completo)

### ✅ 9:00-10:00 (1h) - POWERSET (desde cero, cronometrado)

**Tareas**:
- [ ] Borrar `rendu/powerset/`
- [ ] Hacer desde cero SIN MIRAR NADA
- [ ] Cronometrar tiempo
- [ ] Compilar y probar con tests

**Meta**: 30-40min sin mirar nada. Simula examen.

```bash
# Cronometrar
time ./powerset 3 1 0 2 4 5 3
```

---

### ✅ 10:00-12:00 (2h) - PERMUTATIONS (segunda vez)

**Tareas**:
- [ ] Cerrar TODO (soluciones, apuntes)
- [ ] Hacer desde cero sin mirar
- [ ] Compilar y probar
- [ ] Comparar con solución

**Meta**: 1-1.5h. Debe salir más fluido que ayer.

---

### ✅ 12:00-13:00 (1h) - FILTER (segunda vez)

**Tareas**:
- [ ] Hacer desde cero
- [ ] Compilar y probar

**Meta**: 40-50min

---

### 🍽️ 13:00-14:00 - COMIDA

---

### ✅ 14:00-17:00 (3h) - N-QUEENS (práctica intensiva)

**AHORA SÍ** intenta hacerlo desde cero.

**Tareas**:
- [ ] Cerrar todo (solución, apuntes)
- [ ] Solo con el subject
- [ ] Intentar implementarlo (2h)
- [ ] Comparar con solución (30min)
- [ ] Identificar qué faltó (30min)

**Nota**: Es el ejercicio más difícil. No pasa nada si no sale perfecto.

---

### ☕ 17:00-17:30 - DESCANSO

---

### ✅ 17:30-18:30 (1h) - BROKEN_GNL (segunda vez)

**Tareas**:
- [ ] Leer código buggy
- [ ] Identificar los 8 bugs SIN MIRAR
- [ ] Cronometrar

**Meta**: Encontrarlos en 20-30min

---

### ✅ 18:30-20:00 (1.5h) - N-QUEENS (segunda vez)

**Tareas**:
- [ ] Intentar desde cero otra vez
- [ ] Mejorar respecto a la primera vez

**Meta**: Llegar más lejos que antes

---

### 🍽️ 20:00-21:00 - CENA Y DESCANSO

---

### ✅ 21:00-22:00 (1h) - PERMUTATIONS (tercera vez)

**Tareas**:
- [ ] Desde cero, sin mirar

**Meta**: 40min

---

### ✅ 22:00-23:00 (1h) - Crear/repasar APUNTES

**Tareas**:
- [ ] Crear `APUNTES_PERMUTATIONS.md` si no existe
- [ ] Crear esquema básico de `APUNTES_N_QUEENS.md`
- [ ] Repasar `EXPLICACION_BACKTRACKING.md`
- [ ] Repasar `HERRAMIENTAS_DEBUGGING.md`

---

## 📅 MARTES 11 (Día del examen)

### ✅ 9:00-10:00 - POWERSET (última vez)

**Tareas**:
- [ ] Desde cero
- [ ] Cronometrar

**Meta**: 25-30min (automático)

---

### ✅ 10:00-11:00 - FILTER (última vez)

**Tareas**:
- [ ] Desde cero
- [ ] Cronometrar

**Meta**: 30-40min

---

### ✅ 11:00-12:00 - PERMUTATIONS (última vez)

**Tareas**:
- [ ] Desde cero
- [ ] Cronometrar

**Meta**: 35-45min

---

### 🍽️ 12:00-13:00 - COMIDA

---

### ✅ 13:00-14:00 - BROKEN_GNL (repasar bugs)

**Tareas**:
- [ ] Identificar bugs principales
- [ ] NO hace falta hacerlo completo
- [ ] Solo recordar los 8 bugs

---

### ✅ 14:00-15:00 - N-QUEENS (repasar lógica)

**Tareas**:
- [ ] NO lo hagas desde cero
- [ ] Solo leer solución y apuntes
- [ ] Entender el flujo
- [ ] Recordar conceptos clave

---

### ✅ 15:00-16:30 - SIMULACRO DE EXAMEN

**Escoge UNO aleatorio**:
1. Powerset
2. Permutations
3. Filter
4. Broken_gnl
5. N-queens (solo si te sientes confiado)

**Condiciones**:
- [ ] Cronómetro: 45min máximo
- [ ] Sin mirar NADA
- [ ] Como si fuera el examen real
- [ ] Compilar con `-Wall -Wextra -Werror`
- [ ] Probar con todos los casos del subject

---

### 🧘 16:30-17:30 - DESCANSO TOTAL

**NO ESTUDIES MÁS**. Descansa antes del examen.

- Paseo
- Música
- Café tranquilo
- Respira profundo
- Confianza

---

### 🚀 17:30 - Salir hacia el examen

**Llevas en tu mente**:
- ✅ 5 ejercicios estudiados
- ✅ Confianza en tus habilidades
- ✅ Gdb/valgrind en tu toolbox mental
- ✅ Estructura del main clara
- ✅ Backtracking dominado

---

## 📊 Resumen de Horas por Ejercicio

| Ejercicio | Domingo | Lunes | Martes | Total | Estado esperado |
|-----------|---------|-------|--------|-------|-----------------|
| **Powerset** | 1h | 1h | 1h | 3h | ⭐⭐⭐⭐⭐ Dominado |
| **Permutations** | 3h | 3h | 1h | 7h | ⭐⭐⭐⭐⭐ Dominado |
| **Filter** | 2h | 1h | 1h | 4h | ⭐⭐⭐⭐ Muy bien |
| **Broken_gnl** | 2h | 1h | 1h | 4h | ⭐⭐⭐⭐ Muy bien |
| **N-queens** | 2.5h | 4.5h | 1h | 8h | ⭐⭐⭐ Bien |

**Total**: ~26 horas de estudio en 2.5 días

---

## 🎯 Prioridades si te quedas sin tiempo

### Prioridad 1 (CRÍTICAS - No negociables):
1. ⭐⭐⭐⭐⭐ Powerset
2. ⭐⭐⭐⭐⭐ Permutations
3. ⭐⭐⭐⭐ Filter

### Prioridad 2 (IMPORTANTES):
4. ⭐⭐⭐ Broken_gnl

### Prioridad 3 (BONUS):
5. ⭐⭐ N-queens

**Si el lunes ves que n-queens no sale**: NO pasa nada. Con los otros 4 dominados tienes excelente preparación.

---

## ✅ Checklist Final (Martes 16:30)

Antes del examen, deberías sentirte cómodo con:

### Ejercicios:
- [ ] Powerset desde cero en <40min
- [ ] Permutations desde cero en <50min
- [ ] Filter desde cero en <45min
- [ ] Broken_gnl (identificar 6-8 bugs en <30min)
- [ ] N-queens (entender la lógica, aunque no salga perfecto)

### Herramientas:
- [ ] Usar `gdb` para debuggear segfaults
- [ ] Usar `valgrind` para memory leaks
- [ ] Printf debugging con `fprintf(stderr, ...)`

### Conceptos:
- [ ] Estructura del main sin errores
- [ ] Include guards en .h (`#ifndef`, `#define`, `#endif`)
- [ ] Flags de compilación: `-Wall -Wextra -Werror`
- [ ] Backtracking (decisiones binarias, caso base, recursión)
- [ ] Gestión de memoria (`malloc`, `free`, proteger NULL)
- [ ] Validación de argumentos

---

## 💡 Consejos Finales

### Durante el estudio:

1. **Repite desde cero**: Cada vez que estudies, CIERRA TODO y hazlo desde cero.

2. **Cronometra**: Simula condiciones del examen.

3. **No copies**: Entiende el algoritmo antes de implementar.

4. **Usa papel**: Dibuja el flujo, haz traces con ejemplos.

5. **Descansa**: Duerme 7-8h cada noche. El cerebro consolida durmiendo.

### En el examen:

1. **Lee bien el subject**: 2-3 veces antes de empezar.

2. **Empieza con esqueleto**: Comentarios primero, código después.

3. **Ejemplo concreto**: Usa un ejemplo pequeño en papel.

4. **Compila frecuentemente**: No escribas 100 líneas sin compilar.

5. **Si crashea**: Valgrind primero, gdb si es necesario.

6. **Gestiona el tiempo**: 30-45min por ejercicio máximo.

---

## 🚀 Comandos Útiles Rápidos

### Compilar
```bash
gcc -Wall -Wextra -Werror archivo.c -o programa
gcc -Wall -Wextra -Werror -g archivo.c -o programa  # Con debug
```

### Debuggear
```bash
# Valgrind (segfault y leaks)
valgrind ./programa <args>
valgrind --leak-check=full ./programa <args>

# Gdb (análisis detallado)
gdb ./programa
(gdb) run <args>
(gdb) backtrace
(gdb) print <var>
(gdb) quit
```

### Testing
```bash
# Probar con diferentes inputs
./powerset 3 1 0 2 4 5 3 | cat -e
echo "hello world" | ./filter "world" | cat -e

# Comparar con expected output
./programa <args> > output.txt
diff output.txt expected.txt
```

---

## 📂 Estructura de Carpetas

```
exam-rank-03/
├── level-1/
│   ├── filter/           # Subject y tests
│   └── broken_gnl/       # Subject y código buggy
├── level-2/
│   ├── powerset/         # Subject y tests
│   ├── permutations/     # Subject y tests
│   └── n-queens/         # Subject y tests
├── rendu/                # Tu espacio de trabajo
│   ├── powerset/
│   ├── permutations/
│   └── ...
├── rendu3/               # Soluciones de referencia
│   ├── powerset/
│   ├── permutations/
│   └── ...
└── APUNTES/              # Tus apuntes
    ├── EXPLICACION_BACKTRACKING.md
    ├── HERRAMIENTAS_DEBUGGING.md
    └── PLAN_ESTUDIO_EXAMEN.md (este archivo)
```

---

## 🎓 Recuerda

**Calidad > Cantidad**

Es mejor dominar 4 ejercicios al 90% que medio-saber 5 al 50%.

**Confía en ti**

Has estudiado, has practicado, estás preparado.

**Mantén la calma**

Si te atascas en el examen, respira, usa tus herramientas (gdb, valgrind).

---

## ✨ ¡Mucha suerte en el examen!

**Martes 11 de diciembre, 18:00**

Vas a hacerlo genial. 💪
