CURDIR=$(shell pwd)

run:
	docker run -it -v ${CURDIR}:/compilerbook-challenge compilerbook bash