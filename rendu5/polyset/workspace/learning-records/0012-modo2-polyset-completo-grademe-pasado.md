# Modo 2: Polyset implementado de cero en rendu/ y grademe/test.sh superado

Ciclo completo de implementación guiada (Modo 2) para Polyset, en el directorio real de examen
(`rendu/polyset/`, el que usa `05/exam.sh`, no `rendu5/polyset/` que era la referencia ya
resuelta). El usuario escribió las 3 clases del grafo de compilación de principio a fin, sin que
se le diera el código en ningún momento — solo contrato, esqueleto y pistas ante bugs reales:

1. **searchable_array_bag**: `.hpp` correcto a la primera. `.cpp`: 2 bugs en `has()`
   (incremento duplicado de índice, `return false` mal ubicado cortando el bucle en la primera
   iteración) — corregidos tras trazar un caso concreto a mano.
2. **searchable_tree_bag**: `.hpp` correcto a la primera. `.cpp`: bug de `else` ausente en el
   recorrido del árbol, corrompiendo la búsqueda cada vez que tocaba ir a la derecha — corregido
   tras trazar `has(20)` sobre un árbol de dos nodos.
3. **set**: primera versión del `.hpp` sin `get_bag()`, con el parámetro del ctor de copia
   sombreando al miembro (`sb` en vez de `other`), y nombres confusos en `insert(int*, int)` —
   los tres corregidos. `.cpp`: primera versión sin `set::` en 4 métodos (definía funciones
   globales sueltas, no miembros de la clase — se explicó conectándolo con la lección de `::` de
   unos turnos antes), sin `const` en `has()`, con `print()`/`get_bag()` sin implementar —
   corregido en la segunda pasada, quedando completo y correcto.

Además, dos errores reales de compilación/enlace causados por comandos de `g++` incompletos
(`-I` no compila los `.cpp` de esa carpeta, solo permite encontrar sus `.hpp`; `*.cpp` en el cwd
no incluye los ficheros dados de otra carpeta) — explicados y corregidos, generalizables a
cualquier proyecto multi-fichero futuro.

**Verificación final**: `main.cpp` (dado) enlaza y corre limpio con las 3 clases; `grademe/test.sh`
(vía `05/exam.sh`, incluye build con ASAN) superado. El usuario prefiere ejecutar él mismo los
comandos de verificación (no el tutor) — ver regla ya añadida a
`references/guided-implementation-format.md`.
