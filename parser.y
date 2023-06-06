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

decl        : list_var list_func
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

list_id     : list_id ',' id_label
            | id_label
            ;

list_func   : list_func func
            | func
            ;

func        : header body
            ;

header      : name_func '(' list_param ')' TK_OC_MAP type

list_param  : list_param ',' id_param
            | id_param
            ;

body        : '{' list_cmd '}'
            ;

list_cmd    : list_cmd cmd
            | cmd
            ;

cmd         : cmd_var
            | cmd_atrib
            | cmd_func_call
            | cmd_return
            | cmd_flux_ctrl
            ;

cmd_flux_ctrl   : TK_PR_IF '(' expr ')' body
                | TK_PR_IF '(' expr ')' body TK_PR_ELSE body
                | TK_PR_WHILE '(' expr ')' body

cmd_func_call: name_func '(' list_arg ')' ';'
             ;

expr        : '-' expr           {$$ = -$1;}
            | '!' expr              {$$ = !$1;}
            | expr '*' expr         {$$ = $1 * $3;}
            | expr '/' expr         {$$ = $1 / $3;}
            | expr '%' expr         {$$ = $1 % $3;}
            | expr '+' expr         {$$ = $1 + $3;}
            | expr '-' expr         {$$ = $1 - $3;}
            | expr '<' expr         {$$ = $1 < $3;}
            | expr '>' expr         {$$ = $1 > $3;}
            | expr TK_OC_LE expr         {$$ = $1 <= $3;}
            | expr TK_OC_GE expr         {$$ = $1 >= $3;}
            | expr TK_OC_EQ expr         {$$ = $1 == $3;}
            | expr TK_OC_NE expr         {$$ = $1 != $3;}
            | expr TK_OC_AND expr        {$$ = $1 && $3;}
            | expr TK_OC_OR expr         {$$ = $1 || $3;}
            | operand
            ;

operand     : id_label
            | lit
            | cmd_func_call
            ;


list_arg    : list_arg ',' expr
            | expr
            ;

cmd_return  : TK_PR_RETURN expr ';'
            ;

cmd_atrib   : id_label '=' expr ';'
            ;

cmd_var     : atrib_var  ';'
            ;

atrib_var   : type list_id_atrib
            ;

list_id_atrib   : list_id_atrib ',' id_atrib
                | id_atrib
                ;

id_atrib        : id_label TK_OC_LE lit
                | id_label
                ;

lit             : TK_LIT_INT
                | TK_LIT_FLOAT
                | TK_LIT_TRUE
                | TK_LIT_FALSE
                ;


id_label: TK_IDENTIFICADOR;
name_func: TK_IDENTIFICADOR;
id_param: type TK_IDENTIFICADOR;


%%
int yyerror (const char *message)
{
    printf("%s\n",message);
    return 1;
}