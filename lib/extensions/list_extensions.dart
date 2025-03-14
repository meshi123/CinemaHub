import 'dart:math';

import 'package:cinema_hub/extensions/double_extension.dart';

extension ListExtensions<T> on List<T> {
  T getRandomElement() {
    final random = Random();
    var i = random.nextInt(length);
    return this[i];
  }

  /// Adds [addItem] to the list if it doesn't exist in it already
  void addUnique(T addItem) {
    bool exists = any((element) => element == addItem);
    if (!exists) {
      add(addItem);
    }
  }

  /// returns the next item after [item] in the collection (first item if this is the last item)
  T? next(T? item) {
    if (item == null || isEmpty) return null;

    int index = indexOf(item);
    return index + 1 > length - 1 ? this[0] : this[index + 1];
  }

  /// returns the previous item after [item] in the collection (first item if this is the last item)
  T? previous(T? item) {
    if (item == null || isEmpty) return null;

    int index = indexOf(item);
    return index - 1 < 0 ? last : this[index - 1];
  }

  List<T>? getRandomElements(int n) {
    if (length == 0) return null;

    // [1,2,3,4,5... m]
    n = min(n, length); // constraint to list's length

    List<T> randomItems = [];
    final random = Random();

    while (randomItems.length < n) {
      final randomItem = this[random.nextInt(length)];

      if (!randomItems.contains(randomItem)) {
        randomItems.add(randomItem);
      }
    }

    return randomItems;
  }

  int? getRandomElementIndex() {
    if (length == 0) return null;

    final item = getRandomElement();
    return indexOf(item);
  }

  /// swaps item1 with item2
  void swap(T item1, T item2) {
    // either of the items don't exist -> exit
    if (!contains(item1) || !contains(item2)) {
      return;
    }

    int i1 = indexOf(item1);
    int i2 = indexOf(item2);

    final temp = this[i1];
    this[i1] = this[i2];
    this[i2] = temp;

    // print('item1 = $item1, items2 = $item2, items = ${this}');
  }

  /// finds where the index of [item] inside the list
  double toIndexInterpolant(T item) {
    final index = indexOf(item).toDouble();

    if (index == -1) return 0;

    final result = index.inverseLerp(min: 0, max: length - 1);

    // print(
    // '[toIndexInterpolant]: item = $item, index = $index, result = $result');
    return result;
  }

  T? get firstOrNull => isNotEmpty ? first : null;
  T? get lastOrNull => isNotEmpty ? last : null;

  List<T> getSorted(int Function(T, T)? compare) {
    var result = toList();
    result.sort(compare);

    // print('beofre: $this, after: $result');
    return result;
  }

  List<T> getShuffled() {
    var result = toList();
    result.shuffle();

    return result;
  }

  List<T> getReversed() => reversed.toList();
}

extension Unique<E, Id> on List<E> {
  /// Remove duplicate items from the list
  /// Pass a function that returns the [id] / other field to compare duplicate items (for example: (x) => x.id)
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
