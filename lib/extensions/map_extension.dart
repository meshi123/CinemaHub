extension MapExtension<T, U> on Map<T, U> {
  Map<String, dynamic> toJsonMap() {
    var map = <String, dynamic>{};

    forEach((key, value) {
      if (key != null) {
        map[key.toString()] = value;
      }
    });

    return map;
  }

  // returns map [key] from [value]
  T? getKeyFromValue(U value) {
    T? result;

    for (var key in keys) {
      if (this[key] == value) {
        result = key;
      }
    }
    return result;
  }
}
