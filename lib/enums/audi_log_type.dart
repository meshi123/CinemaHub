import 'package:flutter/material.dart';

enum AudiLogType {
  log,
  assist,
  foreman,
  exit,
}

extension AudiLogTypeExtension on AudiLogType {
  Color toColor() {
    switch (this) {
      case AudiLogType.log:
        return Colors.blue;
      case AudiLogType.assist:
        return Colors.pinkAccent;
      case AudiLogType.foreman:
        return Colors.lightGreenAccent;
      case AudiLogType.exit:
        return Colors.orangeAccent;
    }
  }
}
