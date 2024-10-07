#!/bin/bash

# Especifica la ruta absoluta del directorio
DIRECTORIO="/home/vagrant/repogit/UTNFRA_SO_1P2C_2024_Galarza/RTA_ARCHIVOS_Examen_20241003"

# Verificar si el directorio existe
if [ -d "$DIRECTORIO" ]; then
    echo "Directorio existente, procediendo..."
else
    echo "Directorio no encontrado, creándolo..."
    mkdir "$DIRECTORIO"
fi

# Extraer la información del total de memoria RAM y guardarla en el archivo Filtro_Basico.txt
grep MemTotal /proc/meminfo > "$DIRECTORIO/Filtro_Basico.txt"

# Extraer la información del fabricante del chasis y agregarla al archivo
sudo dmidecode -t chassis | grep "Manufacturer" >> "$DIRECTORIO/Filtro_Basico.txt"

echo "Archivo Filtro_basico.txt creado exitosamente en $DIR."

echo "Fin del script, se ejecutó correctamente!"
