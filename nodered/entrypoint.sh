#!/bin/bash
set -e

if [ -z $NODE_RED_PASSWORD ]; then
  echo "NODE_RED_PASSWORD variable is not defined."
  exit 1
fi

NODE_RED_PASSWORD=$(node -e "console.log(require('bcryptjs').hashSync(process.argv[1], 8));" $NODE_RED_PASSWORD)

trap stop SIGINT SIGTERM

function stop() {
        kill $CHILD_PID
        wait $CHILD_PID
}

/usr/local/bin/node $NODE_OPTIONS node_modules/node-red/red.js --userDir /data $FLOWS "${@}" &

CHILD_PID="$!"

wait "${CHILD_PID}"
