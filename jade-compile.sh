#!/bin/bash

rm ./public/dist/view.js

#cd ./views
#find . -name "*.jade" -type f | sed -e 's/\.\///' -e 's/\.jade//' | xargs node ../jade-compiler.js
#cd ..

find ./client/views -name "*.jade" -type f | sed -e 's/\.\/client\/views\///' -e 's/\.jade//' | xargs node ./jade-compiler.js
