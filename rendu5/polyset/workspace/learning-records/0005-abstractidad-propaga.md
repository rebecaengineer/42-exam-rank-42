# La abstractidad se propaga hasta implementar toda función pura

El usuario resolvió, sin pistas, que `array_bag` seguiría siendo abstracta si no implementara
`clear()` — basta una sola función virtual pura heredada sin cuerpo para que la clase entera lo
sea, sin importar cuántas otras sí estén implementadas. Añadió matices no pedidos y correctos:
punteros/referencias al tipo abstracto sí son válidos (`array_bag* p;` compila), y una clase más
derivada podría "arreglarlo" implementando la función que faltaba. Antes de responder, pidió
explícitamente el "por qué existe" (para qué sirven las clases abstractas) — se le dio con el
propio `main.cpp` como ejemplo (`searchable_bag*` apuntando a implementaciones concretas). Marca
el Bloque 5 (clases abstractas / funciones virtuales puras) confirmado.
