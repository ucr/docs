# 编译
FROM python:3.12 AS build

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
RUN pip install -r requirements-docs.txt
# 执行文档构建
RUN cd ./doc && make html

# 打包镜像
FROM nginx:alpine

COPY --from=build /data/doc/build/html /usr/share/nginx/html

EXPOSE 80
