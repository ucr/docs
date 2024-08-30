# 编译
FROM python:3.12 AS build

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
RUN pip install -r ./requirements/dev/dev-requirements.txt && pip install .[dev]
# 执行文档构建
RUN cd /data/doc && make html-noplot

# 打包镜像
FROM nginx:alpine

COPY --from=build /data/docs/build/html /usr/share/nginx/html

EXPOSE 80
