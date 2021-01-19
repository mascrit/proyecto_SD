#!/bin/sh
usuario=$1
adduser $usuario
uid=$(id -u $usuario)
echo "Ingresa la contraseña SAMBA del usuario"
samba-tool user create $usuario --uid-number $uid
cd /var/yp
make
