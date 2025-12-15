FROM nginx:alpine

# Копируем статичные файлы
COPY . /usr/share/nginx/html/

# Создаем кастомную конфигурацию nginx
RUN echo 'server { \
    listen 80; \
    server_name _; \
    root /usr/share/nginx/html; \
    \
    location / { \
        index index.html; \
        try_files $uri $uri/ /index.html; \
    } \
    \
    location /health { \
        access_log off; \
        return 200 "healthy\n"; \
        add_header Content-Type text/plain; \
    } \
    \
    location /nginx_status { \
        stub_status on; \
        access_log off; \
        allow all; \
    } \
    \
    error_page 404 /404.html; \
    error_page 500 502 503 504 /50x.html; \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
