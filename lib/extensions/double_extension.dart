import 'dart:ui';

import 'package:flutter/material.dart';

extension DoubleExtension on double {
  /// returns the value of [val] inside range [min,max]
  double inverseLerp({
    required double min,
    required double max,
  }) {
    double interpolant = clampDouble((this - min) / (max - min), 0, 1);
    // print('val = ${DateTime(this).day} , min = ${DateTime(min).day}');
    // print('val = $this , range = [$min , $max] , interpolant = $interpolant');

    return interpolant;
  }

  /// rounds [this] to the closes multiple [neareset]
  /// [this] = 42, [neareset] = 5 => [output] = 40
  int roundToNeareset({required int nearest}) {
    return (this / nearest).round() * nearest;
  }

  String toNumberWithCommas() {
    return toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  /// converts a figure between [0,1] to it's respective color in a progress bar
  Color toProgressBarColor() {
    final values = {
      0.2: Colors.red,
      0.4: Colors.orange,
      0.5: Colors.orange.shade400,
      0.6: Colors.yellow.shade700,
      0.65: Colors.yellow,
      0.8: Colors.green,
      0.9: const Color.fromARGB(255, 19, 236, 26),
    };

    final key = values.keys.firstWhere(
      (val) => this <= val,
      orElse: () => values.keys.last,
    );

    return values[key]!;
  }
}
