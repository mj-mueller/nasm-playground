; Exits the program.
%ifdef APPLE
    %define STARTLABEL _main
%else
    %define STARTLABEL _start
%endif
                global      STARTLABEL

                section     .text
STARTLABEL:     mov         rax, 1
                mov         rbx, 42
                int         0x80                    ; invoke syscall to exit
