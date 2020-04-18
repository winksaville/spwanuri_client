# Makefile for spawanuri_example

v1=6
v2=7

.PHONY: all
all: bin/main

run: bin/main
	$< ${v1} ${v2}

bin/main: bin/main.dart lib/calculate.dart
	dart2native $< -o $@

.PHONY: test
test:
	dart test/spawnuri_client_test.dart
    
.PHONY: clean
clean:
	rm -f bin/main
