#!/bin/bash

#################################################################################
#Hacer un script que mediante un menú tipo select permita registrar un usuarios en el sistema. En cada opción del menú se puede agregar alguna de las opciones del comando useradd. Al menos considerar las 3 opciones más comunes (nombre de usuario, home path, tipo de shell, grupos, etc.)

#Se deben poder agregar varios usuarios (pueden poner sub menús).
#################################################################################

function modoUso() {
    echo "-----------------------------------------------"
    echo "|                Modo Uso                     |"
    echo "|                                             |"
    echo "|        Crea, Elimina o Ve usuarios          |"
    echo "|                                             |"
    echo "|           Selecciona una opcion             |"
    echo "-----------------------------------------------"
}


original="IFS"
IFS=$(echo -en ",")
OPTIONS="Crear usuario,Eliminar usuario,Ver usuarios,Salir"
modoUso


select opt in $OPTIONS; do
    if [ "$opt" = "Salir" ]; then
      echo " "
      echo "Me muero..."
      echo "N..O POR FA..VOR"
      echo "aaa..!!"
      exit

  elif [ "$opt" = "Crear usuario" ]; then
    ophome="1"
    ophome2="1"
    opshel="1"
    opgrupo="1"
    namee=""
    homee=""
    pathh=""

    grupoo=""
    namegrupo=""
    shel=""

    echo "Nombre del nuevo usuario:"
    read namee
    #cat /etc/passwd | cut -d ":" -f 1 | grep "$namee" &> /dev/null  || { echo "El usuario ya existe"; }
    echo "Deseas crear una carpeta Home para el usuario $namee
    0 para si
    1 para no"
    read ophome
    if [[ "$ophome" -eq 0 ]]; then
      echo "¿Quieres ingresar una ruta para el directorio home?
      0 para si
      1 para no"
      read ophome2
    fi
    if [[ "$ophome2" -eq 0 ]]; then
      echo "Ingresa la ruta"
      read pathh
      homee=" -m -d $pathh"
    elif [[ "$ophome2" -eq 1 ]]; then
      homee=" -m "
    fi
    echo "Deseas agregar el usuario $namee a un grupo especifico?
    0 para si
    1 para no"
    read opgrupo
    if [[ "$opgrupo" -eq 0 ]]; then
      echo "Ingresa el nombre del grupo:"
      read grupoo
      cat /etc/group | cut -d ":" -f 1 | grep "$gropoo" 2> /dev/null && namegrupo="-d $grupoo" || { echo "El grupo no existe."; }
    fi

    echo "Cual shell quieres que tenga este usuario?
    0 para bash
    1 para shel"
    read shel
    if [[ "$opshel" -eq 0 ]]; then
      shel="-s /bin/bash/"
    else
      shel="-s /bin/bash/"
    fi
    IFS="$original"
    sudo useradd $homee $namee $namegrupo $shel &> && { echo "Se creo el usuario correctamente"; echosudo passwd "$namee"; } || { echo "Algo salio mal"; }



  elif [ "$opt" = "Eliminar usuario" ]; then
    opeli=1
    nameeliminar="hola"
    echo "Nombre del usuario a eliminar:"
    read nameeliminar
    echo "¿Seguro quieres eliminar este usuario?
    0 para si
    1 para no"
    read opeli
    if [[ "$opeli" -eq 0 ]]; then
      sudo userdel -r $nameeliminar 2> /dev/null && { echo "Se elimino usuario"; } ||  { echo "Algo fallo"; }
    else
      echo "Se cancelo la operacion."
    fi

################################################################################
  elif [ "$opt" = "Ver usuarios" ]; then
    cut -d ":" -f 1 /etc/passwd
    else
    clear
    echo "Opcion incorrecta"
    fi
done

IFS="$original"
