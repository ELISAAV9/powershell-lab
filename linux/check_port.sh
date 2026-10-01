#!/bin/bash
# Uso: ./check_port.sh <puerto>

# 1. Validar que se recibió exactamente un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <puerto>"
    exit 1
fi

PUERTO=$1

# 2. Validar que sea un número entre 1 y 65535
if ! [[ "$PUERTO" =~ ^[0-9]+$ ]] || [ "$PUERTO" -lt 1 ] || [ "$PUERTO" -gt 65535 ]; then
    echo "Error: '$PUERTO' no es un puerto válido (1-65535)"
    exit 1
fi

# 3. Intentar conectar por TCP a localhost con límite de 2 segundos
if timeout 2 bash -c "echo > /dev/tcp/127.0.0.1/$PUERTO" 2>/dev/null; then
    echo "El puerto $PUERTO está ABIERTO"
    exit 0
else
    echo "El puerto $PUERTO está CERRADO"
    exit 2
fi
