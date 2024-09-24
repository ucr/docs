# 编译
FROM python:3.12 AS build

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
COPY overrides ./build/overrides
COPY docs ./build/docs
COPY codes ./build/codes
RUN pip install mkdocs mkdocs-material mkdocs-glightbox
# 执行文档构建
RUN mkdocs build -f mkdocs.yml

# 打包镜像
FROM nginx:alpine

COPY --from=build /data/site /usr/share/nginx/html

EXPOSE 80
