import 'package:marchant/models/user_model.dart';

class MerchantEnrollmentService {
  var _phoneNumber = '';
  var _password = '';
  var _CategoryId = '';

  get phoneNumber => _phoneNumber;
  get password => _password;
  get CategoryId => _CategoryId;

  setValue({
    var phoneNumber,
    var password,
    var CategoryId,
  }) {
    _phoneNumber = phoneNumber ?? _phoneNumber;
    _password = password ?? _password;
    _CategoryId = CategoryId ?? _CategoryId;
  }

  getAnObject() {
    return UserModel(
      phoneNumber: _phoneNumber,
      CategoryId: _CategoryId,
      password: _password,
    );
  }

  void resetState() {
    _phoneNumber = '';
    _password = '';
    _CategoryId = '';
  }
}
