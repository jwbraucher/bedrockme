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

# setup user for lambda / node
RUN adduser -D -h /tmp/home app
ENV HOME=/tmp/home
ENV NPM_CONFIG_CACHE=${HOME}/.npm

# setup lambda base
RUN npm install -g aws-lambda-ric
ARG FUNCTION_DIR="/function"
WORKDIR ${FUNCTION_DIR}

# deploy nodejs deps
COPY \
  package.json \
  package-lock.json \
  ${FUNCTION_DIR}

ENV PUPPETEER_SKIP_DOWNLOAD="true"
RUN npm install

# deploy the app
COPY \
  entrypoint.sh \
  index.js \
  ${FUNCTION_DIR}

RUN chown -R app:app /function /tmp/home
RUN chmod -R a+rX /function /tmp/home

USER app
ENTRYPOINT ["/bin/sh", "/function/entrypoint.sh"]
CMD [ "src/index.handler" ]
