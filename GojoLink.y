%{
    #include "stdio.h"
%}
%%
%token OP_ADD OP_SUB OP_MUL OP_DIV OP_MOD OP_EXPO
%token LP RP SC OP_ASSIGN DOT OpenBrace SBO SBC CloseBrace
%token ARR_LENGTH ARR_GET
%token MAIN FUNCTION RETURN OUTPUT OP_INPUT OP_OUTPUT INPUT
%token IF ELSE COMMENT_INIT OP_GT OP_GE OP_LT OP_LE OP_AND OP_OR WHILE
%token INT_TYPE ARR_TYPE INT STRING VAR COMMA

%left OP_ADD OP_SUB
%left OP_MUL OP_DIV OP_MOD
%left OP_EXPO
%nonassoc UMINUS
%%
program: function_list {printf("Gojo: program is working");}
    ;
funciton_list: function_declaration NL function_list
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
    |NL
    ;
stmt:
    return_stmt
    | function_calling_stmt
    | while_stmt
    | assign_stmt
    | if_stmt
    | input_stmt
    | output_stmt
    | comment_stmt
    | function_calling_stmt
    | array_stmt
    ;

return_stmt:
    return arithmetic_expr
function_calling_stmt:
    VAR LP 
%%
int main(){
    yyparse();
    return 0;
}