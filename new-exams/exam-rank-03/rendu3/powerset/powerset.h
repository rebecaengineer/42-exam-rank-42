#ifndef POWERSET_H
#define POWERSET_H

#include <stdio.h>
#include <stdlib.h>

// No se necesitan porque están todas en el archivo .c y antes del main.
void print_subset(int *subset, int size);

void backtrack(int *set, int *subset, int set_size, int subset_size, 
               int index, int current_sum, int target, int *found);

               int check_args(int argc, char **argv);

#endif