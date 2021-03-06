
.PHONY: plugin install clean

# Here is a hack to make $(eval $(shell work
# (copied from coq_makefile generated stuff):
define donewline


endef

includecmdwithout@ = $(eval $(subst @,$(donewline),$(shell { $(1) | tr -d '\r' | tr '\n' '@'; })))
$(call includecmdwithout@,$(COQBIN)coqtop -config)

plugin: Makefile.coq
	$(MAKE) -f Makefile.coq

install: Makefile.coq src/quickChickLib.cmx src/quickChickLib.o
	$(MAKE) -f Makefile.coq install
        # Manually copying the remaining files
	cp src/quickChickLib.cmx $(COQLIB)/user-contrib/QuickChick
	cp src/quickChickLib.o $(COQLIB)/user-contrib/QuickChick

tests:
	coqc examples/Tests.v
	cd examples/RedBlack; make clean && make
	cd examples/stlc; make clean && make
	cd examples/ifc-basic; make clean && make

Makefile.coq: Make
	coq_makefile -f Make -o Makefile.coq

clean:
         # This might not work on macs, but then not my problem
	find . -name *.vo -print -delete
	find . -name *.glob -print -delete
	find . -name *.d -print -delete
	find . -name *.o -print -delete
	find . -name *.cmi -print -delete
	find . -name *.cmx -print -delete
	find . -name *.cmxs -print -delete
	find . -name *.cmo -print -delete
	find . -name *.bak -print -delete
	find . -name *~ -print -delete
	rm -f Makefile.coq

bc:
	coqwc src/*.v
	coqwc examples/RedBlack/*.v
	coqwc ../ifc/*.v
