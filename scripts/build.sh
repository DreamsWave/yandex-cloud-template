#!/usr/bin/env bash

dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

rm -rf $dir/../tmp
mkdir $dir/../tmp
cd $dir/../functions

functions=$(cd $dir/../functions && ls -d *)
for f in ${functions}; do
    echo $f
    cd $dir/../functions/$f/
    rm -rf dist
    npx tsc --build tsconfig.json
    cp package.json ./dist/package.json
    cp -r dist $dir/../tmp/$f
    cd $dir/../tmp
    zip -rj $f.zip $f
done