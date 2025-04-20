#!/bin/bash
set -e

CMD="./start.sh \
  -d ${DATA_DIRECTORY} \
  -ld ${LIBRARY_DIRECTORY}"

# Execute the final command
exec $CMD