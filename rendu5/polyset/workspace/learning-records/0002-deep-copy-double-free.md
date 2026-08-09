# Copia profunda para evitar double free

El usuario identificó, tras una pista dirigida al destructor, que una copia superficial
(`data = src.data;`) en `array_bag` provoca un **double free**: dos objetos comparten el mismo
puntero `data`, y cada destrucción llama a `delete[]` sobre la misma dirección. Su primera
respuesta (aliasing/estado compartido) era cierta pero no era "el fallo concreto" pedido —
demuestra que sabe razonar sobre punteros compartidos, pero necesitó un empujón para conectarlo
con el ciclo de vida (destructor) en vez de quedarse en "los datos mutan de forma rara". Marca el
Bloque 2 (punteros y memoria dinámica) confirmado. El Bloque 3 (forma canónica ortodoxa completa:
ctor, copia, `operator=`, dtor) puede construir directamente sobre este razonamiento sin
repetirlo.
