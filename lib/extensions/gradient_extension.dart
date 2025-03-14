import 'package:cinema_hub/extensions/color_extensions.dart';
import 'package:flutter/material.dart';

extension GradientExtension on LinearGradient {
  LinearGradient copyWith({
    List<Color>? colors,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    List<double>? stops,
    TileMode? tileMode,
    GradientTransform? transform,
  }) =>
      LinearGradient(
        colors: colors != null
            ? (colors.length > 1
                ? colors
                : [
                    colors.first,
                    colors.first.lighten(20),
                  ])
            : this.colors,
        begin: begin ?? this.begin,
        end: end ?? this.end,
        stops: stops ?? this.stops,
        tileMode: tileMode ?? this.tileMode,
        transform: transform ?? this.transform,
      );
}
