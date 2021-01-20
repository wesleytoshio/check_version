import './dialog_locale_interface.dart';

class DialogLocaleEn implements DialogLocaleInterface {
  @override
  String appName;

  @override
  String currentVersion;

  @override
  String dismissText = 'Later';

  @override
  String storeVersion;

  @override
  String updateText = 'Update';

  @override
  String get message =>
      'A new version of $appName is available! Upgrade to $currentVersion, your current version is $storeVersion.';

  @override
  void setValues(_appName, _currentVersion, _storeVersion) {
    appName = _appName;
    currentVersion = _currentVersion;
    storeVersion = _storeVersion;
  }
}
