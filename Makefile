.PHONY: cv book clean

TYPST = typst compile --font-path fonts

cv: cv.pdf

cv.pdf: cv.typ
	$(TYPST) cv.typ cv.pdf

book: book/tutorial.pdf

book/tutorial.pdf: book/tutorial.typ book/template.typ
	$(TYPST) book/tutorial.typ book/tutorial.pdf

clean:
	rm -f cv.pdf book/tutorial.pdf
