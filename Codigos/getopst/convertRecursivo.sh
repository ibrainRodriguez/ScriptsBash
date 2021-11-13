#!/bin/bash

opcionR=""

function modoUso() {
  echo "-------------------------------------------------------------------------"
  echo "|   Este programa convierte todos los archivos de una extencion en un   |"
  echo "|       a un formato especificado y los guarda en uno de salida         |"
  echo "|                                                                       |"
  echo "|   -r = Hace el proceso de forma recursiva                             |"
  echo "|   Parametro 1=directorio de entrada                                   |"
  echo "|   Parametro 2=directorio de salida                                    |"
  echo "|   Parametro 3=formato de entrada                                      |"
  echo "|   Parametro 4=directorio de salida                                    |"
  echo "|                                                                       |"
  echo "|                            Ejemplo:                                   |"
  echo "|     ./convertRevursivo.sh [-r] /tmp /home/usuario/salida jpeg txt     |"
  echo "-------------------------------------------------------------------------"
}

while getopts ":r" opt; do
    case $opt in
    r)
        opcionR="1"
        echo "";
        ;;
    "?")
        echo "Opción inválida -$OPTARG";
        modoUso;
        exit 1;
        ;;
    :)
        echo "Se esperaba un parámetro en -$OPTARG";
        modoUso;
        exit 1;
        ;;
    esac
done

shift $((OPTIND-1))


function validarParam() {
    [[ "$4" ]] || { echo "Se necesitan pasar cuatro parametros"; modoUso; exit 1; }
    [[ -d $1 ]] && [[ -d $2 ]] || { echo "Los paramentros 1 y 2 deben de ser directorios validos"; modoUso; exit 1; }
}

function convertirRe() {
  for elemento in $(ls "$1"); do
      if [[ -f "$1/$elemento" ]]; then
          x=${elemento##*.}
          [[ $x == $3 ]] && { nombre=${elemento%.*}.$4; convert "$1/$elemento" "$2/$nombre"; }
      else
          [[ -d "$1/$elemento" ]] && { dir="$1/$elemento"; convertirRe $dir $2 $3 $4; }
      fi
  done
}

function convertirNormal() {
  cd "$1"

  for elemento in $(ls | egrep ."$3$"); do
        name=${elemento%%.*}
        #echo "${name}.$4"
        #echo "$2/${name}.$4"
        convert "$elemento" "$2/${name}.$4"
  done
}

validarParam $@

[[ $opcionR ]] && { convertirRe "$@"; } || { convertirNormal "$@"; }
