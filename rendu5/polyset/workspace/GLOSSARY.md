# Polyset Glossary

Términos del ejercicio Polyset (05/level-1) que ya has demostrado dominar, no solo visto.

## Terms

**protected**:
Nivel de acceso intermedio entre `public` y `private`: visible para la propia clase y para las
clases que heredan de ella, invisible desde fuera de la jerarquía. Se usa en vez de `private`
cuando una clase hija necesita tocar el dato directamente sin pasar por un getter.
_Avoid_: "medio privado", "casi público"

**copia profunda (deep copy)**:
Copiar el contenido apuntado (reservando memoria nueva y copiando los valores), no la dirección.
Es lo contrario de una copia superficial (`data = src.data;`), que hace que dos objetos
compartan el mismo puntero.
_Avoid_: "copia completa", "clonar" (impreciso — no dice qué se copia)

**double free**:
Comportamiento indefinido que ocurre cuando `delete`/`delete[]` se ejecuta dos veces sobre la
misma dirección de memoria — típicamente porque dos objetos compartían un puntero por una copia
superficial. Consecuencia directa de no hacer copia profunda en el constructor de copia.
_Avoid_: "error de memoria" (demasiado vago — nombra el mecanismo exacto)

**guarda de autoasignación**:
El `if (this != &src)` al inicio de `operator=`. Sin ella, `a = a` libera el recurso de `a`
antes de copiarlo desde `src` — pero `src` es el mismo objeto, así que el origen ya no existe
cuando se intenta copiar.
_Avoid_: "comprobación de seguridad" (no dice de qué protege)

**memory leak (fuga de memoria)**:
Memoria reservada con `new`/`new[]` que se vuelve inalcanzable porque se pierde el único puntero
que la referenciaba, sin haberla liberado antes. En `operator=`, ocurre si se sobreescribe
`data` con el nuevo array antes de hacer `delete[]` sobre el antiguo. No crashea de inmediato;
se acumula.
_Avoid_: "se pierde memoria" (impreciso — no dice el mecanismo: puntero sobrescrito sin liberar)

**forma canónica ortodoxa**:
Convención de James Coplien (*Advanced C++: Programming Styles and Idioms*, 1992): toda clase
que gestiona un recurso debe implementar, como unidad, constructor por defecto + constructor de
copia + `operator=` + destructor. El Rule of Three de C++ solo exige los últimos tres (gestión
de recursos); 42 añade el constructor por defecto para poder instanciar la clase en arrays y
contenedores.
_Avoid_: "las 4 funciones", "el boilerplate" (pierde el porqué de cada pieza)

**lista de inicialización (de miembros y bases)**:
La sintaxis tras `:` en un constructor (`: array_bag(other) {}`) que dice explícitamente qué
constructor usar para construir cada subobjeto base y cada miembro, antes de ejecutar el cuerpo
`{}`. Si se omite, se llama al constructor por defecto de la base — no "no pasa nada".
_Avoid_: `std::initializer_list` (es un tipo distinto, `{1,2,3}`, no esta sintaxis)

**función virtual pura**:
Función declarada con `virtual ... = 0;` — sin cuerpo en esa clase. `= 0` es el *pure specifier*,
no una asignación. Cualquier clase que defina o herede una sin implementación final es
abstracta.
_Avoid_: "función abstracta" (lo abstracto es la clase, no la función)

**clase abstracta**:
Clase que define o hereda al menos una función virtual pura sin implementación final. No se
puede instanciar directamente (`bag b;` no compila), pero sí se pueden declarar punteros o
referencias a ella. La abstractidad se propaga: basta una función pura sin implementar para que
toda la clase lo sea, aunque el resto estén implementadas.
_Avoid_: "interfaz" a secas (en C++ no es una palabra clave — es una clase con funciones puras)

**herencia virtual**:
`virtual` aplicado a una herencia (`class array_bag : virtual public bag`), no a una función —
mismo keyword, significado distinto. Garantiza que si dos caminos de herencia convergen en el
mismo ancestro, comparten un único subobjeto en vez de duplicarlo. Hace falta en **todas** las
herencias que lleven a ese ancestro común, no en una sola.
_Avoid_: confundirlo con "función virtual" (Bloque 5) — el contexto (herencia vs. función) es lo
que cambia el significado

**diamond problem**:
Cuando una clase hereda de dos clases que a su vez heredan de un mismo ancestro común, sin
herencia virtual el objeto final contiene dos copias independientes de ese ancestro —
ambigüedad al convertir a un puntero del tipo ancestro. Se resuelve con `virtual` en ambas
herencias intermedias.
_Avoid_: "conflicto de herencia" (impreciso — el problema es la duplicación del ancestro común)

**tipo estático vs. tipo dinámico**:
El tipo estático es el declarado en el código (`searchable_bag *t`); el dinámico es el del
objeto real al que apunta (`searchable_tree_bag`). Con funciones `virtual`, la llamada se
resuelve según el tipo dinámico en runtime, no según el estático en compilación.
_Avoid_: "tipo real" a secas para el dinámico sin nombrar el estático — la distinción solo tiene
sentido en contraste

**destructor virtual**:
`virtual ~Clase() {}` en una base que se va a usar polimórficamente. Sin él, `delete` a través
de un puntero al tipo base es **comportamiento indefinido** (no "solo un leak garantizado" — eso
es el resultado frecuente en la práctica, no lo que promete el estándar). La virtualidad se
hereda: no hace falta redeclararla en cada clase hija.
_Avoid_: "destructor normal" para uno virtual — la palabra clave es la que activa la cadena de
destrucción completa

**método const**:
`const` tras la firma de un método (`bool has(int) const`) — promete no modificar el objeto.
Cambia el tipo de `this` a `const Clase*`: dentro no se pueden reasignar miembros ni llamar a
métodos no-const sobre `this`. Solo se pueden invocar métodos const sobre objetos/referencias
const.
_Avoid_: tratar `const` aquí como decorativo — es parte de la firma y el compilador lo aplica

**composición (wrapper pattern)**:
Una clase HAS-A otra (guarda un puntero/referencia) en vez de heredar de ella (IS-A). `set`
guarda un `searchable_bag*` sin heredar de `searchable_bag`. No confundir con la herencia de los
Bloques 4/6.
_Avoid_: usar "hereda" para describir esta relación

**ownership (propiedad de un recurso)**:
El factor que decide si copiar un puntero es un bug o el diseño correcto — no la operación en
sí. Si el objeto creó el recurso y su destructor lo libera (`array_bag`/`data`), copiar solo el
puntero produce doble propiedad accidental → double free. Si el objeto no lo posee, solo lo
observa (`set`/`sb`), copiar el puntero es una vista compartida intencional — pero introduce el
riesgo inverso: dangling pointer si el dueño real se destruye primero.
_Avoid_: "es un puntero, hay que copiarlo profundo siempre" — la regla depende de quién posee el
recurso, no es universal
