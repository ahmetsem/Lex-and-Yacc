%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
int entire_charecter[52];
int charecter_value(char ch);
void new_charecter(char ch,int sy);
int check(int,int,int);
void yyerror(char *w);
%}

%union{int num;char chc;}
%start stmts
%token print_ scan_ printc scanc
%token exit_ var
%token int_ char_
%token <num> if_ while_  number 
%token <chc> charecter
%type <num>  stmt expr term fact cond
%left '+' '-' '*' '/''>''<'
%left GREATER SMALLER 
%left NOTEQ EQOR 
%left OR AND
%right '='
%right '!'
%nonassoc lower_
%nonassoc else_

%%

stmts :exit_		{printf("Done\n"); exit(0);}
      |stmt stmts    	{;}
      ;


stmt :assign				{;}
     |print_ expr 			{printf("printed %d\n",$2);}
     |expr print_			{yyerror("output error");}
     |printc charecter			{printf("printed %c\n",$2);}
     |expr printc			{yyerror("output error");}
     |scanc charecter			{scanf("%c",&$2);} 
     |scan_ expr			{scanf("%d",&$2);}
     |charecter scanc			{yyerror("read error");}
     |expr scan_			{yyerror("read error");}
     |if_'('cond')'stmt	%prec lower_	{;}
     |if_'('cond')'stmt else_ stmt  	{;}
     |else_ stmt			{yyerror("condition error");}
     |while_'('cond')'stmt		{;}

;
assign:charecter'='expr		        {new_charecter($1,$3);}
      ;

cond:cond'>'expr			{check('>',$1,$3);}	
    |cond'<'expr			{check('<',$1,$3);}	
    |cond GREATER expr			{check(GREATER,$1,$3);}	
    |cond SMALLER expr			{check(SMALLER,$1,$3);}	
    |cond NOTEQ   expr			{check(NOTEQ,$1,$3);}	
    |cond EQOR    expr			{check(EQOR,$1,$3);}	
    |cond OR 	  cond			{check(OR,$1,$3);}	
    |cond AND     cond			{check(AND,$1,$3);}	
    |expr				{$$=$1;}
    ;

expr:term		{$$=$1;}
    |expr'+' term	{$$=$1+$3;}
    |expr'-' term	{$$=$1-$3;}
	;


term:fact		{$$=$1;}
    |term'*' fact	{$$=$1*$3;}
    |term'/' fact	{$$=$1/$3;if($3==0)yyerror("invaild operation");}
			
    ;				

fact:number	{$$=$1;}
    |charecter	{$$=charecter_value($1);}
    ;	

%%
int index_hesap(char token){
	int indx=-1;
	if(token>='a'&&token <='z'){
	indx=token-'a'+26;
	}
	else if(token>='A'&&token<='Z'){
	indx=token-'A'+26;
	}
 return indx;
}
int charecter_value(char ch){	
	int index=index_hesap(ch);
	return entire_charecter[index];
}

void new_charecter(char ch,int sy){
	int index=index_hesap(ch);
	entire_charecter[index]=sy;
}


int main(){
	yyparse();
	return 0;
}

int check(int oper,int num1,int num2){
	switch(oper){
	case '>':if(num1>=num2)return 1;else return 0;
	case '<':if(num1<=num2)return 1;else return 0;
	case GREATER:if(num1>num2)return 1;else return 0;
	case SMALLER:if(num1>num2)return 1;else return 0;
	case NOTEQ:if(num1!=num2)return 1;else return 0;
	case EQOR:if(num1==num2)return 1;else return 0;
	case AND:if(num1&&num2)return 1;else return 0;
	case OR:if(num1||num2)return 1;else return 0;

	}	
return 0;
}

void yyerror(char *s){	
	printf("%s\n",s);

}	




























	
												































