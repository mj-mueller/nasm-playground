cmake_minimum_required(VERSION 3.16.3)
project("nasm-playground" ASM_NASM C CXX)

#set(CMAKE_BUILD_TYPE DEBUG ) # Adding debug symbols


set(CMAKE_NASM_LINK_EXECUTABLE "ld <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CAN_USE_ASSEMBLER TRUE)

# Mac settings
if (APPLE)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
    # Define MACOS for nasm preprocessor
    set(CMAKE_ASM_NASM_FLAGS " ${CMAKE_ASM_NASM_FLAGS} -DMACOS")
    # Disabled to not confuse c linker flags
    #set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -macosx_version_min 10.13 -no_pie")
else()
    set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
endif (APPLE)

#Adding inputfile to be able to detect files vis %include. Should use includes but documentation is poorly so use as flag
set(CMAKE_ASM_NASM_FLAGS "${CMAKE_ASM_NASM_FLAGS} -i ${CMAKE_CURRENT_SOURCE_DIR}/src/asm/elf64/ -i ${CMAKE_CURRENT_SOURCE_DIR}/src/asm/macho64/")

# Adding debug symbols
if(CMAKE_BUILD_TYPE STREQUAL "DEBUG")
    set(CMAKE_ASM_NASM_FLAGS "${CMAKE_ASM_NASM_FLAGS} -g -Fdwarf")
    set(CMAKE_ASM_NASM_COMPILE_OBJECT "<CMAKE_ASM_NASM_COMPILER> <INCLUDES> <FLAGS> -l <SOURCE>.lst -f ${CMAKE_ASM_NASM_OBJECT_FORMAT} -o <OBJECT> <SOURCE>")
else()
    set(CMAKE_ASM_NASM_COMPILE_OBJECT "<CMAKE_ASM_NASM_COMPILER> <INCLUDES> <FLAGS> -I ${CMAKE_CURRENT_SOURCE_DIR}/ -f ${CMAKE_ASM_NASM_OBJECT_FORMAT} -o <OBJECT> <SOURCE>")
endif()

enable_language(ASM_NASM)

# Adding single file .asm
if (APPLE)
    file( GLOB ASMSOURCES src/asm/macho64/*.asm)
else()
    file( GLOB ASMSOURCES src/asm/elf64/*.asm)
endif()

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