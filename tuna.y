%{
#include <stdio.h>

int lineno = 1;

void yyerror(const char *s) {
    fprintf(stderr, "Syntax error on line %d: %s\n", lineno, s);
}
%}

%token OP_ADD OP_SUB OP_MUL OP_DIV OP_MOD OP_EXPO NL
%token LP RP SC OP_ASSIGN DOT OpenBrace SBO SBC CloseBrace
%token ARR_LENGTH ARR_GET
%token MAIN FUNCTION RETURN OUTPUT OP_INPUT OP_OUTPUT INPUT
%token IF ELSE COMMENT_INIT OP_GT OP_GE OP_LT OP_LE OP_AND OP_OR WHILE
%token INT_TYPE ARR_TYPE INT STRING VAR

%left OP_ADD OP_SUB
%left OP_MUL OP_DIV OP_MOD
%left OP_EXPO
%nonassoc UMINUS

%%
program: function_list { printf("Input program is valid\n"); }
        ;

function_list: function_declaration function_list
             | main_declaration
             ;

function_declaration: FUNCTION VAR LP param_list RP OpenBrace stmt_list return_stmt SC CloseBrace
                   ;

main_declaration: FUNCTION MAIN LP RP OpenBrace stmt_list return_stmt SC CloseBrace
                ;

param_list: type VAR
          | type VAR COMMA param_list
          ;

stmt_list: stmt stmt_list
         | stmt
         ;

stmt: assign_stmt
    | if_stmt
    | function_calling_stmt
    | while_stmt
    | input_stmt
    | output_stmt
    | return_stmt
    | comment_stmt
    | function_calling_stmt
    | array_stmt
    ;

return_stmt: RETURN arithmetic_expr SC
           ;

comment_stmt: COMMENT_INIT COMMENT_TEXT
           ;

function_calling_stmt: VAR LP var_list RP
                   | VAR LP RP
                   ;

var_list: arithmetic_expr COMMA var_list
        | var BRACKETS COMMA var_list
        | arithmetic_expr
        | var BRACKETS
        ;

while_stmt: WHILE LP logical_expr RP OpenBrace stmt_list CloseBrace
           ;

if_stmt: IF LP logical_expr RP OpenBrace stmt_list CloseBrace
       | IF LP logical_expr RP OpenBrace stmt_list CloseBrace ELSE OpenBrace stmt_list CloseBrace
       ;

logical_expr: logical_expr OP_AND compare
            | compare
            ;

compare: arithmetic_expr OP_GT term
       | arithmetic_expr OP_GE term
       | arithmetic_expr OP_LT term
       | arithmetic_expr OP_LE term
       | arithmetic_expr OP_EQ term
       | arithmetic_expr OP_NE term
       | logical_expr OP_OR compare
       | logical_expr OP_AND compare
       ;

output_stmt: OUTPUT OP_OUTPUT arithmetic_expr SC
           | OUTPUT OP_OUTPUT STRING SC
           ;

input_stmt: INPUT OP_INPUT VAR SC
          ;

list_assignment: VAR SBO arithmetic_expr SBC OP_ASSIGN list
              ;

array_expr: VAR DOT array_properties
          ;

array_properties: ARR_ASSIGN LP arithmetic_expr COMMA arithmetic_expr RP
               | ARR_LENGTH LP RP
               | ARR_GET LP arithmetic_expr RP
               ;

list: SBO list_items SBC
    ;

list_items: list_items COMMA INT
          | INT
          ;

assign_stmt: VAR OP_ASSIGN arithmetic_expr SC
           | list_assignment
           ;

arithmetic_expr: arithmetic_expr OP_ADD factor
               | arithmetic_expr OP_SUB factor
               | factor
               ;

factor: factor OP_MUL mod_term
      | factor OP_DIV mod_term
      | mod_term
      ;

mod_term: mod_term OP_MOD expo_term
         | expo_term
         ;

expo_term: expo_term OP_EXPO term
         | term
         ;

term: VAR
     | INT
     | function_calling
     | array_term
     ;

array_term: VAR DOT ARRAY_PROPERTIES
           ;

type: INT
     | ARR_TYPE
     ;

param_list: type VAR
          | type VAR COMMA param_list
          ;

type: INT
     | ARR_TYPE
     ;

%%

int main() {
    yyparse();
    return 0;
}
