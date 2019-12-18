%{
	#include <stdio.h>
	int num = 0;
	
	int lines = 1;	
	extern char *yytext;
	extern FILE *yyin;
	enum yytokentype{
		KEYWORD = 1,
		FUNCTOR = 2,
		IDENTIFIERS = 3,
		BOUNDARY = 4,
		CONSTANT = 5,
		UNKNOWN = 6,
		ENTER = 7,
		SIGCOM = 8,
		LDOCCOM = 9,
		RDOCCOM = 10,
		SPACE = 11,
		EXCEPTION = -1,
		
	};
%}
keyword while|break|continue|for|if|else|float|int|void|return|main
functor (\+)|(\-)|(\*)|(\/)|=|>=|==|<=
identifiers [_a-zA-Z][_a-zA-Z0-9]*
boundary \(|\)|\{|\}|;
integer -?[0-9]*
decimal -?[0-9]*\.[0-9]*
enter [\n]+
invalidIdentifiers [0-9]+[_a-zA-Z]*
whitespace [ \t]+

singleComment (\/\/)
lDocCom (\/\*)
rDocCom (\*\/)
exception .
%%
{keyword} {return KEYWORD;}
{functor} {return FUNCTOR;}
{identifiers} {return IDENTIFIERS;}
{boundary} {return BOUNDARY;}
{integer} {return CONSTANT;}
{decimal} {return CONSTANT;}
{invalidIdentifiers} {return UNKNOWN;}
{enter} {return ENTER;}

{singleComment} {return SIGCOM;}
{lDocCom} {return LDOCCOM;}
{rDocCom} {return RDOCCOM;}
{whitespace} {return SPACE;}
{exception} {return EXCEPTION;}
%%
int main (int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	if (!yyin){
		printf ("The file is not exit\n");
		return 0;
	}
	while (num=yylex()){
		switch (num){
			case 1:{
				printf ("<$KEYWORD,%s>\n",yytext);
				break;
			};
			case 2:{
				printf ("<$FUNCTOR,%s>\n",yytext);
				break;
			};
			case 3:{
				printf ("<$IDENTIFIERS,%s>\n",yytext);
				break;
			};
			case 4:{
				printf ("<$BOUNDARY,%s>\n",yytext);
				break;
			};
			case 5:{
				printf ("<$CONSTANT,%s>\n",yytext);
				break;
			};	
			case 6:{
				printf ("<$UNKNOWN,%s>  CAN'T IDENTIFY THE TYPE OF [%s] IN %d LINES!!!\n",yytext,yytext,lines);
				break;
			};
			case 7:{
				lines++;
				break;
			};
			case 8:{
				int flag = -1;
				while (flag != 7){
					flag = yylex();
				}
				lines++;
				break;			
			};
			case 9:{
				int flag = -1;
				while (flag != 10){
					flag = yylex();
					if (flag == 7){
						lines++;
					}
				}
				break;
			};
			case 11:{
				break;
			}
			default:{
				printf ("<$UNKNOWN,%s>  CAN'T IDENTIFY THE TYPE OF [%s] IN %d LINES!!!\n",yytext,yytext,lines);
				
			}
		}
	
	}
	fclose(yyin);
	return 0;	
}
