#!/bin/bash

echo "Ejecución del script"

# Definir la ruta donde se guardará el archivo
RUTA_DESTINO="/home/vagrant/repogit/UTNFRA_SO_1P2C_2024_Galarza/RTA_ARCHIVOS_Examen_20241003"

# Obtener la dirección IP pública
IP_PUBLICA=$(curl -s ifconfig.me)

# Obtener el nombre de usuario actual
USUARIO=$(logname)

# Generar un hash del nombre de usuario (usando SHA-256)
HASH_USUARIO=$(echo -n "$USUARIO" | sha256sum | awk '{print $1}')

# Obtener la URL del repositorio remoto (asegurarse de estar dentro de la carpeta del repositorio)
URL_REPOSITORIO=$(git remote get-url origin)

# Escribir los resultados en el archivo Filtro_Avanzado.txt en la ruta especificada
echo "Mi IP Pública es: $IP_PUBLICA" > "$RUTA_DESTINO/Filtro_Avanzado.txt"
echo "Mi usuario es: $USUARIO" >> "$RUTA_DESTINO/Filtro_Avanzado.txt"
echo "El Hash de mi usuario es: $HASH_USUARIO" >> "$RUTA_DESTINO/Filtro_Avanzado.txt"
echo "La URL de mi repositorio es: $URL_REPOSITORIO" >> "$RUTA_DESTINO/Filtro_Avanzado.txt"

echo "Fin del script, se ejecutó correctamente!"
