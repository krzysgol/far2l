#!/bin/bash

set -e

CONCURRENCY=$(sysctl -n hw.logicalcpu)

mkdir -p build > /dev/null
pushd build > /dev/null

if [ "$1" == "clean" ]
then
	cd .. > /dev/null
	rm -rf build
elif [ "$1" == "debug" ]
then
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DUSEWX=yes -DCMAKE_BUILD_TYPE=Debug -D CMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.1.sdk ..
	if [ $? -eq 0 ];
	then
		make -j$CONCURRENCY
	fi
else
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DUSEWX=yes -DCMAKE_BUILD_TYPE=Release -D CMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.1.sdk ..
	if [ $? -eq 0 ];
	then
		make -j$CONCURRENCY
	fi
	rm -rf /Applications/far2l.app
    cp -r install/far2l.app /Applications/
fi

popd > /dev/null
