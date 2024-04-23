import 'package:http/http.dart';
import 'package:marchant/models/login_model.dart';
import 'package:marchant/services/api_service/api_call_service.dart';

class Authentication {
  // register new user
  Future<Response> registerNewUser(var userModel) {
    return ApiCallService.postCall(
      '', //'$baseUrl$userUrl',
      'token',
      userModel.toMap(),
      needToken: false,
    );
  }

  // login
  Future<Response> loginUser(LoginModel login) {
    return ApiCallService.postCall(
      '', //'$baseUrl$userUrl$loginUrl',
      'token',
      login.toMap(),
      needToken: false,
    );
  }
}
