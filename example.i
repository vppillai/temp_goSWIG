/* example.i */
%module example
%{
/* Include the h file */
#include "example.h"
%}

/* Parse the header file to generate wrappers */
%include "example.h"
