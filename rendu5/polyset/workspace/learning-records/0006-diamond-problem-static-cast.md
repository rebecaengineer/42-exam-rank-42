# Diamond problem: ambigüedad sin virtual, resuelta trazando ambos caminos

El usuario resolvió, sin pistas, que `bag *b = &sab;` no compilaría sin `virtual` en ambas
herencias (`array_bag`, `searchable_bag`) — identificó la ambigüedad de dos subobjetos `bag`
candidatos, demostró la desambiguación manual con `static_cast<array_bag*>(&sab)` /
`static_cast<searchable_bag*>(&sab)` y notó explícitamente que los punteros resultantes serían
distintos (`b1 != b2`) sin herencia virtual. Confirma que entiende `virtual` en herencia como un
concepto distinto de `virtual` en funciones (Bloque 5), sin confundirlos. Marca el Bloque 6
(herencia virtual / diamond problem) confirmado.
