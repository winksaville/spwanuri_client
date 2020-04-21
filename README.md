# spwawnuri-example

The goal is to create a command-line application that will
be launched by another application using Isolate:spawnUri.

Created initialy using `stagehand command-full'

## Build
```
$ make
dart2native bin/main.dart -o bin/main
Generated: /home/wink/prgs/dart/spawnuri-client/bin/main
```

## Run
```
wink@wink-desktop:~/prgs/dart/spawnuri-client (master)
$ make run
bin/main 6 7
Hello world: 42!

wink@wink-desktop:~/prgs/dart/spawnuri-client (master)
$ make run v1=3
bin/main 3 7
Hello world: 21!

wink@wink-desktop:~/prgs/dart/spawnuri-client (master)
$ make run v1=23 v2=2
bin/main 23 2
Hello world: 46!
```

## Test

Run the tests directly or us `pub run test`
```
wink@wink-desktop:~/prgs/dart/spawnuri_client (master)
$ dart test/*
00:00 +0: calculate 6 * 7

00:00 +1: calculate -1 * 7

00:00 +2: All tests passed!

wink@wink-desktop:~/prgs/dart/spawnuri_client (master)
$ pub run test
00:02 +3: All tests passed!                                                                   
wink@wink-desktop:~/prgs/dart/spawnuri_client (master)
```

## Clean
```
wink@wink-desktop:~/prgs/dart/spawnuri-client (master)
$ make clean
rm -f bin/main

wink@wink-desktop:~/prgs/dart/spawnuri-client (master)
$ make clean run
rm -f bin/main
dart2native bin/main.dart -o bin/main
Generated: /home/wink/prgs/dart/spawnuri-client/bin/main
bin/main 6 7
Hello world: 42!
```
