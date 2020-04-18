import 'package:spawnuri_client/calculate.dart';

void main(List<String> arguments) {
  final int v1 = int.parse(arguments[0] ?? '6');
  final int v2 = int.parse(arguments[1] ?? '7');

  print('Hello world: ${calculate(v1, v2)}!');
}
