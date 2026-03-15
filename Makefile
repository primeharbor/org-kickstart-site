

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
