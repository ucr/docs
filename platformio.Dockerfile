# 编译
FROM python:3.12 AS build

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
RUN pip install sphinx sphinx_rtd_theme
# 执行文档构建
RUN make html

# 打包镜像
FROM nginx:alpine

COPY --from=build /data/_build/html /usr/share/nginx/html

EXPOSE 80
