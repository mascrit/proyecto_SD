# Configuracion cliente Linux
### Preparativos
#### Añadir dominio
1. Modificar archivo /etc/hosts añadiendo el dominio del servidor
```
192.168.100.119 Node03.srv.nis srv.nis Node03 srv
```
## NIS
1. Instalar los paquetes necesarios
```
dnf -y install ypbind rpcbind oddjob-mkhomedir
```
2. Configurar el dominio del NIS
* Usar ypdomainname como root
```
$ ypdomainname srv.world
```
* Añadir el dominio a /etc/sysconfig/network
```
$ echo "NISDOMAIN=srv.world" >> /etc/sysconfig/network 
```
* Añadir el servidor al la configuracion de NIS /etc/yp.conf
```
# [domain (NIS domain) server (NIS server)]
domain srv.nis server Node03.srv.nis 
```
3. Configurar el metodo de autenticacion del cliente
* Añadir NIS como metodo de autenticacion
```
$ authselect select nis --force
rofile "nis" was selected.
The following nsswitch maps are overwritten by the profile:
- aliases
- automount
- ethers
- group
- hosts
- initgroups
- netgroup
- networks
- passwd
- protocols
- publickey
- rpc
- services
- shadow

Make sure that NIS service is configured and enabled. See NIS documentation for more information.
```
4. Añadir la caracteristica para crear directorio de home al primer inicio de sesion
```
$ authselect enable-feature with-mkhomedir 
```
5. Habilitar nis en SELinux (o desactivar SELinux si no es indispensable).
```
$ setsebool -P nis_enabled on 
```
6. Habilitar el servicio en systemd
```
$ systemctl enable --now rpcbind ypbind nis-domainname oddjobd 
```
7. Probar la correcta cofiguracion del cliente
* Confirmar si el enlazador tiene comunicacion con el servidor NIS
```
$ ypwhich
```
* Si todo sale bien debe aparecer el servidor en el dominio
```
Node03.src.nis
```
* Cambiar contraseña de NIS (Se proporcionara un script bash para automatizar este proceso)
```
$ yppasswd
```
## NFS
1. Instalar los paquetes necesarios para NFS
```
$ dnf -y install nfs-utils
```
2. Configurar el dominio del servidor NFS en el archivo /etc/idmapd.conf
```
# linea 5 donde esta el dominio por defecto poner el del servidor
Domain = srv.nis
```
3. Probar que hay acceso al servidor nfs
* Montar la carpeta del servidor NFS
```
$ mount -t nfs Node03.srv.nis:/home /home
```
* Si todo sale bien correr el siguiente comando que mostara que efectivamente esta operativa la particion del tipo nfs4
```
$ df -hT /home
S.ficheros           Tipo Tamaño Usados  Disp Uso% Montado en
Node03.srv.nis:/home nfs4    19G   1.3G   17G   8% /home
```
4. Añadir la particion al fstab, esto montara la carpeta una vez que se inicia el sistema
* Modificar el archivo /etc/fstab
```
# Añadir al final del archivo
Node03.srv.nis:/home/ /home               nfs     defaults        0 0
```
5. Añadir el montaje dinamico (En caso de una caida del servidor este volvera a montar cada vez que se quiera acceder al directorio asignado al NFS)
* Instalar AutoFS
```
dnf -y install autoFS
```
* Añadir la directiva de automontaje a la configuracion maestra de autoFS en el archivo /etc/auto.master
```
# Añadir al final
/-    /etc/auto.mount
```
* Crear la configuracion de automontaje /etc/auto.mount
```
# create new : [mount point] [option] [location]

/home   -fstype=nfs,rw  dlp.srv.world:/home
```
* Habilitar el servicio en systemd
```
$ systemctl enable --now autofs 
```