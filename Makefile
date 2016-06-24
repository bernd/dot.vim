bundle:
	@mkdir -p bundle
	@while read repo; do \
		if echo $$repo | grep -q '^#'; then \
			echo "==> Skipping disabled $$repo"; \
			continue; \
		fi; \
		echo "==> $$repo"; \
		if [ -d "bundle/`basename $$repo`" ]; then \
			(cd bundle && git pull); \
		else \
			(cd bundle && git clone $$repo); \
		fi;\
	done < plugins.txt

help:
	@for dir in `ls -1d bundle/*/doc`; do \
		echo "==> $$dir"; \
		vim +helptags $$dir +quit; \
	done

.PHONY: bundle
