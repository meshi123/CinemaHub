class TimeComponents {
  const TimeComponents({
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
  });

  const TimeComponents.empty({
    this.day = '00',
    this.hour = '00',
    this.minute = '00',
    this.second = '00',
  });

  final String day;
  final String hour;
  final String minute;
  final String second;

  String toStringPrint() => '${day}d ${hour}h ${minute}m ${second}s';

  /// When timeLeft > 1 day: display [day] [hr]
  /// when 1 hr < timeLeft < 1 day : display [hr] [min]
  /// when timeLeft < 1 hr : display [min] [sec]
  /// pass [shortFormat] = true to: [12:30:55] => [12h 30m]
  /// pass [shortFormatWithSeconds] to true to: [12h 30m] => [12h 30m], or [30m] => [30m 15s] when h = 0
  @override
  String toString({bool shortFormat = false, shortFormatWithSeconds = false}) {
    int days = int.parse(day);
    int h = int.parse(hour);
    String output = '';

    if (days.abs() >= 1) {
      String hrs = h.abs() > 0 && days < 100 ? '${h}h' : '';
      output = '${days}d $hrs';

      return output;
    } else {
      if (shortFormat) {
        // [hr][min] or [min][sec]
        if (shortFormatWithSeconds) {
          final s = int.parse(second);
          final m = int.parse(minute).abs();

          final minutes = m > 0 ? '${minute}m ' : '';
          final seconds =
              (h == 0 && m == 0) || (h == 0 && s.abs() > 0) ? '${s}s' : '';
          final hrs = h.abs() > 0 ? '${hour}h ' : '';

          output = '$hrs$minutes$seconds';
        } else {
          output = '${hour}h ${minute}m';
        }
      } else {
        output = '$hour:$minute:$second';
      }

      return output;
    }
  }
}
