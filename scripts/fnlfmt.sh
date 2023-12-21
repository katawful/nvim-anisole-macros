#!/bin/bash

for i in $(find 'fnl/nvim-anisole/' -name "*.fnl"); do
  fnlfmt --fix "$i"
done;
for i in $(find 'test/fnl/nvim-anisole/' -name "*.fnl"); do
  fnlfmt --fix "$i"
done;
echo "Done formatting with fnlfmt"
