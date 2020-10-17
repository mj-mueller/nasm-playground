exit:                                               ; exit program with exit code 0
                mov             rax, 1
                xor             rbx, rbx            ; exit code 0
                int             0x80                ; interrupt for syscall
                ret


printS:                                             ;Prints a string starting at memory address in rax
                push            rbx                 ;Save register
                push            rcx
                push            rdx
                call            slen
                mov             rcx, rax            ; Move message to rcx for syscall
                mov             rax, 4              ; sys_write syscall
                mov             rbx, 1
                int             0x80
                mov             rax, rcx            ;recover rax from rcx
                pop             rdx
                pop             rcx
                pop             rbx
                ret

slen:                                               ;saves string length in rdx; expects msg in rax
                mov             rdx, rax            ;compare register
count:          cmp             byte [rdx], 0       ;Check for null byte
                jz              breakSLength        ;Found end of string
                inc             rdx                 ;check next char
                jmp             count
breakSLength:   sub             rdx, rax
                ret


sprintLF:                                           ;prints a string and a line feed; message in rax
                call            printS              ;print string
                push            rax                 ;save address of message
                mov             rax, 0xA            ;push char with rax to stack
                push            rax
                mov             rax, rsp            ;provide stack memory address to printS
                call            printS
                pop             rax
                pop             rax
                ret