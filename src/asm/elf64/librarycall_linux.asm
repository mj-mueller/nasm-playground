
%include 'library_linux.asm'


global _start

SECTION .text

_start:
        jmp zwei
        mov         rax, message1
        call        sprintLF

        mov         rax, message2
        call        sprintLF

        call        exit

zwei:
        mov rax, 0xA

        call printS
        call exit

SECTION .data
message1 db  'Testmessage!', 0x
message2 db  'Testmessage number two!', 0xA, 0x