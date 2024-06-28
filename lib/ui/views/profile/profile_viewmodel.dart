import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/services/state_service/orders_state_service.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/setting_model.dart';
import '../../../services/storage_service.dart/session.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _productService = locator<ProductStateService>();
  final _orderService = locator<OrderStateService>();

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

  // String get fullName => _userService.user?.fullName?? '';

  String get profilePhoneNumber => _userService.user?.phoneNumber?? '';

  tapHandler(SettingOptions setting) {
    switch (setting) {
      case SettingOptions.shortCode:
        _makePhoneCall();
        break;
      case SettingOptions.changePass:
        _navigation.navigateToChangePasswordView();
        break;
      case SettingOptions.myDetail:
        break;
      case SettingOptions.credit:
        break;
      case SettingOptions.about:
        break;
      case SettingOptions.logout:
        SessionService.clearAll();
        //  _landingService.clearState();
        _userService.resetState();
        _productService.clearState();
        _orderService.clearState();
        _navigation.clearStackAndShow(Routes.loginView);
        break;
    }
  }

  final String _phoneNumber = '+251989363689';

  Future<void> _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: _phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
