#!/bin/bash

V2RAY_VER=$1
V2RAY_ARCH=$2
PKG_VER=$3
PKG_ARCH=$4

WORK_PATH=$(dirname $(readlink -f $0))
TEMP_PATH=$WORK_PATH/tmp
RELEASE_PATH=$WORK_PATH/packages
IPKG_BUILD=$WORK_PATH/ipkg-build

rm -rf $TEMP_PATH >/dev/null 2>&1
mkdir $TEMP_PATH
mkdir $RELEASE_PATH >/dev/null 2>&1

echo "Building $PKG_VER for ${V2RAY_ARCH}..."

cd $TEMP_PATH
wget https://github.com/v2ray/v2ray-core/releases/download/${V2RAY_VER}/v2ray-linux-${V2RAY_ARCH}.zip
unzip -j -o v2ray-linux-${V2RAY_ARCH}.zip "*/v2ray" "*/v2ctl" -d ../../pkg_file/opt/bin/v2ray/
rm v2ray-linux-${V2RAY_ARCH}.zip
sed -i "/Architecture/c\Architecture: $PKG_ARCH" ../../pkg_file/CONTROL/control
sed -i "/Version/c\Version: $PKG_VER" ../../pkg_file/CONTROL/control
$IPKG_BUILD -c -o admin -g root ../../pkg_file ./ >/dev/null 2>&1

if [ $PKG_ARCH == "arm" -a $V2RAY_ARCH == "arm64" ]; then
    mv -f v2ray_${PKG_VER}_${PKG_ARCH}.ipk $RELEASE_PATH/v2ray_${PKG_VER}_${V2RAY_ARCH}.ipk
    echo "Build complete: $RELEASE_PATH/v2ray_${PKG_VER}_${V2RAY_ARCH}.ipk"
else
    mv -f v2ray_${PKG_VER}_${PKG_ARCH}.ipk $RELEASE_PATH/
    echo "Build complete: $RELEASE_PATH/v2ray_${PKG_VER}_${PKG_ARCH}.ipk"
fi

exit 0
