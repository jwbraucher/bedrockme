# bedrockme

This is a command-line tool for pulling the latest download url for the
minecraft linux bedrock server.

This is difficult because it requires a browser that can execute javascript, so
typical command-line tools like curl or wget will not work.

This is accomplished in this tool by using puppeteer and chromium running in a
node container.

## To execute bedrockme:  
```
docker run docker.io/jwbraucher/bedrockme:latest
```

## To build bedrockme:  
git clone https://github.com/jwbraucher/bedrockme
cd bedrockme
make

