# protected vs private para permitir acceso desde clases hijas

El usuario identificó correctamente que `array_bag` declara `data` y `size` en
`protected` (no `private`) porque `searchable_array_bag::has()` — definida en
la clase hija — necesita leerlos directamente. Respuesta razonada sobre el
código real (`searchable_array_bag.cpp`), no una definición recitada de
memoria. Marca el Bloque 1 (clases básicas / encapsulación) del árbol de
dependencias de Polyset como confirmado con evidencia — se puede pasar al
Bloque 2 (punteros y memoria dinámica) sin reexplicar este bloque.
