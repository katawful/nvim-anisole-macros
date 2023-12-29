#!/usr/bin/env bash

PACK_DIR=./.test-config/nvim/pack/nfnl-tests/start

mkdir -p "$PACK_DIR"
git clone https://github.com/nvim-lua/plenary.nvim.git "$PACK_DIR/plenary.nvim"
git clone https://github.com/bakpakin/fennel.vim.git "$PACK_DIR/fennel.vim"
git clone https://github.com/Olical/nfnl.git "$PACK_DIR/nfnl"
git clone https://github.com/andreyorst/fenneldoc "$PACK_DIR/fenneldoc"
make build -C "$PACK_DIR/fenneldoc"
cp -f "$PACK_DIR/fenneldoc/fenneldoc" "fenneldoc"
