; Exits the program.
%ifdef MACOS
    %define STARTLABEL _main
%else
    %define STARTLABEL _start
%endif
                global      STARTLABEL

                section     .text
STARTLABEL:     mov         rax, 0x02000001
                mov         rbx, 42
                syscall                   ; invoke syscall to exit
