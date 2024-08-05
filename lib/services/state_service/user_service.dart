import 'package:marchant/models/user_model.dart';
import 'package:stacked/stacked.dart';

class UserService with ListenableServiceMixin {
  UserModel? _userData;

  void setUserData(UserModel user) {
    _userData = user;
    notifyListeners();

  }

  UserModel? get user => _userData;

  void resetState() {
    _userData = null;
    notifyListeners();
  }
}
