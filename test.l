%{
	#include <stdio.h>
	extern char *yytext;
	#include "y.tab.h"
%}

integer [-+]?[0-9]+
hexadecimal [-+]?0x[a-fA-F0-9]+
decimal [-+]?(([0-9]*\.[0-9]+)|([0-9]+\.[0-9]*))
scientific_notation_front {integer}|{decimal}
scientific_notation {scientific_notation_front}e{integer}
number ({integer}|{hexadecimal}|{decimal}|{scientific_notation})[fF]?

identifier [_a-zA-Z][_a-zA-Z0-9]*
%%
{number}		{return NUM;}
while			{return WHILE;}
break			{return BREAK;}
continue		{return CONTINUE;}
for				{return FOR;}
if				{return IF;}
else			{return ELSE;}
float			{return BASIC;}
int				{return BASIC;}
void			{return VOID;}
return			{return RETURN;}
main			{return MAIN;}

\+				{return ADD;}
\-				{return SUB;}
\<\=			{return LE;}
\>\=			{return GE;}
\=\=			{return EQ;}
\=				{return '=';}

\{				{return '{';}
\}				{return '}';}
\(				{return '(';}
\)				{return ')';}


\*				{return MUL;}
\/				{return DIV;}
{identifier}	{return IDEN;}

%%


