#!/bin/bash

echo "Ejecución del script"

# Creamos la variable password y le pasamos nuestra contraseña generada para que los
# users tengan todos la misma.

PASSWORD=$(openssl passwd -crypt 'vagrant')

# Creamos grupos que nos pide el enunciado.

sudo groupadd p1c2_2024_gAlumno
sudo groupadd p1c2_2024_gProfesores

# Crear usuarios con sus respectivos grupos secundarios y la misma clave.

sudo useradd -m -G p1c2_2024_gAlumno -p "$PASSWORD" p1c2_2024_A1
sudo useradd -m -G p1c2_2024_gAlumno -p "$PASSWORD" p1c2_2024_A2
sudo useradd -m -G p1c2_2024_gAlumno -p "$PASSWORD" p1c2_2024_A3
sudo useradd -m -G p1c2_2024_gProfesores -p "$PASSWORD" p1c2_2024_P1

# Verificar si el directorio ya existe

if [ ! -d "/Examenes-UTN" ]; then
    sudo mkdir -p /Examenes-UTN/{alumno_{1..3},profesores}
else
    echo "/Examenes-UTN ya existe."
fi

# Ajustar permisos de las carpetas

sudo chown p1c2_2024_A1:p1c2_2024_A1 /Examenes-UTN/alumno_1
sudo chmod 750 /Examenes-UTN/alumno_1

sudo chown p1c2_2024_A2:p1c2_2024_A2 /Examenes-UTN/alumno_2
sudo chmod 740 /Examenes-UTN/alumno_2

sudo chown p1c2_2024_A3:p1c2_2024_A3 /Examenes-UTN/alumno_3
sudo chmod 750 /Examenes-UTN/alumno_3

sudo chown p1c2_2024_P1:p1c2_2024_gProfesores /Examenes-UTN/profesores
sudo chmod 775 /Examenes-UTN/profesores

# Crear archivo de validación con la salida de whoami
for user in p1c2_2024_A1 p1c2_2024_A2 p1c2_2024_A3 p1c2_2024_P1; do
    sudo su -c "whoami > /Examenes-UTN/${user/alumno_/alumno_1}/validar.txt" "$user"
done

echo "Usuarios creados, permisos ajustados y archivo de validación generado."
echo "Fin del script, se ejecutó correctamente!"

