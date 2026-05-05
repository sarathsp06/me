.PHONY: cv book clean blog

cv: cv/cv.pdf

cv/cv.pdf: cv/cv.typ
	typst compile --font-path cv/fonts cv/cv.typ cv/cv.pdf

book: book/tutorial.pdf

book/tutorial.pdf: book/tutorial.typ book/template.typ
	typst compile --font-path cv/fonts book/tutorial.typ book/tutorial.pdf

blog:
	cd absolute-ablation && npm run deploy

clean:
	rm -f cv/cv.pdf book/tutorial.pdf
