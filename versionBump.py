#!/bin/python3

import yaml
newVer= "0.0.0"
with open("./version.yaml", "r") as buffer:
    newVer= buffer.read()
newVer= yaml.safe_load(newVer)["version"]
oldVer= "1.0.0"

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
replace("./cobol/app.cbl")
replace("./lua/processor.lua")
