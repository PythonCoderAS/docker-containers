#!/bin/sh
printf "["
first=0
root="$(dirname "$(dirname "$(dirname "$(realpath $0)")")")"/containers
for dockerfile in $(find "$root" -name Dockerfile)
do
  dirname="$(basename "$(dirname $dockerfile)")"
  if [ $first -eq 0 ]
  then
    printf "\"$dirname\""
    first=1
  else
    printf ",\"$dirname\""
  fi
done
printf "]"