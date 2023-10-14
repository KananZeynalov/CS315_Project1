%option main
alphabetic	[A-Za-z]
numeric		[0-9]
%%
int|int\[\]	{printf("%s","TYPE");}
{numeric}+ 	{printf("%s","INT");}
{alphabetic}({alphabetic}|{numeric})*	{printf("%s", "var");}
.		;
