import './dialog_locale_interface.dart';

class DialogLocalePtBr implements DialogLocaleInterface {
  @override
  String appName;

  @override
  String currentVersion;

  @override
  String dismissText = 'depois';

  @override
  String storeVersion;

  @override
  String updateText = 'Atualizar';

  @override
  String get message =>
      'Uma nova versão do $appName está disponível! Atualize para $storeVersion, sua versão atual é $currentVersion';

  @override
  void setValues(_appName, _currentVersion, _storeVersion) {
    appName = _appName;
    currentVersion = _currentVersion;
    storeVersion = _storeVersion;
  }
}
