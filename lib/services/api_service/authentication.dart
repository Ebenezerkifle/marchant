import 'package:http/http.dart';
import 'package:marchant/models/login_model.dart';
import 'package:marchant/models/user_model.dart';
import 'package:marchant/services/api_service/api_call_service.dart';
import 'package:marchant/services/api_service/api_constants.dart';

class Authentication {
  // register new user
  Future<Response> registerNewUser(UserModel userModel) {
    return ApiCallService.postCall(
      '$baseUrl$singUpUrl',
      'token',
      userModel.toMap(),
      needToken: false,
    );
  }

  // login
  Future<Response> loginUser(LoginModel login) {
    return ApiCallService.postCall(
      '$baseUrl$loginUrl',
      'token',
      login.toMap(),
      needToken: false,
    );
  }
}
