#!/bin/bash

[ -z $AWS_ACCESS_KEY ] && { echo "no value for AWS_ACCESS_KEY"; exit 1; }
[ -z $AWS_SECRET_KEY ] && { echo "no value for AWS_SECRET_KEY"; exit 1; }
[ -z $BUCKET ]         && { echo "no value for BUCKET"; exit 1; } ## asl-docker
[ -z $REPO ]           && { echo "no value for REPO"; exit 1; } ## el6

set -e

basedir=$( cd $( dirname $0 ) && /bin/pwd )

[ -d ${basedir}/rpms ] || mkdir -p ${basedir}/rpms

docker run \
    -v ${basedir}:/scripts \
    -v ${basedir}/rpms:/rpms \
    -e AWS_ACCESS_KEY \
    -e AWS_SECRET_KEY \
    -e BUCKET \
    -e REPO \
    -i -t \
    zardoz.podzone.org:11003/tools/centos-buildtools \
    /scripts/build_all.sh
