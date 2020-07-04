                global          _start

                SECTION         .text

_start:         mov             rcx, message
                mov             rdx, rcx

count:          cmp             byte [rdx], 0       ;Check for null byte
                jz              print               ;Found end of string
                inc             rdx                 ;check next char
                jmp             count

print:          sub             rdx, rcx            ;print syscall setup
                mov             rax, 4
                mov             rbx, 1
                int             0x80

                mov             rax, 1              ;sys_exit
                xor             rbx, rbx
                int             0x80


                SECTION         .data
message:        db              "Test: Hello World+ null byte scan!", 0xA