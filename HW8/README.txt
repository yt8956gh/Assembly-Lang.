Details:

# hw8 program will operate float number of matrix a,b,c in c code and record run time with timespec.

# hw8_SIMD program will operate float number of matrix a,b,c 
with x86 SIMD Intrinsic function and record run time with timespec.

# Because 202 is not multiple of 4, program will initialize AB and AC to zero first.
Therefore, 203 and 204 will not influence final sum.
Finally, I use a 204(51*4) times loop to deal with float number in a,b,c array.

Compile:

    gcc hw8_SIMD.c -o hw8_SIMD.exe
    gcc hw8.c -o hw8.exe

    make // compile with make

    make clear // remove files produced by make

Run:
    The necessary files had been writen in source code.
    Thus, user can run ./a.out directly.

GCC version:

    gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6 ubuntu1~16.04.4)

OS:

    OS: Mint 18.1 x86_64
    Kernel: 4.4.0-64-generic       
    CPU: Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz


    

    
