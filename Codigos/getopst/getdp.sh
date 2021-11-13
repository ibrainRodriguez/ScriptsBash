#!/bin/bash

opcionD=""
paramD=""
opcionP=""
paramP=""

function modoUso() {
    echo ""
    echo "Scrip que copiar todos los archivos de un directorio de forma especial."
    echo ""
    echo "Opciones:"
    echo ""
    echo "-d: directorio de entrada (obligatorio):"
    echo "-p: prefijo (opcional), a cada archivo que se copie se le agrega esta cadena al       inicio"
    echo ""
    echo "Ejemplo de uso:"
    echo "  getdp.sh -d /tmp -p copia- /home/usuario1 /home/usuario2"
}

while getopts ":d:p:" opt; do
    case $opt in
    d)
        opcionD="1"
        paramD="$OPTARG"
        ;;
    p)
        opcionP="1"
        paramP="$OPTARG"
        ;;
    "?")
        echo "Opción inválida -$OPTARG";
        modoUso;
        exit 1;
        ;;
    :)
        echo "Se esperaba un parametro en -$OPTARG";
        modoUso;
        exit 1;
        ;;
    esac
done

shift $((OPTIND-1))

function validarParametros() {
    [[ "$1" ]] || { echo "Se necesita que ingrese la opcion -d"; modoUso; exit 1; }
    [[ "$1" ]] && { [[ -d "$2" ]] || { echo "Pase el parametro -d con un directorio valido."; modoUso; exit 1; } }
}

function validarOtros() {
    for elemento in "$@"; do
      [[ -d "$elemento" ]] || { echo "El directorio $elemento no es valido."; modoUso; exit 1; }
    done
}

validarParametros $opcionD $paramD $opcionP $paramP
validarOtros $@

for elemento1 in "$@"; do
  for elemento in $(ls "$paramD"); do
  	cp "$paramD"/"$elemento" "$elemento1"/"$paramP$elemento";
  done
done
