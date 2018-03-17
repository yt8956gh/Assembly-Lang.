小寫轉大寫是透過讀取檔案中的字母到R8，
之後再用「小寫字母的ascii減32」存入write_param實現的。

$make 編譯成hw6.exe

$/.../foo/bin/arm-elf-insight 選取hw6.exe於Simulator運行。

$make clean 刪除執行檔
