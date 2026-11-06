#!/bin/bash
# Script para detener el devcontainer desde terminal

CONTAINER_NAME="llm-setup-dev"
VOLUME_NAME="llm-models"

echo "🐳 Deteniendo LLM-Setup DevContainer..."
echo "========================================"
echo ""

if docker ps --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
    echo "✅ Contenedor '$CONTAINER_NAME' está corriendo"
    
    echo "   Deteniendo..."
    if docker stop $CONTAINER_NAME; then
        echo "   ✅ Detenido"
    else
        echo "   ⚠️  Error al detener"
    fi
    
    echo ""
    echo "   Eliminando contenedor..."
    if docker rm $CONTAINER_NAME; then
        echo "   ✅ Contenedor eliminado"
    else
        echo "   ⚠️  Error al eliminar contenedor"
    fi
    
    echo ""
    echo "💾 El volumen '$VOLUME_NAME' y los modelos (~13 GB) se conservan"
    echo "   para la próxima vez que arranques el contenedor."
    
elif docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
    echo "⚠️  El contenedor '$CONTAINER_NAME' existe pero está detenido"
    echo "   ¿Quieres eliminarlo? (y=sí, n=no): "
    read -r answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        docker rm $CONTAINER_NAME 2>/dev/null || {
            echo "   ⚠️  Error al eliminar contenedor"
        }
    else
        echo "   Se mantiene el contenedor detenido"
    fi
else
    echo "⚠️  El contenedor '$CONTAINER_NAME' no se encuentra"
    echo ""
    echo "   Verificando si hay contenedores llm-setup..."
    docker ps -a | grep -i llm || echo "   No se encontraron contenedores llm-setup"
    exit 1
fi

echo ""
echo "✅ Operación completada"
