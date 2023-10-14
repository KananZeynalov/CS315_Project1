%option noyywrap  /* Disabling yywrap for now to handle end of input by ourselves with ' quit' */

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
print           {printf("%s", "PRINT ");}
if              {printf("%s", "if ");}
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