%{
    #include "stdio.h"
%}
%%
%token OP_ADD OP_SUB OP_MUL OP_DIV OP_MOD OP_EXPO
%token LP RP SC OP_ASSIGN DOT OpenBrace SBO SBC CloseBrace
%token ARR_LENGTH ARR_GET ARR_SET
%token MAIN FUNCTION RETURN OUTPUT OP_INPUT OP_OUTPUT INPUT
%token IF ELSE COMMENT_INIT OP_GT OP_GE OP_LT OP_LE OP_AND OP_OR WHILE
%token INT_TYPE ARR_TYPE INT STRING VAR COMMA

%left OP_ADD OP_SUB
%left OP_MUL OP_DIV OP_MOD
%right OP_EXPO
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
    ;
function_calling:
     FUNCTION LP var_list rp 
    | FUNCTION LP RP
    ;

var_list: 
    arithmetic_expr COMMA var_list
    | VAR SBO SBC var_list
    | arithmetic_expr 
    | VAR SBO SBC
    ;

input_stmt:
   INPUT OP_INPUT VAR SC
   ;

output_stmt:
      OUTPUT OP_OUTPUT arithmetic_expr
    | OUTPUT OP_OUTPUT STRING
    ;
return_stmt:
    RETURN arithmetic_expr
    ;

array_stmt:
    VAR DOT array_properties SC
    ;
array_properties:
    DOT ARR_SET LP INT COMMA INT RP
    | DOT ARR_LENGTH LP RP
    | DOT ARR_GET LP INT RP
    ;
while_stmt:WHILE LP logical_expr RP OpenBrace stmt_list CloseBrace
    ;
if_stmt:
    IF LP logical_expr RP OpenBrace stmt_list CloseBrace
    | IF LP logical_expr RP OpenBrace stmt_list CloseBrace ELSE OpenBrace stmt_list CloseBrace

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
type:
    INT_TYPE
    | ARR_TYPE
%%
int main(){
    yyparse();
    return 0;
}