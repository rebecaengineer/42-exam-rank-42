# 🎓 EXAM RANK 03 - Sistema de Práctica

## 📍 **Ubicación**
```
/home/ubuntu/projects/42-exam-rank-42/new-exams/exam-rank-03/
```

Este directorio contiene un sistema completo de práctica para el Exam Rank 03 de 42 School, basado en la estructura de [martamakes/42-exam-rank-42](https://github.com/martamakes/42-exam-rank-42).

---

## 🚀 **Inicio Rápido**

### **Para practicar:**
```bash
cd /home/ubuntu/projects/42-exam-rank-42/new-exams/exam-rank-03/
./exam.sh
```

### **Para crear nuevo ejercicio:**
```bash
./init.sh <nivel> <nombre_ejercicio>
# Ejemplo: ./init.sh 1 nuevo_ejercicio
```

---

## 📁 **Estructura del Proyecto**

```
exam-rank-03/
├── 🎯 exam.sh                 # Script principal de práctica
├── 🔧 init.sh                # Generador de entornos de test
├── 📚 level-1/               # Ejercicios Level 1
│   ├── filter/
│   │   ├── 🔒 solutions/      # TUS SOLUCIONES ORIGINALES (INTOCABLES)
│   │   │   ├── filter.c       # Tu implementación funcional
│   │   │   └── README.md      # Documentación de tu solución
│   │   ├── ✅ grademe/        # Tests automáticos
│   │   │   └── test.sh
│   │   ├── 📋 subject.txt     # Enunciado del ejercicio
│   │   └── [filter.c]         # 🎯 ZONA DE PRÁCTICA (aquí trabajas)
│   ├── scanf/
│   │   ├── 🔒 solutions/
│   │   │   ├── ft_scanf.c
│   │   │   ├── ft_scanf_academico.c
│   │   │   └── README.md
│   │   ├── ✅ grademe/test.sh
│   │   └── [ft_scanf.c]       # 🎯 ZONA DE PRÁCTICA
│   └── broken_gnl/
│       ├── 🔒 solutions/
│       │   ├── broken_gnl.c
│       │   ├── APUNTES_BROKEN_GNL.md
│       │   └── README.md
│       ├── ✅ grademe/test.sh
│       └── [broken_gnl.c]     # 🎯 ZONA DE PRÁCTICA
├── 📚 level-2/               # Ejercicios Level 2
│   ├── permutations/grademe/test.sh
│   ├── powerset/grademe/test.sh
│   ├── n_queens/grademe/test.sh
│   ├── rip/grademe/test.sh
│   └── tsp/grademe/test.sh
└── 📊 exam_progress/         # Seguimiento automático de progreso
    ├── level1_done.txt
    └── level2_done.txt
```

---

## 🎯 **Flujo de Trabajo Completo**

### **1. Iniciar sistema de práctica**
```bash
./exam.sh
```

### **2. Menú principal**
```
1. Practicar ejercicios (aleatorio de todos los niveles)
2. Practicar Level 1 (aleatorio) 
3. Practicar Level 2 (aleatorio)
4. Seleccionar ejercicio específico
5. Ver progreso
6. Limpiar progreso
7. Salir
```

### **3. Cuando el sistema te asigna un ejercicio:**
- **Te muestra el subject** del ejercicio
- **Te indica la carpeta** donde trabajar (ej: `level-1/filter/`)

### **4. Implementar tu solución:**
```bash
cd level-1/filter/           # Ir a la carpeta del ejercicio
vim filter.c                 # Crear/editar tu solución
# O usar cualquier editor: nano, code, etc.
```

### **5. Probar tu solución:**
- Presiona **ENTER** en el terminal del script
- El sistema **automáticamente**:
  - Ejecuta `grademe/test.sh`
  - Te dice si pasaste o fallaste
  - Si pasas → marca como completado
  - Si fallas → puedes intentar de nuevo

### **6. Si fallas y necesitas ayuda:**
```bash
cd level-1/filter/solutions/
cat filter.c                 # Ver tu solución original funcional
cat README.md               # Ver documentación de tu implementación
```

---

## 🔒 **Sistema de Protección de Soluciones**

### **Carpetas `solutions/` = ZONA PROTEGIDA**
- **NUNCA se modifican** automáticamente
- Contienen tus implementaciones originales que funcionan
- Son tu **referencia permanente**
- Incluyen documentación de conceptos implementados

### **Archivos principales = ZONA DE PRÁCTICA**
- Donde creas nuevas implementaciones
- Se pueden sobrescribir cada vez que practiques
- Permiten experimentar sin miedo

---

## 🧪 **Sistema de Tests**

### **Tests automáticos en `grademe/test.sh`:**

#### **Level 1 (Tests completos):**
- **filter**: Tests de reemplazo, casos edge, manejo de argumentos
- **ft_scanf**: Tests de string, integer, character parsing
- **broken_gnl**: Tests de lectura línea por línea con diferentes casos

#### **Level 2 (Tests básicos):**
- **permutations, powerset, n_queens, rip, tsp**: Compilación + ejecución básica
- Verificación manual del output requerida

### **Busca tests en este orden:**
1. `ejercicio/grademe/test.sh` (prioritario)
2. `ejercicio/test.sh` (alternativo)
3. `ejercicio/tester/run_exam.sh` (legacy)

---

## 🔧 **init.sh - Generador de Entornos**

### **Uso:**
```bash
./init.sh <nivel> <nombre_ejercicio>
```

### **Ejemplos:**
```bash
./init.sh 1 new_exercise      # Crear en level-1/
./init.sh 2 advanced_algo     # Crear en level-2/
```

### **Qué crea automáticamente:**
- 📁 Estructura de directorios
- 🧪 `test_main.c` adaptado al tipo de ejercicio
- ✅ `test.sh` con compilación y testing
- 📋 `Makefile` con targets útiles

---

## 📊 **Seguimiento de Progreso**

### **Archivos automáticos:**
- `exam_progress/level1_done.txt` - Ejercicios Level 1 completados
- `exam_progress/level2_done.txt` - Ejercicios Level 2 completados

### **Ver progreso:**
```bash
./exam.sh → Opción 5
```

### **Resetear progreso:**
```bash
./exam.sh → Opción 6
```

---

## 🎓 **Ejercicios Disponibles**

### **Level 1 (Básicos) - ✅ COMPLETADOS**
- **filter** - Reemplazo de strings con asteriscos
- **ft_scanf** - Implementación de scanf con %s, %d, %c
- **broken_gnl** - Debugging de get_next_line

### **Level 2 (Avanzados) - 🔄 EN PROGRESO**
- **permutations** - Generación de permutaciones lexicográficas
- **powerset** - Generación de subconjuntos ordenados
- **n_queens** - Problema de las N reinas con backtracking
- **rip** - Balanceo de paréntesis
- **tsp** - Traveling Salesman Problem

---

## ⚙️ **Configuración y Personalización**

### **Colores del terminal:**
Los scripts usan colores ANSI estándar. Si tienes problemas, verifica que tu terminal los soporte.

### **Modificar tests:**
Puedes personalizar los tests editando los archivos `grademe/test.sh` de cada ejercicio.

### **Añadir nuevos ejercicios:**
1. Usar `./init.sh` para crear la estructura
2. Añadir el ejercicio a la lista en `exam.sh` (líneas 22-23)

---

## 🆘 **Resolución de Problemas**

### **Error: "No se encontró script de test"**
Verifica que existe `grademe/test.sh` y tiene permisos de ejecución:
```bash
chmod +x level-X/ejercicio/grademe/test.sh
```

### **Error de compilación**
Verifica:
- Nombre del archivo correcto (ej: `filter.c`, no `Filter.c`)
- Sintaxis C correcta
- Funciones permitidas según el subject

### **El script no encuentra mis archivos**
Asegúrate de estar trabajando en la carpeta correcta del ejercicio, NO en `solutions/`.

---

## 📝 **Notas Importantes**

### **🔒 Protección de datos:**
- Tus soluciones originales están protegidas en `solutions/`
- El sistema NUNCA modifica archivos en `solutions/`
- Puedes practicar sin miedo a perder tu trabajo

### **🎯 Zona de trabajo:**
- Trabaja siempre en la carpeta principal del ejercicio
- Los archivos aquí SÍ se pueden sobrescribir al practicar

### **📚 Compatibilidad:**
- Sistema basado en martamakes/42-exam-rank-42
- Compatible con estructura estándar de 42 School
- Tests adaptados a los requisitos específicos de cada ejercicio

---

## 🤝 **Créditos**

- Basado en: [martamakes/42-exam-rank-42](https://github.com/martamakes/42-exam-rank-42)
- Adaptado para: Exam Rank 03
- Ejercicios implementados por: [Tu nombre]
- Sistema de automatización: Configurado para tu flujo de trabajo

---

## 🚀 **¡Empezar a Practicar!**

```bash
cd /home/ubuntu/projects/42-exam-rank-42/new-exams/exam-rank-03/
./exam.sh
# ¡Selecciona una opción y a practicar! 🎯
```

**¡Buena suerte en tu preparación para el examen! 🍀**