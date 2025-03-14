import 'package:cinema_hub/main.dart';
import 'package:cinema_hub/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

UserData get userData => UserData.instance;

@Entity()
class UserData {
  UserData({
    this.id = 0,
    this.isDarkMode = true,
  });

  UserData.empty({
    UserData? updateUserData,
    int id = 0,
    bool darkMode = true,
  })  : id = updateUserData?.id ?? id,
        isDarkMode = darkMode;

  @Id()
  int id;
  bool isDarkMode;

  static UserData get instance => _singleton ??= UserData.empty();
  // singleton
  static UserData? _singleton;

  static const userId = 1; // id must be constant and unique

  // * Properties

  /// Create a new default user if it isn't registered
  static void init() {
    // getting existin user / creating new
    _singleton = objectBox.getItem<UserData>(userId) ?? UserData.empty();

    // saving/updating user
    objectBox.insertItems<UserData>(items: [_singleton!]);
    // print(allUsers.map((e) => '${e.id}: ${e.isPremium}'));
  }
}
