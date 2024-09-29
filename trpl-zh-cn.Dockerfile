# 编译
FROM rust:latest AS build

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
RUN cargo install mdbook && rustup install  --component rust-docs
# 执行文档构建
RUN mdbook build

# 打包镜像
FROM nginx:alpine

COPY --from=build /data/book/html /usr/share/nginx/html

EXPOSE 80
