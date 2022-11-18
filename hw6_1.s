# ----------------------------------------
#   File: hw6_1.s
#   Description:flips 2 words to be the other way around
#
# ----------------------------------------

    .global _start
    .text

_start: 
                #... write our code here ...
                movq    $str, %rbx  # moves the pointer of the first value into rbx
                movb    (%rbx), %dl #puts the value at the pointer 
                movb    $32, %cl #moves blank space into rcx
                cmpb    %cl, %dl # compares the string bit to space
                jne     findSpace # if not equal it loops
                jmp     mainRotate # if equal it moves on



findSpace:      addq    $1, %rbx # adds one to pointer
                addq    $1, %r8  # adds one to index
                movb    (%rbx), %dl #puts the value at the pointer 
                cmpb    %cl, %dl # compares the string bit to space
                jne     findSpace # if not equal it loops
                jmp     moveSpace # once space is found jump to move space

moveSpace:      movq    $str, %rcx # moves the pointer of the first value into rcx
                movb    (%rbx), %dl # moves the space into dl
rotate1:        subq    $1, %rbx # traverses through the string backwards
                movb    (%rbx), %al # moves the value into al
                movb    %al, 1(%rbx) # moves al into next address
                cmpq    %rbx, %rcx  # sees whether rbx is at the beginning
                jne     rotate1 # if not repeat
                movb    %dl, (%rbx) # puts space at the beginning

                movq    %r8, %r9
                movb    $10, %r10b
wordLength:     addq    $1, %r9
                movb    (%rbx,%r9), %dl 
                cmpb    %r10b, %dl # compares the string bit to space
                jne     wordLength # if not equal it loops 
                subq    %r8, %r9
                subq    $1, %r9
                jmp     mainRotate

mainRotate:     movq    %r8, %r12
                addq    %r9, %r12
repeat:         movq    %r12, %r11
                movb    (%rbx,%r11), %dl # moves the space into dl
rotate2:        subq    $1, %r11 # traverses through the string backwards
                movb    (%rbx,%r11), %al # moves the value into al
                movb    %al, 1(%rbx,%r11) # moves al into next address
                cmpq    $0, %r11  # sees whether rbx is at the beginning
                jne     rotate2 # if not repeat
                movb    %dl, (%rbx) # puts space at the beginning
                subq    $1, %r9
                cmpq    $0, %r9
                jne     repeat


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
str:            .ascii "helicopter airplane\n"   #any string here
                .equ len, (. - str)
        