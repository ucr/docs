# 编译
FROM python:3.12 AS build

RUN apt-get update && apt-get install -y build-essential valgrind curl --no-install-recommends

RUN pip install cmake numpy Cython pytest pytest-valgrind

WORKDIR /data

ENV PYTHONMALLOC malloc

ENV LD_LIBRARY_PATH /usr/local/lib

# Build GEOS
RUN export GEOS_VERSION=3.10.3 && \
    mkdir /data/geos && cd /data/geos && \
    curl -OL http://download.osgeo.org/geos/geos-$GEOS_VERSION.tar.bz2 && \
    tar xfj geos-$GEOS_VERSION.tar.bz2 && \
    cd geos-$GEOS_VERSION && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR=lib .. && \
    cmake --build . -j 4 && \
    cmake --install . && \
    cd /data

ARG SOURCE
COPY $SOURCE /data

# Build shapely
RUN python setup.py build_ext --inplace && python setup.py install
# 安装依赖包
RUN pip install .
# 执行文档构建
RUN cd /data/docs && make html

# 打包镜像
FROM nginx:alpine

COPY --from=build /data/docs/build/html /usr/share/nginx/html

EXPOSE 80
