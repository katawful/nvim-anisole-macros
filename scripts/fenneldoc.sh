#!/bin/bash

FENNEL_DOC=".test-config/nvim/pack/nfnl-tests/start/fenneldoc/fenneldoc"

$FENNEL_DOC --no-sandbox $(fnl/**/*.fnl)
