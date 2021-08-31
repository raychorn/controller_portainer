#!/bin/bash

PWD=$(pwd)
DIR0=$(dirname $0)

if [ "$DIR0." == ".." ]; then
    DIR0=$PWD
fi
echo "DIR0=$DIR0"
echo "PWD=$PWD"

if [ -f "$DIR0/.env" ]; then
    echo "Importing environment variables."
    export $(cat $DIR0/.env | sed 's/#.*//g' | xargs)
    echo "Done importing environment variables."
else
    echo "ERROR: Environment variables not found. Please run the following command to generate them:"
    sleeping
fi

CID=$(docker ps -qf "name=$CNAME")

if [ -z "$CID" ]; then
    echo "Container $CNAME not found. Cannot continue."
else
    echo "BEGIN: Container $CNAME exists via $CID. Copying the file(s) to begin the deployment process."
    docker cp deploy_pihole.sh $CNAME:/deploy_pihole.sh
    echo "Files copied and permissions set. Good to go."
    echo "END!!!"
fi
