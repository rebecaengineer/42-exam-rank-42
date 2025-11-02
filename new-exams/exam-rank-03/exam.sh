#!/bin/bash

# Colores para mejor visualización
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'

# Directorios de trabajo
EXAM_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(dirname "$EXAM_DIR")"
PROGRESS_DIR="$EXAM_DIR/exam_progress"
RENDU_DIR="$PROJECT_ROOT/rendu"

# Crear directorios necesarios
mkdir -p "$PROGRESS_DIR"
mkdir -p "$RENDU_DIR"

# Archivos para almacenar ejercicios completados por nivel
LEVEL1_DONE="$PROGRESS_DIR/level1_done.txt"
LEVEL2_DONE="$PROGRESS_DIR/level2_done.txt"

# Crear archivos si no existen
touch "$LEVEL1_DONE" "$LEVEL2_DONE"

# Función para validar ejercicio con test específico
validate_exercise() {
    local exercise_name="$1"
    local exercise_path="$2"
    
    echo -e "${BLUE}=======================================================================${NC}"
    echo -e "${CYAN}Validando ejercicio: ${YELLOW}$exercise_name${NC}"
    echo -e "${BLUE}=======================================================================${NC}"
    
    if [ ! -d "$exercise_path" ]; then
        echo -e "${RED}Error: El directorio del ejercicio no existe: $exercise_path${NC}"
        return 1
    fi
    
    # Buscar script de test en grademe/
    local test_script="$exercise_path/grademe/test.sh"
    if [ ! -f "$test_script" ]; then
        # Buscar alternativas de test
        test_script="$exercise_path/test.sh"
        if [ ! -f "$test_script" ]; then
            test_script="$exercise_path/tester/run_exam.sh"
            if [ ! -f "$test_script" ]; then
                echo -e "${RED}Error: No se encontró script de test para $exercise_name${NC}"
                echo -e "${YELLOW}Se buscó en:${NC}"
                echo -e "  - $exercise_path/grademe/test.sh"
                echo -e "  - $exercise_path/test.sh"
                echo -e "  - $exercise_path/tester/run_exam.sh"
                return 1
            fi
        fi
    fi
    
    echo -e "${CYAN}Ejecutando test: $test_script${NC}"
    
    # Cambiar al directorio del ejercicio para ejecutar el test
    cd "$exercise_path"
    
    # Ejecutar el script de test
    if bash "$test_script"; then
        echo -e "${GREEN}✓ Test pasado correctamente${NC}"
        return 0
    else
        echo -e "${RED}✗ Test fallido${NC}"
        return 1
    fi
}

# Función para obtener ejercicios disponibles (no completados) de un nivel
get_available_exercises() {
    local level="$1"
    local level_dir="level-$level"
    local done_file
    
    case $level in
        1) done_file="$LEVEL1_DONE" ;;
        2) done_file="$LEVEL2_DONE" ;;
        *) echo ""; return ;;
    esac
    
    if [ ! -d "$level_dir" ]; then
        echo ""
        return
    fi
    
    local available_exercises=""
    for exercise_dir in "$level_dir"/*; do
        if [ -d "$exercise_dir" ]; then
            local exercise_name=$(basename "$exercise_dir")
            # Verificar si no está en la lista de completados
            if ! grep -q "^$exercise_name$" "$done_file" 2>/dev/null; then
                if [ -z "$available_exercises" ]; then
                    available_exercises="$exercise_name"
                else
                    available_exercises="$available_exercises $exercise_name"
                fi
            fi
        fi
    done
    
    echo "$available_exercises"
}

# Función para mostrar el subject de un ejercicio
show_subject() {
    local exercise_name="$1"
    local exercise_path="$2"
    
    echo -e "${BLUE}=======================================================================${NC}"
    echo -e "${CYAN}Subject para: ${YELLOW}$exercise_name${NC}"
    echo -e "${BLUE}=======================================================================${NC}"
    
    # Buscar archivo subject
    local subject_file=""
    if [ -f "$exercise_path/subject.txt" ]; then
        subject_file="$exercise_path/subject.txt"
    elif [ -f "$exercise_path/subject.en.txt" ]; then
        subject_file="$exercise_path/subject.en.txt"
    elif [ -f "$exercise_path/subject" ]; then
        subject_file="$exercise_path/subject"
    fi
    
    if [ -n "$subject_file" ]; then
        cat "$subject_file"
    else
        echo -e "${RED}No se encontró archivo subject para $exercise_name${NC}"
        echo -e "${YELLOW}Se buscó en:${NC}"
        echo -e "  - $exercise_path/subject.txt"
        echo -e "  - $exercise_path/subject.en.txt"
        echo -e "  - $exercise_path/subject"
    fi
    
    echo -e "${BLUE}=======================================================================${NC}"
}

# Función para marcar ejercicio como completado
mark_as_completed() {
    local exercise_name="$1"
    local level="$2"
    local done_file
    
    case $level in
        1) done_file="$LEVEL1_DONE" ;;
        2) done_file="$LEVEL2_DONE" ;;
        *) echo -e "${RED}Error: Nivel inválido $level${NC}"; return 1 ;;
    esac
    
    # Verificar si ya está marcado como completado
    if grep -q "^$exercise_name$" "$done_file" 2>/dev/null; then
        echo -e "${YELLOW}El ejercicio $exercise_name ya está marcado como completado${NC}"
    else
        echo "$exercise_name" >> "$done_file"
        echo -e "${GREEN}✓ Ejercicio $exercise_name marcado como completado${NC}"
    fi
}

# Función principal para practicar ejercicios
practice_exercises() {
    echo -e "${CYAN}Iniciando práctica de ejercicios...${NC}"
    
    while true; do
        # Obtener ejercicios disponibles de todos los niveles
        local level1_exercises=$(get_available_exercises 1)
        local level2_exercises=$(get_available_exercises 2)
        
        # Crear array con todos los ejercicios disponibles
        local all_exercises=""
        local exercise_levels=""
        
        for exercise in $level1_exercises; do
            all_exercises="$all_exercises $exercise"
            exercise_levels="$exercise_levels 1"
        done
        
        for exercise in $level2_exercises; do
            all_exercises="$all_exercises $exercise"
            exercise_levels="$exercise_levels 2"
        done
        
        if [ -z "$all_exercises" ]; then
            echo -e "${GREEN}¡Felicidades! Has completado todos los ejercicios disponibles.${NC}"
            break
        fi
        
        # Convertir a arrays
        local exercises_array=($all_exercises)
        local levels_array=($exercise_levels)
        
        # Seleccionar ejercicio aleatorio
        local random_index=$((RANDOM % ${#exercises_array[@]}))
        local selected_exercise="${exercises_array[$random_index]}"
        local selected_level="${levels_array[$random_index]}"
        local exercise_path="level-$selected_level/$selected_exercise"
        
        echo -e "${YELLOW}Ejercicio seleccionado: $selected_exercise (Level $selected_level)${NC}"
        
        # Mostrar subject
        show_subject "$selected_exercise" "$exercise_path"
        
        echo
        echo -e "${CYAN}¿Qué quieres hacer?${NC}"
        echo "1. Continuar con este ejercicio"
        echo "2. Seleccionar otro ejercicio aleatorio"
        echo "3. Salir"
        
        read -p "Opción (1-3): " choice
        
        case $choice in
            1)
                echo -e "${CYAN}Trabajando en: $exercise_path${NC}"
                echo -e "${YELLOW}Presiona ENTER cuando hayas terminado de implementar...${NC}"
                read
                
                # Validar ejercicio
                if validate_exercise "$selected_exercise" "$exercise_path"; then
                    mark_as_completed "$selected_exercise" "$selected_level"
                    echo -e "${GREEN}¡Excelente! Continuemos con el siguiente ejercicio.${NC}"
                    echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                    read
                    echo
                else
                    echo -e "${RED}El ejercicio no pasó la validación. Inténtalo de nuevo.${NC}"
                    echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                    read
                fi
                ;;
            2)
                continue
                ;;
            3)
                echo -e "${CYAN}¡Hasta luego!${NC}"
                break
                ;;
            *)
                echo -e "${RED}Opción inválida${NC}"
                ;;
        esac
    done
}

# Función para practicar nivel específico aleatoriamente
practice_level_randomly() {
    local level="$1"
    
    echo -e "${CYAN}Practicando Level $level aleatoriamente...${NC}"
    
    while true; do
        local available_exercises=$(get_available_exercises "$level")
        
        if [ -z "$available_exercises" ]; then
            echo -e "${GREEN}¡Felicidades! Has completado todos los ejercicios del Level $level.${NC}"
            break
        fi
        
        # Convertir a array y seleccionar aleatorio
        local exercises_array=($available_exercises)
        local random_index=$((RANDOM % ${#exercises_array[@]}))
        local selected_exercise="${exercises_array[$random_index]}"
        local exercise_path="level-$level/$selected_exercise"
        
        echo -e "${YELLOW}Ejercicio seleccionado: $selected_exercise${NC}"
        
        # Mostrar subject
        show_subject "$selected_exercise" "$exercise_path"
        
        echo
        echo -e "${CYAN}¿Qué quieres hacer?${NC}"
        echo "1. Continuar con este ejercicio"
        echo "2. Seleccionar otro ejercicio aleatorio del Level $level"
        echo "3. Salir"
        
        read -p "Opción (1-3): " choice
        
        case $choice in
            1)
                echo -e "${CYAN}Trabajando en: $exercise_path${NC}"
                echo -e "${YELLOW}Presiona ENTER cuando hayas terminado de implementar...${NC}"
                read
                
                # Validar ejercicio
                if validate_exercise "$selected_exercise" "$exercise_path"; then
                    mark_as_completed "$selected_exercise" "$level"
                    echo -e "${GREEN}¡Excelente! Continuemos con el siguiente ejercicio.${NC}"
                    echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                    read
                    echo
                else
                    echo -e "${RED}El ejercicio no pasó la validación. Inténtalo de nuevo.${NC}"
                    echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                    read
                fi
                ;;
            2)
                continue
                ;;
            3)
                echo -e "${CYAN}¡Hasta luego!${NC}"
                break
                ;;
            *)
                echo -e "${RED}Opción inválida${NC}"
                ;;
        esac
    done
}

# Función para mostrar progreso
show_progress() {
    echo -e "${BLUE}=======================================================================${NC}"
    echo -e "${CYAN}PROGRESO DEL EXAMEN${NC}"
    echo -e "${BLUE}=======================================================================${NC}"
    
    for level in 1 2; do
        echo -e "${YELLOW}Level $level:${NC}"
        
        local level_dir="level-$level"
        local done_file
        
        case $level in
            1) done_file="$LEVEL1_DONE" ;;
            2) done_file="$LEVEL2_DONE" ;;
        esac
        
        if [ ! -d "$level_dir" ]; then
            echo -e "${RED}  Directorio $level_dir no encontrado${NC}"
            continue
        fi
        
        local total_exercises=0
        local completed_exercises=0
        
        for exercise_dir in "$level_dir"/*; do
            if [ -d "$exercise_dir" ]; then
                local exercise_name=$(basename "$exercise_dir")
                total_exercises=$((total_exercises + 1))
                
                if grep -q "^$exercise_name$" "$done_file" 2>/dev/null; then
                    echo -e "${GREEN}  ✓ $exercise_name${NC}"
                    completed_exercises=$((completed_exercises + 1))
                else
                    echo -e "${RED}  ✗ $exercise_name${NC}"
                fi
            fi
        done
        
        echo -e "${CYAN}  Completado: $completed_exercises/$total_exercises${NC}"
        echo
    done
}

# Función para limpiar archivos de progreso
clean_progress_files() {
    echo -e "${YELLOW}¿Estás seguro de que quieres limpiar todo el progreso? (y/N)${NC}"
    read -p "Respuesta: " response
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
        > "$LEVEL1_DONE"
        > "$LEVEL2_DONE"
        echo -e "${GREEN}Progreso limpiado correctamente${NC}"
    else
        echo -e "${CYAN}Operación cancelada${NC}"
    fi
}

# Función para seleccionar ejercicio específico
select_specific_exercise() {
    echo -e "${CYAN}Selecciona el nivel:${NC}"
    echo "1. Level 1"
    echo "2. Level 2"
    
    read -p "Nivel (1-2): " level
    
    if [[ ! "$level" =~ ^[12]$ ]]; then
        echo -e "${RED}Nivel inválido${NC}"
        return
    fi
    
    local level_dir="level-$level"
    
    if [ ! -d "$level_dir" ]; then
        echo -e "${RED}Directorio $level_dir no encontrado${NC}"
        return
    fi
    
    echo -e "${CYAN}Ejercicios disponibles en Level $level:${NC}"
    
    local exercises=()
    local counter=1
    
    for exercise_dir in "$level_dir"/*; do
        if [ -d "$exercise_dir" ]; then
            local exercise_name=$(basename "$exercise_dir")
            exercises+=("$exercise_name")
            echo "$counter. $exercise_name"
            counter=$((counter + 1))
        fi
    done
    
    if [ ${#exercises[@]} -eq 0 ]; then
        echo -e "${RED}No se encontraron ejercicios en Level $level${NC}"
        return
    fi
    
    read -p "Selecciona ejercicio (1-${#exercises[@]}): " selection
    
    if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le "${#exercises[@]}" ]; then
        local selected_exercise="${exercises[$((selection - 1))]}"
        local exercise_path="level-$level/$selected_exercise"
        
        echo -e "${YELLOW}Ejercicio seleccionado: $selected_exercise${NC}"
        
        # Mostrar subject
        show_subject "$selected_exercise" "$exercise_path"
        
        echo -e "${CYAN}Trabajando en: $exercise_path${NC}"
        echo -e "${YELLOW}Presiona ENTER cuando hayas terminado de implementar...${NC}"
        read
        
        # Validar ejercicio
        if validate_exercise "$selected_exercise" "$exercise_path"; then
            mark_as_completed "$selected_exercise" "$level"
            echo -e "${GREEN}¡Excelente! Ejercicio completado correctamente.${NC}"
            echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
            read
        else
            echo -e "${RED}El ejercicio no pasó la validación.${NC}"
            echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
            read
        fi
    else
        echo -e "${RED}Selección inválida${NC}"
    fi
}

# Función principal del menú
main_menu() {
    while true; do
        clear
        echo -e "${BLUE}=======================================================================${NC}"
        echo -e "${CYAN}                    EXAM RANK 03 - SISTEMA DE PRÁCTICA${NC}"
        echo -e "${BLUE}=======================================================================${NC}"
        echo
        echo -e "${YELLOW}Opciones disponibles:${NC}"
        echo "1. Practicar ejercicios (aleatorio de todos los niveles)"
        echo "2. Practicar Level 1 (aleatorio)"
        echo "3. Practicar Level 2 (aleatorio)"
        echo "4. Seleccionar ejercicio específico"
        echo "5. Ver progreso"
        echo "6. Limpiar progreso"
        echo "7. Salir"
        echo
        
        read -p "Selecciona una opción (1-7): " choice
        
        case $choice in
            1)
                practice_exercises
                ;;
            2)
                practice_level_randomly 1
                ;;
            3)
                practice_level_randomly 2
                ;;
            4)
                select_specific_exercise
                ;;
            5)
                show_progress
                echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                read
                ;;
            6)
                clean_progress_files
                echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                read
                ;;
            7)
                echo -e "${GREEN}¡Buena suerte en tu preparación para el examen!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Opción inválida${NC}"
                echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                read
                ;;
        esac
    done
}

# Iniciar el programa
main_menu