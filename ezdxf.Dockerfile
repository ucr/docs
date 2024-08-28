# 编译
FROM python:3.12 AS build

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
RUN pip install -r requirements-dev.txt
RUN pip install .
# 执行文档构建
RUN cd ./docs && make --file Makefile.linux html

# 打包镜像
FROM nginx:latest

COPY --from=build /data/docs/build/html /usr/share/nginx/html

EXPOSE 80
