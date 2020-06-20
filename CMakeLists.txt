cmake_minimum_required(VERSION 3.16.3)
project("nasm-playground" ASM_NASM C CXX)

#set(CMAKE_BUILD_TYPE DEBUG )


set(CMAKE_NASM_LINK_EXECUTABLE "ld <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CAN_USE_ASSEMBLER TRUE)

# Mac settings
if (APPLE)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
    set(CMAKE_ASM_NASM_FLAGS "-DMACOS")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -macosx_version_min 10.13 -no_pie")
endif (APPLE)

if (UNIX AND NOT APPLE)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
endif (UNIX AND NOT APPLE)

set(CMAKE_ASM_NASM_COMPILE_OBJECT "<CMAKE_ASM_NASM_COMPILER> <INCLUDES> <FLAGS> -l <SOURCE>.lst -f ${CMAKE_ASM_NASM_OBJECT_FORMAT} -o <OBJECT> <SOURCE>")

enable_language(ASM_NASM)

# Adding .asm from src/asm
file( GLOB ASMSOURCES src/asm/*.asm)
foreach( testsourcefile ${ASMSOURCES} )
    string( REGEX REPLACE "(.*/)(.*)([.]asm)" "\\2" testname ${testsourcefile} )
    add_executable( ${testname} ${testsourcefile} )
    set_target_properties(${testname} PROPERTIES LINKER_LANGUAGE NASM)
    if (APPLE)
        target_link_libraries(${testname} System)
    endif (APPLE)
endforeach( testsourcefile ${ASMSOURCES} )

# Adding .c targets
set(CMAKE_CXX_STANDARD 14 )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
add_executable( helloworld src/c/helloworld.c )