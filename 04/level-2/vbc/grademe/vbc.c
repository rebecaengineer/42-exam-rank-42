
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "vbc.h"

node    *new_node(node n)
{
    node *ret = calloc(1, sizeof(n));
    if (!ret)
        return (NULL);
    *ret = n;
    return (ret);
}

void    destroy_tree(node *n)
{
    if (!n)
        return ;
    if (n->type != VAL)
    {
        destroy_tree(n->l);
        destroy_tree(n->r);
    }
    free(n);
}

void    unexpected(char c)
{
    if (c)
        printf("Unexpected token '%c'\n", c);
    else
        printf("Unexpected end of input\n");
}

int accept(char **s, char c)            //si es caracter consumelo y avanza (silencioso si falla)
{                                       //se usa para buscar digitos, operaciones y la apertura del paréntesis
    if (**s == c)
    {
        (*s)++;
        return (1);
    }
    return (0);
}

int expect(char **s, char c)            //tiene que ser este caracter, si no lo es, error" (grita si falla)
{                                       //se usa para buscar el cierre del paréntesis, si no lo hay hay que decirlo.
    if (accept(s, c))
        return (1);
    unexpected(**s);
    return (0);
}

//...

// ---- FUNCION 1: lee un numero o un parentesis ----
node *parse_factor(char **s)
{
    if (isdigit(**s))                             // si es digito (0-9)
        return new_node((node){                   // crea nodo hoja
            VAL,                                  // tipo: valor
            *(*s)++ - '0',                        // lee el digito, convierte a int, avanza
            NULL, NULL                            // sin hijos (es hoja)
        });
    if (accept(s, '('))                           // si es '(' -> consume el '('
    {
        node *ret = parse_expr_inner(s);          // parsea todo lo de dentro
        if (!ret)                                 // si fallo
            return NULL;
        if (!expect(s, ')'))                      // busca ')'. Si no esta -> error
        {
            destroy_tree(ret);                    // limpia memoria
            return NULL;
        }
        return ret;                               // devuelve lo de dentro
    }
    unexpected(**s);                              // no es digito ni '(' -> error
    return NULL;
}

// ---- FUNCION 2: agrupa multiplicaciones ----
node *parse_term(char **s)
{
    node *ret = parse_factor(s);                  // lee primer factor
    if (!ret)
        return NULL;
    while (accept(s, '*'))                        // mientras haya '*' -> consume
    {
        node *right = parse_factor(s);            // lee siguiente factor
        if (!right)
        {
            destroy_tree(ret);
            return NULL;
        }
        ret = new_node((node){MULTI, 0, ret, right});  // une: ret * right
    }
    return ret;
}

// ---- FUNCION 3: agrupa sumas (version doble puntero) ---- // Es lo mismo que parse_expr pero recibe char **s // La necesitas porque parse_factor la llama dentro de ()
node *parse_expr_inner(char **s)
{
    node *ret = parse_term(s);                    // lee primer termino
    if (!ret)
        return NULL;
    while (accept(s, '+'))                        // mientras haya '+' -> consume
    {
        node *right = parse_term(s);              // lee siguiente termino
        if (!right)
        {
            destroy_tree(ret);
            return NULL;
        }
        ret = new_node((node){ADD, 0, ret, right});    // une: ret + right
    }
    return ret;
}

// ---- FUNCION 4: parse_expr (la que llama main) ----
// Recibe char *s (un solo puntero) porque main la llama con argv[1]
node *parse_expr(char *s)
{
    node *ret = parse_expr_inner(&s);             // pasa &s para convertir a char **
    if (!ret)
        return NULL;
    if (*s)                //codigo dado          // si quedan caracteres sin parsear
    {
        unexpected(*s);                           // error: caracter sobrante
        destroy_tree(ret); //dado
        return NULL;       //dado
    }
    return ret;             //dado
}

int eval_tree(node *tree)
{
    switch (tree->type)
    {
        case ADD:
            return (eval_tree(tree->l) + eval_tree(tree->r));
        case MULTI:
            return (eval_tree(tree->l) * eval_tree(tree->r));
        case VAL:
            return (tree->val);
    }
    return 0;           //FALTA
}

int main(int argc, char **argv)
{
    if (argc != 2)
        return (1);
    node *tree = parse_expr(argv[1]);
    if (!tree)
        return (1);
    printf("%d\n", eval_tree(tree));
    destroy_tree(tree);
}