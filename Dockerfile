FROM node:23-alpine
WORKDIR /opt/bedrockme
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true"

RUN apk add --no-cache \
    git \
    udev \
    ttf-freefont \
    chromium

COPY main.js /opt/bedrockme/main.js
COPY package.json /opt/bedrockme/package.json
RUN npm install
ENTRYPOINT ["/usr/local/bin/node", "/opt/bedrockme/main.js"]
