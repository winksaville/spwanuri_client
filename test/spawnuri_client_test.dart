import 'dart:isolate';
import 'package:test/test.dart';

void main() {
  test('Test spawnUri', () async {
    final ReceivePort receivePort = ReceivePort();
    receivePort.first.then(expectAsync1<void, dynamic>((dynamic msg) {
      expect(msg is int, isTrue);
      expect(msg, 246);
    }));

    final Uri uri = Uri.parse('../bin/main.dart');
    Isolate.spawnUri(uri, <String>['123', '2'], receivePort.sendPort);
  });
}
