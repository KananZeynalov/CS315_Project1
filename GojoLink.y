%{
    #include <stdio.h>
    int lineno = 1;
    void yyerror(const char *s);
    int yylex();
    int valid = 1;

%}

%token OP_ADD OP_SUB OP_MUL OP_DIV OP_MOD OP_EXPO
%token LP RP SC OP_ASSIGN DOT OpenBrace SBO SBC CloseBrace
%token ARR_LENGTH ARR_GET ARR_SET
%token MAIN FUNCTION RETURN OUTPUT OP_INPUT OP_OUTPUT INPUT
%token IF ELSE OP_GT OP_GE OP_LT OP_LE OP_AND OP_OR WHILE OP_EQ
%token INT_TYPE ARR_TYPE INT STRING VAR COMMA

%left OP_LT OP_LE OP_GT OP_GE
%left OP_EQ
%left OP_AND
%left OP_OR

%left OP_ADD OP_SUB
%left OP_MUL OP_DIV OP_MOD
%right OP_EXPO
%nonassoc UMINUS
%%
program: function_list {printf("Gojo: program is working");}
    ;
function_list: function_declaration function_list
    | main_declaration {printf("we are in the main");}
    ;
function_declaration: FUNCTION LP param_list RP OpenBrace stmt_list CloseBrace
    | FUNCTION LP RP OpenBrace stmt_list CloseBrace
    ;
main_declaration: FUNCTION MAIN LP RP OpenBrace stmt_list CloseBrace

param_list: type VAR COMMA param_list
    | type VAR
    ;
stmt_list: stmt SC stmt_list 
    | stmt SC {printf("We are in statement");}

    ;
stmt:
    return_stmt
    | while_stmt
    | assign_stmt
    | if_stmt
    | input_stmt {printf("Input Stmt found!");}
    | output_stmt
    | array_stmt
    error { yyerror("Invalid statement"); }
    ;

return_stmt:
    RETURN arithmetic_expr
    ;
function_calling:
     FUNCTION LP var_list RP
    | FUNCTION LP RP
    ;

var_list: 
    arithmetic_expr COMMA var_list
    | VAR SBO SBC var_list
    | arithmetic_expr 
    | VAR SBO SBC
    ;

input_stmt:
   INPUT OP_INPUT VAR
   ;

output_stmt:
      OUTPUT OP_OUTPUT arithmetic_expr
    | OUTPUT OP_OUTPUT STRING
    ;

array_stmt:
    VAR array_properties
    ;
array_properties:
    DOT ARR_SET LP arithmetic_expr COMMA arithmetic_expr RP
    | DOT ARR_LENGTH LP RP
    | DOT ARR_GET LP arithmetic_expr RP
    ;
while_stmt:WHILE LP logical_expr RP OpenBrace stmt_list CloseBrace
    ;
if_stmt:
    IF LP logical_expr RP OpenBrace stmt_list CloseBrace
    | IF LP logical_expr RP OpenBrace stmt_list CloseBrace ELSE OpenBrace stmt_list CloseBrace
    ;
assign_stmt:
    VAR OP_ASSIGN arithmetic_expr 
    | list_assignment
    ;
list_assignment:
    VAR SBO INT SBC OP_ASSIGN list
    ;
list:
    SBO list_items SBC
    ;
list_items: list_items COMMA INT
          | INT
          ;

arithmetic_expr:
    term
    | arithmetic_expr OP_ADD arithmetic_expr
    | arithmetic_expr OP_SUB arithmetic_expr
    | arithmetic_expr OP_MUL arithmetic_expr
    | arithmetic_expr OP_DIV arithmetic_expr
    | arithmetic_expr OP_MOD arithmetic_expr
    | arithmetic_expr OP_EXPO arithmetic_expr 
    | LP arithmetic_expr RP
    ; 
logical_expr:
    term OP_LE term
    | term OP_GE term
    | term OP_LT term
    | term OP_EQ term
    | logical_expr OP_AND logical_expr
    | logical_expr OP_OR logical_expr
term:
    INT
    | VAR
    | array_term
    | function_calling
    ;
array_term:
    VAR array_properties
    ;
type:
    INT_TYPE
    | ARR_TYPE
%%
#include "lex.yy.c"
void yyerror(const char *s); /* this one is required by YACC */



int main(){

    /* while(1){*/
        
        yyparse();

         /* if (feof(stdin)) {
            break;  // No more input, exit the loop ; fuck this shit tuna did not work 
        }*/

        if(valid){
            printf("Program is valid!\n");
        }

       // }
    return 0;
}
void yyerror(const char *s) {
    fprintf(stderr, "Syntax error on line %d: %s\n", lineno, s);
    valid = 0;
}