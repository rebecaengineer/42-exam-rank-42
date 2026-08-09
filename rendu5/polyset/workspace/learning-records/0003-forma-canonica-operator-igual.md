# operator= trazado completo: autoasignación y fuga de memoria

El usuario resolvió, sin pistas, las dos mitades de `operator=` en `array_bag`:

1. **Guarda de autoasignación** (`if (this != &src)`): trazó línea a línea qué pasa en `a = a`
   sin la guarda — `delete[]` destruye el origen (mismo objeto), y señaló correctamente que leer
   los `int` sin inicializar tras el `new[]` es UB, no solo "basura". Más preciso de lo pedido.
2. **Liberar el dato viejo antes de reasignar** (`delete[] data` antes de `data = new int[...]`):
   identificó memory leak (no crash) cuando se sobreescribe el puntero de un objeto que ya tenía
   datos, y que el destructor solo libera el último array, dejando los anteriores inalcanzables.

Confirma razonamiento transferido del Bloque 2 (deep copy/double free) a un caso nuevo sin
reexplicación. Marca el Bloque 3 (forma canónica ortodoxa) como confirmado — incluyendo por qué
42 exige también un constructor por defecto (instanciabilidad en arrays/contenedores, no gestión
de recursos), explicado con fuente real tras cerrar el Gap que había en `RESOURCES.md`.
