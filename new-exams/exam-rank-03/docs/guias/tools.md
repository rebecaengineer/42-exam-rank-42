🔧 Herramienta 1: Valgrind (LA MEJOR para segfaults)
Valgrind te dice exactamente en qué línea ocurre el error.
Cómo usarlo:
--------------------------------------------------------
# 1. Compila con flag de debug (-g)
gcc -Wall -Wextra -Werror -g powerset.c -o powerset

# 2. Ejecuta con valgrind
valgrind ./powerset 3 1 0 2 4 5 3
Qué buscar en la salida:
==12345== Invalid write of size 4
==12345==    at 0x401234: backtraking (powerset.c:40)
==12345==    by 0x401567: main (powerset.c:102)
                                    ↑
                        Te dice la línea exacta


___________________________________________________________
🔧 Herramienta 2: gdb (Debugger paso a paso)
Si quieres ver exactamente qué está pasando:

# 1. Compila con -g
gcc -Wall -Wextra -Werror -g powerset.c -o powerset

# 2. Ejecuta con gdb
gdb ./powerset

# 3. Dentro de gdb:
(gdb) run 3 1 0 2 4 5 3
# → Crashea y te muestra dónde

# 4. Ver el stack trace
(gdb) backtrace
# → Te muestra la cadena de llamadas

# 5. Ver variables
(gdb) print index
(gdb) print subset_size
(gdb) print set_size