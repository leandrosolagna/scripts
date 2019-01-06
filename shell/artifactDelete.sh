#!/bin/bash

#############################################################################
#Script Name    :artifactDelete.sh                                          #
#Description    :get the info from the repo and delete the artifact name    #
#Args           :the username and password of artifactory                   #
#Author  	:Leandro Solagna                                            #
#Date   	:06/01/2019                                                 #
#############################################################################


ARTIFACTUSER=${1}
ARTIFACTPASSWD=${2}
ARTIURL="http://artifactory.com:8081/artifactory/target-repo"
FILEOUT=/tmp/artifactsFromRepo.out
FILEDEL=/tmp/artifactsForDEL.out

curl -u${ARTIFACTUSER}:${ARTIFACTPASSWD} -o ${FILEOUT} -k -L ${ARTIURL}

sed -ni 's/.*href="\([^"]*\).*/\1/p' "${FILEOUT}"
sed 's/\([0-9]\)/;\1/' "${FILEOUT}" | sort -n -t\; -k2,2 | tr -d ';' > "${FILEDEL}"

if [ "$(wc -l < ${FILEDEL})" -gt 2 ]; then
    echo "[INFO] DELETING OLD ARTIFACT NAMED "$(head -n 1 ${FILEDEL})""
    curl -u${ARTIFACTUSER}:${ARTIFACTPASSWD} -k -X DELETE ${ARTIURL}/$(head -n 1 ${FILEDEL})
else
    echo "[INFO] ONLY TWO OR LESS ARTIFACTS IN REPO. REPOSITORY IS OK"
fi

if [ -f "${FILEOUT}" ] && [ -f "${FILEDEL}" ] ; then
    rm "${FILEOUT}" "${FILEDEL}"
fi
