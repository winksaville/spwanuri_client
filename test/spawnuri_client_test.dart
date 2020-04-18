import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:async/async.dart';

import 'package:spawnuri_client/calculate.dart';
import 'package:test/test.dart';

Future<void> main() async {

  test('calculate', () {
    expect(calculate(6, 7), 42);
  });

  // TODO(wink): Make this an async test that executes
  //
  // According to [this](https://pub.dev/packages/test#asynchronous-tests) we
  // should be abl3e to create asynchornous tests but I couldn't get it to
  // work, the tests weren't run.

  //test('spawnUri', () async {
    const String v1 = '123';
    const String v2 = '2';
    final ReceivePort receivePort = ReceivePort();
    final SendPort replyTo = receivePort.sendPort;
    final Isolate isolate = await Isolate.spawnUri(Uri.parse('../bin/main.dart'), <String>[v1, v2], replyTo);

    // Create aStream and feed it into a aQueue that we can
    // wait on and know that the reply was retunred and can
    // verify we had the expected result.
    final StreamController<int> aStream = StreamController<int>();
    final StreamQueue<int> aQueue = StreamQueue<int>(aStream.stream);

    //receivePort.listen(expectAsync1((dynamic msg) {
    receivePort.listen((dynamic msg) async {
      if (msg is int) {
        aStream.add(msg);
      }
    }); //, count: 1));

    // Wait for the 
    final int result = await aQueue.next;
    final int expected = int.parse(v1) * int.parse(v2);
    if (result == expected) {
      print('result:$result == expected:$expected');
    } else {
      throw 'result:$result was not $expected';
    }

    // Cleanup queue and stream
    aQueue.cancel();
    aStream.close();

    // Clean up receive por tand kill the isolate
    receivePort.close();
    isolate.kill();
  //});

  exit(0);
}
