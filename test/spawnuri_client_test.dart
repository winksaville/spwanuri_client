import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:async/async.dart';

import 'package:spawnuri_client/calculate.dart';
import 'package:test/test.dart';

//void main() {
Future<void> main() async {
  const String v1 = '123';
  const String v2 = '2';
  final int expected = int.parse(v1) * int.parse(v2);

  test('calculate 6 * 7', () {
    expect(calculate(6, 7), 42);
  });

  test('calculate -1 * 7', () {
    expect(calculate(-1, 7), -7);
  });

  // TODO(wink): Make this an async test work reliabely.
  //
  // According to [this](https://pub.dev/packages/test#asynchronous-tests) we
  // should beable to create asynchornous tests. But I couldn't get this to
  // work reliablely.
  //
  // If both are disabled then we always see the two calcuate tests.
  //
  // If 'Test spawnUri is enabled and 'Inline spawnUri' is disabled then there
  // is no output.
  //
  // If 'Test spwanUri is disabled and 'Inline spawnUri' calcuate tests and
  // 'Inline spawnUri' work.
  //
  // If both 'Test spawnUri' and 'Inline spawnUri' are enabled then 1 out of 4
  // times it works as expected, but the other times 'Test spawnUri' starts but
  // only outputs upto 'Test spawnUri: 1' and 'Inline spawnUri' works everytime.
  //
  // This above is on my desktop, YMMV :)
  if (false) {
    test('Test spawnUri', () async {
      print('Test spawnUri:+');
      final ReceivePort receivePort = ReceivePort();
      final SendPort replyTo = receivePort.sendPort;
      print('Test spawnUri: 1');
      final Isolate isolate = await Isolate.spawnUri(Uri.parse('../bin/main.dart'), <String>[v1, v2], replyTo);
      print('Test spawnUri: 2');

      final StreamController<int> aStream = StreamController<int>();
      final StreamQueue<int> aQueue = StreamQueue<int>(aStream.stream);

      //receivePort.listen(expectAsync1<Function, dynamic>((dynamic msg) {
      receivePort.listen((dynamic msg) {
        print('Test spawnUri: 3');
        if (msg is int) {
          expect(msg, expected);
          aStream.add(msg);
        }
      });
      //}, count: 1));

      print('Test spawnUri: 4');
      final int result = await aQueue.next;
      print('Test spawnUri: 5');
      expect(result, expected);

      // Clean up receive port and kill the isolate
      receivePort.close();
      isolate.kill();
      print('Test spawnUri:-');
    });
  }

  if (true) {
    print('Inline spawnUri:+');
    final ReceivePort receivePort = ReceivePort();
    final SendPort replyTo = receivePort.sendPort;
    final Isolate isolate = await Isolate.spawnUri(Uri.parse('../bin/main.dart'), <String>[v1, v2], replyTo);

    // Create aStream and feed it into a aQueue that we can
    // wait on and know that the reply was retunred and can
    // verify we had the expected result.
    final StreamController<int> aStream = StreamController<int>();
    final StreamQueue<int> aQueue = StreamQueue<int>(aStream.stream);

    receivePort.listen((dynamic msg) async {
      if (msg is int) {
        aStream.add(msg);
      }
    });

    // Wait for the 
    final int result = await aQueue.next;

    if (result == expected) {
    } else {
      throw 'Inline spawnUri: result:$result was not $expected';
    }

    // Cleanup queue and stream
    aQueue.cancel();
    aStream.close();

    // Clean up receive port and kill the isolate
    receivePort.close();
    isolate.kill();
    print('Inline spawnUri:-');
  }

  exit(0);
}
