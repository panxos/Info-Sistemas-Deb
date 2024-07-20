# Info-Sistemas.sh

![PanXOS Logo](https://raw.githubusercontent.com/panxos/ConfServerDebian/main/panxos_logo.png)

## 📖 Descripción

Info-Sistemas.sh es un script de Bash completo diseñado para recopilar y mostrar información detallada sobre un sistema Linux basado en Debian. Proporciona una forma rápida y fácil de obtener una visión general de varios componentes del sistema, convirtiéndolo en una herramienta invaluable para administradores de sistemas, desarrolladores y usuarios avanzados.

## 🚀 Características

- **Información del Sistema**: Detalles del SO, versión del kernel
- **Detalles del Hardware**: Modelo de CPU, núcleos, RAM, swap
- **Información de Almacenamiento**: Uso del disco
- **Configuración de Red**: Dirección IP, puertos abiertos
- **Versiones de Compiladores**: GCC, G++, Python, Java
- **Estado de Seguridad**: Firewall, SELinux, ClamAV
- **Carga del Sistema**: Promedio de carga actual, procesos en ejecución
- **Información de Tiempo de Actividad**
- **Detalles de Docker** (si está instalado)
- **Estado de Servicios**: SSH, Apache, Nginx, MySQL, PostgreSQL
- **Información de Usuarios**: Usuarios conectados, último inicio de sesión
- **Detalles de Virtualización**
- **Información de GPU**
- **Actualizaciones del Sistema**: Conteo de actualizaciones disponibles
- **Registros Recientes del Sistema**: Últimos 5 errores del sistema

## 🛠️ Instalación

1. Clona este repositorio:
   ```
   git clone https://github.com/panxos/Info-Sistemas-Deb.git
   ```
2. Navega al directorio del script:
   ```
   cd Info-Sistemas-Deb
   ```
3. Haz el script ejecutable:
   ```
   chmod +x info-sistemas.sh
   ```

## 💻 Uso

Ejecuta el script con:

```
./info-sistemas.sh
```

### Opciones:

- `-o <nombre_archivo>`: Exporta la salida a un archivo
- `-h`: Muestra información de ayuda

Ejemplo:
```
./info-sistemas.sh -o informe_sistema.txt
```

## 📊 Salida

El script proporciona una salida colorizada para mejor legibilidad, organizada en secciones:

- 🖥️ Información del Sistema
- 🔧 Información del Hardware
- 💽 Información de Almacenamiento
- 🌐 Información de Red
- 🏗️ Información de Compiladores
- 🔒 Información de Seguridad
- 📈 Carga del Sistema y Procesos
- ⏱️ Información de Tiempo de Actividad
- 🐳 Información de Docker (si aplica)
- 🔄 Estado de Servicios
- 👥 Información de Usuarios
- 🖼️ Información de Virtualización
- 🎮 Información de GPU
- 🔄 Actualizaciones del Sistema
- 📝 Registros Recientes del Sistema

## 📋 Requisitos

- Sistema operativo basado en Debian
- Shell Bash
- Acceso root o sudo para funcionalidad completa
- Utilidades comunes de Linux (la mayoría están preinstaladas en distribuciones estándar)

## 🤝 Contribuciones

¡Las contribuciones, problemas y solicitudes de características son bienvenidas! No dudes en revisar la [página de problemas](https://github.com/panxos/Info-Sistemas-Deb/issues).

## 👨‍💻 Autor

**PanXOS**

- GitHub: [@panxos](https://github.com/panxos)
- Correo electrónico: faravena@soporteinfo.net

## 📜 Licencia

Este proyecto está bajo la licencia [MIT](https://opensource.org/licenses/MIT).

## 🙏 Agradecimientos

- Todas las herramientas y bibliotecas de código abierto utilizadas en este script
- La comunidad de Linux por su continua inspiración y apoyo
