import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/setting_model.dart';
import '../../../services/storage_service.dart/session.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();

  String get image => 'assets/images/user.png';

  Map<SettingOptions, SettingModel> settings = {
    SettingOptions.myDetail: SettingModel(
      title: 'My detail',
      icon: FontAwesomeIcons.user,
    ),
    // SettingOptions.payement: SettingModel(
    //   title: 'Payment',
    //   icon: FontAwesomeIcons.wallet,
    // ),
    SettingOptions.shortCode: SettingModel(
      title: 'Short code',
      icon: FontAwesomeIcons.phone,
    ),
    SettingOptions.credit: SettingModel(
      title: 'Credit',
      icon: FontAwesomeIcons.creditCard,
    ),
    SettingOptions.language: SettingModel(
      title: 'Language',
      icon: FontAwesomeIcons.language,
    ),
    SettingOptions.about: SettingModel(
      title: 'About',
      icon: FontAwesomeIcons.info,
    ),
    SettingOptions.logout: SettingModel(
      title: 'Logout',
      icon: FontAwesomeIcons.rightFromBracket,
    ),
  };

  tapHandler(SettingOptions setting) {
    switch (setting) {
      case SettingOptions.shortCode:
        break;
      case SettingOptions.myDetail:
        break;
      case SettingOptions.credit:
        break;
      case SettingOptions.language:
        break;
      case SettingOptions.about:
        break;
      case SettingOptions.logout:
        SessionService.clearAll();
        _navigation.clearStackAndShow(Routes.loginView);
        break;
    }
  }
}
