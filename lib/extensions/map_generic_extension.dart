extension MapExtension<K, V> on Map<K, V> {
  /// removes pairs if the values are duplicates
  Map<K, V> uniqueValues() {
    Map<K, V> uniqueValuesMap = {};

    for (var key in keys) {
      final val = this[key];

      if (val != null && !uniqueValuesMap.containsValue(val)) {
        uniqueValuesMap[key] = val;
      }
    }

    return uniqueValuesMap;
  }
}
