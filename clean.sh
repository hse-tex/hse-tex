#!/bin/bash

to_delete=".aux .fls .log .dvi .out .gz .toc .fdb_latexmk -converted-to.pdf"

echo "Cleaning files with extensions: $to_delete"
for ext in $to_delete; do
    find . -name '*'$ext -delete
done
