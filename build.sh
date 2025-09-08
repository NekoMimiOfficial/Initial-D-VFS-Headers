#!/bin/bash

VERSION="1.0.2"

mkdir -p ./build/
mkdir -p ./build/lib/
mkdir -p ./build/libidssvfs_${VERSION}_amd64/
mkdir -p ./build/libidssvfs_${VERSION}_amd64/DEBIAN/
mkdir -p ./build/libidssvfs_${VERSION}_amd64/usr/
mkdir -p ./build/libidssvfs_${VERSION}_amd64/usr/bin/
mkdir -p ./build/libidssvfs_${VERSION}_amd64/usr/share/
mkdir -p ./build/libidssvfs_${VERSION}_amd64/usr/share/idss/
mkdir -p ./build/libidssvfs_${VERSION}_amd64/usr/include/
mkdir -p ./build/libidssvfs_${VERSION}_amd64/usr/include/IDSSVfs/
mkdir -p ./build/libidssvfs_${VERSION}_amd64/usr/lib/
mkdir -p ./build/libidssvfs_${VERSION}_amd64/usr/lib/x86_64-linux-gnu/

rm -rf ./build/lib/*
rm -rf ./build/libidssvfs_${VERSION}_amd64/usr/include/IDSSVfs/*
rm -rf ./build/libidssvfs_${VERSION}_amd64/usr/lib/x86_64-linux-gnu/*
rm -rf ./objects/*

cp -r ./debian/* ./build/libidssvfs_${VERSION}_amd64/DEBIAN/
cmake -L .
make -j4
cobc -x ./cobol/app.cbl -o ./build/libidssvfs_${VERSION}_amd64/usr/bin/idss-vfs
lua ./lua/processor.lua
javac -d ./build/ ./java/Installer.java
cd build
jar -cfe ./Installer.jar Installer ./Installer.class
cd ..
chmod +x ./build/Installer.jar
chmod +x ./build/Installer.class
cp -r -d ./objects/libIDSSVfs.so* ./build/libidssvfs_${VERSION}_amd64/usr/lib/x86_64-linux-gnu/
cp -r -d ./headers/* ./build/libidssvfs_${VERSION}_amd64/usr/include/IDSSVfs/
mkdir -p ./build/lib/src/
mkdir -p ./build/lib/header/
cp ./doc.txt ./build/libidssvfs_${VERSION}_amd64/usr/share/idss/
cp -r -d ./objects/libIDSSVfs.so* ./build/lib/src/
cp -r -d ./headers/* ./build/lib/header/

dpkg-deb --build ./build/libidssvfs_${VERSION}_amd64
