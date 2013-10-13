bundle:
	@while read repo; do \
		echo "==> $$repo"; \
		(cd bundle && git clone $$repo); \
	done < plugins.txt

help:
	@for dir in `ls -1d bundle/*/doc`; do \
		echo "==> $$dir"; \
		vim +helptags $$dir +quit; \
	done

.PHONY: bundle
