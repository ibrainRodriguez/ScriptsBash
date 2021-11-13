#!/bin/bash

#El script también recibe algún comando en forma de cadena de texto.
#El script ejecuta el comando de forma remota en el servidor cuya información está almacenada
#en el archivo de texto de entrada y despliega la salida del comando.
#Ejemplo de uso:
#ejecutaRemoto /tmp/creds.txt 'echo hola mundo'
#grep -oP "^user:\K.+"

function modoUso() {
  echo "-------------------------------------------------------------------------"
  echo "|  El script también recibe algún comando en forma de cadena de texto.  |"
  echo "|                                                                       |"
  echo "|   Parametro 1=directorio de entrada                                   |"
  echo "|   Parametro 2=comando a ejecutar                                      |"
  echo "|                                                                       |"
  echo "|                          Ejemplo:                                     |"
  echo "|          ejecutaRemoto /tmp/creds.txt 'echo hola mundo'               |"
  echo "-------------------------------------------------------------------------"
}

function validar() {
  [[ "$2" ]] || { echo "Debes enviar 2 parametros"; modoUso; exit 1; }
  [[ -f "$1" ]] || { echo "El parametro 1 debe ser un archivo valido"; modoUso; exit 1; }
}


validar "$@"

comando="$2"
usuario=$(cat "$1" | grep -oP "^user:\K.+")
puerto=$(cat "$1" | grep -oP "^puerto:\K.+")
host=$(cat "$1" | grep -oP "^host:\K.+")
#echo "$usuario"
#echo "$puerto"
#echo "$host"
#echo "$comando"
ssh -p "$puerto" "$usuario"@"$host" "$comando"
