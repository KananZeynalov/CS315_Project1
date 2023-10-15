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
\*\*                {printf("%s", "OP_EXPO);}
\%                  {printf("%s", "OP_MOD");}
\/              	{printf("%s", "OP_DIV" );} 
\(              	{printf("%s", "LP ");}
\)              	{printf("%s", "RP ");}
\;               	{printf("%s", "END_STMT ");}
\[                  {printf("%s", "SBO")}
\]                  {printf("%s", "SBC")}
\=               	{printf("%s", "OP_ASSIGN ");}
\{               	{printf("%s", "OpenBrace ");} /* for now taking as string i think*/
\}               	{printf("%s", "CloseBrace ");}
print           	{printf("%s", "PRINT ");}
if              	{printf("%s", "IF ");}
else            	{printf("%s", "ELSE ");}
\>               	{printf("%s", "OP_GT ");}
\>\=              	{printf("%s", "OP_GE ");}  /* print statements can be changed */
\<               	{printf("%s", "OP_LT ");}
\<\=              	{printf("%s", "OP_LE ");}
\&\&              	{printf("%s", "OP_AND ");}
"||"              	{printf("%s", "OP_OR ");}
while           	{printf("%s", "WHILE ");}
int|int\[\]	    	{printf("%s","TYPE ");}
{numeric}+ 	    	{printf("%s","INT ");}
\"({alphabetic}|{numeric})*\"    	{printf("%s", "STRING ");} /* Detects String in quotation mark */
{alphabetic}({alphabetic}|{numeric})*	{printf("%s", "VAR ");}
.		;

%%
int main(){
    yylex();
    return 0;
}
