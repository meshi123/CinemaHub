import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  Color lighten([int percent = 10]) {
    assert(
      0 <= percent && percent <= 100,
      'percentage must be between 1 and 100',
    );
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }

  Color darken([int percent = 10]) {
    assert(
      0 <= percent && percent <= 100,
      'percentage must be between 0 and 100',
    );

    final p = percent / 100;
    Color color = Color.fromARGB(
      alpha,
      // red - ((255 - red) * p).round(),
      (red * (1 - p)).round(),
      (green * (1 - p)).round(),
      (blue * (1 - p)).round(),
    );

    return color;
  }

  /// inverts the color
  Color inverse() {
    return Color.fromRGBO(255 - red, 255 - green, 255 - blue, opacity);
  }
}
