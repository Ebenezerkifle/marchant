import 'package:http/http.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/login_model.dart';
import 'package:marchant/models/user_model.dart';
import 'package:marchant/services/api_service/api_call_service.dart';
import 'package:marchant/services/api_service/api_constants.dart';

import '../state_service/user_service.dart';

class Authentication {
    final _userService = locator<UserService>();

  // register new user
  Future<Response> registerNewUser(UserModel userModel) {
    return ApiCallService.postCall(
      '$baseUrl$singUpUrl',
      userModel.toMap(),
      needToken: false,
    );
  }

  // login
  Future<Response> loginUser(LoginModel login) {
    return ApiCallService.postCall(
      '$baseUrl$loginUrl',
      login.toMap(),
      needToken: false,
    );
  }
Future<Response> changePassword(
    String userId,
    String prevPassword,
    String newPassword,
) async {
    final changeUrl = _userService.user?.role == "Retailor" ? changePassUrl: changeManuPassUrl;
    return ApiCallService.patchCall(
        '$baseUrl$changeUrl',
        {'oldPassword': prevPassword, 'newPassword': newPassword},
        needToken: true,
    );
}

  // // change password
  // Future<Response> changePassword(
  //   String userId,
  //   String prevPassword,
  //   String newPassword,
  // ) async {
  //   return ApiCallService.patchCall(
  //     '$baseUrl$changePassUrl',
  //     {
  //       'oldPassword': prevPassword,
  //       'newPassword': newPassword,
  //     },
  //     needToken: true,
  //   );
  // }

  // reset password
  Future<Response> resetPassword(
    String userId,
    String newPassword,
  ) async {
    return ApiCallService.patchCall(
      '$baseUrl$singUpUrl$passResetUrl$userId',
      {'password': newPassword},
      needToken: false,
    );
  }

  // check phone number
  Future<Response> checkPhoneNumber(String phone) {
    // String phoneNum = _changePhoneNumberFormat(phone);
    return ApiCallService.postCall(
      '$baseUrl$singUpUrl$phoneCheckerUrl',
      {'phoneNumber': phone},
      needToken: false,
    );
  }
}
