import 'dart:isolate';
import 'package:test/test.dart';

void main() {
  test('Test spawnUri', () async {
    final ReceivePort receivePort = ReceivePort();
    receivePort.first.then(expectAsync1<void, dynamic>((dynamic msg) {
      expect(msg is int, isTrue);
      expect(msg, 246);
    }));

    // From [this](https://gitter.im/dart-lang/TALK-general?at=5e9cc5c574bfed5a1b4c9c65)
    // conversation on gitter, Jacob MacDonald suggested something like the following:
    //   (await Isolate.resolvePackageUri(Uri.parse('package:spawnuri-client/fake.dart')))
    //       .resolve('../bin/main.dart');
    // but it didn't work for me, I may want to explore it in the future.

    // But his other suggestion, using base.resolve, allows `pub run test`
    // to work perfectly. It's only problem is that you can't run this test
    // from anywhere but the project root.
    final Uri uri = Uri.base.resolve('bin/main.dart');
    Isolate.spawnUri(uri, <String>['123', '2'], receivePort.sendPort);
  });
}
