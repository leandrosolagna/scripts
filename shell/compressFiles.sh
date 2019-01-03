#!/bin/bash

WORKSPACE=${1}
FILENAME="file_`date "+%Y%m%d%H%M"`_`head -n 1 ${WORKSPACE}/.git/FETCH_HEAD | cut -c-8`.tar.gz"

echo ""
echo "[INFO] Creating new archive ${FILENAME}"
echo ""

cd ${WORKSPACE}/files
tar -czf ${WORKSPACE}/${FILENAME} files
