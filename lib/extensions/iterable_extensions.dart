import 'dart:math';

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));

  /// Note: this returns a new iterable: meaning the original is NOT changed!
  Iterable<E> sort(int Function(E, E) sortBy) {
    return toList()..sort(sortBy);
  }

  Iterable<E> insert(int index, E item) {
    // constrain number to list size, or 0 if empty
    index = index.clamp(
      0,
      max(0, length),
    );

    return toList()..insert(index, item);
  }

  add(E item) {
    (this as List<E>).add(item);
  }

  addAll(Iterable<E> items) {
    (this as List<E>).addAll(items);
  }

  /// Note: this returns a new iterable: meaning the original is NOT changed!
  Iterable<E> remove(E item) {
    return toList()..remove(item);
  }

  /// test when there's free time (lol)
  remove2(E item) {
    where((element) => element == item);
  }

  /// Note: this returns a new iterable: meaning the original is NOT changed!
  Iterable<E> removeAt(int index) {
    return toList()..removeAt(index);
  }

  /// Note: this returns a new iterable: meaning the original is NOT changed!
  Iterable<E> removeWhere(bool Function(E) test) {
    return toList()..removeWhere(test);
  }

  /// Note: this returns a new iterable: meaning the original is NOT changed!
  clear() {
    return toList()..clear();
  }

  int indexOf(E? item) {
    return item == null ? -1 : toList().indexOf(item);
  }

  int indexWhere(bool Function(E) predicate, [int start = 0]) {
    return toList().indexWhere(predicate, start);
  }
}
