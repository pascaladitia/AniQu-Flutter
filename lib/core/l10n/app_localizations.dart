import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const supportedLocales = [Locale('en'), Locale('id')];

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = {
    'en': {
      'home': 'Home', 'search': 'Search', 'favorites': 'Favorites', 'settings': 'Settings'
    },
    'id': {
      'home': 'Beranda', 'search': 'Cari', 'favorites': 'Favorit', 'settings': 'Pengaturan'
    },
  };

  String _t(String key) => _localizedValues[locale.languageCode]![key] ?? key;

  String get home => _t('home');
  String get search => _t('search');
  String get favorites => _t('favorites');
  String get settings => _t('settings');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.any((l) => l.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
