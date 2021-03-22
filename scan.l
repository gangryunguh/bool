%{
#include "y.tab.h"
extern int linenum;
%}



%%
(true|TRUE)     { yylval.val = -1; return TRUE; }
(false|FALSE)   { yylval.val = 0; return FALSE;}
[ \t]+          ;
\n              { linenum++; }
(and|AND)       { return AND;}
(or|OR)         { return OR;}
(not|NOT)       { return NOT;}
.               { return *yytext; }
