import 'package:marchant/enums/user_role.dart';
import 'package:stacked/stacked.dart';


class LandingStateService with ListenableServiceMixin {
  LandingStateService() {
    listenToReactiveValues([_userRole, _currentIndex]);
  }

  final _currentIndex = ReactiveValue(0);
  int get currentIndex => _currentIndex.value;

  bool _reverse = false;

  bool get reverse => _reverse;

  void setIndex(int value) {
    if (value < _currentIndex.value) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _currentIndex.value = value;
    notifyListeners();
  }

  final _userRole = ReactiveValue<UserRole>(UserRole.retailor);
  UserRole get userRole => _userRole.value;

  changeUserRole(UserRole userRole) {
    _userRole.value = userRole;
    notifyListeners();
  }
}
