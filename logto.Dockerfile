# 编译
FROM node:hydrogen-alpine AS build

WORKDIR /data
ARG SOURCE
COPY $SOURCE .
RUN corepack enable pnpm && pnpm install
# 执行文档构建
RUN pnpm build

# 执行容器
EXPOSE 3000
CMD ["pnpm", "serve"]
