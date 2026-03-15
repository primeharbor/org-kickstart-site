

PORT=1319
HUGO=hugo

clean:
	rm -rf public/* resources/_gen/*

test:
	open http://localhost:$(PORT)
	$(HUGO) server --disableFastRender -p $(PORT)

test-drafts:
	open http://localhost:$(PORT)
	$(HUGO) server -DF  --disableFastRender  -p $(PORT)

build-static:
	$(HUGO)

npm:
	npm install

post:
	mkdir content/blog/$(slug)
	$(HUGO) new blog/$(slug)/index.md

project:
	mkdir content/projects/$(name)
	$(HUGO) new projects/$(name)/index.md

# -----------------------------------------------------------------------
# Module documentation — auto-generated from Terraform source
# -----------------------------------------------------------------------
REPO_URL       := https://github.com/primeharbor/org-kickstart
CLONE_DIR      := /tmp/org-kickstart-docs-gen
MODULE_DOCS    := content/en/docs/reference/module-docs/_index.md
DOCS_MARKER_B  := <!-- BEGIN TERRAFORM-DOCS -->
DOCS_MARKER_E  := <!-- END TERRAFORM-DOCS -->

.PHONY: generate-module-docs
generate-module-docs:
	@command -v terraform-docs >/dev/null 2>&1 || \
		{ echo "ERROR: terraform-docs is not installed. See https://terraform-docs.io/user-guide/installation/"; exit 1; }
	@echo ">>> Cloning $(REPO_URL) (shallow) ..."
	@rm -rf $(CLONE_DIR)
	@git clone --depth=1 $(REPO_URL) $(CLONE_DIR)
	@echo ">>> Generating terraform-docs output ..."
	@$(eval TMPFILE := $(shell mktemp))
	@# Strip the README preamble (copyright header) — keep only from first '## ' heading onward
	@terraform-docs markdown table $(CLONE_DIR) | sed -n '/^## /,$$p' > $(TMPFILE)
	@echo ">>> Injecting docs between markers in $(MODULE_DOCS) ..."
	@awk \
		-v begin="$(DOCS_MARKER_B)" \
		-v end="$(DOCS_MARKER_E)" \
		-v content="$(TMPFILE)" \
		'BEGIN { skip=0 } \
		 $$0 == begin { print; while ((getline line < content) > 0) print line; close(content); skip=1; next } \
		 $$0 == end   { skip=0 } \
		 !skip        { print }' \
		$(MODULE_DOCS) > $(MODULE_DOCS).tmp
	@mv $(MODULE_DOCS).tmp $(MODULE_DOCS)
	@rm -f $(TMPFILE)
	@rm -rf $(CLONE_DIR)
	@echo ">>> Done. Module docs written to $(MODULE_DOCS)"
