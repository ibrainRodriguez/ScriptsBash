#!/bin/bash
original="IFS"
IFS=$(echo -en ",")
OPTIONS="Hello word,Quit"
select opt in $OPTIONS; do
    if [ "$opt" = "Quit" ]; then
    echo done
    exit
  elif [ "$opt" = "Hello word" ]; then
    echo "Hello World"
    else
    clear
    echo "bad option"
    fi
done
IFS="$original"
