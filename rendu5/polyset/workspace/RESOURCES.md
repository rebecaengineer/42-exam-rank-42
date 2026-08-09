# Polyset Resources

## Knowledge

- [cppreference: Access specifiers](https://en.cppreference.com/w/cpp/language/access)
  Referencia oficial de `public`/`protected`/`private` y su efecto en herencia. Use for: dudas exactas
  sobre visibilidad de miembros heredados.
- Enunciado real: `05/level-1/polyset/subject.txt` (este repo)
  Qué clases hay que implementar (`searchable_array_bag`, `searchable_tree_bag`, `set`) y que todas
  deben respetar la forma canónica ortodoxa. Use for: qué archivos/funciones son obligatorios.
- Código de referencia dado por 42: `05/level-1/polyset/{bag,searchable_bag,array_bag,tree_bag}.hpp/.cpp`
  (este repo). Use for: ver la jerarquía base tal cual la entrega el curriculum, antes de tocarla.
- Implementación propia ya resuelta: `rendu5/polyset/*` (este repo)
  Use for: ver `protected` (y luego herencia virtual, polimorfismo, BST) aplicados en código real
  y ya funcionando, no en un ejemplo de juguete.
- [cppreference: Rule of three](https://en.cppreference.com/w/cpp/language/rule_of_three)
  Por qué destructor, ctor de copia y `operator=` van juntos — el nombre formal de la comunidad
  C++ para lo que 42 llama "forma canónica ortodoxa". Use for: double free, copia profunda,
  Bloque 3 (forma canónica completa).
- [CRySoL: La Forma Canónica Ortodoxa](https://crysol.org/recipe/2008-09-03/la-forma-cannica-ortodoxa.html)
  Explica el término en español y por qué hace falta constructor por defecto: sin él no se
  pueden declarar arrays ni contenedores de la clase. Origen: James Coplien, *Advanced C++:
  Programming Styles and Idioms* (1992). Use for: cerrar el porqué del 4º miembro que el Rule
  of Three no cubre.
- [cppreference: Constructors and member initializer lists](https://en.cppreference.com/w/cpp/language/constructor)
  Sintaxis y orden real de construcción de bases/miembros (`: array_bag(other) {}`). **Cuidado**:
  no confundir con `cppreference/language/initializer_list` (que es sobre `std::initializer_list`,
  el de `{1,2,3}` — un tipo distinto, nombre parecido). El usuario trajo esa cita equivocada de
  otra fuente; verificado y corregido antes de usarla en la lección 0004.
- [cppreference: Abstract class](https://en.cppreference.com/w/cpp/language/abstract_class)
  Definición formal: una clase es abstracta si define o hereda al menos una función para la que
  el "final overrider" es virtual pura. Use for: por qué la abstractidad se propaga, Bloque 5.
- [cppreference: Derived classes](https://en.cppreference.com/w/cpp/language/derived_class)
  Sección de bases virtuales: "solo un subobjeto de esa clase, siempre que se herede virtual cada
  vez" — confirma que hace falta en las dos herencias, no en una. También: solo la clase más
  derivada inicializa la base virtual. Use for: diamond problem, Bloque 6.
- [Wikipedia: Multiple inheritance](https://en.wikipedia.org/wiki/Multiple_inheritance)
  El usuario citó esta como apoyo al diamond problem — verificada, correcta como cross-reference
  general, pero cppreference (arriba) es la fuente primaria para el comportamiento exacto de C++.
- [cppreference: delete expression](https://en.cppreference.com/w/cpp/language/delete)
  Confirma que `delete` de un objeto derivado a través de puntero al tipo base con destructor no
  virtual es UB. Use for: Bloque 7.
- [cppreference: Destructors](https://en.cppreference.com/w/cpp/language/destructor)
  Regla: si una clase tiene funciones virtuales y se usa polimórficamente, su destructor debe ser
  virtual. Use for: Bloque 7.
- [cppreference: Non-static member functions](https://en.cppreference.com/w/cpp/language/member_functions)
  Confirma que un método `const` recibe `this` cv-qualificado (`const Clase*`) — de ahí que no
  se puedan modificar miembros ni llamar métodos no-const desde dentro. Use for: Bloque 8.
- [isocpp.org: Const correctness FAQ](https://isocpp.org/wiki/faq/const-correctness)
  `const` en member functions da comprobación en compilación sin coste en runtime. Use for:
  Bloque 8.
- [C++ Core Guidelines: R.3 — a raw pointer is non-owning](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)
  Principio formal detrás de `set::sb`: los raw pointers son observadores por defecto, no
  dueños. Use for: Bloque 9, por qué copiar el puntero en `set` es correcto.

## Gaps

- Ninguno abierto actualmente para forma canónica ortodoxa — resuelto con la entrada de CRySoL
  arriba.
