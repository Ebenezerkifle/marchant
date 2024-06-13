import 'package:marchant/models/user_model.dart';

class UserService {
  // ignore: prefer_typing_uninitialized_variables
  var _userData;

  setUserData(UserModel user) {
    _userData = user;
  }

  UserModel get user => _userData;

  void resetState() {
    _userData = null;
  }
}
