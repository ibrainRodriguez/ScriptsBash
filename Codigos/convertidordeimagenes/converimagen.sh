#!/bin/bash
function modoUso() {
  echo "-------------------------------------------------------------------------"
  echo "|   Este programa convierte todos los archivos de una extencion en un   |"
  echo "|       a un formato especificado y los guarda en uno de salida         |"
  echo "|                                                                       |"
  echo "|   Parametro 1=directorio de entrada                                   |"
  echo "|   Parametro 2=directorio de salida                                    |"
  echo "|   Parametro 3=formato de entrada                                      |"
  echo "|   Parametro 4=formato de salida                                       |"
  echo "-------------------------------------------------------------------------"
}

function validar() {

  [[ "$4" ]] || { echo "Necesitas 4 parametros"; modoUso; exit 1; }

  [[ -d $1 ]] || { echo "El parametro 1 debe ser un directorio"; modoUso; exit 1; }

  [[ -d $2 ]] || { echo "El parametro 2 debe ser un directorio"; modoUso; exit 1; }

}

validar "$@"

cd "$1"

for elemento in $(ls | egrep ."$3$"); do
      name=${elemento%%.*}
      #echo "${name}.$4"
      #echo "$2/${name}.$4"
      convert "$elemento" "$2/${name}.$4" && { echo "Se convirtieron las imagenes"; }
done
