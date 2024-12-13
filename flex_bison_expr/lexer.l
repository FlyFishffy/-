%{
#include "parser.tab.h"  // 引入由 Bison 生成的头文件
#define YY_NO_UNPUT
%}

%%

[0-9]+          { yylval = atoi(yytext); return NUMBER; }
[+\-*/]         { return yytext[0]; }
[ \t]           ;             // 忽略空格
\n              { return '\n'; }  // 处理换行符
.               { return yytext[0]; } // 匹配其他字符

%%

int yywrap() {
    return 1;
}
