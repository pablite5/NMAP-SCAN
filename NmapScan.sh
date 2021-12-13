#!/bin/bash

#Añadimos los colores
ROJO='\033[0;31m'
BLANCO='\033[0;37m' 
SINCOLOR='\033[0m' # No Color

echo -e "${ROJO}LANZAR SCRIPT COMO SUDO${BLANCO}"

if [ $# -eq 1 ]; then
    echo -e "OBJETIVO ${RED}IP:$1${WHITE}"
else
    echo "INCORRECTO"
    echo -e "EJEMPLO: ${RED} sudo NmapScanner.sh IP ${WHITE}"
    exit 1
fi

#Obtenemos la fecha
DATE=`date +%Y-%m-%d`
filename=$1_$DATE

echo -e "SCRIPT ${RED}escaneo rapido ${WHITE}iniciando ......"
# Scan rapido
nmap -T4 -F -O $1 > scanner_rapido_$filename.txt &
echo -e "Resultado -> ${RED}scanner_rapido_$filename.txt${WHITE}"

echo -e "Running ${RED}escaneo intenso ${WHITE}iniciando ......"
# Scan intenso
nmap -sS -sU -T4 -A -O -v $1 > scanner_intenso_$filename.txt &
echo -e "Resultado -> ${RED}scanner_intenso_$filename.txt${WHITE}"


echo -e "Running ${RED}escaneo full ${WHITE}iniciando ......"
# Scan tocho
nmap -sS -sU -T4 -A -v -PE -PP -PS80,443 -PA3389 -PU40125 -PY -g 53 –-script discovery 'default or (discovery and safe)' $1 > scanner_full_$filename.txt &
echo -e "Resultado -> ${RED}scanner_full_$filename.txt${WHITE}"

echo "FICHEROS CREADOS"
echo -e "PUEDE DURAR ${RED} 2 HORAS ${WHITE}....."

exit 0
