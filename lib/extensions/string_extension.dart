import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';

extension StringExtension on String {
  DateTime? toDate() {
    final date = DateTime.tryParse(this);
    return date;
  }

  Duration toDuration() {
    if (isEmpty) {
      return Duration.zero;
    }

    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> components = split(':');

    if (components.length > 2) {
      hours = int.parse(components[components.length - 3]);
    }
    if (components.length > 1) {
      minutes = int.parse(components[components.length - 2]);
    }

    micros =
        (double.parse(components[components.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  /// hello -> Hello
  String capitalizeFirstWord() {
    return isEmpty ? '' : "${this[0].toUpperCase()}${substring(1)}";
  }

  /// "hi my name jeff" => "Hi My Name Jeff"
  String capitalizeFirstLetterEachWord() {
    // capitalize the letter when it comes after these chars
    final capitalizeAfterChars = [
      ' ',
      '(',
      '[',
      ',',
    ];
    var result = '';

    // iterate over each char of the string
    for (var i = 0; i < length; i++) {
      final char = this[i]; // current char
      final charPrevious = i > 0 ? this[i - 1] : ''; // previous
      // should capitalize if first letter or when comes after char set
      final capitalize = i == 0 || capitalizeAfterChars.contains(charPrevious);

      // append char to result
      result += capitalize ? char.toUpperCase() : char;
    }

    // print('$this => $result');
    return result;
  }

  Uint8List toUint8List() {
    return base64Decode(this);
  }

  bool isValidEmail() {
    final result = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);

    // print('$this => $result');
    return result;
  }

  bool isValidPassword() {
    return length >= 6;
  }

  String removeWhitespace() {
    return replaceAll(' ', '');
  }

  TextDirection toTextDirection() {
    // character ranges in unicode for RTL languages
    final RegExp arabic = RegExp(r'[\u0621-\u064A]+');
    final RegExp hebrew = RegExp(r'[\u0590-\u05FF]+');

    final isRTL = arabic.hasMatch(this) || hebrew.hasMatch(this);
    final result = isRTL ? TextDirection.rtl : TextDirection.ltr;
    // print('str = $this => $result');
    return result;
  }

  bool isRTL() => toTextDirection() == TextDirection.rtl;

  /// moves the alpha component of a hex color to the end of the string
  String moveAlphaToEnd() {
    final alpha = substring(0, 2);
    final result = substring(2, length) + alpha;

    // print('alpha = $alpha, hex = $this => result = $result');
    return result;
  }

  /// converts a string uuid to a unique int
  int toIntFromUUID() {
    int result = hashCode & 0x7FFFFFFF;
    // print('$this => $result');
    return result;
  }

  /// trims the string to the specified length while also replacing the last 3 characters with [...] if it's too long
  /// pass [isElipsis] = true to always replace the last 3 characters with an elipsis regardless of the length
  /// str = 'abcdefgh', [maxLength] = 5, result = "ab..."
  /// str = '12345', [maxLength] = 5, result = "12345"
  /// str = '123', [maxLength] = 5, result = "123"
  String toElipsis({
    int? maxLength,
    bool isElipsis = false,
  }) {
    maxLength ??= length;

    var result = this;
    const elipsis = '...';
    const elipsisLength = elipsis.length;
    maxLength = max(maxLength, elipsisLength);

    String? strTrimmed;

    // trimming string and appending elipsis
    if (length > maxLength) {
      strTrimmed = substring(0, maxLength - elipsisLength);
      result = '$strTrimmed$elipsis';
    }
    // replacing elipsis.length with elipsis
    if (isElipsis) {
      result = substring(0, length - elipsisLength) + elipsis;
    }

    // print(
    //     'maxLength = $maxLength, original = $this, strTrimmed = $strTrimmed, trimmedLength = ${strTrimmed?.length} result = $result');
    return result;
  }

  bool isEmoji() {
    // Regular expression for matching emojis
    final emojiRegExp = RegExp(
      r'[\u203C-\u3299]|[\uD83C-\uDBFF\uDC00-\uDFFF]|[\uD83C\uDDE6-\uD83C\uDDFF]|[\uD83C\uDDE8-\uD83C\uDDEC]|[\uD83C\uDDEE-\uD83C\uDDF9]|[\uD83C\uDDFB-\uD83C\uDDFE]|[\uD83C\uDDE6\uD83C\uDDF0\uD83C\uDDFF\uD83C\uDDFF]|[\uD83D\uDC00-\uD83D\uDCFF]|[\uD83D\uDD00-\uD83D\uDDFF]|[\uD83D\uDE00-\uD83D\uDE4F]|[\uD83D\uDE80-\uD83D\uDEFF]|[\uD83C\uDF00-\uD83D\uDDFF]',
      unicode: true,
    );

    final result = emojiRegExp.hasMatch(this);

    // print('$this => $result');

    return result;
  }

  /// extracts the emojis out of this string
  String getEmoji() {
    final regExp = RegExp(
      r'[\u203C-\u3299]|[\uD83C-\uDBFF\uDC00-\uDFFF]|[\uD83C\uDDE6-\uD83C\uDDFF]|[\uD83C\uDDE8-\uD83C\uDDEC]|[\uD83C\uDDEE-\uD83C\uDDF9]|[\uD83C\uDDFB-\uD83C\uDDFE]|[\uD83C\uDDE6\uD83C\uDDF0\uD83C\uDDFF\uD83C\uDDFF]|[\uD83D\uDC00-\uD83D\uDCFF]|[\uD83D\uDD00-\uD83D\uDDFF]|[\uD83D\uDE00-\uD83D\uDE4F]|[\uD83D\uDE80-\uD83D\uDEFF]|[\uD83C\uDF00-\uD83D\uDDFF]',
      unicode: true,
    );

    final emojis =
        regExp.allMatches(this).map((match) => match.group(0)!).toList().join();

    return emojis;
  }
}
