#!/bin/bash

echo "Ejecución del script"

# Definir el disco
DISCO="/dev/sdc"

# Crear las particiones primarias
echo "Creando particiones primarias de 1 GiB..."
parted -s $DISCO mkpart primary 0% 1GiB
parted -s $DISCO mkpart primary 1GiB 2GiB
parted -s $DISCO mkpart primary 2GiB 3GiB

# Crear la partición extendida de 7 GiB
echo "Creando partición extendida de 7 GiB..."
parted -s $DISCO mkpart extended 3GiB 10GiB

# Crear las particiones lógicas de 1 GiB dentro de la partición extendida
echo "Creando particiones lógicas dentro de la partición extendida..."
parted -s $DISCO mkpart logical 3GiB 4GiB
parted -s $DISCO mkpart logical 4GiB 5GiB
parted -s $DISCO mkpart logical 5GiB 6GiB
parted -s $DISCO mkpart logical 6GiB 7GiB
parted -s $DISCO mkpart logical 7GiB 8GiB
parted -s $DISCO mkpart logical 8GiB 9GiB

echo "Las particiones han sido creadas."


# Formatear las particiones con ext4
echo "Formateando las particiones con ext4..."
for i in {1..4}; do
    sudo mkfs.ext4 ${DISCO}${i}
done

for i in {5..10}; do
    sudo mkfs.ext4 ${DISCO}${i}
done

echo "Montando las particiones..."
sudo mount ${DISCO}1 /Examenes-UTN/alumno_1/parcial_1
sudo mount ${DISCO}2 /Examenes-UTN/alumno_1/parcial_2
sudo mount ${DISCO}3 /Examenes-UTN/alumno_1/parcial_3
sudo mount ${DISCO}4 /Examenes-UTN/alumno_2/parcial_1
sudo mount ${DISCO}5 /Examenes-UTN/alumno_2/parcial_2
sudo mount ${DISCO}6 /Examenes-UTN/alumno_2/parcial_3
sudo mount ${DISCO}7 /Examenes-UTN/alumno_3/parcial_1
sudo mount ${DISCO}8 /Examenes-UTN/alumno_3/parcial_2
sudo mount ${DISCO}9 /Examenes-UTN/alumno_3/parcial_3
sudo mount ${DISCO}10 /Examenes-UTN/profesores

# Agregar entradas a /etc/fstab para el montaje persistente
{
    echo "${DISCO}1   /Examenes-UTN/alumno_1/parcial_1   ext4    defaults    0    2"
    echo "${DISCO}2   /Examenes-UTN/alumno_1/parcial_2   ext4    defaults    0    2"
    echo "${DISCO}3   /Examenes-UTN/alumno_1/parcial_3   ext4    defaults    0    2"
    echo "${DISCO}4   /Examenes-UTN/alumno_2/parcial_1   ext4    defaults    0    2"
    echo "${DISCO}5   /Examenes-UTN/alumno_2/parcial_2   ext4    defaults    0    2"
    echo "${DISCO}6   /Examenes-UTN/alumno_2/parcial_3   ext4    defaults    0    2"
    echo "${DISCO}7   /Examenes-UTN/alumno_3/parcial_1   ext4    defaults    0    2"
    echo "${DISCO}8   /Examenes-UTN/alumno_3/parcial_2   ext4    defaults    0    2"
    echo "${DISCO}9   /Examenes-UTN/alumno_3/parcial_3   ext4    defaults    0    2"
    echo "${DISCO}10  /Examenes-UTN/profesores            ext4    defaults    0    2"
} | sudo tee -a /etc/fstab

echo "Fin del script, se ejecutó correctamente!"


