import 'package:cinema_hub/models/user_data.dart';
import 'package:flutter/foundation.dart';
import '../objectbox.g.dart';

// flutter pub run build_runner build

class ObjectBox {
  // contains most of the data to be saved within the app
  late final Store _store;
  // ? Temporary until models are implemented
  late final Box<UserData> someBox;

  ObjectBox._init({
    required Store store,
  }) {
    _store = store;
    someBox = _store.box<UserData>();
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();

    return ObjectBox._init(
      store: store,
    );
  }

  T? getItem<T>(int id) => getBox<T>().get(id);

  List<T> getItems<T>({
    bool Function(T)? query,
  }) =>
      getBox<T>()
          .getAll()
          .map((item) => item as T)
          .where((item) => query?.call(item) ?? true)
          .toList();

  List<int> insertItems<T>({
    required List<T> items,
  }) {
    try {
      return getBox<T>().putMany(items);
    } catch (e) {
      if (kDebugMode) {
        print('[objectBox insertItems]: $e');
      }
      return [];
    }
  }

  /// deletes all of the items with the given [ids]
  int deleteItems<T>({
    required List<int> ids,
  }) =>
      getBox<T>().removeMany(ids.where((id) => id > 0).toList());

  /// remove items by predicate. [removeItemId] should return the objectbox id of the item if it's to be deleted, 0 to skip
  int deleteItemsWhere<T>({
    required int Function(T) removeItemId,
  }) {
    final removeIds = getItems<T>()
        .map((item) => removeItemId(item))
        .where((id) => id > 0)
        .toList();

    // print('[deleteItemsWhere] objectBox Ids = $ids');
    return getBox<T>().removeMany(removeIds);
  }

  int deleteAll<T>() {
    return getBox<T>().removeAll();
  }

  /// Find the box that corresponds to type T
  Box getBox<T>() {
    final mapBoxByType = {
      UserData: someBox,
    };

    final box = mapBoxByType[T]!;

    return box;
  }
}
