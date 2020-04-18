import 'dart:isolate';
import 'package:spawnuri_client/calculate.dart';

void main(List<String> arguments, SendPort replyTo) {
  final int v1 = int.parse((arguments.isEmpty) ? '6' : arguments[0]);
  final int v2 = int.parse((arguments.length < 2) ? '7' : arguments[1]);

  final int result = calculate(v1, v2);
  if (replyTo !=null) {
    replyTo.send(result);
  } else {
    print('Hello world: ${calculate(v1, v2)}!');
  }
}
