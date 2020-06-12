for asm in *.asm
do
  nasm -fmacho64 -l $(basename -s .asm $asm).lst $asm
done
