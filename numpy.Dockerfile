# 编译
FROM python:3.12 AS build

# 安装依赖包
RUN apt-get update && apt-get install -y build-essential

WORKDIR /data
ARG SOURCE
COPY $SOURCE .

# 打包镜像
FROM nginx:alpine

COPY --from=build /data /usr/share/nginx/html

EXPOSE 80
