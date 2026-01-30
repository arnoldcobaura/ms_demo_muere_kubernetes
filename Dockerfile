FROM alpine

# Instalar date y bash
RUN apk add --no-cache bash coreutils

# Contenedor que falla cada 10 segundos
CMD echo "👋 Hola, soy un contenedor"; \
    echo "⏳ Viviré 10 segundos a las $(date '+%Y-%m-%d %H:%M:%S')"; \
    sleep 10; \
    echo "💀 Me estoy apagando a las $(date '+%Y-%m-%d %H:%M:%S')"; \
    exit 1
