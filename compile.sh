for asm in *.asm
do
  nasm -fmacho64 $asm
  gcc $(basename -s .asm $asm).o -o $(basename -s .asm $asm) 2> /dev/null
done
