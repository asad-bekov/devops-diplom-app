FROM nginx:alpine

# Копируем статичные файлы
COPY . /usr/share/nginx/html/

# Создаем health endpoint
RUN echo 'OK' > /usr/share/nginx/html/health

# Экспонируем порт
EXPOSE 80

# Запускаем nginx
CMD ["nginx", "-g", "daemon off;"]
