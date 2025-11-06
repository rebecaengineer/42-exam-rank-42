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
RENDU_DIR="$EXAM_DIR/rendu3"

# Crear directorios necesarios
mkdir -p "$PROGRESS_DIR"
mkdir -p "$RENDU_DIR"

# Archivos para almacenar ejercicios completados por nivel
LEVEL1_DONE="$PROGRESS_DIR/level1_done.txt"
LEVEL2_DONE="$PROGRESS_DIR/level2_done.txt"

# Crear archivos si no existen
touch "$LEVEL1_DONE" "$LEVEL2_DONE"

# Función para obtener el archivo source principal de un ejercicio
get_source_file() {
    local exercise_name="$1"
    local exercise_path="$2"

    # Buscar archivos .c en el directorio del ejercicio (excluyendo subdirectorios)
    local c_files=$(find "$exercise_path" -maxdepth 1 -name "*.c" 2>/dev/null)

    if [ -z "$c_files" ]; then
        echo ""
        return 1
    fi

    # Si hay un archivo que coincide con el nombre del ejercicio, usar ese
    local matching_file="$exercise_path/${exercise_name}.c"
    if [ -f "$matching_file" ]; then
        echo "$matching_file"
        return 0
    fi

    # Si solo hay un archivo .c, usar ese
    local count=$(echo "$c_files" | wc -l)
    if [ "$count" -eq 1 ]; then
        echo "$c_files"
        return 0
    fi

    # Si hay múltiples archivos, buscar en solutions/
    local solution_file="$exercise_path/solutions/${exercise_name}.c"
    if [ -f "$solution_file" ]; then
        echo "$solution_file"
        return 0
    fi

    # Retornar el primer archivo encontrado
    echo "$c_files" | head -n 1
    return 0
}

# Función para copiar solución a rendu3
copy_to_rendu() {
    local exercise_name="$1"
    local exercise_path="$2"

    # Crear directorio en rendu3
    local rendu_exercise_dir="$RENDU_DIR/$exercise_name"
    mkdir -p "$rendu_exercise_dir"

    # Obtener archivo source principal
    local source_file=$(get_source_file "$exercise_name" "$exercise_path")

    if [ -z "$source_file" ] || [ ! -f "$source_file" ]; then
        echo -e "${YELLOW}No se encontró archivo fuente para copiar${NC}"
        return 1
    fi

    # Copiar archivo a rendu3
    local dest_file="$rendu_exercise_dir/${exercise_name}.c"
    cp "$source_file" "$dest_file" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Solución copiada a: rendu3/$exercise_name/${exercise_name}.c${NC}"

        # Copiar también archivos .h si existen
        local header_file="${source_file%.c}.h"
        if [ -f "$header_file" ]; then
            cp "$header_file" "$rendu_exercise_dir/" 2>/dev/null
            echo -e "${GREEN}✓ Header copiado a: rendu3/$exercise_name/$(basename "$header_file")${NC}"
        fi

        return 0
    else
        echo -e "${RED}Error al copiar solución${NC}"
        return 1
    fi
}

# Función para preparar archivos para validación
prepare_exercise_files() {
    local exercise_name="$1"
    local exercise_path="$2"

    # Obtener archivo source principal
    local source_file=$(get_source_file "$exercise_name" "$exercise_path")

    if [ -z "$source_file" ] || [ ! -f "$source_file" ]; then
        return 1
    fi

    # Si el archivo está en solutions/, copiarlo a la raíz del ejercicio
    if [[ "$source_file" == *"/solutions/"* ]]; then
        local dest_file="$exercise_path/${exercise_name}.c"
        cp "$source_file" "$dest_file" 2>/dev/null

        # Copiar también el header si existe
        local header_file="${source_file%.c}.h"
        if [ -f "$header_file" ]; then
            cp "$header_file" "$exercise_path/" 2>/dev/null
        fi
    fi

    return 0
}

# Función para validar ejercicio con test específico
validate_exercise() {
    local exercise_name="$1"
    local exercise_path="$2"

    # Guardar directorio actual para volver después
    local original_dir=$(pwd)

    echo -e "${BLUE}=======================================================================${NC}"
    echo -e "${CYAN}Validando ejercicio: ${YELLOW}$exercise_name${NC}"
    echo -e "${BLUE}=======================================================================${NC}"

    # Construir ruta absoluta
    local absolute_path="$EXAM_DIR/$exercise_path"

    if [ ! -d "$absolute_path" ]; then
        echo -e "${RED}Error: El directorio del ejercicio no existe: $absolute_path${NC}"
        cd "$original_dir"
        return 1
    fi

    # Preparar archivos para validación (copiar de solutions/ si es necesario)
    prepare_exercise_files "$exercise_name" "$absolute_path"

    # Buscar script de test en grademe/
    local test_script="$absolute_path/grademe/test.sh"
    if [ ! -f "$test_script" ]; then
        # Buscar alternativas de test
        test_script="$absolute_path/test.sh"
        if [ ! -f "$test_script" ]; then
            test_script="$absolute_path/tester/run_exam.sh"
            if [ ! -f "$test_script" ]; then
                echo -e "${RED}Error: No se encontró script de test para $exercise_name${NC}"
                echo -e "${YELLOW}Se buscó en:${NC}"
                echo -e "  - $absolute_path/grademe/test.sh"
                echo -e "  - $absolute_path/test.sh"
                echo -e "  - $absolute_path/tester/run_exam.sh"
                cd "$original_dir"
                return 1
            fi
        fi
    fi

    echo -e "${CYAN}Ejecutando test: $test_script${NC}"

    # Cambiar al directorio del ejercicio para ejecutar el test
    cd "$absolute_path"

    # Ejecutar el script de test
    local test_result=0
    if bash "$test_script"; then
        echo -e "${GREEN}✓ Test pasado correctamente${NC}"
        test_result=0
    else
        echo -e "${RED}✗ Test fallido${NC}"
        test_result=1
    fi

    # Volver al directorio original
    cd "$original_dir"

    return $test_result
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

# Función para obtener TODOS los ejercicios de un nivel (incluidos completados)
get_all_exercises() {
    local level="$1"
    local level_dir="level-$level"

    if [ ! -d "$level_dir" ]; then
        echo ""
        return
    fi

    local all_exercises=""
    for exercise_dir in "$level_dir"/*; do
        if [ -d "$exercise_dir" ]; then
            local exercise_name=$(basename "$exercise_dir")
            if [ -z "$all_exercises" ]; then
                all_exercises="$exercise_name"
            else
                all_exercises="$all_exercises $exercise_name"
            fi
        fi
    done

    echo "$all_exercises"
}

# Función para verificar si un ejercicio está completado
is_exercise_completed() {
    local exercise_name="$1"
    local level="$2"
    local done_file

    case $level in
        1) done_file="$LEVEL1_DONE" ;;
        2) done_file="$LEVEL2_DONE" ;;
        *) return 1 ;;
    esac

    grep -q "^$exercise_name$" "$done_file" 2>/dev/null
    return $?
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

    # Mostrar si el ejercicio ya está completado
    local level=$(echo "$exercise_path" | grep -oP 'level-\K[0-9]+')
    if is_exercise_completed "$exercise_name" "$level"; then
        echo -e "${GREEN}✓ Este ejercicio ya está completado${NC}"
        echo -e "${YELLOW}Puedes rehacerlo para practicar${NC}"
        echo -e "${BLUE}=======================================================================${NC}"
    fi
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
                # Bucle de práctica del ejercicio
                while true; do
                    echo
                    echo -e "${CYAN}¿Qué quieres hacer?${NC}"
                    echo "1. Validar ejercicio"
                    echo "2. Marcar como completado sin validar"
                    echo "3. Ver subject de nuevo"
                    echo "4. Siguiente ejercicio"

                    read -p "Opción (1-4): " option

                    case $option in
                        1)
                            # Validar ejercicio
                            if validate_exercise "$selected_exercise" "$exercise_path"; then
                                # Copiar solución a rendu3
                                copy_to_rendu "$selected_exercise" "$exercise_path"

                                # Marcar como completado
                                mark_as_completed "$selected_exercise" "$selected_level"
                                echo -e "${GREEN}¡Excelente! Continuemos con el siguiente ejercicio.${NC}"
                                echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                                read
                                echo
                                break
                            else
                                echo -e "${RED}Los tests han fallado. Sigue intentándolo.${NC}"
                                echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                                read
                            fi
                            ;;
                        2)
                            # Marcar como completado sin validar
                            copy_to_rendu "$selected_exercise" "$exercise_path"
                            mark_as_completed "$selected_exercise" "$selected_level"
                            echo -e "${YELLOW}Ejercicio marcado como completado sin validación.${NC}"
                            echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                            read
                            echo
                            break
                            ;;
                        3)
                            # Ver subject de nuevo
                            show_subject "$selected_exercise" "$exercise_path"
                            ;;
                        4)
                            # Limpiar ejercicio (empezar de cero)
                            echo -e "${YELLOW}¿Estás seguro de que quieres limpiar este ejercicio? (s/N)${NC}"
                            read -p "Respuesta: " confirm
                            if [[ "$confirm" =~ ^[Ss]$ ]]; then
                                local absolute_path="$EXAM_DIR/$exercise_path"
                                # Eliminar archivos .c y .h en la raíz del ejercicio (no en solutions/)
                                rm -f "$absolute_path"/*.c "$absolute_path"/*.h 2>/dev/null
                                # Eliminar también binarios compilados
                                rm -f "$absolute_path"/"$selected_exercise" 2>/dev/null
                                echo -e "${GREEN}✓ Ejercicio limpiado. Puedes empezar de cero.${NC}"
                                echo -e "${CYAN}Crea tu archivo: $exercise_path/${selected_exercise}.c${NC}"
                            else
                                echo -e "${CYAN}Limpieza cancelada.${NC}"
                            fi
                            ;;
                        5)
                            # Siguiente ejercicio
                            echo -e "${CYAN}Pasando al siguiente ejercicio...${NC}"
                            break
                            ;;
                        *)
                            echo -e "${RED}Opción inválida${NC}"
                            ;;
                    esac
                done
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
                # Bucle de práctica del ejercicio
                while true; do
                    echo
                    echo -e "${CYAN}¿Qué quieres hacer?${NC}"
                    echo "1. Validar ejercicio"
                    echo "2. Marcar como completado sin validar"
                    echo "3. Ver subject de nuevo"
                    echo "4. Limpiar ejercicio (empezar de cero)"
                    echo "5. Siguiente ejercicio"

                    read -p "Opción (1-5): " option

                    case $option in
                        1)
                            # Validar ejercicio
                            if validate_exercise "$selected_exercise" "$exercise_path"; then
                                # Copiar solución a rendu3
                                copy_to_rendu "$selected_exercise" "$exercise_path"

                                # Marcar como completado
                                mark_as_completed "$selected_exercise" "$level"
                                echo -e "${GREEN}¡Excelente! Continuemos con el siguiente ejercicio.${NC}"
                                echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                                read
                                echo
                                break
                            else
                                echo -e "${RED}Los tests han fallado. Sigue intentándolo.${NC}"
                                echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                                read
                            fi
                            ;;
                        2)
                            # Marcar como completado sin validar
                            copy_to_rendu "$selected_exercise" "$exercise_path"
                            mark_as_completed "$selected_exercise" "$level"
                            echo -e "${YELLOW}Ejercicio marcado como completado sin validación.${NC}"
                            echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                            read
                            echo
                            break
                            ;;
                        3)
                            # Ver subject de nuevo
                            show_subject "$selected_exercise" "$exercise_path"
                            ;;
                        4)
                            # Limpiar ejercicio (empezar de cero)
                            echo -e "${YELLOW}¿Estás seguro de que quieres limpiar este ejercicio? (s/N)${NC}"
                            read -p "Respuesta: " confirm
                            if [[ "$confirm" =~ ^[Ss]$ ]]; then
                                local absolute_path="$EXAM_DIR/$exercise_path"
                                # Eliminar archivos .c y .h en la raíz del ejercicio (no en solutions/)
                                rm -f "$absolute_path"/*.c "$absolute_path"/*.h 2>/dev/null
                                # Eliminar también binarios compilados
                                rm -f "$absolute_path"/"$selected_exercise" 2>/dev/null
                                echo -e "${GREEN}✓ Ejercicio limpiado. Puedes empezar de cero.${NC}"
                                echo -e "${CYAN}Crea tu archivo: $exercise_path/${selected_exercise}.c${NC}"
                            else
                                echo -e "${CYAN}Limpieza cancelada.${NC}"
                            fi
                            ;;
                        5)
                            # Siguiente ejercicio
                            echo -e "${CYAN}Pasando al siguiente ejercicio...${NC}"
                            break
                            ;;
                        *)
                            echo -e "${RED}Opción inválida${NC}"
                            ;;
                    esac
                done
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

# Función para seleccionar ejercicio específico (PERMITE REHACER COMPLETADOS)
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

    # Usar get_all_exercises en lugar de get_available_exercises
    # para incluir también los ejercicios completados
    local all_exercises=$(get_all_exercises "$level")

    if [ -z "$all_exercises" ]; then
        echo -e "${RED}No se encontraron ejercicios en Level $level${NC}"
        return
    fi

    echo -e "${CYAN}Ejercicios disponibles en Level $level:${NC}"

    local exercises=()
    local counter=1

    for exercise_name in $all_exercises; do
        exercises+=("$exercise_name")

        # Mostrar si está completado
        if is_exercise_completed "$exercise_name" "$level"; then
            echo -e "$counter. ${GREEN}$exercise_name ✓${NC}"
        else
            echo "$counter. $exercise_name"
        fi
        counter=$((counter + 1))
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

        # Bucle de práctica del ejercicio
        while true; do
            echo
            echo -e "${CYAN}¿Qué quieres hacer?${NC}"
            echo "1. Validar ejercicio"
            echo "2. Marcar como completado sin validar"
            echo "3. Ver subject de nuevo"
            echo "4. Limpiar ejercicio (empezar de cero)"
            echo "5. Volver al menú principal"

            read -p "Opción (1-5): " option

            case $option in
                1)
                    # Validar ejercicio
                    if validate_exercise "$selected_exercise" "$exercise_path"; then
                        # Copiar solución a rendu3
                        copy_to_rendu "$selected_exercise" "$exercise_path"

                        # Marcar como completado
                        mark_as_completed "$selected_exercise" "$level"
                        echo -e "${GREEN}¡Excelente! Ejercicio completado correctamente.${NC}"
                        echo -e "${YELLOW}Presiona ENTER para volver al menú principal...${NC}"
                        read
                        break
                    else
                        echo -e "${RED}Los tests han fallado. Sigue intentándolo.${NC}"
                        echo -e "${YELLOW}Presiona ENTER para continuar...${NC}"
                        read
                        # Continuar el bucle para permitir reintentar
                    fi
                    ;;
                2)
                    # Marcar como completado sin validar
                    copy_to_rendu "$selected_exercise" "$exercise_path"
                    mark_as_completed "$selected_exercise" "$level"
                    echo -e "${YELLOW}Ejercicio marcado como completado sin validación.${NC}"
                    echo -e "${YELLOW}Presiona ENTER para volver al menú principal...${NC}"
                    read
                    break
                    ;;
                3)
                    # Ver subject de nuevo
                    show_subject "$selected_exercise" "$exercise_path"
                    ;;
                4)
                    # Limpiar ejercicio (empezar de cero)
                    echo -e "${YELLOW}¿Estás seguro de que quieres limpiar este ejercicio? (s/N)${NC}"
                    read -p "Respuesta: " confirm
                    if [[ "$confirm" =~ ^[Ss]$ ]]; then
                        local absolute_path="$EXAM_DIR/$exercise_path"
                        # Eliminar archivos .c y .h en la raíz del ejercicio (no en solutions/)
                        rm -f "$absolute_path"/*.c "$absolute_path"/*.h 2>/dev/null
                        # Eliminar también binarios compilados
                        rm -f "$absolute_path"/"$selected_exercise" 2>/dev/null
                        echo -e "${GREEN}✓ Ejercicio limpiado. Puedes empezar de cero.${NC}"
                        echo -e "${CYAN}Crea tu archivo: $exercise_path/${selected_exercise}.c${NC}"
                    else
                        echo -e "${CYAN}Limpieza cancelada.${NC}"
                    fi
                    ;;
                5)
                    # Volver al menú principal
                    echo -e "${CYAN}Volviendo al menú principal...${NC}"
                    break
                    ;;
                *)
                    echo -e "${RED}Opción inválida${NC}"
                    ;;
            esac
        done
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
        echo "4. Seleccionar ejercicio específico (permite rehacer completados)"
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
