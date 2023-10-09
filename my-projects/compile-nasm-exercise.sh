#!/bin/bash
if [ -z $1 ]; then
  echo "unknown exercise nr"
fi
if [ -z $2 ]; then
  echo "unknows file name"
fi


if [ $1 ] && [ $2 ]; then 
  exerciseNr=$1
  file=$2
  shouldExecute=$3


  path="nasm/excercise-${exerciseNr}/"
  fullPath="${path}${file}"
  o_file="${fullPath}.o"
  asm_file="${fullPath}.asm"

  case ${shouldExecute} in
    e) execute=true ;;
    *) execute=false ;;
  esac

  echo "input params : path = ${path}, file = ${file}, execute = ${execute}"

  if [ -f "${o_file}" ]; 
    then
      echo "removing old  ${file}.o file"
      rm "${o_file}"
    else
      echo "dupka zbita"
  fi

  if [ -f "${path}${file}" ]; then
    echo "removing old ${file} file"
    rm "${path}${file}"
  fi

  echo "creating fresh obj file"
  nasm -g -f elf64 -o "${o_file}" "${asm_file}"

  if [ -f "${o_file}" ]; then
    echo "linking"
    ld "${o_file}" -o "${fullPath}"
  fi
  echo "end"

  if [ -f ${fullPath} ] && [ ${execute} = "true" ]; then 
    ${fullPath}
  fi
fi

