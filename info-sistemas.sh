#!/bin/bash

# Colores para mejor legibilidad
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
print_banner() {
    echo -e "${CYAN}"
    echo "  ____               __  __  ___  ____  "
    echo " |  _ \ __ _ _ __   \ \/ / / _ \/ ___| "
    echo " | |_) / _' | '_ \   \  / | | | \___ \ "
    echo " |  __/ (_| | | | |  /  \ | |_| |___) |"
    echo " |_|   \__,_|_| |_| /_/\_\ \___/|____/ "
    echo -e "${NC}"
    echo "Creado por PanXOS"
    echo "Contacto: faravena@soporteinfo.net"
    echo "https://github.com/panxos"
    echo ""
}

# Función para imprimir secciones
print_section() {
    echo -e "\n${BLUE}## $1 ##${NC}"
}

# Función para imprimir información
print_info() {
    echo -e "${GREEN}$1:${NC} $2"
}

# Función para imprimir advertencias
print_warning() {
    echo -e "${YELLOW}[!] $1${NC}"
}

# Función para imprimir errores
print_error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

# Función para comprobar si un comando está disponible
check_command() {
    if ! command -v $1 &> /dev/null; then
        print_warning "El comando $1 no está disponible. Algunas funciones pueden no estar disponibles."
        return 1
    fi
    return 0
}

# Función para obtener información del sistema
get_system_info() {
    print_section "Información del Sistema Operativo"
    OS_NAME=$(lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om)
    OS_VERSION=$(lsb_release -rs 2>/dev/null || cat /etc/*release 2>/dev/null | grep "VERSION_ID" | cut -d= -f2 | tr -d '"')
    KERNEL_VERSION=$(uname -r)
    print_info "Distribución" "$OS_NAME"
    print_info "Versión" "$OS_VERSION"
    print_info "Kernel" "$KERNEL_VERSION"

    print_section "Información del Hardware"
    CPU_MODEL=$(lscpu | grep "Model name" | cut -d: -f2 | sed 's/^[ \t]*//')
    CPU_CORES=$(nproc)
    TOTAL_RAM=$(free -h | awk '/^Mem:/ {print $2}')
    TOTAL_SWAP=$(free -h | awk '/^Swap:/ {print $2}')
    print_info "Modelo de CPU" "$CPU_MODEL"
    print_info "Núcleos de CPU" "$CPU_CORES"
    print_info "RAM Total" "$TOTAL_RAM"
    print_info "Swap Total" "$TOTAL_SWAP"

    print_section "Información de Almacenamiento"
    df -h | awk '$NF=="/" {print "Espacio en disco (/) : "$2" (Total), "$4" (Disponible)"}'

    print_section "Información de Red"
    IP_ADDRESS=$(hostname -I | awk '{print $1}')
    print_info "Dirección IP" "$IP_ADDRESS"

    if check_command "netstat"; then
        print_info "Puertos abiertos" "$(netstat -tuln | grep LISTEN | awk '{print $4}' | cut -d: -f2 | sort -u | tr '\n' ', ')"
    fi

    print_section "Información de Compiladores"
    GCC_VERSION=$(gcc --version 2>/dev/null | sed -n '1s/^.* //p')
    GPLUS_VERSION=$(g++ --version 2>/dev/null | sed -n '1s/^.* //p')
    PYTHON_VERSION=$(python3 --version 2>/dev/null | cut -d' ' -f2)
    JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    print_info "GCC" "${GCC_VERSION:-No instalado}"
    print_info "G++" "${GPLUS_VERSION:-No instalado}"
    print_info "Python" "${PYTHON_VERSION:-No instalado}"
    print_info "Java" "${JAVA_VERSION:-No instalado}"

    print_section "Información de Seguridad"
    FIREWALL_STATUS=$(systemctl is-active ufw 2>/dev/null || echo "No instalado")
    SELINUX_STATUS=$(getenforce 2>/dev/null || echo "No instalado")
    print_info "Firewall (UFW)" "$FIREWALL_STATUS"
    print_info "SELinux" "$SELINUX_STATUS"

    if check_command "clamav"; then
        CLAMAV_VERSION=$(clamscan --version | awk '{print $2}')
        print_info "ClamAV" "$CLAMAV_VERSION"
    else
        print_info "ClamAV" "No instalado"
    fi

    print_section "Procesos y Carga del Sistema"
    LOAD_AVERAGE=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | sed 's/^[ \t]*//')
    RUNNING_PROCESSES=$(ps aux | wc -l)
    print_info "Carga promedio (1 min)" "$LOAD_AVERAGE"
    print_info "Procesos en ejecución" "$RUNNING_PROCESSES"

    print_section "Tiempo de Actividad del Sistema"
    UPTIME=$(uptime -p)
    print_info "Tiempo de actividad" "$UPTIME"

    if check_command "docker"; then
        print_section "Información de Docker"
        DOCKER_VERSION=$(docker --version | awk '{print $3}' | sed 's/,//')
        DOCKER_CONTAINERS=$(docker ps -q | wc -l)
        print_info "Versión de Docker" "$DOCKER_VERSION"
        print_info "Contenedores en ejecución" "$DOCKER_CONTAINERS"
    fi

    print_section "Estado de Servicios Importantes"
    check_service() {
        local service_name=$1
        local service_status=$(systemctl is-active $service_name 2>/dev/null || echo "No instalado")
        print_info "$service_name" "$service_status"
    }

    check_service "ssh"
    check_service "apache2"
    check_service "nginx"
    check_service "mysql"
    check_service "postgresql"

    print_section "Información de Usuarios"
    USERS_COUNT=$(who | wc -l)
    LAST_LOGIN=$(last -n 1 | head -n 1 | awk '{print $1 " " $4 " " $5 " " $6 " " $7}')
    print_info "Usuarios conectados" "$USERS_COUNT"
    print_info "Último login" "$LAST_LOGIN"

    print_section "Información de Virtualización"
    if systemd-detect-virt --quiet; then
        VIRT_TYPE=$(systemd-detect-virt)
        print_info "Tipo de virtualización" "$VIRT_TYPE"
    else
        print_info "Tipo de virtualización" "No detectada"
    fi

    print_section "Información de GPU"
    if check_command "lspci"; then
        GPU_INFO=$(lspci | grep -i 'vga\|3d\|2d')
        print_info "GPU" "$GPU_INFO"
    else
        print_info "GPU" "Información no disponible"
    fi

    print_section "Chequeo de Actualizaciones"
    if check_command "apt"; then
        UPDATES_AVAILABLE=$(apt list --upgradable 2>/dev/null | grep -c upgradable)
        print_info "Actualizaciones disponibles" "$UPDATES_AVAILABLE"
    else
        print_info "Actualizaciones disponibles" "No se pudo verificar"
    fi

    print_section "Resumen de Logs del Sistema"
    if check_command "journalctl"; then
        RECENT_ERRORS=$(journalctl -p 3 -xn 5 --no-pager)
        echo -e "${YELLOW}Últimos 5 errores del sistema:${NC}"
        echo "$RECENT_ERRORS"
    else
        print_warning "journalctl no está disponible. No se pueden mostrar los logs del sistema."
    fi
}

# Función principal
main() {
    print_banner
    get_system_info
    echo -e "\n${YELLOW}Nota: Este script proporciona una visión general del sistema. Para información más detallada, consulte los comandos específicos o archivos de log.${NC}"
}

# Manejo de opciones de línea de comandos
while getopts ":ho:" opt; do
  case ${opt} in
    h )
      echo "Uso:"
      echo "    $0 [-o output] [-h]"
      echo "Opciones:"
      echo "    -o output    Exportar resultado a un archivo"
      echo "    -h           Mostrar esta ayuda"
      exit 0
      ;;
    o )
      output=$OPTARG
      ;;
    \? )
      print_error "Opción inválida: $OPTARG" 1>&2
      exit 1
      ;;
    : )
      print_error "La opción -$OPTARG requiere un argumento." 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

# Ejecutar el script y exportar si se especifica
if [ -n "$output" ]; then
    main | tee "$output"
    print_success "Resultado exportado a $output"
else
    main
fi
