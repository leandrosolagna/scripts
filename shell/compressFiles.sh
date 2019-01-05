#!/bin/bash

#############################################################################
#Script Name    :compressFiles.sh                                           #
#Description    :compress a bunch of files and add the date and githash     #
#Args           :the workspace to where the directory is                    #
#Author  	:Leandro Solagna                                            #
#Date   	:03/01/2019                                                 #
#############################################################################

WORKSPACE=${1}
FILENAME="file_`date "+%Y%m%d%H%M"`_`head -n 1 ${WORKSPACE}/.git/FETCH_HEAD | cut -c-8`.tar.gz"

echo ""
echo "[INFO] Creating new archive ${FILENAME}"
echo ""

cd ${WORKSPACE}/files
tar -czf ${WORKSPACE}/${FILENAME} files
