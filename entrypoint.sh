#!/bin/sh -ex

MODE="${MODE:-lambda}"

if [ "${MODE}" != "lambda" ]; then
  /usr/local/bin/node index.js
  exit $?
fi

/usr/local/bin/npx aws-lambda-ric $*
