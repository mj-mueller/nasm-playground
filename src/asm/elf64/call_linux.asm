; call test
global _start

SECTION .text
_start:
                mov             rax, 423
                call            printString
                jmp             exit



printString:    push            rax                 ;Save registers
                push            rbx
                push            rcx
                push            rdx
                mov             rcx, message
                mov             rdx, rcx

count:          cmp             byte [rdx], 0       ;Check for null byte
                jz              print               ;Found end of string
                inc             rdx                 ;check next char
                jmp             count

print:          sub             rdx, rcx            ;print syscall setup
                mov             rax, 4
                mov             rbx, 1
                int             0x80

                pop             rdx
                pop             rcx
                pop             rbx
                pop             rax
                ret

exit:           mov         rax, 1
                mov         rbx, 42         ; exit code 42
                int         0x80            ; interrupt for syscall


                SECTION         .data
message:        db              "Test: Hello World+ null byte scan!", 0xA