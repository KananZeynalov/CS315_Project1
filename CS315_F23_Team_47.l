
/* Disabling yywrap for now to handle end of input by ourselves with ' quit' */
alphabetic	[A-Za-z]
numeric		[0-9]
sign [+-]

%%
\+			{return OP_ADD;} 
-              		{return OP_SUB;} 
\*              	{return OP_MUL;} 
\/              	{return OP_DIV;} 
\%                  {return OP_MOD;}
\,                  {return COMMA;}
\*\*                {return OP_EXPO;}
\n                  {extern int lineno; extern int stopflag;extern int linesno; if(!stopflag){linesno++;}lineno++;}
\(              	{return LP;}
\)              	{return RP;}
\;               	{extern int stopflag;extern int linesno;extern int linesno;stopflag=0;linesno = lineno;return SC;}
\=               	{return OP_ASSIGN;}
\:                  {return COLON;}
\{               	{extern int stopflag;extern int linesno;extern int linesno;stopflag=0;linesno=lineno;return OpenBrace;} 
\[                  {return SBO;}
\]                  {return SBC;}
\}               	{return CloseBrace;}
length              {return ARR_LENGTH;}
get                 {return ARR_GET;}
set           {return ARR_SET;}
main			{return MAIN;} /*starting of the program. Inside this function will be executed just like C*/
func		{extern int stopflag;stopflag = 1;return FUNCTION;} /*function declaration start token*/
return			{extern int stopflag;stopflag = 1;return RETURN;} /*Return token for function return stmt */
cout			{extern int stopflag;stopflag = 1;return OUTPUT;}
\>\>            {return OP_INPUT;}
\<\<            {return OP_OUTPUT;}
cin			{extern int stopflag;stopflag = 1;return INPUT;}
if              	{extern int stopflag;stopflag = 1; return IF;}
elif              	{extern int stopflag;stopflag = 1; return ELIF;}
else            	{return ELSE;}
\#\"({alphabetic}|.)*\"	    ;
\>               	{return OP_GT;}
\>\=              	{return OP_GE;}  /* print statements can be changed */
\<               	{return OP_LT;}
\<\=              	{return OP_LE;} 
\&\&              	{return OP_AND;}
\|\|              	{return OP_OR;}
\=\=                {return OP_EQ;}
while           	{extern int stopflag;stopflag = 1;return WHILE;}
int			{return INT_TYPE;}
int\[\]		    	{return ARR_TYPE;}
{numeric}+ 	    	{return INT;}
\"({alphabetic}|.)*\"    	{return STRING;} /* Detects String in quotation mark */
{alphabetic}({alphabetic}|{numeric})*	{extern int stopflag;stopflag = 1;return VAR;}
.		;

%%

int yywrap(){return 1;} 

