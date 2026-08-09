# Modo 2: searchable_array_bag implementado y corregido sin dárselo hecho

El usuario escribió `searchable_array_bag.{hpp,cpp}` en `rendu/polyset/` (directorio real de
`05/exam.sh`, distinto de `rendu5/polyset/` que era la referencia ya resuelta). El `.hpp` salió
correcto a la primera (5 firmas del contrato completas). El `.cpp` tuvo dos bugs reales en
`has()`, corregidos tras pistas (no dados directamente):

1. `this->data[x++]` — incremento duplicado de `x` dentro del índice, además del `x++` del
   propio `for`, saltándose posiciones del array.
2. `return false;` dentro del cuerpo del `for` en vez de después — cortaba el bucle en la primera
   iteración, devolviendo `false` aunque el valor estuviera más adelante en el array. Consecuencia
   adicional detectada: sin un `return` fuera de todo camino del `for`, la función podía no
   compilar bajo `-Werror` si `size == 0` (control-reaches-end-of-non-void-function).

También surgieron dudas puntuales de sintaxis durante la escritura (uso de `&` como referencia
vs. dirección-de, `this` vs. nombre de parámetro, `::` vs `:`, por qué `bag`/`searchable_bag` no
tienen `.cpp` — conectado correctamente a Bloque 5 sin ayuda) — todas resueltas con desgloses
pieza a pieza, consistente con la preferencia de `workspace/NOTES.md`.

Primera clase del grafo de dependencias de compilación (Modo 2) completada de verdad, escrita por
el usuario, revisada por el tutor sin escribir el código.
