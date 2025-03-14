class Config {
  static const String appName = 'CinemaHub';

  /// the group used to link app with home widget
  static const String appGroupID = 'group.cinemahub';

  /// home screen widget name
  static const String homeWidgetNameIOS = 'homeWidget';
  static const String homeWidgetNameAndroid = 'homeWidget';

  static const int textFieldTitleMaxLength = 40;
  static int get textFieldNameMaxLength => 20;
  static const int textFieldDescriptionMaxLength = 150;

  /// the length of generated uuids
  static const int lengthId = 7;

  /// clockthis Pro free trial lasts for this many days
  static const int durationDaysFreeTrial = 7;

  static String emailAdmin = 'meshi.levy@gmail.com';
}

class Contactnfo {
  static String urlMail = 'contact.meshiapps@gmail.com';
  static String urlDiscord = 'discord.gg/';
}
