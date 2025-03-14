import 'package:cinema_hub/extensions/double_extension.dart';
import 'package:flutter/foundation.dart';

extension IntExtension on int {
  String to2Digits() => toString().padLeft(2, "0");

  /// returns the value of [val] inside range [min,max]
  double inverseLerp({
    required int min,
    required int max,
  }) {
    double interpolant = clampDouble((this - min) / (max - min), 0, 1);
    // print('val = ${DateTime(this).day} , min = ${DateTime(min).day}');
    // print('val = $this , range = [$min , $max] , interpolant = $interpolant');

    return interpolant;
  }

  int clamp({
    required int min,
    required int max,
  }) {
    if (this < min) {
      return min;
    }
    if (this > max) {
      return max;
    }
    if (isNaN) {
      return max;
    }
    return this;
  }

  // 1234 => 1.2k, 1234567 => 1.2m
  String toCollapsed({int decimalPoints = 2}) {
    if (this < 1000) return toString();

    var val1 = this;
    var val2 = toDouble();
    final oneThousand = this >= 1000;
    final oneMillion = this >= 1000000;
    final prefix = oneMillion
        ? 'm'
        : oneThousand
            ? 'k'
            : '';

    // * 1234567 -> 1.23m
    if (oneMillion) {
      val1 = (val1 / 1000000).floor();
      val2 = val2 % 1000000 / 1000000;
    }

    // * 1234 -> 1.23k
    else if (oneThousand) {
      val1 = (val1 / 1000).floor();
      val2 = val2 % 1000 / 1000;
    }

    final val3 = val1 + val2;
    final result =
        '${val3.toStringAsFixed(decimalPoints).replaceAll(RegExp(r'(\.0+|(?<=\d)0+)$'), '')}$prefix';

    // print(
    //     'initial = $this, val1 = $val1, val2 = $val2, val3 = $val3 -> $result');

    return result;
  }

  String toNumberWithCommas() {
    return toDouble()
        .toNumberWithCommas()
        .replaceAll(RegExp(r'(\.0+|(?<=\d)0+)$'), '');
  }
}
