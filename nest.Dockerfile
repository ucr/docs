# 编译
FROM node:hydrogen-alpine AS build

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
RUN npm install
# 执行文档构建
RUN npm run build

# 打包镜像
FROM nginx:alpine

COPY --from=build /data/dist /usr/share/nginx/html

EXPOSE 80
