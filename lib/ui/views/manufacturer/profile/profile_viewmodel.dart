import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/setting_model.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ManuProfileViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();

  String get image => 'assets/images/user.png';

  Map<SettingOptions, SettingModel> settings = {
    SettingOptions.myDetail: SettingModel(
      title: 'My detail',
      icon: FontAwesomeIcons.user,
    ),
    SettingOptions.shortCode: SettingModel(
      title: '889',
      icon: FontAwesomeIcons.phone,
    ),
    SettingOptions.changePass: SettingModel(
      title: 'change_password',
      icon: FontAwesomeIcons.lock,
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

  void tapHandler(SettingOptions setting) {
    switch (setting) {
      case SettingOptions.shortCode:
        break;
      case SettingOptions.myDetail:
        break;
      case SettingOptions.changePass:
        _navigation.navigateToChangePasswordView();
        break;
      case SettingOptions.about:
        break;
      case SettingOptions.logout:
        SessionService.clearAll();
        _navigation.clearStackAndShow(Routes.loginView);
        break;
      case SettingOptions.credit:
      // TODO: Handle this case.
    }
  }
}
