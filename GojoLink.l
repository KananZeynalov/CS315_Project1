/* Disabling yywrap for now to handle end of input by ourselves with ' quit' */

%option noyywrap  

alphabetic	[A-Za-z]
numeric		[0-9]
sign [+-]

%%
Q			{printf("\n"); return 0;} /* All version of the ' quit ' accepted to leave program */
\+			{printf("%s", "OP_ADD " );} 
-              		{printf("%s", "OP_SUB " );} 
\*              	{printf("%s", "OP_MUL " );} 
\/              	{printf("%s", "OP_DIV" );} 
\(              	{printf("%s", "LP ");}
\)              	{printf("%s", "RP ");}
\;               	{printf("%s", "SC ");}
\=               	{printf("%s", "OP_ASSIGN ");}
\.                  {printf("%s", "DOT");}
\{               	{printf("%s", "OpenBrace ");} /* for now taking as string i think*/
\}               	{printf("%s", "CloseBrace ");}
length              {printf("%s","ARR_LENGTH");}
get                 {printf("%s","ARR_GET");}
OP_ASSIGN           {printf("%s", "ARR_ASSIGN ");}
main			{printf("%s","MAIN ");} /*starting of the program. Inside this function will be executed just like C*/
function		{printf("%s", "FUNCTION ");} /*function declaration start token*/
return			{printf("%s", "RETURN ");} /*Return token for function return stmt */
cout			{printf("%s","OUTPUT ");}
\>\>            {printf("%s","OP_INPUT");}
\<\<            {printf("%s","OP_OUTPUT");}
cin			{printf("%s","INPUT");}
if              	{printf("%s", "IF ");}
else            	{printf("%s", "ELSE ");}
\#			{printf("%s","COMMENT_INIT ");}
\>               	{printf("%s", "OP_GT ");}
\>\=              	{printf("%s", "OP_GE ");}  /* print statements can be changed */
\<               	{printf("%s", "OP_LT ");}
\<\=              	{printf("%s", "OP_LE ");}
\&\&              	{printf("%s", "OP_AND ");}
\|\|              	{printf("%s", "OP_OR ");}
while           	{printf("%s", "WHILE ");}
int			{printf("%s","INT_TYPE");}
int\[\]		    	{printf("%s","ARR_TYPE ");}
{numeric}+ 	    	{printf("%s","INT ");}
\"({alphabetic}|.)*\"    	{printf("%s", "STRING ");} /* Detects String in quotation mark */
{alphabetic}({alphabetic}|{numeric})*	{printf("%s", "VAR ");}
.		;

%%
int main(){
    yylex();
    return 0;
}
