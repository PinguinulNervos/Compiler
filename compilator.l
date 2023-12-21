%{
#include <stdio.h>
#include <stdlib.h>
#include "compilator.tab.h"
%}
%option noyywrap
%%
"int"|"float"|"char"|"bool"|"string"|"char" {yylval.string = strdup(yytext);return TYPE;}
"const" {return CONST;}
"struct" {return STRUCT;}
"class" {return CLASS;}
"begin_progr" {return begin_progr;}
"end_progr" {return end_progr;}
"begin_class" {return begin_class;}
"end_class"  {return end_class;}
"begin_struct" {return begin_struct;}
"end_struct" {return end_struct;}
[a-zA-Z][a-zA-Z0-9]* {yylval.string = strdup(yytext); return ID;}
[0-9]+ {return NR;}
[ \t] ;
"="    { return ASSIGN; }
\n {yylineno++;}
. {return yytext[0];}
