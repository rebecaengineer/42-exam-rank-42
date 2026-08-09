# Modo 2: searchable_tree_bag implementado — bug de missing else en has()

Los 4 miembros canónicos salieron correctos a la primera, adaptando el patrón de
`searchable_array_bag` a `tree_bag` sin ayuda. `has()` tuvo un bug real: `cur = cur->r;` seguido
de `cur = cur->l;` **sin `else`** — ambas líneas se ejecutaban siempre en secuencia, así que tras
mover a la derecha, inmediatamente se sobreescribía con el hijo izquierdo de esa nueva posición,
corrompiendo la búsqueda cada vez que tocaba ir a la derecha. Corregido tras trazar a mano
`has(20)` sobre un árbol de dos nodos (pista dada, no la solución). Marca la Clase 2 del grafo de
implementación de Modo 2 completada.
