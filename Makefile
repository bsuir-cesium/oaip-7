solve1:
	@echo "\n\n---===---\nbuilding... \n---===---\n\n"
	fpc src/solve1.dpr -obin/solve1.o
	@echo "\n\n---===---\nbuild done \ntrying to run:\n---===---\n\n"
	./bin/solve1.o

solve1-py:
	python -m src.solve1

solve2:
	@echo "\n\n---===---\nbuilding... \n---===---\n\n"
	fpc src/solve2.dpr -obin/solve2.o
	@echo "\n\n---===---\nbuild done \ntrying to run:\n---===---\n\n"
	./bin/solve2.o

install:
	pip install -r requirements.txt

test:
	pytest