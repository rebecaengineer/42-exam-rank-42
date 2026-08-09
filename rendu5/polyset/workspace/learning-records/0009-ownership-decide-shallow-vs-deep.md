# Ownership, no la sintaxis, decide si copiar un puntero es bug o diseño

El usuario resolvió el checkpoint capstone del árbol completo de Polyset: por qué `sb(other.sb)`
en `set` (copiar el puntero) es correcto, mientras que la misma operación en `array_bag` (Bloque
2/3) era el bug de double free. Identificó con precisión que el factor decisivo es la propiedad
(ownership) del recurso, no la operación de copiar un puntero en sí — produjo una tabla
comparativa correcta (quién crea el recurso / quién lo libera / si el destructor hace `delete` /
si la copia superficial es correcta). Añadió, sin que se pidiera, el riesgo inverso que introduce
el patrón de puntero no-propietario: dangling pointer si el dueño externo del `searchable_bag`
se destruye antes que el `set` que lo envuelve, con un ejemplo de código correcto que lo
demuestra.

**Marca el árbol de dependencias completo de Polyset (9/9 bloques) confirmado con evidencia real
en cada uno**, la mayoría sin pistas y con matices no solicitados.
