import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/orders_state_service.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/setting_model.dart';
import '../../../services/common_services/phone_service_service.dart';
import '../../../services/storage_service.dart/session.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _landingService = locator<LandingStateService>();
  final _productService = locator<ProductStateService>();
  final _orderService = locator<OrderStateService>();
  final _phoneService = locator<PhoneServiceService>();

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
    SettingOptions.credit: SettingModel(
      title: 'Credit',
      icon: FontAwesomeIcons.creditCard,
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

  num get credit => _userService.user?.creditAvailable ?? 0;

// Concatenate first name and last name with a space in between
  String get fullName {
    final firstName = _userService.user?.firstName ?? '';
    final lastName = _userService.user?.lastName ?? '';
    return '$firstName $lastName'.trim();
  }

  String get profilePhoneNumber => _userService.user?.phoneNumber ?? '';

  tapHandler(SettingOptions setting) {
    switch (setting) {
      case SettingOptions.shortCode:
        makePhoneCall();
        break;
      case SettingOptions.changePass:
        _navigation.navigateToChangePasswordView();
        break;
      case SettingOptions.myDetail:
        _navigation.navigateToMydetailView();
        break;
      case SettingOptions.credit:
        break;
      case SettingOptions.about:
        break;
      case SettingOptions.logout:
        SessionService.clearAll();
        _landingService.clearState();
        _userService.resetState();
        _productService.clearState();
        _orderService.clearState();
        _navigation.clearStackAndShow(Routes.loginView);
        break;
    }
  }

  Future<void> makePhoneCall() async {
    await _phoneService.makePhoneCall();
  }
}
