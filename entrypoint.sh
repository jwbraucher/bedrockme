#!/bin/sh -ex

if [ "${LAMBDA_TASK_ROOT}" == "" ]; then
  /usr/local/bin/node index.js
  exit $?
fi

/usr/local/bin/npx aws-lambda-ric $*
