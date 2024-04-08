# makefile to generate the executable for the project

# phony targets
.SILENT: 
.PHONY: all clean swig generate

all: pytest gotest 

pyswig:
	swig -python example.i

goswig:
	rm -rf go.mod go.sum example-package &&\
	go mod init example-module &&\
	mkdir -p example-package &&\
	swig -go -cgo -intgosize 64 -outdir example-package -o example-package/example_wrap.c example.i &&\
	cp example.h example-package/example.h &&\
	cp example.c example-package/example.c

# compile the c++ code to generate the shared object file
generate: pyswig
	gcc -c -fPIC example.c example_wrap.c -I/usr/include/python3.10 &&\
	gcc -shared example.o example_wrap.o -o _example.so

compilec: 
	gcc test.c -o test

clean:
	rm -rf example_wrap.c example.py __pycache__ *.o _example.so example.py\
			example_wrap.c test example-package go.mod go.sum *.bin

pytest: clean generate compilec
	echo "---------------Python test---------------" && python3 test.py &&\
	echo "-----------------C test------------------" && ./test

gotest: clean goswig compilec
	echo "-----------------go test------------------" && go run test.go &&\
	echo "-----------------C test------------------" && ./test data_go.bin