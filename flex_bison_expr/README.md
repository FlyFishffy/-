**#西电编译原理大作业（实验）**

---

#基于flex和bison实现基本的词法编译器，最终生成语法树

#前情提要：基本上所有班的作业都是做一个什么绘图的编译器，但是如果你和我一样，~~不幸的是这一个实验题目~~那么很高兴这些资料能帮助你，以下所有代码均在Arch Linux上实现，因为比windows方便很多

1.在Linux上下载flex和bison：

'sudo pacman -S flex bison'

如果你是centos则是'sudo dnf flex bison'

2.编译lexer.l和parser.y

​	1.'flex lexer.l' 	这会生成一个lex.yy.c文件

​	2.'bison -d parser.y'	这会生成parser.tab.c和parser.tab.h两个文件

3.联合编译生成可执行程序

​	1.‘gcc lex.yy.c parser.tab.c -o calc’	calc是生成的可执行程序的名字，可以随便起

​	2.'./calc'	运行程序，输入表达式**(我的文件中输入的是4 + 7 * (7 - 3) / 2， 你可以随意更改)**，运	行结果会输出result(计算结果), 和dot文档

​	3.'dot -Tpng syntax_tree.dot -o syntax_tree.png'	编译dot文档生成语法树图片

​	4.查看图片sysntax_tree.png
