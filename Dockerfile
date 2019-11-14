FROM node:alpine

EXPOSE 8080

RUN \
  apk add --no-cache python make g++ && \
  apk add vips-dev fftw-dev build-base \
  --update-cache \
  --repository http://dl-3.alpinelinux.org/alpine/edge/community \
  --repository http://dl-3.alpinelinux.org/alpine/edge/main && \
  rm -fR /var/cache/apk/*

ENV NODE_PATH=/node_modules
ENV PATH=$PATH:/node_modules/.bin

RUN npm -g config set user root

RUN npm install -g yarn

RUN mkdir /app
WORKDIR /app

COPY package.json /app/package.json

RUN yarn install && yarn cache clean

COPY . /app

CMD ["yarn", "-v"]
