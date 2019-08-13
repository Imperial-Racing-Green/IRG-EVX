#!/bin/bash

# closure compiler
wget https://dl.google.com/closure-compiler/compiler-latest.zip
unzip compiler-latest.zip -d closure-compiler
cd closure-compiler
jarfile=(*.jar)
ln -s $jarfile compiler.jar
cd ..

# PDFJS
wget https://github.com/mozilla/pdf.js/releases/download/v1.8.188/pdfjs-1.8.188-dist.zip
unzip pdfjs-1.8.188-dist.zip -d pdfjs

# tarballjs
wget https://github.com/ankitrohatgi/tarballjs/archive/master.zip
unzip master.zip -d tarballjs
rm master.zip

# numericjs
wget https://github.com/sloisel/numeric/archive/v1.2.6.zip
unzip v1.2.6.zip -d numericjs
cd numericjs
ln -s numeric-1.2.6/src/numeric.js numeric_core.js
ln -s numeric-1.2.6/src/svd.js numeric_svd.js
cd ..

# emscripten
wget https://github.com/juj/emsdk/archive/master.zip
unzip master.zip
mv emsdk-master emsdk
cd emsdk
./emsdk install latest
./emsdk activate latest
cd ..
rm master.zip

# clean up downloaded packages
rm *.zip

