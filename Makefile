FNLSOURCES = $(wildcard fnl/nvim-anisole/macros/*.fnl)
FENNELDOC = $(.test-config/nvim/pack/nfnl-tests/start/fenneldoc/fenneldoc)
.PHONY: test doc

default: test doc

doc:
	./fenneldoc --mode doc $(FNLSOURCES)

format:
	scripts/fnlfmt.sh

test:
	scripts/test.sh
