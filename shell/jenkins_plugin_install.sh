#!/bin/bash

#############################################################################
#Script Name	:jenkins_plugin_install					    #
#Description	:read plugins name and version from a file and install them #
#Author     	:Leandro Solagna                                            #
#Date       	:11/01/2019						    #
#############################################################################

HOST=https://jenkins-URL
URL=/pluginManager/installNecessaryPlugins
USER="user"
TOKEN="usertoken"
COMMAND="curl -u $USER:$TOKEN -X POST -d"
FILE=/path/to/file

while read LINE
do
    	$COMMAND '<jenkins><install plugin="'${LINE}'" /></jenkins>' --header 'Content-Type: text/xml' $HOST$URL
done < ${FILE}

sleep 10

curl -u $USER:$TOKEN -X POST $HOST/safeRestart
