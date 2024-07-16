import 'package:marchant/services/state_service/language_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class ChangeLanguageSheetModel extends BaseViewModel {
  final _languageService = locator<LanguagesService>();

  String get currentLanguage => _languageService.currentLang;

  onLanguageChange(var context, String code, String language) {
    _languageService.changeLanguage(context, code);
    notifyListeners();
  }
}
