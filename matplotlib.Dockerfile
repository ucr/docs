# 打包镜像
FROM nginx:alpine

ARG SOURCE
COPY $SOURCE /usr/share/nginx/html

EXPOSE 80
