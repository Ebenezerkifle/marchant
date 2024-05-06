import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/setting_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

enum Setting {
  myOrders,
  history,
}

class SideBarViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();

  String get image => 'assets/images/user.png';

  Map<Setting, SettingModel> settingItems = {
    Setting.myOrders: SettingModel(
      title: 'My Orders',
      icon: FontAwesomeIcons.cartArrowDown,
    ),
    Setting.history: SettingModel(
      title: 'History',
      icon: FontAwesomeIcons.clockRotateLeft,
    ),
  };

  onTapHandler(Setting setting) {
    switch (setting) {
      case Setting.myOrders:
        _navigation.navigateToMyOrdersView();
        break;
      case Setting.history:
        break;
    }
  }
}
