#!/bin/sh
# Динамически обновляем hostname и timestamp
HOSTNAME=$(hostname)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

sed -i "s/{{HOSTNAME}}/$HOSTNAME/g" /usr/share/nginx/html/index.html
sed -i "s/{{TIMESTAMP}}/$TIMESTAMP/g" /usr/share/nginx/html/index.html

# Запускаем nginx
exec nginx -g 'daemon off;'
