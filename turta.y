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
    | OP_SUB arithmetic_expr %prec OP_UMINUS
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
    INT
    | INT SBO SBC