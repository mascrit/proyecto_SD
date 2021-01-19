# Configuracion cliente Windows
### Preparativos
#### Configurar tarjeta de red
* Añadir el DNS y asignar una ip estatica a la tarjeta de red en el administrador de dispositivos
* En servidor DNS poner la IP del servidor SAMBA AD DC
![Captura de administrador de dispositivos](images/config_red_win.PNG?raw=true "Administrador de red")
## SAMBA AD DC
#### Añadir cliente a dominio
* Click derecho a equipo y propiedades/configuracion avanzada/Nombre de equipo/ boton cambiar...
![Configuracion Nombre equipo](images/config_cambiar.PNG?raw=true "Nombre equipo")
* En la seccion Miembro del seleccionar Dominio poner el dominio del servidor SAMBA que es srv.nis
![Captura de asignacion de dominio](images/config_cambiar_domi.PNG?raw=true "Asignacion de dominio") 
* Si sale un dialogo de inicio de sesion usar el usuario "Administrator" y poner la contraseña proporcionada en la configuracion
* Añadir el script drive.bat a la carpeta de programas de inicio para automontar la unidad Z al inicio de sesion de cada usuario.
![Captura de menu de inicio](images/menu_inicio.png?raw=true "Menu de inicio") 
* el contenido de este drive.bat es el siguiente
```bat
net use Z: \\SRV.NIS\%USERNAME% /PERSISTENT:YES
```
* Para adaptar a caso de uso diferente modificar \\SRV.NIS por el nombre de dominio correspondiente
* Reiniciar equipo
* Si todo sale bien debe poder iniciar sesion con los usuarios creados en el servidor SAMBA
![Captura de inicio de sesion](images/inicio_sesion.PNG?raw=true "Inicio de sesion")
* Si todo sale bien la unidad Z con la carpeta home del usuario debe montarse al inicio de cada sesion
![Captura de inicio de sesion](images/samba_drive_z.PNG?raw=true "Inicio de sesion") 