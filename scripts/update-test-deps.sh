#!/usr/bin/env bash

PACK_DIR=./.test-config/nvim/pack/nfnl-tests/start

git fetch "$PACK_DIR/plenary.nvim"
git fetch "$PACK_DIR/fennel.vim"
git fetch "$PACK_DIR/nfnl"
git fetch "$PACK_DIR/fenneldoc"
