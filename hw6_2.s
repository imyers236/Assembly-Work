# ----------------------------------------
#   File: hw6_2.s
#   Description: ...
# ----------------------------------------

    .global _start
    .text

_start: 
        #... write our code here ...
        

        #write to stdout
        movq    $1, %rax
        movq    $1, %rdi
        movq    $str, %rsi
        movq    $len, %rdx
        syscall

        #exit the program
        movq    $60, %rax
        xorq    %rdi, %rdi
        syscall

        .data
str:    .ascii "helloworld\n"   #any string here
        .equ len, (. - str)
        