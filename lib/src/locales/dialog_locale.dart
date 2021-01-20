import 'package:check_version/src/locales/dialog_locale_en.dart';

import 'dialog_locale_interface.dart';
import 'dialog_locale_pt_br.dart';

class DialogLocale {
  String defaultLocale = 'en';

  DialogLocaleInterface locale;

  Map<String, DialogLocaleInterface> locales = {
    'en': DialogLocaleEn(),
    'pt_BR': DialogLocalePtBr(),
  };

  set(_localeCode, _appName, _currentVersion, _storeVersion) {
    locale = _findAvailableLocale(_localeCode);
    locale.setValues(_appName, _currentVersion, _storeVersion);
  }

  _findAvailableLocale(_localeCode) {
    if (locales[_localeCode] != null) {
      return locales[_localeCode];
    } else {
      return locales[defaultLocale];
    }
  }
}
