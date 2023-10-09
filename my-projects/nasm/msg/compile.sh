#!/bin/bash
if [ -f "msg.o" ]; 
  then
    echo "removing old msg.o file"
    rm "msg.o"
fi

if [ -f "msg" ]; then
  echo "removing old msg file"
  rm "msg"
fi

echo "creating obj file"
nasm -g -f elf64 -o msg.o msg.asm
echo "linking"
ld msg.o -o msg
echo "end"