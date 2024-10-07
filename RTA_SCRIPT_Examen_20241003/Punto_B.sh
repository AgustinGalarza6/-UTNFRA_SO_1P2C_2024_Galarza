#!/bin/bash

# Variables
DISK="/dev/sdc" # Disco de 10GB
PARTITION_SIZE_PRIMARY=$((1 * 1024 * 1024 * 1024)) # Tamaño de cada partición primaria (1GB)
PARTITION_SIZE_LOGICAL=$((1 * 1024 * 1024 * 1024)) # Tamaño de cada partición lógica (1GB)
MOUNT_BASE="/mnt/particiones" # Ruta base para montar las particiones

# Crear el directorio de montaje
sudo mkdir -p $MOUNT_BASE

# Particionando...
echo "Creando particiones en $DISK..."

{
    # Crear 3 particiones primarias de 1 GB
    for i in {1..3}; do
        echo "n" # Nueva partición
        echo "p" # Primaria
        echo ""  # Número de partición (dejar en blanco para que fdisk asigne automáticamente)
        echo "+$PARTITION_SIZE_PRIMARY" # Tamaño de la partición = 1GB
    done

    # Crear 1 partición extendida de 7 GB
    echo "n" # Nueva partición
    echo "e" # Extendida
    echo ""  # Número de partición (dejar en blanco para que fdisk asigne automáticamente)
    echo ""  # Usar el tamaño máximo disponible = 7GB

    # Crear 6 particiones lógicas de 1 GB dentro de la extendida
    for i in {5..10}; do
        echo "n" # Nueva partición
        echo "l" # Lógica
        echo ""  # Número de partición (dejar en blanco para que fdisk asigne automáticamente)
        echo "+$PARTITION_SIZE_LOGICAL" # Tamaño de la partición = 1GB
    done

    echo "w" # Guardar y salir
} | sudo fdisk $DISK

echo "Particiones creadas exitosamente."

# Formatear las particiones
echo "Formateando las particiones..."
for i in {1..3}; do
    sudo mkfs.ext4 "${DISK}p${i}"
done

for i in {5..10}; do
    sudo mkfs.ext4 "${DISK}p${i}"
done

echo "Particiones formateadas exitosamente."

# Montar las particiones
echo "Montando las particiones..."
for i in {1..3}; do
    sudo mount "${DISK}p${i}" "$MOUNT_BASE/particion_pri_$i"
done

for i in {5..10}; do
    sudo mount "${DISK}p${i}" "$MOUNT_BASE/particion_log_$((i-3))"
done

echo "Particiones montadas exitosamente."
echo "Fin del script, se ejecutó correctamente!"

