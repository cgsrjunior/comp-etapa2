/* Trabalho de Compiladores - Cleiber Rodrigues e Cintia Valente */
/* Cartões: 00270139 */

%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror (const char *message);
%}

%token CHAR COMMA FLOAT ID INT SEMI

%token TK_PR_INT
%token TK_PR_FLOAT
%token TK_PR_BOOL
%token TK_PR_IF
%token TK_PR_ELSE
%token TK_PR_WHILE
%token TK_PR_RETURN
%token TK_OC_LE
%token TK_OC_GE
%token TK_OC_EQ
%token TK_OC_NE
%token TK_OC_AND
%token TK_OC_OR
%token TK_OC_MAP
%token TK_IDENTIFICADOR
%token TK_LIT_INT
%token TK_LIT_FLOAT
%token TK_LIT_FALSE
%token TK_LIT_TRUE
%token TK_ERRO


%%

programa    : list_decl
            | ;
            ;            
        
list_decl   :  list_decl decl
            |  decl
            ;

decl        : list_var list_func ';'
            ;

list_var    : list_var var
            | var
            ;

var         : type list_id ';'
            ;

type        : TK_PR_INT
            | TK_PR_FLOAT
            | TK_PR_BOOL
            ;

list_func   : list_func func
            | func
            ;

list_id     : list_id ',' id_label
            | id_label
            ;

id_label: TK_IDENTIFICADOR;
func: '*';


%%
int yyerror (const char *message)
{
    printf("%s\n",message);
    return 1;
}