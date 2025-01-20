%{
#include <stdio.h>
#include <string.h>
int yylex();
void yyerror(const char *message);
int flag = 0;
int n = 0;
struct var{
	char* name;
	int val;
};
struct var arr[100];
%}
%union {
int ival;
char* c;
}
%token<ival> PRINTNUM
%token<ival> PRINTBOOL
%token <ival> INUMBER
%token <c> TRUE
%token <c> FALSE
%token <c> ID
%token <c> BOOL
%token <c> ADD
%token <c> SUB
%token <c> MUL
%token <c> DIV
%token <c> MOD
%token <c> GREAT
%token <c> SMALL
%token <c> EQUAL
%token <c> AND
%token <c> OR
%token <c> NOT
%token <c> IF
%token <c> DEFINE
%type <ival> stmt
%type <c> variable
%type <ival> exp
%type <ival> expa
%type <ival> expm
%type <ival> expand
%type <ival> expor
%%
program : program stmt
	|stmt
	;
stmt: exp
	;
exp :PRINTNUM exp {printf("%d\n", $2);} 
	|PRINTBOOL exp {
			if($2 == 1){
				printf("#t\n");
			}
			else{
				printf("#f\n");
			}
		}
	|ADD exp expa 	{$$ = $2 + $3;}
	|SUB exp exp	{$$ = $2 - $3;}
	|MUL exp expm	{$$ = $2 * $3;} 
	|DIV exp exp		{$$ = $2 / $3;}
	|MOD exp exp	{$$ = $2 % $3;}
	|GREAT exp exp {
		if($2 > $3){
			$$ = 1;
		}
		else{
			$$ = 0;
		}
	}
	|SMALL exp exp	{
		if($2 < $3){
			$$ = 1;
		}
		else{
			$$ = 0;
		}
	}
	|EQUAL exp exp	{
		if($2 == $3){
			$$ = 1;
		}
		else{
			$$ = 0;
		}
	}
	|AND exp expand	{
			if($2 == 1 && $3 == 1){
				$$ = 1;
			}
			else{
				$$ = 0;
			}
		}
	|OR exp expor	{
			if($2 == 0 && $3 == 0){
				$$ = 0;
			}
			else{
				$$ = 1;
			}
		}
	|NOT exp	{
			if($2 == 0){
				$$ = 1;
			}
			else{
				$$ = 0;
			}
		}
	|IF exp exp exp{
			if($2 == 1){
				$$ = $3;
			}
			else{
				$$ = $4;
			}
		}
	|DEFINE variable exp{
			arr[n].name = $2;
			arr[n].val = $3;
			n++;
		}
	| '(' exp ')'          {$$ = $2;}
	|TRUE	{$$ = 1;}
	|FALSE	{$$ = 0;}
	|variable	{
			int i=0;
			while(i < n){
				if(strcmp(arr[i].name, $1) == 0){
					$$ = arr[i].val;
				}
				i++;
			}
		}
	|INUMBER	{$$ = $1;}
	;
variable : ID	{$$ = $1;}
	;
expa : exp
	| exp expa{$$ = $1 + $2;}
	;
expm : exp
	| exp expm{$$ = $1 * $2;}
	;
expand : exp
	| exp expand{
		if($1 == 1 && $2 == 1){
				$$ = 1;
		}
		else{
			$$ = 0;
		}
	}
expor : exp
	| exp expor{
		if($1 == 0 && $2 == 0){
			$$ = 0;
		}
		else{
			$$ = 1;
		}
	}
%%
void yyerror (const char *message)
{
        printf ("syntax error\n");
	flag = 1;
}
int main(int argc, char *argv[]) {
        yyparse();
        return(0);
}