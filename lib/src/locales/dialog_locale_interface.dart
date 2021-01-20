/// [LocaleMessagesInterface] Interface for language
abstract class DialogLocaleInterface {
  String currentVersion;

  String storeVersion;

  void setValues(_appName, _currentVersion, _storeVersion);

  String get message;

  String updateText;

  String dismissText;

  String appName;
}
