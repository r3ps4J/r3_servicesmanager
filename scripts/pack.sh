#!/usr/bin/env bash

mkdir -p ./temp/r3_servicesmanager
cp ./{fxmanifest.lua,LICENSE,README.md} ./temp/r3_servicesmanager
cp -r ./dist ./temp/r3_servicesmanager
cd ./temp && zip -r ../r3_servicesmanager.zip ./r3_servicesmanager
cd .. && rm -rf ./temp
