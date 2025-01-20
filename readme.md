# Mini-LISP-interpreter

109502007 張原鳴
實作項目:
1. Syntax validation
2. Print
3. Numerical operations
4. Logical operations
5. if Expression
6. Variable definition

## 編譯
### compile bison
bison -d -o y.tab.c lisp.y
gcc -c -g -I.. y.tab.c
### compile flex
flex -o lex.yy.c lisp.l
gcc -c -g -I.. lex.yy.c
### compile and link bison and flex
gcc -o lisp y.tab.o lex.yy.o -ll
### alan.sh
#### 內容
file="lisp" // .l, .y 檔名

bison -d -o y.tab.c

gcc -c -g -

fl y.tab.c 

flex -o lex.yy.c ${file}.l

gcc -c -g -I.. lex.yy.c 

gcc -o {file} y.tab.o lex.yy.o -ll -lm

./${file} < input.txt // 測資檔名

## 實作

在終端機輸入 sh alan.sh即可編譯及執行。






 
 