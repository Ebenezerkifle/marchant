import 'package:marchant/models/user_model.dart';

class UserService {
  UserModel? _userData;

  void setUserData(UserModel user) {
    _userData = user;
    print('User data set: ${_userData?.CategoryId}, ${_userData?.phoneNumber}');
  }

  UserModel? get user => _userData;

  void resetState() {
    _userData = null;
  }
}
