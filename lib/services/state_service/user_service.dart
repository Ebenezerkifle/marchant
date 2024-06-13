import 'package:marchant/models/user_model.dart';

class UserService {
  UserModel? _userData; // Making _userData nullable

  void setUserData(UserModel user) {
    _userData = user;
  }

  UserModel? get user => _userData; // Return nullable UserModel

  void resetState() {
    _userData = null;
  }
}
