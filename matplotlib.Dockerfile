# 打包镜像
FROM nginx:alpine

COPY $SOURCE /usr/share/nginx/html

EXPOSE 80
