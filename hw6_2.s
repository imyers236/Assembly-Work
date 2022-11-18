# ----------------------------------------
#   File: hw6_2.s
#   Description: Uses selection sort and the stack to sort a string of 10 digits
# ----------------------------------------

    .global _start
    .text

_start: jmp print1


begin:  movq    $str, %rbx  # moves the pointer of the first value into rbx
        movl    $10, %edx   # index
        movq    $10, %r10   # index for inner loop
        movq    $10, %r11    # index for outer loop
loop1:  movl    %r13d, %ecx
        cmpl    %edx, %ecx  # pushes all numbers to stack
        jl      input
        jmp     body        # moves to sort

input:  pushq   (%rbx)      # pushes onto stack then increments
        incq    %rbx
        addl    $1, %r13d
        jmp     loop1
        

body:   movq    %r9, %rcx    # moves outer counter to inter counter so numbers are not repeated
        movb    (%rsp, %rcx, 8), %al    # moves value to al
findMin:incq    %rcx         
        cmpq    %r10, %rcx   # makes sure counter is not out of numbers
        jge     place
        movb    (%rsp, %rcx, 8), %r8b   # moves value to r8b
        cmpb    %al, %r8b    # if r8b is less than al they will switch
        jl      switch
        cmpq    %r10, %rcx   # makes sure counter is not out of numbers
        jl      findMin      # reloops
        jmp     place        # jumps to place

switch: xchgb   %r8b, %al    # switchs smaller number to al
        movq    %rcx, %r12   # moves other numbers index to r12
        cmpq    %r10, %rcx   # makes sure counter is not out of numbers
        jl      findMin      # reloops
        jmp     place        # jumps to place

swap:   movb    (%rsp, %r9, 8), %r8b    # moves number about to be replaced to r8b
        movb    %r8b, (%rsp, %r12, 8)   # moves r8b to saved index
        jmp     cont         # continues with place

place:  movb    (%rsp, %r9, 8), %r14b     # moves number about to be replace to bl
        cmpb    %r14b, %al                # if al is not the same value as bl perform swap
        jne     swap
cont:   movb    %al, (%rsp, %r9, 8)     # moves value into index
        incq    %r9                     # increments index
        cmpq    %r11, %r9               # makes sure index is not out of space
        jl      body                    # reloops

        movq    $0, %r13
        movq    $str, %rbx              # puts original string pointer in rbx
loop3:  movq    %r13, %rcx                # resets ecx
        cmpl    %edx, %ecx              # pops all number back into the string 
        jl      output
        jmp     print2                  # pops number into string     
        jmp     done                    # jumps to done

output: popq    %r14
        movb    %r14b, (%rbx)        
        incq    %rbx                    
        addq    $1, %r13
        jmp     loop3



done:   #exit the program
        movq    $60, %rax
        xorq    %rdi, %rdi
        syscall

print1:   #write to stdout
        movq    $1, %rax
        movq    $1, %rdi
        movq    $str, %rsi
        movq    $len, %rdx
        syscall
        jmp begin

print2:   #write to stdout
        movq    $1, %rax
        movq    $1, %rdi
        movq    $str, %rsi
        movq    $len, %rdx
        syscall
        jmp done

        .data
str:    .ascii "3920184356\n"
        .equ len, (. - str)
        