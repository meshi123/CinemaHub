import 'package:cinema_hub/extensions/duration_extensions.dart';
import 'package:cinema_hub/extensions/string_extension.dart';

enum TimeUnits {
  minute,
  hour,
  day,
  week,
  month,
  year,
}

extension TimeUnitsExtension on TimeUnits {
  /// stores the timeUnit along with the amount in a <amount>:<TimeUnit> format
  String toRepeatEvery({
    required int amount,
    required int repetitions,
  }) {
    return '$name:$amount:$repetitions';
  }

  String toName1Letter() {
    switch (this) {
      case TimeUnits.month:
        return 'mo';
      default:
        return name[0];
    }
  }

  String toName({bool isPlural = false}) =>
      '${name.capitalizeFirstWord()}${isPlural ? 's' : ''}';

  Duration toDuration({int amount = 1}) {
    switch (this) {
      case TimeUnits.minute:
        return Duration(minutes: amount);
      case TimeUnits.hour:
        return Duration(hours: amount);
      case TimeUnits.day:
        return Duration(days: amount);
      case TimeUnits.week:
        return Duration(days: 7 * amount);
      case TimeUnits.month:
        return Duration(days: 30 * amount);
      case TimeUnits.year:
        return Duration(days: 365 * amount);
    }
  }

  int toIntervalQnt(Duration duration) {
    switch (this) {
      case TimeUnits.minute:
        return duration.inMinutes;
      case TimeUnits.hour:
        return duration.inHours;
      case TimeUnits.day:
        return duration.inDays;
      case TimeUnits.week:
        return duration.inWeeks;
      case TimeUnits.month:
        return duration.inMonths;
      case TimeUnits.year:
        return duration.inYears;
    }
  }
}
