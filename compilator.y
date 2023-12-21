%{
#include <iostream>
#include <vector>
#include "IdList.h"
#include <cstdlib>
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
extern int yylex();
void yyerror(const char * s);
class IdList ids;
%}
%union {
     char* string;
}
%token  begin_progr end_progr ASSIGN NR 
%token begin_struct end_struct
%token begin_class end_class
%token<string> ID TYPE
%token CONST STRUCT CLASS
%start progr

%left '+' '-'
%left '*' '/'
%%
progr: declarations block {printf("Your program it's syntactically correct!\n");}
     ;

declarations :  decl ';'          
	      |  declarations decl ';'   
	      ;

decl       :  TYPE ID { if(!ids.existsVar($2)) {
                          ids.addVar($1,$2);
                     }
                     else{
                         yyerror("Variable already declared!\n");
                     }
                    }
           | CONST TYPE ID {
                 if(!ids.existsVar($3)){
                     ids.addVar($2,$3);
                 }
                 else{
                    yyerror("Variable already declared!\n");
                 }
             }
           | TYPE ID '(' list_param ')'  
           | TYPE ID '(' ')' 
           | TYPE ID '['NR']' {if (!ids.existsArray($2)){
                                  // ids.addArray($1,$2,$4);
                                 }  
                              }
           | struct_block 
           | class_block
           ;

struct_block : begin_struct ID struct_decl end_struct  { if(!ids.existsStructs($2)){
                                  ids.addStruct($2);
                            }
                            else{
                              yyerror("Struct already declared!\n");
                            }                

                     }
            ;

struct_decl : s_decl ';' 
            | struct_decl s_decl ';'
            ;

class_block : begin_class ID class_decl end_class  { if(!ids.existsClass($2)){
                                  ids.addClass($2);
                            }
                            else{
                              yyerror("Class already declared!\n");
                            }                

                     }
            ;

class_decl  : c_decl ';'
            | class_decl c_decl ';'
            ;

list_param : param
            | list_param ','  param 
            ;

s_decl : TYPE ID  
       | CONST TYPE ID 
       | TYPE ID'[' NR ']' 
       
       ;

c_decl : TYPE ID 
       | CONST TYPE ID
       | TYPE '[' NR ']'
       ;
            
param : TYPE ID 
      | CONST TYPE ID
     ;
      

block : begin_progr list end_progr  
     ;
     

list :  statement ';' 
     | list statement ';'
     ;


statement: ID ASSIGN  e { if(!ids.existsVar($1)){
                          yyerror("The variable has not been declared!");
                        } 
                    }
          | ID '(' call_list ')'
          | id_struct ASSIGN e
          ;

id_struct: ID '.' ID
         ;


e: e '+' e
 | e '-' e
 | e '*' e
 | '(' e ')'
 | NR
 | ID {if(!ids.existsVar($1) ){
          yyerror("The variable has not been declared!");
       }
    }
 ;

call_list : e
           | call_list ',' e
           ;
%%
void yyerror(const char * s){
printf("error: %s at line:%d\n",s,yylineno);
exit(1);
}

int main(int argc, char** argv){
     yyin=fopen(argv[1],"r");
     yyparse();
     cout << "Variables:" <<endl;
     ids.printVars();
    
} 
