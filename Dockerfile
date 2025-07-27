FROM node:20-alpine3.16
WORKDIR /opt/bedrockme

RUN apk add --no-cache \
  autoconf \
  automake \
  chromium \
  cmake \
  curl-dev \
  g++ \
  git \
  libexecinfo \
  libexecinfo-dev \
  libtool \
  make \
  nodejs \
  npm \
  python3 \
  ttf-freefont \
  udev \
  unzip

RUN npm install -g aws-lambda-ric

ARG FUNCTION_DIR="/function"
WORKDIR ${FUNCTION_DIR}

# nodejs config
COPY \
  package.json \
  package-lock.json \
  ${FUNCTION_DIR}

ENV PUPPETEER_SKIP_DOWNLOAD="true"
RUN npm install

COPY \
  entrypoint.sh \
  index.js \
  ${FUNCTION_DIR}

ENTRYPOINT ["/bin/sh", "/function/entrypoint.sh"]
