#ifndef VBC_H
#define VBC_H


typedef struct node {
    enum {
        ADD,
        MULTI,
        VAL
    }   type;
    int val;
    struct node *l;
    struct node *r;
}   node;

node *parse_factor(char **s);
node *parse_term(char **s);
node *parse_expr_inner(char **s);

#endif