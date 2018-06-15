#!/bin/bash

V2RAY_VER="v3.26"
PKG_VER="3.26.0-1"

WORK_PATH=$(dirname $(readlink -f $0))
BUILD_SCRIPT=$WORK_PATH/build.sh

$BUILD_SCRIPT $V2RAY_VER mipsle $PKG_VER mipsel
$BUILD_SCRIPT $V2RAY_VER arm $PKG_VER arm
$BUILD_SCRIPT $V2RAY_VER arm64 $PKG_VER arm

exit 0
