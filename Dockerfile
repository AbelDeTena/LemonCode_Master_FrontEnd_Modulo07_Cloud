FROM node:18-alpine AS base

WORKDIR /usr/app

FROM base AS build-front

COPY ./ ./
RUN npm ci
RUN npm run type-check
RUN npm run build:prod

FROM base AS release
COPY --from=build-front /usr/app/dist ./public
COPY ./server/package.json ./
COPY ./server/package-lock.json ./
COPY ./server/index.js ./
RUN  npm ci --only=production

ENV PORT=8083
CMD node index.js

