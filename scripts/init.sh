#!/usr/bin/env bash

dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $dir/..
npm install

cd $dir/../terraform
terraform init

functions=$(cd $dir/../functions && ls -d *)
for f in ${functions}; do
    echo $f
    cd $dir/../functions/$f/
    npm install
done