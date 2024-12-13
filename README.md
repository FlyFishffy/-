# **西电编译原理大作业（实验）**

## 基于Flex和Bison实现基本的词法编译器，最终生成语法树

### 前情提要：
基本上所有的作业都是做一个什么绘图的编译器，但是如果你和我一样，~~不幸的是你也是这一个实验题目~~，这些资料能帮助你。以下所有代码均在Arch Linux上实现，因为比Windows方便很多。


### 1. 在Linux下下载flex和bison：

```bash
sudo pacman -S flex bison
```
如果你是CentOS则是：
```
sudo dnf install flex bison
```

2. 编译lexer.l和parser.y

    编译 lexer.l 文件：
```
flex lexer.l
```

这会生成一个 lex.yy.c 文件。

编译 parser.y 文件：
```
    bison -d parser.y
```
这会生成 parser.tab.c 和 parser.tab.h 两个文件。

3. 联合编译生成可执行程序

    使用 gcc 编译：
```
gcc lex.yy.c parser.tab.c -o calc
```
这里 calc 是生成的可执行程序的名字，可以随便起。

运行程序，输入表达式：
```
    ./calc
```
例如输入：4 + 7 * (7 - 3) / 2，运行结果会输出 result（计算结果）和 dot 文档。

4. 生成语法树图片

    使用 dot 命令生成图片：
```
dot -Tpng syntax_tree.dot -o syntax_tree.png
```
查看生成的图片 syntax_tree.png。
