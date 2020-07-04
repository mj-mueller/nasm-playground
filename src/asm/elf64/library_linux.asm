exit:
        mov         rax, 1
        xor         rbx, rbx        ; exit code 42
        int         0x80            ; interrupt for syscall