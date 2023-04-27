#!/bin/bash
if [ $# -ne 1 ]
then
    echo "Missing argument: JAVA version"
    exit 1
else

JAVA_VERSION=$1

sed -E******