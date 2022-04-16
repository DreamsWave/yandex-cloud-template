#!/usr/bin/env bash

dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $dir/../functions
functions=$(cd $dir/../functions && ls -d *)

for f in ${functions}; do
    echo $f
    cd $dir/../functions/$f/
    rm -rf dist
    npx tsc --build tsconfig.json
    cp package.json ./dist/package.json
done