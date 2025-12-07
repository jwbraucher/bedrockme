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

ENV HOME=/tmp/home
ENV BEDROCK_DIR=/minecraft
ENV BEDROCK_FILE=bedrock-url.txt
ENV TASK_DIR="/function"
ARG FUNCTION_DIR="/function"

RUN mkdir -p \
  ${FUNCTION_DIR} \
  ${TASK_DIR} \
  ${HOME} \
  ${BEDROCK_DIR}

# setup user for lambda / node
RUN adduser -D -h ${HOME} app
ENV NPM_CONFIG_CACHE=${HOME}/.npm

# setup lambda base
RUN npm install -g aws-lambda-ric
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

RUN chown -R app:app ${BEDROCK_DIR} ${HOME} ${FUNCTION_DIR}
RUN chmod -R a+rX ${BEDROCK_DIR} ${HOME} ${FUNCTION_DIR}

USER app
ENTRYPOINT ["/bin/sh", "/function/entrypoint.sh"]
CMD [ "index.handler" ]
