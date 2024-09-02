# 编译
FROM python:3.12 AS build

# 安装依赖包
RUN apt-get update && apt-get install -y build-essential

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
RUN pip install -r ./requirements/doc-requirements.txt && \
    pip install .[dev]
# 执行文档构建
RUN cd /data/doc && make html

# 打包镜像
FROM nginx:alpine

COPY --from=build /data/doc/build/html /usr/share/nginx/html

EXPOSE 80
