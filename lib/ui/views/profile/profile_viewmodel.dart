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
    SettingOptions.editProfile: SettingModel(
      title: 'Edit Profile',
      icon: FontAwesomeIcons.user,
    ),
    // SettingOptions.payement: SettingModel(
    //   title: 'Payment',
    //   icon: FontAwesomeIcons.wallet,
    // ),
    SettingOptions.notification: SettingModel(
      title: 'Notification',
      icon: FontAwesomeIcons.bell,
    ),
    SettingOptions.security: SettingModel(
      title: 'Security',
      icon: FontAwesomeIcons.shieldHalved,
    ),
    SettingOptions.help: SettingModel(
      title: 'Help',
      icon: FontAwesomeIcons.info,
    ),
    SettingOptions.logout: SettingModel(
      title: 'Logout',
      icon: FontAwesomeIcons.rightFromBracket,
    ),
  };

  tapHandler(SettingOptions setting) {
    switch (setting) {
      case SettingOptions.editProfile:
        break;
      case SettingOptions.notification:
        break;
      case SettingOptions.security:
        break;
      case SettingOptions.help:
        break;
      case SettingOptions.logout:
        SessionService.clearAll();
        _navigation.clearStackAndShow(Routes.loginView);
        break;
    }
  }
}
