import 'package:cinema_hub/extensions/double_extension.dart';
import 'package:cinema_hub/extensions/duration_extensions.dart';
import 'package:cinema_hub/extensions/int_extension.dart';
import 'package:cinema_hub/models/time_components.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool isEarlyDate({required DateTime compareWith}) {
    return !difference(compareWith).isNegative;
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  /// Clock view date representation
  String toStringClock() {
    final formatter = DateFormat('MM/dd/yyyy @ hh:mm');
    final String dateString = formatter.format(this);

    return dateString;
  }

  /// Date picker date representation
  String toStringDatePicker() {
    final now = DateTime.now();
    final date = DateTime(year, month, day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final sameYear = now.year == year;

    if (now.day == day && sameYear) return 'Today';
    if (date == tomorrow) return 'Tomorrow';

    final monthName = DateFormat('MMMM').format(DateTime(0, month));
    final formatter = DateFormat('yyyy');
    final String dateString =
        '$monthName ${dayWithSuffix()} ${formatter.format(this)}';

    return dateString;
  }

  /// extracts the time portions of the date [YYYY/MM/DD:HH:mm:ss] => [HH:mm:ss]
  Duration toDurationTime() {
    return Duration(hours: hour, minutes: minute, seconds: second);
  }

  /// converts the whole date into a duration
  Duration toDuration() {
    return Duration(milliseconds: millisecondsSinceEpoch);
  }

  DateTime removeTime() {
    return DateTime(year, month, day);
  }

  DateTime setTime(Duration duration) {
    final time = duration.toDate();

    final result = copyWith(
      hour: time.hour,
      minute: time.minute,
      second: time.second,
    );

    return result;
  }

  String dayWithSuffix() {
    switch (day) {
      case 1:
      case 21:
      case 31:
        return '${day}st';
      case 2:
      case 22:
        return '${day}nd';
      case 3:
      case 23:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  /// [secondRoundToMultiple] will round the [second] property to the nearest number of this multiple. For example: 24 -> 25, 12 -> 10
  /// [nowInverse]: Pass [true] to compare the difference between now and date instead of date to now (useful when checking how distant a date in the past is compared to the present)
  TimeComponents toTimeUnits({
    bool shortFormat = false,
    bool shortFormatWithSeconds = false,
    int secondRoundToMultiple = 5,
  }) {
    final now = DateTime.now();
    Duration timeLeft = difference(now);

    var seconds = timeLeft.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    // 42 -> (42 + 5 / 5) * 5 => 45
    seconds = shortFormatWithSeconds && secondRoundToMultiple != 1
        ? seconds.toDouble().roundToNeareset(nearest: secondRoundToMultiple)
        : seconds;

    final timeUnits = TimeComponents(
      day: days.abs() < 10 ? days.to2Digits() : days.toString(),
      hour: shortFormat ? hours.toString() : hours.to2Digits(),
      minute: shortFormat ? minutes.toString() : minutes.to2Digits(),
      second: shortFormat && !shortFormatWithSeconds ? '' : seconds.to2Digits(),
    );

    // print(
    //     'shortFormat = $shortFormat, timeLeft = $timeLeft, inSeconds = ${timeLeft.inSeconds}, timeUnits = ${timeUnits.day}:${timeUnits.hour}:${timeUnits.minute}');
    return timeUnits;
  }

  String toTimeLeft({
    bool shortFormat = false,
    bool shortFormatWithSeconds = false,
    int secondRoundToMultiple = 5,
  }) {
    final timeUnits = toTimeUnits(
      shortFormat: shortFormat,
      shortFormatWithSeconds: shortFormatWithSeconds,
      secondRoundToMultiple: secondRoundToMultiple,
    );

    return timeUnits.toString(
      shortFormat: shortFormat,
      shortFormatWithSeconds: shortFormatWithSeconds,
    );
  }

  DateTime removeMillisAndMicro() => copyWith(millisecond: 0, microsecond: 0);

  /// Pass [true] to convert the date to UTC
  DateTime setUTC({bool isUTC = false}) {
    return isUtc ? toUtc() : this;
  }

  /// DateTime => hh:mm:ss
  String toStringTime({
    bool isHr = true,
    bool isMin = true,
    bool isSec = false,
  }) {
    var timeUnits = {
      'hh': isHr,
      'mm': isMin,
      'ss': isSec,
    };

    // remove excluded time units
    timeUnits.removeWhere((key, val) => !timeUnits[key]!);

    final format = timeUnits.keys.fold('', (acc, element) {
      final isFinal = timeUnits.keys.last == element;
      final colon = isFinal ? '' : ':';
      final str = '$acc$element$colon';

      return str;
    });

    final formatter = DateFormat(format);
    final dateString = formatter.format(this);

    return dateString;
  }
}
