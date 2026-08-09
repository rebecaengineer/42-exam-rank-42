# const-correctness conectada con node* vs node** (Bloque 2)

El usuario explicó, con precisión técnica, por qué `tree_bag::insert()` usa `node**` (necesita la
dirección modificable de un enlace del árbol para reasignarlo) mientras que
`searchable_tree_bag::has()` (const) solo usa `node*` (avanza una copia local del puntero, sin
tocar el árbol real). Modeló correctamente `this` como `const Clase*` dentro de un método const
y explicó por qué eso impide modificar miembros o llamar métodos no-const. La conexión con el
razonamiento de punteros del Bloque 2 fue espontánea, no pedida. Marca el Bloque 8
(const-correctness) confirmado.
