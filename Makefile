MUSTACHE=node_modules/.bin/mustache
BUILD=build

all: $(BUILD)/notice.docx $(BUILD)/notice.pdf

$(BUILD)/notice.docx: notice.complete_md reference.docx $(BUILD)
	pandoc -f markdown -t docx -o $@ --reference-docx reference.docx $<

%.pdf: %.docx
	doc2pdf $<

$(BUILD):
	mkdir $(BUILD)

.INTERMEDIATE: notice.complete_md

notice.complete_md: notice.md blanks.json $(MUSTACHE)
	$(MUSTACHE) blanks.json notice.md > $@

$(MUSTACHE):
	npm install

.PHONY: clean docker

clean:
	rm -rf notice.pdf notice.docx

DOCKER_TAG=dgcl-228-e-notice

docker:
	docker build -t $(DOCKER_TAG) .
	docker run -v $(shell pwd)/$(BUILD):/work/$(BUILD) $(DOCKER_TAG)
	sudo chown -R `whoami`:`whoami` $(BUILD)
