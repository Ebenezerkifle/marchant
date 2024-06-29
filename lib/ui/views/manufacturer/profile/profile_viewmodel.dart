import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/setting_model.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../services/state_service/user_service.dart';

class ManuProfileViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
    final _userService = locator<UserService>();


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
      title: 'Change password',
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

  // Concatenate first name and last name with a space in between
String get fullName {
  final firstName = _userService.user?.firstName ?? '';
  final lastName = _userService.user?.lastName ?? '';
  return '$firstName $lastName'.trim();
}
  String get profilePhoneNumber => _userService.user?.phoneNumber ?? '';

  void tapHandler(SettingOptions setting) {
    switch (setting) {
      case SettingOptions.shortCode:
        break;
      case SettingOptions.myDetail:
        _navigation.navigateToMydetailView();
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
