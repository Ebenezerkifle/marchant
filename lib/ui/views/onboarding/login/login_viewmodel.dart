import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/login_model.dart';
import 'package:marchant/models/user_model.dart';
import 'package:marchant/services/api_service/authentication.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'package:marchant/services/validation_service/front_validation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authentication = Authentication();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _landingStateService = locator<LandingStateService>();

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

    if (_formKey.currentState!.validate() && _formError.isEmpty) {
      // Show progress indicator
      setBusy(true);
      notifyListeners();
      SessionService.setBool(SessionKey.newUser, false);

        // Backend call to login the user
        var response = await _authentication.loginUser(
          LoginModel(
            phoneNumber: phoneNumController.text.substring(1),
            password: passwordController.text,
          ),
        );
        // Check the response status
        if (response.statusCode == 201 || response.statusCode == 200) {
          var body = jsonDecode(response.body);
          var merchant = body['userLogged'];
          var token = body['token'];

          // Store user data
          UserModel user = UserModel.fromMap(merchant);
          _userService.setUserData(user); // Ensure user data is set here

          // Save the token
          SessionService.setString(SessionKey.token, token);
          _landingStateService.setIndex(0);
          // Navigate to the landing view after successful login

          _navigationService.clearStackAndShow(Routes.landingView);
        } else {
          // Handle unsuccessful response
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
         // Reset the busy state and notify listeners
        setBusy(false);
        notifyListeners();
      } 
           
  }
}
