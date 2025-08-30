#!/bin/python3

import sys
newVer= sys.argv[1]
oldVer= "1.0.6"

if not oldVer.count(".") == 2 and not len(oldVer) == 5:
    exit(1)

def replace(file):
    newStr= ""
    try:
        with open(file, "r") as rbuffer:
            newStr= rbuffer.read().replace(oldVer, newVer)
        with open(file, "w") as wbuffer:
            wbuffer.write(newStr)
        print(f"[  ok  ] bumped version in: {file}")
    except Exception as e:
        print(f"[ fail ] couldn't update: {file} | error: {e}")

replace("./build.sh")
replace("./debian/control")
replace("./debian/changelog")
replace("./CMakeLists.txt")
replace("./versionBump.py")
