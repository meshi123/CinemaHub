import 'package:cinema_hub/enums/time_units.dart';

extension DurationExtension on Duration {
  int get inWeeks => inMicroseconds ~/ (Duration.microsecondsPerDay * 7);
  int get inMonths => inMicroseconds ~/ (Duration.microsecondsPerDay * 30);
  int get inYears => inMicroseconds ~/ (Duration.microsecondsPerDay * 365);

  String toStringTimePicker() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    // String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(inHours)}:$twoDigitMinutes";
  }

  DateTime toDate() {
    var seconds = inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final result = DateTime(0, 0, days, hours, minutes, seconds);
    // final temp = this;
    // print('$temp => $result');

    return result;
  }

  /// converts to "<DD> <d/Days> <HH> <h/Hours> <MM> <m/Minutes>" format based on [formatLengthIndex]
  /// Pass [formatLengthIndex] value from 0-2 to determine the length of the component name (0 = shortest)
  String toStringName({
    int formatLengthIndex = 0,
  }) {
    formatLengthIndex = formatLengthIndex.clamp(0, 2);

    final namesByIndex = {
      'day': ['d', ' Day', ' Day'],
      'hour': ['h', ' Hr', ' Hour'],
      'minute': ['m', ' Min', ' Minute'],
    };

    var temp = inMilliseconds;
    const millisMinute = 60 * 1000;
    final days = inDays;

    temp -= days * 24 * 60 * millisMinute;

    final hrs = Duration(milliseconds: temp).inHours;

    temp -= hrs * 60 * millisMinute;

    final mins = Duration(milliseconds: temp).inMinutes;

    getPlural(int n) => n > 1 && formatLengthIndex == 2 ? 's' : '';

    final strDays = days != 0
        ? '$days${namesByIndex['day']![formatLengthIndex]}${getPlural(days)}'
        : '';
    final strHrs = hrs != 0
        ? '$hrs${namesByIndex['hour']![formatLengthIndex]}${getPlural(hrs)}'
        : '';
    final strMins = mins != 0
        ? '$mins${namesByIndex['minute']![formatLengthIndex]}${getPlural(mins)}'
        : '';

    final strs = [
      strDays,
      strHrs,
      strMins,
    ].where((str) => str.isNotEmpty);

    final str = strs.isEmpty
        ? ''
        : strs.reduce((acc, str) {
            return '$acc $str';
          });

    // print('days = $days, hrs = $hrs, mins = $mins');
    // print('$this => $str');

    return str;
  }

  (TimeUnits, int) toTimeUnits() {
    final intervalQntByUnit = Map.fromEntries(TimeUnits.values
        .map((timeUnit) => MapEntry(timeUnit, timeUnit.toIntervalQnt(this))));

    // pick the min value greater than 0
    final timeUnit = intervalQntByUnit.entries
        .where((entry) => entry.value > 0)
        .reduce((a, b) => a.value < b.value ? a : b)
        .key;

    final amount = intervalQntByUnit[timeUnit]!;

    // print(intervalQntByUnit);
    // print('$timeUnit => $amount');

    return (timeUnit, amount);
  }
}
