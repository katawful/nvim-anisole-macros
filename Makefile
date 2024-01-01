FNLSOURCES = $(wildcard fnl/nvim-anisole/macros/*.fnl)
FNLTESTS = $(wildcard test/fnl/nvim-anisole/macros/*.fnl)
FENNELDOC = $(.test-config/nvim/pack/nfnl-tests/start/fenneldoc/fenneldoc)
.PHONY: format test doc

default: format test doc

deps:
	scripts/setup-test-deps.sh
	scripts/update-test-deps.sh

doc:
	./fenneldoc --mode doc $(FNLSOURCES)

format:
	scripts/fnlfmt.sh

test:
	scripts/test.sh
