#!/bin/bash

VERSION="1.0.0"

mkdir -p ./build/
mkdir -p ./build/libIDSSVfs_${VERSION}_amd64/
mkdir -p ./build/libIDSSVfs_${VERSION}_amd64/DEBIAN/
mkdir -p ./build/libIDSSVfs_${VERSION}_amd64/usr/
mkdir -p ./build/libIDSSVfs_${VERSION}_amd64/usr/bin/
mkdir -p ./build/libIDSSVfs_${VERSION}_amd64/usr/include/
mkdir -p ./build/libIDSSVfs_${VERSION}_amd64/usr/include/IDSSVfs/
mkdir -p ./build/libIDSSVfs_${VERSION}_amd64/usr/lib/
mkdir -p ./build/libIDSSVfs_${VERSION}_amd64/usr/lib/x86_64-linux-gnu/

rm -rf ./build/libIDSSVfs_${VERSION}_amd64/usr/include/IDSSVfs/*
rm -rf ./build/libIDSSVfs_${VERSION}_amd64/usr/lib/x86_64-linux-gnu/*

cp -r ./debian/* ./build/libIDSSVfs_${VERSION}_amd64/DEBIAN/
cmake -L .
make -j4
cobc -x ./cobol/app.cbl -o ./build/libIDSSVfs_${VERSION}
lua ./lua/processor.lua
cp -r -d ./objects/libIDSSVfs.so* ./build/libIDSSVfs_${VERSION}_amd64/usr/lib/x86_64-linux-gnu/
cp -r -d ./headers/* ./build/libIDSSVfs_${VERSION}_amd64/usr/include/IDSSVfs/

dpkg-deb --build ./build/libIDSSVfs_${VERSION}_amd64
