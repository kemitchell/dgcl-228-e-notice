all: notice.docx notice.pdf

notice.docx: notice.complete_md reference.docx
	pandoc -f markdown -t docx -o $@ --reference-docx reference.docx $<

notice.pdf: notice.docx
	doc2pdf $<

.INTERMEDIATE: notice.complete_md

notice.complete_md: notice.md blanks.json
	mustache blanks.json notice.md > $@

.PHONY: clean

clean:
	rm -rf notice.pdf notice.docx
