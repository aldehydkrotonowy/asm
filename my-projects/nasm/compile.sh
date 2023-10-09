if [ -f "test.o" ]; then
  echo "removing old test.o file"
  rm test.o
fi
if [ -f "test" ]; then
  echo "removing old test file"
  rm test
fi
echo "creating obj file"
nasm -f elf64 -o test.o test.asm
echo "linking"
ld test.o -o test
echo "end"