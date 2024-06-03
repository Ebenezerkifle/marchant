import 'package:marchant/models/user_model.dart';

class MerchantEnrollmentService {
  var _phoneNumber = '';
  var _password = '';
  var _categoryId = '';

  get phoneNumber => _phoneNumber;
  get password => _password;
  get categoryId => _categoryId;

  setValue({
    var phoneNumber,
    var password,
    var categoryId,
  }) {
    _phoneNumber = phoneNumber ?? _phoneNumber;
    _password = password ?? _password;
    _categoryId = categoryId ?? _categoryId;
  }

  UserModel getAnObject() {
    return UserModel(
      phoneNumber: _phoneNumber,
      categoryId: _categoryId,
      password: _password,
    );
  }

  void resetState() {
    _phoneNumber = '';
    _password = '';
    _categoryId = '';
  }
}
