FROM node:18-alpine

WORKDIR /usr/app

COPY ./ ./

RUN npm ci

RUN npm run type-check

RUN npm run build:prod

RUN cp -r ./dist ./server/public

RUN cd server && npm ci

ENV PORT=8083
CMD node server/index.js

