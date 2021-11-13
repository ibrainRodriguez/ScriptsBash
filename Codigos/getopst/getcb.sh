#!/bin/bash

opcionB=""
opcionC=""
paramC="" 

function modoUso() {

    echo "Modo de uso:"
    echo "Scrip que copia o borra un archivo"
    echo ""
    echo "getcb.sh -b /tmp/archivo"
    echo "Borra el archivo /tmp/archivo"
    echo ""
    echo "getcb.sh -c /home/usuario /tmp/archivo"
    echo "Copia /tmp/archivo en /home/usuario"
    echo ""
    echo "OPCIONES:"
    echo "   -b:"
    echo "   -c: ruta donde debe copiar"
    echo "Argumentos:"
    echo "   paramPosicional: archivo que se dea borrar o copiar"

}

while getopts ":c:b" opt; do
    case $opt in
    b)
        opcionB="1";
        ;;
    c)
        opcionC="1";
        paramC="$OPTARG";
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

shift $((OPTIND-1)) #borrar todos los params que ya procesó getopts

function validar() {


    [[ "$1" ]] && [[ "$2" ]] && { echo "Solo se puede seleccionar una opcion"; exit 1;  }

    [[ "$1" == "" ]] && [[ "$2" == "" ]] && { echo "Debes mandar un parametro minimo"; modoUso; exit 1; }


    if [[ "$2" ]]; then
      [[ -d "$3" ]] || { echo "-c tiene que estar asociado a un directorio válido"; modoUso; exit 1; }
    fi

    [[ "$4" ]] || { echo "Se necesita inngresar un arhivo"; modoUso; exit 1; }

    [[ -d "$4" ]] && { echo "El parametro debe ser un archivo"; modoUso; exit 1; }


}

validar "$opcionB" "$opcionC" "$paramC" "$@"

[[ "$opcionB" == "1" ]] && { rm "$1"; echo "Se borro el archivo $1"; exit; }

[[ "$opcionC" == "1" ]] && { cp "$1" "$paramC"; echo "se copio el archivo"; exit; }
