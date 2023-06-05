/* Trabalho de Compiladores - Cleiber Rodrigues e Cintia Valente */
/* Cartões: 00270139 */

%{
int yylex(void);
void yyerror (char const *s);
%}

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
            ;
        
list_decl   : decl list_decl
            |
            ;

decl        : list_var decl
            | list_var list_func
            ;

list_func   : func list_func 
            |
            ;

func        : header_func body_func
            ;

header_func : name_func '(' list_param ')' TK_OC_MAP type
            ;

list_param  : param ',' list_param
            | param
            |
            ;

param       : type ID
            ;

body_func   : list_cmd
            ;

list_cmd    : '{' cmd list_cmd '}'
            |
            ;

cmd         : expr
            ;

expr        : '-' expr              { $$ = - $1}
            | '!' expr              { $$ = !$1}
            | expr '+' expr	        { $$ = $1 + $3; }
		    | expr '-' expr	        { $$ = $1 - $3; }
		    | expr '*' expr	        { $$ = $1 * $3; }
            | expr '/'  expr	    { $$ = $1 / $3; }
            | expr '%'  expr	    { $$ = $1 % $3; }
            | expr '<'  expr	    { $$ = $1 < $3; }
            | expr '>'  expr	    { $$ = $1 > $3; }
            | expr '%'  expr	    { $$ = $1 % $3; }
            | expr '<' '='  expr	{ $$ = $1 <= $3; }
            | expr '>' '='  expr	{ $$ = $1 >= $3; }
            | expr '=' '='  expr	{ $$ = $1 == $3; }
            | expr '!' '='  expr	{ $$ = $1 != $3; }
            | expr '|' '|'  expr	{ $$ = $1 || $3; }
            | ID
		    ;

list_var    : list_var variable_decl
            |
            ;            

type        : TK_LIT_INT
            | TK_LIT_FLOAT
            | tk_lit_bool
            ;

tk_lit_bool : TK_LIT_TRUE
            | TK_LIT_FALSE
            ;

variable_decl : type list_id ';'

list_id       : ID list_id
              |
              ;


%%
