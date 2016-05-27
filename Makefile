all: notice.docx notice.pdf

notice.docx: notice.complete_md
	pandoc -f markdown -t docx -o $@ $<

notice.pdf: notice.docx
	doc2pdf $<

.INTERMEDIATE: notice.complete_md

notice.complete_md: notice.md blanks.json
	mustache blanks.json notice.md > $@

.PHONY: clean

clean:
	rm -rf notice.pdf notice.docx
