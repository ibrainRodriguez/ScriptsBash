#!/bin/bash
[[ "$3" ]] || {
  echo "Necesitas ingresar 3 parametros";
  exit 1;
}

name=$(basename $3)
ab=$(realpath $3)
dir=$(dirname $ab)

[[ -d $dir ]] || {
  echo "El directorio no es valido ";
  exit 1;
}


echo "DROP DATABASE IF EXISTS $2;"> $3
echo "create database $2;" >> $3
echo "use $2;" >> $3

msqldump -u $1 -p $2 >> $3 2> /dev/null  && { echo "fallo"; exit 1; } || { echo "OK"; exit 1;  }
