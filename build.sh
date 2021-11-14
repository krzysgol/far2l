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
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DUSEWX=yes -DCMAKE_BUILD_TYPE=Debug ..
	if [ $? -eq 0 ];
	then
		make -j$CONCURRENCY
	fi
else
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DUSEWX=yes -DCMAKE_BUILD_TYPE=Release ..
	if [ $? -eq 0 ];
	then
		make -j$CONCURRENCY
	fi
	rm -r /Applications/far2l.app
    cp -r install/far2l.app /Applications/
fi

popd > /dev/null
