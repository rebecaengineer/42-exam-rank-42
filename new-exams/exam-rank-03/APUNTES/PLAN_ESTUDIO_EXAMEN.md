# Plan de Estudio para el Examen - Rank 03

## ⏰ Información del Examen

- **Fecha**: Sábado 15 de noviembre de 2025, 12:00
- **Inicio del plan**: Jueves 13 de noviembre de 2025, 11:00 AM
- **Tiempo disponible**: ~49 horas (realista: 24-28h de estudio efectivo)

---

## 📚 Ejercicios a Estudiar (ordenados por probabilidad de caer)

| Ejercicio | Nivel | Prioridad | Estado Base |
|-----------|-------|-----------|-------------|
| **Broken_gnl** | 1 | ⭐⭐⭐⭐⭐ | 🔄 Consolidar (ya estudiado) |
| **Filter** | 1 | ⭐⭐⭐⭐⭐ | 🔄 Consolidar (ya estudiado) |
| **Powerset** | 2 | ⭐⭐⭐⭐⭐ | 🔄 Consolidar (ya estudiado) |
| **Permutations** | 2 | ⭐⭐⭐⭐⭐ | 🔄 Consolidar (ya estudiado) |
| **Scanf** | 1 | ⭐⭐⭐⭐ | ⏳ Por estudiar desde cero |
| **N-queens** | 2 | ⭐⭐⭐⭐ | ⏳ Por estudiar desde cero (CAE MUCHO) |
| **RIP** | 2 | ⭐⭐⭐ | ⏳ Por estudiar desde cero (cae menos) |
| **TSP** | 2 | ⭐⭐ | ⏳ Por estudiar (cae poco - BONUS) |

---

## 📅 JUEVES 13 DE NOVIEMBRE (Hoy - desde 11:00 AM)

### ✅ 11:00-12:30 (1.5h) - BROKEN_GNL (consolidación rápida)

**Ubicación**: `level-1/broken_gnl/`

**Objetivo**: Refrescar identificación de bugs

**Tareas**:
- [ ] Leer código buggy (15min)
- [ ] Identificar los 8 bugs principales SIN MIRAR (30min)
- [ ] Repararlos y compilar (30min)
- [ ] Comparar con solución (15min)

**Los 8 bugs principales** (repaso):
1. ❌ `ft_strchr()` - Bucle infinito (falta protección `\0`)
2. ❌ `ft_memcpy()` - Copia incompleta (`--n > 0`)
3. ❌ `str_append_mem()` - Crash con NULL pointer
4. ❌ `ft_memmove()` - Uso incorrecto de `ft_strlen()` vs `n`
5. ❌ `ft_memmove()` - Bucle infinito con `size_t` unsigned
6. ❌ `get_next_line()` - No maneja EOF (`read_ret == 0`)
7. ❌ `get_next_line()` - No actualiza `tmp` después de leer
8. ❌ `get_next_line()` - Crash con `tmp` NULL al final

**Meta**: Identificar todos en 30min

---

### ✅ 12:30-14:00 (1.5h) - FILTER (consolidación)

**Ubicación**: `level-1/filter/`

**Tareas**:
- [ ] Borrar `rendu/filter/` si existe
- [ ] Hacer desde cero SIN MIRAR (1h)
- [ ] Compilar y probar con tests (15min)
- [ ] Comparar con solución si falla (15min)

**Conceptos clave**:
- `read()` dinámico de stdin
- `memmem()` para buscar substring
- Reemplazo con asteriscos
- Gestión de memoria dinámica

**Meta**: Terminarlo en 1h sin mirar

```bash
cd rendu/
rm -rf filter/
mkdir filter
cd filter
touch filter.c
# Implementar
gcc -Wall -Wextra -Werror filter.c -o filter
echo "hello world" | ./filter "world"
```

---

### 🍽️ 14:00-15:00 - COMIDA Y DESCANSO

---

### ✅ 15:00-16:30 (1.5h) - POWERSET (consolidación)

**Ubicación**: `level-2/powerset/`

**Tareas**:
- [ ] Borrar `rendu/powerset/`
- [ ] Hacer desde cero SIN MIRAR (1h)
- [ ] Compilar y probar (15min)
- [ ] Comparar con solución si necesario (15min)

**Meta**: Terminarlo en 1h fluido

```bash
cd rendu/
rm -rf powerset/
mkdir powerset
cd powerset
touch powerset.c powerset.h
# Implementar backtracking
gcc -Wall -Wextra -Werror powerset.c -o powerset
./powerset 3 1 0 2 4 5 3
```

---

### ✅ 16:30-18:00 (1.5h) - PERMUTATIONS (consolidación)

**Ubicación**: `level-2/permutations/`

**Tareas**:
- [ ] Borrar `rendu/permutations/`
- [ ] Hacer desde cero SIN MIRAR (1h)
- [ ] Compilar y probar (15min)
- [ ] Comparar con solución si necesario (15min)

**Meta**: Terminarlo en 1h fluido

```bash
cd rendu/
rm -rf permutations/
mkdir permutations
cd permutations
touch permutations.c permutations.h
# Implementar backtracking con array de usados
gcc -Wall -Wextra -Werror permutations.c -o permutations
./permutations 1 2 3
```

---

### ☕ 18:00-18:30 - DESCANSO

---

### ✅ 18:30-21:00 (2.5h) - SCANF (primera vez - estudio profundo)

**Ubicación**: `level-1/scanf/`

**IMPORTANTE**: Ejercicio complejo, tómate tu tiempo

**Tareas**:
- [ ] Leer `subject-es.txt` MUY BIEN (20min)
- [ ] Estudiar solución en `rendu3/scanf/` si existe (1h)
- [ ] Entender parsing de formato `%s`, `%d`, `%c` (30min)
- [ ] Escribir pseudocódigo (20min)
- [ ] Intentar implementar (no hace falta terminar hoy) (20min)

**Conceptos clave**:
- Argumentos variables (`va_start`, `va_arg`, `va_end`)
- Parsing de cadenas de formato
- `fgetc()` y `ungetc()` para manejo de streams
- Construcción de números dígito por dígito
- Saltar espacios en blanco

**Meta**: Entender bien la lógica, no dominarlo hoy

```bash
cd level-1/scanf/
cat subject-es.txt
# Estudiar solución
```

---

### 🍽️ 21:00-21:30 - CENA

---

### ✅ 21:30-23:30 (2h) - N-QUEENS (primera vez - estudio profundo)

**Ubicación**: `level-2/n-queens/`

**IMPORTANTE**: Este ejercicio CAE MUCHO en los exámenes. Prioridad alta.

**Tareas**:
- [ ] Leer `subject-es.txt` MUY BIEN (20min)
- [ ] Entender el problema de las N reinas (20min)
- [ ] Estudiar solución en `rendu3/n-queens/` si existe (1h)
- [ ] Entender backtracking con validación de diagonales (30min)
- [ ] Escribir pseudocódigo (10min)

**Conceptos clave**:
- Backtracking complejo (similar a powerset/permutations pero más validación)
- Array de posiciones de reinas
- Validación de columnas ocupadas
- Validación de diagonales (diagonal principal y secundaria)
- Imprimir soluciones al encontrarlas

**Meta**: Entender muy bien la lógica de validación

```bash
cd level-2/n-queens/
cat subject-es.txt
# Estudiar solución
```

---

### 📖 23:30-23:45 - Repaso mental antes de dormir

**Tareas**:
- [ ] Repasar mentalmente broken_gnl, filter, powerset, permutations
- [ ] Pensar en el flujo de scanf
- [ ] Visualizar el algoritmo de n-queens

---

## 📅 VIERNES 14 DE NOVIEMBRE (Día completo)

### ✅ 9:00-11:30 (2.5h) - N-QUEENS (segunda vez - implementación)

**PRIORIDAD ALTA** - Este ejercicio cae mucho

**Tareas**:
- [ ] Cerrar TODO (soluciones, apuntes)
- [ ] Solo con el subject
- [ ] Intentar implementarlo desde cero (2h)
- [ ] Compilar y probar con diferentes N (20min)
- [ ] Comparar con solución (10min)

**Meta**: Tener versión funcionando con validación correcta

```bash
cd rendu/
mkdir n-queens
cd n-queens
touch n_queens.c n_queens.h
# Implementar
gcc -Wall -Wextra -Werror n_queens.c -o n_queens
./n_queens 4
./n_queens 8
```

---

### ✅ 11:30-12:30 (1h) - FILTER (repaso cronometrado)

**Tareas**:
- [ ] Desde cero sin mirar
- [ ] Cronometrar

**Meta**: 40-50min

---

### 🍽️ 12:30-13:30 - COMIDA

---

### ✅ 13:30-16:00 (2.5h) - SCANF (segunda vez - implementación)

**Tareas**:
- [ ] Cerrar TODO (soluciones, apuntes)
- [ ] Solo con el subject
- [ ] Intentar implementarlo desde cero (2h)
- [ ] Compilar y probar (20min)
- [ ] Comparar con solución (10min)

**Meta**: Tener versión funcionando, aunque mires la solución

```bash
cd rendu/
mkdir scanf
cd scanf
touch ft_scanf.c
# Implementar
gcc -Wall -Wextra -Werror ft_scanf.c -o ft_scanf
```

---

### ✅ 16:00-17:00 (1h) - POWERSET (repaso cronometrado)

**Tareas**:
- [ ] Desde cero sin mirar
- [ ] Cronometrar

**Meta**: 30-40min

---

### ☕ 17:00-17:30 - DESCANSO

---

### ✅ 17:30-19:30 (2h) - RIP (primera vez - estudio)

**Ubicación**: `level-2/rip/`

**Tareas**:
- [ ] Leer `subject-es.txt` (20min)
- [ ] Entender el problema (20min)
- [ ] Estudiar solución si existe (1h)
- [ ] Escribir pseudocódigo (20min)

**Meta**: Entender bien la lógica

```bash
cd level-2/rip/
cat subject-es.txt
# Estudiar solución
```

---

### 🍽️ 19:30-20:00 - CENA RÁPIDA

---

### ✅ 20:00-21:00 (1h) - PERMUTATIONS (repaso cronometrado)

**Tareas**:
- [ ] Desde cero sin mirar
- [ ] Cronometrar

**Meta**: 35-45min

---

### ✅ 21:00-22:00 (1h) - BROKEN_GNL (repaso rápido)

**Tareas**:
- [ ] Identificar los 8 bugs SIN MIRAR
- [ ] Cronometrar

**Meta**: 20-25min para identificarlos todos

---

### ✅ 22:00-23:00 (1h) - N-QUEENS (tercera vez - repaso)

**Tareas**:
- [ ] Repasar la lógica de validación
- [ ] Entender bien las diagonales
- [ ] NO hace falta hacerlo desde cero, solo repasar conceptos

**Meta**: Consolidar conocimiento

---

## 📅 SÁBADO 15 DE NOVIEMBRE (Día del examen - hasta 12:00)

### ✅ 7:00-8:00 - REPASO MENTAL (en casa)

**NO TOQUES CÓDIGO**

**Tareas**:
- [ ] Repasar mentalmente los 6 ejercicios principales
- [ ] Recordar conceptos clave de cada uno
- [ ] Desayunar bien
- [ ] Café/té tranquilo
- [ ] Mentalidad positiva

**Ejercicios principales por probabilidad**:
1. **Broken_gnl** - 8 bugs (identificar y reparar)
2. **Filter** - read dinámico + memmem + reemplazo
3. **Powerset** - backtracking binario
4. **Permutations** - backtracking con usados
5. **N-queens** - backtracking + validación diagonales (CAE MUCHO)
6. **Scanf** - argumentos variables + parsing formato
7. **RIP** - (conceptos principales si lo estudiaste)

---

### ✅ 8:00-9:00 (1h) - SIMULACRO NIVEL 1

**Escoge UNO aleatorio**:
- Filter
- Broken_gnl
- Scanf

**Condiciones del simulacro**:
- [ ] Cronómetro: 45min máximo
- [ ] Sin mirar NADA
- [ ] Como si fuera el examen real
- [ ] Compilar con `-Wall -Wextra -Werror`
- [ ] Probar con todos los casos

---

### ✅ 9:00-10:00 (1h) - SIMULACRO NIVEL 2

**Escoge UNO aleatorio** (prioriza N-queens):
- **N-queens** (recomendado - cae mucho)
- Powerset
- Permutations
- RIP (si lo estudiaste)

**Condiciones del simulacro**:
- [ ] Cronómetro: 50min máximo para N-queens, 40min para los demás
- [ ] Sin mirar NADA
- [ ] Como si fuera el examen real

---

### 🧘 10:00-11:30 - DESCANSO TOTAL

**NO ESTUDIES MÁS**

Es momento de relajarte antes del examen:
- [ ] Ducha
- [ ] Paseo corto
- [ ] Música relajante
- [ ] Café/té tranquilo
- [ ] Respira profundo
- [ ] Mentalidad positiva

**NO repases código**, ya has trabajado suficiente.

---

### 🚀 11:30 - Preparación final

**Llevas en tu mente**:
- ✅ 6 ejercicios estudiados a fondo
- ✅ 4 ejercicios consolidados al 100% (broken_gnl, filter, powerset, permutations)
- ✅ 2 ejercicios nuevos MUY bien estudiados (scanf, N-queens)
- ✅ 1 ejercicio adicional estudiado (RIP)
- ✅ Confianza en tus habilidades
- ✅ Herramientas de debugging en tu toolbox mental
- ✅ Backtracking dominado (powerset, permutations, N-queens)

---

### 🎯 12:00 - EXAMEN

**¡Mucha suerte!** 💪

---

## 📊 Resumen de Horas por Ejercicio

| Ejercicio | Jueves 13 | Viernes 14 | Sábado 15 | Total | Estado esperado |
|-----------|-----------|------------|-----------|-------|-----------------|
| **N-queens** | 2h | 2.5h + 1h | 1h | **6.5h** | ⭐⭐⭐⭐ Muy bien |
| **Scanf** | 2.5h | 2.5h | 1h | **6h** | ⭐⭐⭐⭐ Muy bien |
| **Filter** | 1.5h | 1h | 1h | **3.5h** | ⭐⭐⭐⭐⭐ Dominado |
| **Powerset** | 1.5h | 1h | 1h | **3.5h** | ⭐⭐⭐⭐⭐ Dominado |
| **Permutations** | 1.5h | 1h | - | **2.5h** | ⭐⭐⭐⭐⭐ Dominado |
| **Broken_gnl** | 1.5h | 1h | - | **2.5h** | ⭐⭐⭐⭐⭐ Dominado |
| **RIP** | - | 2h | - | **2h** | ⭐⭐⭐ Básico |
| **TSP** | - | - | - | **0h** | ⭐ No estudiado |

**Total**: ~26.5 horas de estudio en 2.5 días

**Distribución inteligente**:
- **6.5h dedicadas a N-queens** (ejercicio que más cae)
- **18h dedicadas a los 5 consolidados** (broken_gnl, filter, powerset, permutations, scanf)
- **2h a RIP** (estudio básico)
- **TSP sacrificado** (no hay tiempo suficiente)

---

## 🎯 Prioridades si te quedas sin tiempo

### Prioridad 1 (CRÍTICAS - No negociables):
1. ⭐⭐⭐⭐⭐ **Broken_gnl** (cae siempre)
2. ⭐⭐⭐⭐⭐ **Filter** (cae siempre)
3. ⭐⭐⭐⭐⭐ **Powerset** (cae siempre)
4. ⭐⭐⭐⭐⭐ **Permutations** (cae siempre)

### Prioridad 2 (MUY IMPORTANTES - Alta probabilidad):
5. ⭐⭐⭐⭐ **N-queens** (CAE MUCHO - prioridad alta)
6. ⭐⭐⭐⭐ **Scanf** (cae frecuentemente)

### Prioridad 3 (IMPORTANTES - Probabilidad media):
7. ⭐⭐⭐ **RIP** (cae menos que los anteriores)

### Prioridad 4 (BONUS - Baja probabilidad):
8. ⭐⭐ **TSP** (cae poco - solo si tienes tiempo)

**Si te quedas sin tiempo**:
- Sacrifica **TSP** primero (apenas cae)
- Luego sacrifica **RIP** si es necesario
- **NUNCA sacrifiques N-queens** (cae mucho más que RIP/TSP)
- Los 6 primeros (broken_gnl, filter, powerset, permutations, N-queens, scanf) son imprescindibles

---

## ✅ Checklist Final (Sábado 10:00)

Antes del examen, deberías sentirte cómodo con:

### Ejercicios consolidados (ya conocías):
- [ ] Broken_gnl (identificar 8 bugs en <25min)
- [ ] Filter desde cero en <40min
- [ ] Powerset desde cero en <35min
- [ ] Permutations desde cero en <40min

### Ejercicios nuevos dominados:
- [ ] **N-queens desde cero en <1h** (PRIORIDAD MÁXIMA)
- [ ] Scanf desde cero en <1h-1h15
- [ ] RIP desde cero en <1h-1h15 (si lo estudiaste)
- [ ] TSP (entender básico - opcional)

### Herramientas:
- [ ] Usar `gdb` para debuggear segfaults
- [ ] Usar `valgrind` para memory leaks
- [ ] Printf debugging con `fprintf(stderr, ...)`

### Conceptos:
- [ ] Estructura del main sin errores
- [ ] Include guards en .h (`#ifndef`, `#define`, `#endif`)
- [ ] Flags de compilación: `-Wall -Wextra -Werror`
- [ ] Backtracking (decisiones binarias/múltiples, caso base, recursión)
- [ ] Argumentos variables (`va_start`, `va_arg`, `va_end`)
- [ ] Gestión de memoria (`malloc`, `free`, proteger NULL)
- [ ] Validación de argumentos
- [ ] Manejo de streams (`fgetc`, `ungetc`)

---

## 💡 Consejos Finales

### Durante el estudio:

1. **Repite desde cero**: Cada vez que estudies, CIERRA TODO y hazlo desde cero.

2. **Cronometra**: Simula condiciones del examen desde jueves.

3. **No copies**: Entiende el algoritmo antes de implementar.

4. **Usa papel**: Dibuja el flujo, haz traces con ejemplos pequeños.

5. **Descansa**: Duerme 7-8h cada noche. El cerebro consolida durmiendo.

6. **No te frustres**: Los ejercicios nuevos (scanf, rip, tsp) son complejos. Es normal tardar.

### En el examen:

1. **Lee bien el subject**: 2-3 veces antes de empezar.

2. **Empieza con esqueleto**: Comentarios primero, código después.

3. **Ejemplo concreto**: Usa un ejemplo pequeño en papel.

4. **Compila frecuentemente**: No escribas 100 líneas sin compilar.

5. **Si crashea**: Valgrind primero, gdb si es necesario.

6. **Gestiona el tiempo**:
   - Nivel 1: 30-45min por ejercicio
   - Nivel 2: 45-60min por ejercicio

7. **Prioriza bien**:
   - Si sale **broken_gnl o filter** (nivel 1): Hazlos rápido y perfecto (30-40min)
   - Si sale **powerset o permutations** (nivel 2): Hazlos fluido (35-45min)
   - Si sale **N-queens** (nivel 2): Respira, tienes 1h, recuerda validación de diagonales
   - Si sale **scanf** (nivel 1): Argumentos variables, parsing formato, 1h-1h15
   - Si sale **RIP** (nivel 2): Recuerda la lógica estudiada, 1h
   - Si sale **TSP** (nivel 2): Si lo estudiaste, aplica backtracking + pruning

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
│   ├── broken_gnl/       # Subject y código buggy
│   └── scanf/            # Subject y tests
├── level-2/
│   ├── powerset/         # Subject y tests
│   ├── permutations/     # Subject y tests
│   ├── rip/              # Subject y tests
│   ├── tsp/              # Subject y tests
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

Es mejor dominar 6 ejercicios al 90% que medio-saber 8 al 50%.

**Confía en ti**

Has estudiado ejercicios complejos (backtracking, argumentos variables, optimización). Estás preparado.

**Mantén la calma**

Si te atascas en el examen:
1. Respira profundo (10 segundos)
2. Lee el subject otra vez
3. Haz un ejemplo en papel
4. Usa tus herramientas (gdb, valgrind)
5. Divide el problema en partes pequeñas

**El examen es maratón, no sprint**

Gestiona bien tu tiempo. Mejor terminar 2 ejercicios perfectos que 4 a medias.

---

## ✨ ¡Mucha suerte en el examen!

**Sábado 15 de noviembre de 2025, 12:00**

Tienes 2.5 días de preparación intensiva. Vas a hacerlo genial. 💪

**Distribución inteligente**:
- **Jueves 13**: Consolidar los 4 conocidos + empezar scanf + **empezar N-queens (2h)**
- **Viernes 14**: **N-queens implementación (2.5h)** + scanf + empezar RIP + repasos + N-queens repaso (1h)
- **Sábado 15**: Simulacros matutinos + descanso mental → **EXAMEN 12:00**

**Estrategia ajustada** (solo 2.5 días):
- **6.5h a N-queens** porque cae mucho (prioridad máxima)
- **6h a scanf** (nuevo ejercicio importante)
- **10h a los 4 consolidados** (broken_gnl, filter, powerset, permutations)
- **2h a RIP** (estudio básico)
- **TSP sacrificado** (no hay tiempo)

**Enfoque realista**: Con menos tiempo, priorizamos los 6 ejercicios más importantes. TSP queda fuera por falta de tiempo. 💪
