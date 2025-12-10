FROM nginx:1.21-alpine

# Копируем статические файлы
COPY index.html /usr/share/nginx/html/index.html

# Создаем entrypoint скрипт
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
