#!/bin/bash

set -e

if [[ -z "$1" ]]; then
    echo "Usage: $0 <APK_FILE>"
    exit 1
else
    APK_PATH="$1"
    APK_FILE=${APK_PATH##*/}
    APK_NAME=${APK_FILE%%.*}
    ZIP_PATH="./${APK_NAME}_z"
fi


echo "Extracting APK..."
echo unzip $APK_FILE -d $ZIP_PATH
echo "Converting DEX to JAR..."
echo dex2jar ${ZIP_PATH}/classes.dex -o ${APK_NAME}.jar
echo "Decoding to SMIL..."
echo apktool decode ${APK_FILE}

