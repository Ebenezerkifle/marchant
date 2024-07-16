import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'package:stacked/stacked.dart';

enum Language { english, amharic }

Map<Language, String> languageStringMap = {
  Language.english: 'English',
  Language.amharic: 'አማርኛ',
};

Map<Language, String> languageSymbolMap = {
  Language.english: 'en',
  Language.amharic: 'am',
};

Map<String, String> languageNameCodeMap = {
  'English': 'en',
  'አማርኛ': 'am',
};

Map<String, String> languageCodeNameMap = {
  'en': 'English',
  'am': 'አማርኛ',
};

class LanguagesService with ListenableServiceMixin {
  // current language
  String _current = languageSymbolMap[Language.english] ?? 'en';
  String _currentLang = languageStringMap[Language.english] ?? 'English';
  String get currentLangCode => _current;
  String get currentLang => _currentLang;
  String get currentLangCodeCapital => currentLangCode == 'en' ? 'En' : 'አማ';

  LanguagesService() {
    _init();
  }

  _init() async {
    _current = await SessionService.getString(SessionKey.language) ?? _current;
    _currentLang = languageCodeNameMap[_current] ?? _currentLang;
  }

  // change langugae
  changeLanguage(BuildContext context, String code) {
    context.setLocale(Locale(code));
    _current = code;
    _currentLang = languageCodeNameMap[code] ?? 'English';
    SessionService.setString(SessionKey.language, code);
  }
}
