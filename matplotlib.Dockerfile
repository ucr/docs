# 编译
FROM python:3.12 AS build

# 安装依赖包
RUN apt-get update && apt-get install -y build-essential ffmpeg texlive-full texmaker graphviz

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
RUN pip install -r ./requirements/dev/dev-requirements.txt && \
    pip install --verbose --no-build-isolation --config-settings=editable-verbose=true --editable .[dev]
# 执行文档构建
RUN cd /data/doc && make html

# 打包镜像
FROM nginx:alpine

COPY --from=build /data/doc/build/html /usr/share/nginx/html

EXPOSE 80
