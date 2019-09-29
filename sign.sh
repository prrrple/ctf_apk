#!/bin/bash

set -e

   
if [[ -z "$1" ]]; then
    echo "Usage: $0 <APK_BASE> [KEYFILE]"
    echo "Where APK_BASE is the name of the apktool directory"
    exit 1
else
    SRC_APK="${1}/dist/${1}.apk"
    DST_APK="${1}-mod.apk"
fi

function echo_var() {
    echo -en "\033[97m$1: "
    echo -e "\033[0m$2"
}

echo_var "Unsigned APK" $SRC_APK
echo_var "Signed APK" "$DST_APK"

if [[ -z "$2" ]]; then
    for f in *.jks; do
        KEYFILE="$f"
        break
    done
else
    KEYFILE="$2"
fi

echo_var "Using keyfile" "${KEYFILE}"

for p in $ANDROID_HOME/build-tools/*; do
    BUILD_TOOLS_ROOT="$p"
done

echo_var "Using SDK version" "${BUILD_TOOLS_ROOT##*/}"

echo '' 
$BUILD_TOOLS_ROOT/apksigner sign --ks nisctf-release-key.jks --out $DST_APK $SRC_APK 
