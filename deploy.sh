#!/bin/bash
echo "inicia el bash"
# Actualizar la lista de paquetes
apt-get update -y

# Actualizar los paquetes instalados
apt-get upgrade -y

# Instalar Git
apt-get install git -y

# Instalar Node.js
apt-get install nodejs -y

# Instalar npm
apt-get install npm -y

# Clonar el repositorio desde GitHub
git clone https://github.com/jhonatanBaron/RemoteExecutionNodejsBack.git

# Entrar en el directorio del proyecto clonado
#cd servidor

# Instalar las dependencias del proyecto usando npm

# esta es la direccion de nuestro directorio donde se encuentra el código del sitio
WEB_DIR="/var/www/html"

# direccion de nuestro repositorio de GitHub
REPO_URL="https://github.com/jhonatanBaron/RemoteExecutionNodejsBack.git"

# Descargamos el código más reciente
if [ -d "$WEB_DIR" ]; then
    cd $WEB_DIR
    git pull origin main
else
    git clone $REPO_URL $WEB_DIR
fi

#  ??? Minificar archivos (si es necesario)
npm run build

# Reiniciamos servidor web (ejemplo con Nginx)
sudo systemctl restart nginx

echo "termina el bash"

