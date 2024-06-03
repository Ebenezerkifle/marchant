import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/login_model.dart';
import 'package:marchant/models/user_model.dart';
import 'package:marchant/services/api_service/authentication.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'package:marchant/services/validation_service/front_validation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authentication = Authentication();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();

  String get welcomeMsg => 'Welcome';
  String get image => 'assets/images/order_delivery.png';
  String get singinMsg => 'Signin';

  double get iconSize => 15;

  String get phoneNumFieldHint => 'Phone number';
  String get passwordHint => 'Password';
  bool get passwordVisible => _passVisible;
  String get forgotPass => 'Forgot password?';
  String get loginButtonText => 'Login';
  String get dontHaveAccMsg => 'Do not have an account?';
  String get register => 'Register';

  TextEditingController phoneNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  onForgotPassword() {
    // todo
  }

  onRegister() {
    _navigationService.replaceWithSignupView();
  }

  //------------------ Validation --------------
  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  final Map<dynamic, String> _formError = {};
  Map<dynamic, String> get formError => _formError;

  // validate phone number.
  validatePhoneNumber(String value, var controller) {
    return _setStateOfFormField(
      FrontValidation.validateFormField(
        value,
        "Phone number",
        minLength: 10,
        maxLength: 10,
      ),
      controller,
    );
  }

  // a method to validate password field.
  validatePassword(String value, var controller) {
    return _setStateOfFormField(
      FrontValidation.validateFormField(
        value,
        "Password",
        minLength: 6,
      ),
      controller,
    );
  }

  _setStateOfFormField(String msg, var controller) {
    // takes the validation result and set the state
    if (msg.isNotEmpty) {
      _formError[controller] = msg;
      notifyListeners();
      return;
    }
    _formError.remove(controller);
    notifyListeners();
    return;
  }
  //--------------------------------------------

  bool _passVisible = false;
  void togglePasswordVissibility() {
    _passVisible = !_passVisible;
    notifyListeners();
  }

  // handles login button click.
  void onLoginButton() async {
    _formError.remove('response');
    //show error message when a some fields are not filled
    if (_formKey.currentState!.validate() && _formError.isEmpty) {
      //show progress indicator here
      setBusy(true);
      notifyListeners();
      SessionService.setBool(SessionKey.newUser, false);
      //backend call
      var response = await _authentication.loginUser(
        LoginModel(
          phoneNumber: phoneNumController.text,
          password: passwordController.text,
        ),
      );
      _navigationService
          .clearStackAndShow(Routes.landingView); // todo change later.
      // check a response
      //validate a user credential.
      if (response.statusCode == 201 || response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var merchant = body['data']['user'];
        var token = body['data']['token'];

        // store a user data...
        UserModel user = UserModel.fromMap(merchant);
        _userService.setUserData(user);
        SessionService.setString(SessionKey.token, token);

        //navigate to the next page.
        _navigationService.clearStackAndShow(Routes.landingView);
      } else {
        // not successful
        if (response.body.contains('{')) {
          try {
            var body = jsonDecode(response.body);
            var message = body['message'];
            _formError['response'] = message;
          } catch (e) {
            _formError['response'] = response.body.toString();
          }
        } else {
          _formError['response'] = response.body.toString();
        }
      }
      setBusy(false);
      notifyListeners();
    }
  }
}
