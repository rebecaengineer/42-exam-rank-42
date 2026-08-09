# Lista de inicialización: por qué `: array_bag(other)` y no `: array_bag()`

El usuario resolvió el checkpoint de herencia múltiple: identificó que usar `: array_bag()` en
vez de `: array_bag(other)` en el constructor de copia de `searchable_array_bag` no da error de
compilación, pero deja el objeto nuevo vacío (`data=NULL`, `size=0`) en vez de copiar `other` —
porque llama al constructor por defecto de la base, no al de copia. Trajo también material propio
sobre la sintaxis de lista de inicialización (tabla "léelo por trozos", diagrama de subobjetos)
que se incorporó a la lección 0004, corrigiendo una cita errónea que traía
(`cppreference/initializer_list.html`, que es sobre `std::initializer_list`, no sobre listas de
inicialización de miembros/bases — la correcta es `cppreference/language/constructor`). Marca el
Bloque 4 (herencia simple y múltiple) confirmado.

**Preferencia declarada**: el usuario indicó explícitamente que la sintaxis de C++ le resulta
árida y que necesita clarificaciones frecuentes — ver `workspace/NOTES.md`.
