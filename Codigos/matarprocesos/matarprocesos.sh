#!/bin/bash

function modoUso(){
    echo "Este Script mata procesos que sean igual o pasen del limite de memoria cada 10 seg"
    echo " parametro 1 = el porsentaje de memoria que desean que maten"
    echo "Ejemplo:"
    echo "./killCPU.sh [porsentaje]"
}

function validar(){
    [[ "$1" ]] || { echo "Se necesitas pasar 1 parametro"; modoUso; exit 1; }
}

function matarProces(){
    #for elemento in $(ps aux --sort +pcpu | awk '{ print $2","$3 }'); do
    for elemento in $(ps aux --sort +pcpu | awk '{ print $2","$3 }' | egrep  -o "[0-9]*,[0-9]*"); do
        memoriaOcupada=$(echo "$elemento" | cut -d "," -f 2) #| cut -d "." -f 1
        #echo "$memoriaOcupada"
        [[ "$memoriaOcupada" -eq "$1" ]] || [[ "$memoriaOcupada" -gt "$1" ]] && { kill $(echo "$elemento" | cut -d "," -f 1); }
    done
}

function segundosDiez(){
    while true; do
        #echo "holis1"
        matarProces "$1";
        sleep 10;
    done
}

validar "$@";
segundosDiez "$@"
