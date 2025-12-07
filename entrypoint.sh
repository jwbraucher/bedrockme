#!/bin/sh -ex

if [ "${AWS_LAMBDA_TASK_ROOT}" == "" ]; then
  /usr/local/bin/node index.js | tee ${BEDROCK_DIR}/${BEDROCK_FILE}
  exit $?
fi

/usr/local/bin/npx aws-lambda-ric $1
