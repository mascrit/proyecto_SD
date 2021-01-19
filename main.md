# Proyecto 3 SHIANTY ----> SAMBA
## Arquitectura
![Arquitectura de la red](images/arquitectura.png?raw=true "Arquitectura") 
## Material utilizado
### Red emulada
* Segmento: 192.168.100.0/24
* Puerta de enlace: 192.168.100.1
* Broadcast: 192.168.100.255
* Dominio: srv.nis
### Servidor
1. #### Maquina virtual servidor linux
    * hostname: Node03
    * SO: Debian 10
    #### Tarjeta de red 
    * ip: 192.16.100.119/24
    * dns: 192.168.100.119 8.8.8.8
    #### Configuracion
    [configuracion Servidor](server.md)
    #### Creacion de usuarios
    * Ejecutar add_user.sh
    ```sh
    $ ./add_user.sh usuario_77
    ```
    * Si todo sale bien se le pedira la contraseña de UNIX y la de SAMBA(Usar la misma)
    ```
    Añadiendo el usuario `usuario_77' ...
    make: se entra en el directorio '/var/yp'
    make[1]: se entra en el directorio '/var/yp/srv.nis'
    Updating netid.byname...
    make[1]: se sale del directorio '/var/yp/srv.nis'
    make: se sale del directorio '/var/yp'
    Añadiendo el nuevo grupo `usuario_77' (1010) ...
    make: se entra en el directorio '/var/yp'
    make[1]: se entra en el directorio '/var/yp/srv.nis'
    Updating group.byname...
    Updating group.bygid...
    Updating netid.byname...
    make[1]: se sale del directorio '/var/yp/srv.nis'
    make: se sale del directorio '/var/yp'
    Añadiendo el nuevo usuario `usuario_77' (1010) con grupo 'usuario_77' ...
    make: se entra en el directorio '/var/yp'
    make[1]: se entra en el directorio '/var/yp/srv.nis'
    Updating passwd.byname...
    Updating passwd.byuid...
    Updating netid.byname...
    Updating shadow.byname...
    make[1]: se sale del directorio '/var/yp/srv.nis'
    make: se sale del directorio '/var/yp'
    Creando el directorio personal '/home/usuario_77' ...
    Copiando los ficheros desde '/etc/skel' ...
    Nueva contraseña:
    Vuelva a escribir la nueva contraseña:
    passwd: contraseña actualizada correctamente
    Cambiando la información de usuario para usuario_77
    Introduzca el nuevo valor, o pulse INTRO para usar el valor predeterminado
            Nombre completo []: Usuario 77
            Número de habitación []: 12b
            Teléfono del trabajo []: 5567382132
            Teléfono de casa []: 5536271232
            Otro []:
    ¿Es correcta la información? [S/n] S
    Ingresa la contraseña SAMBA del usuario
    New Password:
    Retype Password:
    User 'usuario_77' created successfully
    make[1]: se entra en el directorio '/var/yp/srv.nis'
    Updating passwd.byname...
    Updating passwd.byuid...
    Updating netid.byname...
    Updating shadow.byname...
    make[1]: se sale del directorio '/var/yp/srv.nis'
    ```
    * El contenido del script add_user.sh es el siguiente
    ```sh
    #!/bin/sh
    usuario=$1
    adduser $usuario
    uid=$(id -u $usuario)
    echo "Ingresa la contraseña SAMBA del usuario"
    samba-tool user create $usuario --uid-number $uid
    cd /var/yp
    make
    ```

### Clientes
2) #### Maquina virtual cliente linux
    * hostname: Node01
    * SO: Centos 8
    #### Tarjeta de red
    * configuracion por DHCP
    #### Configuracion
    [configuracion Cliente linux](cliente.md)

3) #### maquina virtual cliente windows 
    * hostname: Node02
    * SO: windows 10
    #### Tarjeta de red
    * ip: 192.168.100.28/24
    * puerta de enlace: 192.168.100.1
    * Broadcast: 192.168.100.255
    * dns: 192.168.100.119 8.8.8.8
    * Dominio AC: SRV
    #### Configuracion
    [configuracion Cliente windows](windows.md)
