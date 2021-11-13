#!/bin/bash
function modoUso() {
    echo "-----------------------------------------------"
    echo "|                Modo Uso                     |"
    echo "|    Ejecutalo con permisos de super user     |"
    echo "|        Agrega una entrada a crontab         |"
    echo "|     de cada usuario y los registros los     |"
    echo "|          guarda en /home/redcront           |"
    echo "-----------------------------------------------"
}

function validar() {
  [[ "$1" ]] && { echo "Necesitas un parametro"; exit 1; }
}


validar $@
fecha=$(date +%Y-%m-%d)

for elemento in $(cat /etc/passwd | egrep -v "([nologin]?/[false])" | cut -d ":" -f 1);do
  (crontab -u $elemento -l; echo "@reboot firefox") |  crontab -u $elemento - && { echo "$elemento $fecha" >> /home/redcront; }
done
