# 编译
FROM rust:latest AS build

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
RUN curl -sSL https://github.com/KaiserY/mdbook-typst-pdf/releases/download/v0.4.4/mdbook-typst-pdf-x86_64-unknown-linux-musl.tar.xz | tar -xJ --directory=bin --strip-components 1
RUN cargo install mdbook && rustup update && rustup component add rust-docs
# 执行文档构建
RUN mdbook build

# 打包镜像
FROM nginx:alpine

COPY --from=build /data/book/html /usr/share/nginx/html

EXPOSE 80
