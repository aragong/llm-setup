#!/bin/bash
# Script para detener el devcontainer desde terminal

CONTAINER_NAME="llm-setup-dev"
VOLUME_NAME="llm-models"

echo "🐳 Deteniendo LLM-Setup DevContainer..."
echo "========================================"

if docker ps --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
    echo "✅ Deteniendo contenedor..."
    docker stop $CONTAINER_NAME
    echo ""
    echo "🗑️  Limpiando contenedor..."
    docker rm $CONTAINER_NAME
    echo ""
    echo "✅ Contenedor detenido y eliminado"
    echo ""
    echo "💾 El volumen '$VOLUME_NAME' y los modelos (~13 GB) se conservan"
    echo "   para la próxima vez que arranques el contenedor."
else
    echo "⚠️  El contenedor '$CONTAINER_NAME' no está corriendo"
    exit 1
fi
