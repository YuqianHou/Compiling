
%{	
	#include <stdio.h>
	extern FILE *yyin;
%}
%token NUM WHILE BREAK CONTINUE FOR IF ELSE BASIC VOID RETURN MAIN ADD SUB LE GE EQ MUL DIV IDEN


%%
program : functions     {printf("program-->functions\n");}
;
functions : functions function  {printf("functions-->functions function\n");}
| function   {printf("functions-->functions function\n");}
;
function : type function_name parameter_list codeblocks   {printf("function-->type function_name parameter_list codeblocks\n");}
;
function_name : IDEN   {printf("function_name-->identifier\n");}
| MAIN    {printf("function-->main\n");}
;
parameter_list : '('variables')'   {printf("parameter_list-->(variables)\n");} 
| '('')'     {printf("parameter_list-->()\n");} 
;
codeblocks : '{'codeblocks stmt'}'	{printf("codeblocks-->codeblocks stmt\n");}
| stmt	{printf("codeblocks-->stmt\n");}
;
stmt : 
| if_stmt			{printf("stmt-->if_stmt\n");}
| loop_stmt			{printf("stmt-->loop_stmt\n");}
| jump_stmt			{printf("stmt-->jump_stmt\n");}
| invoking_stmt		{printf("stmt-->invoking_stmt\n");}
| assignment_stmt	{printf("stmt-->assignment_stmt\n");}
| definition_stmt	{printf("stmt-->definition_stmt\n");}
;
if_stmt : simple_if_stmt	{printf("if_stmt-->simple_if_stmt\n");}
| complex_if_stmt	{printf("if_stmt-->complex_if_stmt\n");}
;
simple_if_stmt : IF '('data')' codeblocks ELSE codeblocks	{printf("simple_if_stmt-->if (data) codeblocks else codeblocks\n");}
| IF '('data')' codeblocks	{puts("simple_if_stmt-->if (data) codeblocks");}
;
complex_if_stmt : IF '('data')' codeblocks ifs ELSE codeblocks {puts("complex_if_stmt-->if (data) codeblocks ifs else codeblocks");}
;
ifs : ifs ELSE IF codeblocks	{puts("ifs-->ifs else if codeblocks");}
| ELSE IF codeblocks	{puts("ifs-->else if codeblocks");}
;
loop_stmt : WHILE'('data')'codeblocks  {printf("loop_stmt-->while(data)codeblocks\n");}
| FOR'('assignment_stmt';'com_expr';'com_expr')'codeblocks    {printf("for(assignment_stmt;com_expr;com_expr)codeblocks\n");}
;
jump_stmt : CONTINUE {printf("jump_stmt-->continue;\n");}
| BREAK {printf("jump_stmt-->break;\n");}
| RETURN {printf("jump_stmt-->return;\n");}
| RETURN data {printf("jump_stmt-->return data;\n");}
;
invoking_stmt : IDEN parameter_list {printf("invoking_stmt-->IDEN parameter_list\n");}
;
definition_stmt : BASIC variable_stmt  {printf("definition_stmt-->basic right;\n");}
;
variable_stmt : variable_stmt assignment_stmt	{puts("variable_stmt-->variable_stmt assignment_stmt");}
;
variables : variables','IDEN	{puts("variables-->variables,identifier");}
| IDEN	{puts("variables--> identifier");}
;
assignment_stmt : assignment_stmt','IDEN'='data	{puts("assignment_stmt-->assignment_stmt,identifier=data");}
| IDEN'='data	{puts("assignment_stmt-->identifier=data");}
;
data : number	{puts("data-->number");}
| IDEN	{puts("data-->identifier");}
| com_expr	{puts("data-->com_expr");}
| '('BASIC')''('data')'	{puts("data--> basic data");}
;
com_expr : com_expr operator expr	{puts("com_expr-->com_expr operator expr");}
| '('com_expr operator expr')'	{puts("(com_expr-->com_expr operator expr)");}
| expr	{puts("com_expr-->expr");}
;
expr : data operator data	{puts("expr-->data operator data");}
| '('data operator data')'	{puts("expr-->(data operator data)");}
;
type : VOID  {printf("type-->void\n");}
| BASIC   {printf("type-->basic\n");}
;
operator : relation	{puts("operator-->relation");}
| calculation	{puts("operator-->calculation");}
;
relation : GE	{puts("relation--> >= ");}
| LE	{puts("relation--> <= ");}
| EQ	{puts("relation--> == ");}
calculation :  ADD {printf("calculation--> + \n");}
| SUB	{printf("calculation--> - \n");}
| MUL	{printf("calculation--> * \n");}
| DIV	{printf("calculation--> / \n");}
;




%%
int main(int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	if (!yyin){
		printf ("The file is not exit\n");
		return 0;
	}
	
	yyparse();
		
	
	fclose(yyin);
	return 0;
}
int yyerror(char *msg){
	printf("Error encountered: %s \n", msg);
}

int yywrap(){
	return 0;
}

