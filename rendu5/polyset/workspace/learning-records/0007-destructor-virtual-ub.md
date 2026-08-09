# delete a través de puntero base sin destructor virtual: UB, no "solo leak"

El usuario resolvió que `delete t;`/`delete a;` (tipo estático `searchable_bag*`, tipo dinámico
`searchable_tree_bag`/`searchable_array_bag`) es comportamiento indefinido porque ni `bag` ni
`searchable_bag` declaran destructor virtual. La parte más valiosa de la respuesta: distinguió
explícitamente entre "resultado frecuente en la práctica" (solo se ejecuta el destructor base,
`data` se filtra) y "lo que el estándar garantiza" (nada — UB real, no solo un leak predecible).
Propuso el arreglo correcto (`virtual ~bag()`, con la nota de que la virtualidad se hereda a las
clases hijas sin redeclararla). Marca el Bloque 7 (polimorfismo con punteros a clase base)
confirmado.
