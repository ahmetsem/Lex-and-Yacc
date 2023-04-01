%{
	#include"y.tab.h"
	void yyerror(char *w);
	
%}

%%
"read"		{return scan_;}
"readc"		{return scanc;}
"output"	{return print_;}
"outputc"	{return printc;}
"end"		{return exit_;}   
"while"		{return while_;}
"if"		{return if_;}
"or"		{return else_;} 			 
[a-zA-Z]	{yylval.chc=yytext[0]; return charecter;}
[0-9]+		{yylval.num=atoi(yytext); return number;}
[-+*/<>!(){}=;]	{return yytext[0];}
[ \t\n]		;
">>"		{return GREATER;}
"<<"		{return SMALLER;}
"?="		{return EQOR;}
"!="    	{return NOTEQ;}
"||"		{return OR;}
"&&"		{return AND;}
"//"		;

.		{ECHO;printf("Tanımlanamayan isaret\n");}
%%

int yywrap(void){
return 1;
}



