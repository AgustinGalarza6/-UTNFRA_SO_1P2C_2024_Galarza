#!/bin/bash

echo "Ejecución del script"

# Ruta de la carpeta
DIR=~/repogit/UTNFRA_SO_1P2C_2024_Galarza/RTA_ARCHIVOS_Examen_20241003

# Asignamos a la variable FILTER_FILE la ruta completa del archivo Filtro_basico.txt.
FILTER_FILE="$DIR/Filtro_basico.txt"

# Obtener el total de memoria RAM
grep MemTotal /proc/meminfo > "$FILTER_FILE"

# Obtener información del fabricante del chassis
sudo dmidecode -t chassis | grep -i 'manufacturer' >> "$FILTER_FILE"

echo "Archivo Filtro_basico.txt creado exitosamente en $DIR."

echo "Fin del script, se ejecutó correctamente!"
