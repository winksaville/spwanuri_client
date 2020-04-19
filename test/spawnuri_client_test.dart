import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:async/async.dart';

import 'package:spawnuri_client/calculate.dart';
import 'package:test/test.dart';

void main() {
  const String v1 = '123';
  const String v2 = '2';
  final int expected = int.parse(v1) * int.parse(v2);

  test('calculate 6 * 7', () {
    expect(calculate(6, 7), 42);
  });

  test('calculate -1 * 7', () {
    expect(calculate(-1, 7), -7);
  });

  test('Test spawnUri', () async {
    final ReceivePort receivePort = ReceivePort();
    receivePort.first.then<void>(expectAsync1<dynamic, void>((dynamic msg){
      expect(msg is int, isTrue);
      expect(msg, expected);
    }));

    final Isolate isolate = await Isolate.spawnUri(
      Uri.parse('../bin/main.dart'), <String>[v1, v2], receivePort.sendPort);
    isolate.kill();
  });
}
