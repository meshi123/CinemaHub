import 'dart:math';

extension EnumRandom<T extends Enum> on Iterable<T> {
  T get randomValue {
    final random = Random();
    return elementAt(random.nextInt(length));
  }
}
