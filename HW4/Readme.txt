
Feature： 
    hw4.s是透過每次將指標指向A和B中的其中一行，兩兩相乘三次後，再累加存入r6。
    回到main之後，把D中的元素load進r9，再把它和r6相加，存回D中。
    最後將D中的元素用load/storage multiple系列的指令存入C的記憶體位置中。

Compile：
    $make    P.S.使用make中的 /foo/bin/arm-elf-gcc -g -O0 hw4.s -o hw4.exe





