#!/bin/bash

echo "Ejecución del script"

# Definir la ruta donde se creará el archivo
DIR=~/repogit/UTNFRA_SO_1P2C_2024_Galarza/RTA_ARCHIVOS_Examen_20241003

# Obtener la fecha actual
FECHA=$(date +%Y%m%d)

# Crear el archivo Filtro_Avanzado.txt en la carpeta especificada
FILTER_FILE="$DIR/Filtro_Avanzado.txt"

# Guardar información en el archivo
echo "Mi IP pública es: $(curl -s ifconfig.me)" > "$FILTER_FILE"
echo "Mi usuario es: $(whoami)" >> "$FILTER_FILE"
echo "El hash de mi usuario es: $(sudo grep "^$(whoami):" /etc/shadow | awk -F: '{print $2}')" >> "$FILTER_FILE"
echo "La URL de mi repositorio es: $(git config --get remote.origin.url)" >> "$FILTER_FILE"

echo "Archivo Filtro_Avanzado.txt creado exitosamente en $DIR."

echo "Fin del script, se ejecutó correctamente!"
