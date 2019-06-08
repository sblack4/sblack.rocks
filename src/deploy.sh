#!/bin/bash


echo "Preparing site for deployment"

rm -rf public

git clone -b master https://github.com/sblack4/sblack4.github.io.git public

rm -rf public/*

hugo 

cd public 

git add . 

echo "add commit message and push :)"