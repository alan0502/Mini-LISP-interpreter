%{
#include "y.tab.h"
%}

%%
\n        {}
[ \t]+ {}
print\-num	{return PRINTNUM;}
print\-bool	{return PRINTBOOL;}
\+	{return ADD;}
\-	{return SUB;}
\*	{return MUL;}
\/	{return DIV;}
mod	{return MOD;}
\>	{return GREAT;}
\<	{return SMALL;}
\=	{return EQUAL;}
and	{return AND;}
or	{return OR;}
not	{return NOT;}
if	{return IF;}
define	{return DEFINE;}
\#t	{return TRUE;}
\#f	{return FALSE;}
0|[1-9][0-9]*|-[1-9][0-9]*		{yylval.ival = atoi(yytext);return(INUMBER);}
[a-z]([a-z]|[0-9]|‘-’)*	{yylval.c = strdup(yytext);return ID;}
.	      { return(yytext[0]); }
%%