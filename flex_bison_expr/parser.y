%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();

void yyerror(const char *s);

// 定义树节点结构
typedef struct Node {
    int id;
    const char *label;
    struct Node *left;
    struct Node *right;
} Node;

Node *create_node(const char *label, Node *left, Node *right);
void print_dot(Node *node, FILE *file);

int node_id = 0;
FILE *output_file;

// 将 YYSTYPE 定义为 Node* 类型
#define YYSTYPE Node*

%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%

input:
      /* empty */
    | input line
    ;

line:
    expr '\n' {
        Node *root = $1;
        output_file = fopen("syntax_tree.dot", "w");
        if (output_file) {
            fprintf(output_file, "digraph ARG {\n");
            print_dot(root, output_file);
            fprintf(output_file, "}\n");
            fclose(output_file);
            printf("Syntax tree written to syntax_tree.dot\n");
        } else {
            printf("Error opening file for writing.\n");
        }
        exit(0);  // 正常退出程序
    }
    | '\n'
    ;

expr:
    NUMBER {
        char *buffer = (char*)malloc(10);
        sprintf(buffer, "%d", yylval);
        $$ = create_node(buffer, NULL, NULL);
    }
    | expr '+' expr {
        $$ = create_node("+", $1, $3);
    }
    | expr '-' expr {
        $$ = create_node("-", $1, $3);
    }
    | expr '*' expr {
        $$ = create_node("*", $1, $3);
    }
    | expr '/' expr {
        $$ = create_node("/", $1, $3);
    }
    | '(' expr ')' {
        $$ = $2;
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

// 创建一个新的树节点
Node *create_node(const char *label, Node *left, Node *right) {
    Node *node = (Node *)malloc(sizeof(Node));
    node->id = node_id++;
    node->label = label;
    node->left = left;
    node->right = right;
    return node;
}

// 以 DOT 格式输出树
void print_dot(Node *node, FILE *file) {
    if (!node) return;

    fprintf(file, "    %d [label=\"%s\"];\n", node->id, node->label);

    if (node->left) {
        fprintf(file, "    %d -> %d [label=\"l\"];\n", node->id, node->left->id);
        print_dot(node->left, file);
    }
    if (node->right) {
        fprintf(file, "    %d -> %d [label=\"r\"];\n", node->id, node->right->id);
        print_dot(node->right, file);
    }
}

int main() {
    printf("Enter an expression: ");
    yyparse();  // 持续解析直到用户终止程序
    return 0;
}


