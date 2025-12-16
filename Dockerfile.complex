FROM nginx:alpine

# Устанавливаем envsubst для подстановки переменных
RUN apk add --no-cache gettext

# Копируем статичные файлы
COPY html/index.html.template /usr/share/nginx/html/index.html.template
COPY health.html /usr/share/nginx/html/health.html

# Создаем entrypoint скрипт
RUN echo '#!/bin/sh\n\
# Подставляем переменные окружения в шаблон\n\
envsubst "$$GIT_SHA $$DEPLOY_METHOD $$REGISTRY $$ENVIRONMENT" < /usr/share/nginx/html/index.html.template > /usr/share/nginx/html/index.html\n\
# Запускаем nginx\n\
exec nginx -g "daemon off;"' > /docker-entrypoint.d/20-process-template.sh && \
    chmod +x /docker-entrypoint.d/20-process-template.sh

# Создаем кастомную конфигурацию nginx
RUN echo 'server { \
    listen 80; \
    server_name _; \
    root /usr/share/nginx/html; \
    \
    location / { \
        index index.html; \
        try_files $$uri $$uri/ /index.html; \
    } \
    \
    location /health { \
        alias /usr/share/nginx/html/health.html; \
    } \
    \
    location /nginx_status { \
        stub_status on; \
        access_log off; \
        allow all; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Переменные окружения по умолчанию
ENV GIT_SHA=manual-build \
    DEPLOY_METHOD=manual \
    REGISTRY=local \
    ENVIRONMENT=development

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
