; Basic hello world program with normal exit
            global      _start

            SECTION     .text
_start:     mov         rax, 4                  ; SYS_WRITE opcode
            mov         rbx, 1                  ; STD_OUT
            mov         rcx, helloworld         ; address to data
            mov         rdx, 13                 ; bytes to read
            int         0x80                    ; hardware interrupt

            mov         rax, 1                  ; SYS_EXIT
            mov         rbx, 0                  ; exit code 0
            int         0x80


            SECTION     .data
helloworld: db          "Hello world!", 0xA     ; "Hello world!" and new line ASCIi