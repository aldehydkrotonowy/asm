#!/bin/bash
if [[ -z $1 ]]; then
  echo "unknown path"
fi
if [[ -z $2 ]]; then
  echo "unknows file name"
fi
path=$1
file=$2

echo "input params : path = ${path}, file = ${file}"

if [ -f "${path}${file}.o" ]; 
  then
    echo "removing old test.o file"
    rm "${path}${file}.o"
  else
    echo "dupka zbita"
fi

if [ -f "${path}${file}" ]; then
  echo "removing old test file"
  rm "${path}${file}"
fi
echo "creating obj file"
nasm -g -f elf64 -o test.o test.asm
echo "linking"
ld test.o -o test
echo "end"