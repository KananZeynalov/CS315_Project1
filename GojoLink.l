
/* Disabling yywrap for now to handle end of input by ourselves with ' quit' */
alphabetic	[A-Za-z]
numeric		[0-9]
sign [+-]

%%
Q			{printf("\n"); return 0;} /* All version of the ' quit ' accepted to leave program */
\+			{printf("%s", "OP_ADD " ); return OP_ADD;} 
-              		{printf("%s", "OP_SUB " );return OP_SUB;} 
\*              	{printf("%s", "OP_MUL " );return OP_MUL;} 
\/              	{printf("%s", "OP_DIV" );return OP_DIV;} 
\%                  {printf("%s","OP_MOD");return OP_MOD;}
\,                  {return COMMA;}
\*\*                {printf("%s","OP_EXPO"); return OP_EXPO;}
\n                  {printf("\n");lineno++;}
\(              	{printf("%s", "LP "); return LP;}
\)              	{printf("%s", "RP "); return RP;}
\;               	{printf("%s", "SC "); return SC;}
\=               	{printf("%s", "OP_ASSIGN ");return OP_ASSIGN;}
\.                  {printf("%s", "DOT"); return DOT;}
\{               	{printf("%s", "OpenBrace "); return OpenBrace;} 
\[                  {printf("%s", "SBO "); return SBO;}
\]                  {printf("%s", "SBC "); return SBC;}
\}               	{printf("%s", "CloseBrace "); return CloseBrace;}
length              {printf("%s","ARR_LENGTH"); return ARR_LENGTH;}
get                 {printf("%s","ARR_GET"); return ARR_GET;}
set           {printf("%s","ARR_ASSIGN "); return ARR_SET;}
main			{printf("%s","MAIN "); return MAIN;} /*starting of the program. Inside this function will be executed just like C*/
func		{printf("%s", "FUNCTION "); return FUNCTION; } /*function declaration start token*/
return			{printf("%s", "RETURN "); return RETURN;} /*Return token for function return stmt */
cout			{printf("%s","OUTPUT "); return OUTPUT;}
\>\>            {printf("%s","OP_INPUT"); return OP_INPUT;}
\<\<            {printf("%s","OP_OUTPUT"); return OP_OUTPUT;}
cin			{printf("%s","INPUT"); return INPUT;}
if              	{printf("%s", "IF "); return IF;}
else            	{printf("%s", "ELSE "); return ELSE;}
\#\"({alphabetic}|.)*\"	    {printf("%s","COMMENT");}
\>               	{printf("%s", "OP_GT "); return OP_GT;}
\>\=              	{printf("%s", "OP_GE "); return OP_GE;}  /* print statements can be changed */
\<               	{printf("%s", "OP_LT "); return OP_LT;}
\<\=              	{printf("%s", "OP_LE "); return OP_LE;} 
\&\&              	{printf("%s", "OP_AND "); return OP_AND;}
\|\|              	{printf("%s", "OP_OR "); return OP_OR;}
\=\=                {printf("%s", "OP_EQ "); return OP_EQ;}
while           	{printf("%s", "WHILE "); return WHILE;}
int			{printf("%s","INT_TYPE"); return INT_TYPE;}
int\[\]		    	{printf("%s","ARR_TYPE "); return ARR_TYPE;}
{numeric}+ 	    	{printf("%s","INT "); return INT;}
\"({alphabetic}|.)*\"    	{printf("%s", "STRING "); return STRING;} /* Detects String in quotation mark */
{alphabetic}({alphabetic}|{numeric})*	{printf("%s", "VAR "); return VAR;}
.		;

%%

int yywrap(){return 1;} 

