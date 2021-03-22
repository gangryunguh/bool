%{
#include <cstdio>

int linenum=1;

int yyparse();
void yyerror(char *);
int yylex();
%}

%union {
   unsigned char val;
}
    
%token OR AND NOT 
%token<val> TRUE FALSE
%type<val> exp term fact

%%
prog: stmts
    ;
stmts: 
    | stmts exp ';'  { if ($2) 
                         printf("TRUEEE\n");
                       else
                         printf("FALSEEEE\n");
                     }
    | ';'
    ;
exp: exp OR term     { $$ = $1 | $3;}
   | term            { $$ = $1; }
   ;
term : term AND fact { $$ = $1 & $3;}
   | fact            { $$ = $1;}
   ;
fact : NOT fact      { $$ = ~$2;}
     | '(' exp ')'   { $$ = $2;}
     | TRUE          { $$ = $1;}
     | FALSE         { $$ = $1;} 
     ;
%%
int main() {
   yyparse();
   return 0;
}

void yyerror(char *s) {
  fprintf(stderr, "%d.: %s\n", linenum, s);
}


