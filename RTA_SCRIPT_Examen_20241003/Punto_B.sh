#!/bin/bash
echo "Script Punto B"

num_primarias=4
num_logicas=6
tam_particion=1

{
    # Crear las particiones primarias
    for ((i=1; i<=num_primarias; i++)); do
        echo "n"       # Crear nueva partición
        echo "p"       # Partición primaria
        echo "$i"      # Número de partición
        if [ $i -eq 1 ]; then
            echo ""    # Primera partición, empieza en el primer sector
        else
            echo ""    # Usar el siguiente sector disponible
        fi
        echo "+${tam_particion}G" # Tamaño de 1GB
    done

    # Crear una partición extendida
    echo "n"           # Crear nueva partición
    echo "e"           # Partición extendida
    echo ""            # Usar el siguiente número de partición
    echo ""            # Usar el siguiente sector disponible
    echo "+$((num_logicas * tam_particion))G" # Tamaño total de las lógicas

    # Crear las particiones lógicas dentro de la extendida
    for ((i=1; i<=num_logicas; i++)); do
        echo "n"       # Crear nueva partición
        echo "l"       # Partición lógica
        echo ""        # Usar el siguiente sector disponible
        echo "+${tam_particion}G" # Tamaño de 1GB
    done

    echo "w"           # Escribir cambios
} | sudo fdisk /dev/sdc

# Actualizar la tabla de particiones
sudo partprobe /dev/sdc

echo "Formatear las particiones con ext4"
for i in {1..4}; do
    sudo mkfs.ext4 /dev/sdc$i
done

for i in {5..10}; do
    sudo mkfs.ext4 /dev/sdc$i
done

echo "Montando las particiones..."
sudo mount /dev/sdc1 /Examenes-UTN/alumno_1/parcial_1
sudo mount /dev/sdc2 /Examenes-UTN/alumno_1/parcial_2
sudo mount /dev/sdc3 /Examenes-UTN/alumno_1/parcial_3
sudo mount /dev/sdc4 /Examenes-UTN/alumno_2/parcial_1
sudo mount /dev/sdc5 /Examenes-UTN/alumno_2/parcial_2
sudo mount /dev/sdc6 /Examenes-UTN/alumno_2/parcial_3
sudo mount /dev/sdc7 /Examenes-UTN/alumno_3/parcial_1
sudo mount /dev/sdc8 /Examenes-UTN/alumno_3/parcial_2
sudo mount /dev/sdc9 /Examenes-UTN/alumno_3/parcial_3
sudo mount /dev/sdc10 /Examenes-UTN/profesores

# Agregar entradas a /etc/fstab para el montaje persistente
{
    echo "/dev/sdc1   /Examenes-UTN/alumno_1/parcial_1   ext4    defaults    0    2"
    echo "/dev/sdc2   /Examenes-UTN/alumno_1/parcial_2   ext4    defaults    0    2"
    echo "/dev/sdc3   /Examenes-UTN/alumno_1/parcial_3   ext4    defaults    0    2"
    echo "/dev/sdc4   /Examenes-UTN/alumno_2/parcial_1   ext4    defaults    0    2"
    echo "/dev/sdc5   /Examenes-UTN/alumno_2/parcial_2   ext4    defaults    0    2"
    echo "/dev/sdc6   /Examenes-UTN/alumno_2/parcial_3   ext4    defaults    0    2"
    echo "/dev/sdc7   /Examenes-UTN/alumno_3/parcial_1   ext4    defaults    0    2"
    echo "/dev/sdc8   /Examenes-UTN/alumno_3/parcial_2   ext4    defaults    0    2"
    echo "/dev/sdc9   /Examenes-UTN/alumno_3/parcial_3   ext4    defaults    0    2"
    echo "/dev/sdc10  /Examenes-UTN/profesores            ext4    defaults    0    2"
} | sudo tee -a /etc/fstab

