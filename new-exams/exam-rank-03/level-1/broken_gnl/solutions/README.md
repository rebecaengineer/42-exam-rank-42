# broken_gnl - Solución Original

## Descripción
Ejercicio de debugging completado. Se identificaron y repararon 8 errores críticos en get_next_line.

## Archivos
- `broken_gnl.c` - Tu versión reparada funcional
- `APUNTES_BROKEN_GNL.md` - Documentación detallada de todos los errores encontrados

## Errores identificados y reparados
1. ✅ `ft_strchr()` - Bucle infinito sin protección '\0'
2. ✅ `ft_memcpy()` - Copia incompleta con condición --n > 0
3. ✅ `str_append_mem()` - Crash con NULL pointer
4. ✅ `ft_memmove()` - Uso incorrecto de ft_strlen() vs n
5. ✅ `ft_memmove()` - Bucle infinito con size_t unsigned
6. ✅ `get_next_line()` - No maneja EOF (read_ret == 0)
7. ✅ `get_next_line()` - No actualiza tmp después de leer
8. ✅ `get_next_line()` - Crash con tmp NULL al final

## Conceptos aplicados
- Debugging avanzado
- Manejo de static variables
- Buffer management
- Memory leak detection
- Tipos signed vs unsigned
- Manejo correcto de EOF

## Estado
✅ **COMPLETADO** - Todos los errores identificados y reparados

## Nota
Este archivo es de solo lectura. Para practicar, trabaja en el `broken_gnl.c` de la carpeta principal.