#!/bin/bash

echo "let files = $(find -name *.pdf | jq -R '[inputs]');"
