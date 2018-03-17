內容：
    hw3.s中使用CMP去判斷R0的正負，
    之後再用帶有MI和PL條件的指令去判斷是否執行
    （1）負轉正後將結果丟R2
     或
    （2）直接將正數丟到R2

編譯程式：
    /foo/bin/arm-elf-gcc -g -O0 hw3.s -o hw3.exe

程式的執行環境：
    ARM Simulator on Linux Mint 18.1 Serena

執行：

    (1)/foo/bin/arm-elf-insight 開啟GUI

    (2)設定Target為Simulator

    (3)run hw3.exe

    (4)執行完 "MOV r0, #-100" 後可以直接將r0的值用GUI更改
    

