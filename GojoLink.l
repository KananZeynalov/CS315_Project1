/* Disabling yywrap for now to handle end of input by ourselves with ' quit' */

%option noyywrap  

alphabetic	[A-Za-z]
numeric		[0-9]
sign [+-]

%%
[Qq][Uu][Ii][Tt] {printf("\n"); return 0;} /* All version of the ' quit ' accepted to leave program */
\+              {printf("%s", "OP " );} 
\-              {printf("%s", "OP " );} 
\*              {printf("%s", "OP " );} 
\/              {printf("%s", "OP " );} 
\(              {printf("%s", "LP ");}
\)              {printf("%s", "RP ");}
;               {printf("%s", "SC ");}
=               {printf("%s", "ASSIGN ");}
"{"               {printf("%s", "openBrace ");} /* for now taking as string i think*/
"}"               {printf("%s", "closeBrace ");}
print           {printf("%s", "PRINT ");}
if              {printf("%s", "if ");}
else            {printf("%s", "else ");}
\>               {printf("%s", "greater ");}
\>=              {printf("%s", "greater or equal ");}  /* print statements can be changed */
\<               {printf("%s", "smaller ");}
\<=              {printf("%s", "smaller or equal ");}
\&&              {printf("%s", "and ");}
"||"              {printf("%s", "or ");}
while           {printf("%s", "while ");}
int|int\[\]	    {printf("%s","TYPE ");}
{numeric}+ 	    {printf("%s","INT ");}
\"[^\"\n]*\"    {printf("%s", "STRING ");} /* Detects String in quotation mark */
{alphabetic}({alphabetic}|{numeric})*	{printf("%s", "var ");}
.		;

%%
int main(){
    yylex();
    return 0;
}