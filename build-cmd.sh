#!/usr/bin/env bash

cd "$(dirname "$0")"

# turn on verbose debugging output for parabuild logs.
exec 4>&1; export BASH_XTRACEFD=4; set -x

# make errors fatal
set -e

# complain about unreferenced environment variables
set -u

if [ -z "$AUTOBUILD" ] ; then
    exit 1
fi

if [ "$OSTYPE" = "cygwin" ] ; then
    autobuild="$(cygpath -u $AUTOBUILD)"
else
    autobuild="$AUTOBUILD"
fi

top="$(pwd)"
stage="$top/stage"

# load autobuild provided shell functions and variables
TINYGLTF_SOURCE_DIR="tinygltf-2.5.0"

pushd "$TINYGLTF_SOURCE_DIR"
    mkdir -p "$stage/include/tinygltf"
    cp -a tiny_gltf.h "$stage/include/tinygltf"
    cp -a stb_image.h "$stage/include/tinygltf"
    cp -a stb_image_write.h "$stage/include/tinygltf"
    cp -a json.hpp "$stage/include/tinygltf"
    mkdir -p "$stage/LICENSES"
    cp -a LICENSE "$stage/LICENSES/tinygltf_license.txt"
	echo "v2.5.0" > "$stage/include/tinygltf/tinygltf_version.txt"
popd

