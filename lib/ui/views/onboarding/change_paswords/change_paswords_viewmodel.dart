import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:marchant/services/api_service/authentication.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';

import '../../../../services/state_service/snackbar_service.dart';
import '../../../../services/state_service/user_service.dart';
import '../../../../services/validation_service/front_validation.dart';

class ChangePasswordsViewModel extends BaseViewModel {
  final _apiCall = Authentication();
  final _userService = locator<UserService>();

  final _navigation = locator<NavigationService>();

  String get title => 'change password';

  String get password => 'previous password';
  TextEditingController passwordController = TextEditingController();
  String get passwordHint => '******';

  bool _prevPass = false;
  bool get prevPassVisible => _prevPass;

  togglePrevPass() {
    // previous password
    _prevPass = !_prevPass;
    notifyListeners();
  }

  String get newPassword => 'new password';
  TextEditingController newPasswordController = TextEditingController();
  String get newPasswordHint => '******';

  bool _newPass = false;
  bool get newPassVisible => _newPass;

  toggleNewPass() {
    // new newPassword
    _newPass = !_newPass;
    notifyListeners();
  }

  String get confirmPassword => 'confirm password';
  TextEditingController confirmPasswordController = TextEditingController();
  String get confirmPasswordHint => '******';

  bool _confirmPass = false;
  bool get confirmPassVisible => _confirmPass;

  toggleconfirmPass() {
    // confirm confirmPassword
    _confirmPass = !_confirmPass;
    notifyListeners();
  }

  String errorMsg = '';

  onSubmit() async {
    errorMsg = '';
    // on submit.
    if (_formKey.currentState!.validate() && _formError.isEmpty) {
      // here we are.
      setBusy(true);

      Response response;

      var userId = _userService.user?.id ?? '';
      response = await _apiCall.changePassword(
        userId,
        passwordController.text,
        newPasswordController.text,
      );
      // print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // success
        // show snakbar here
        SnackBarService.showSnackBar(
          content: 'password changed successfuly'.trim(),
        );
        // clear all fields for security reason.
        _clearFields();

        _navigation.back();
      } else {
        setError(true);
        errorMsg = 'Something went wrong!';
        notifyListeners();
      }
      setBusy(false);
    }
  }

  _clearFields() {
    passwordController.clear();
    confirmPasswordController.clear();
    newPasswordController.clear();
  }

  //---------------- FRONT END VALIDATION -------------

  final Map<dynamic, String> _formError = {};
  Map<dynamic, String> get formError => _formError;

  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  _setStateOfFormField(String msg, var controller) {
    // takes the validation result and set the state
    if (msg.isNotEmpty) {
      _formError[controller] = msg;
      notifyListeners();
      return;
    } else {
      _formError.remove(controller);
      notifyListeners();
      return;
    }
  }

  // validate Name
  validateText(String value, var controller, String label,
      {int? minLength, int? maxLength}) {
    return _setStateOfFormField(
      FrontValidation.validateFormField(
        value,
        label,
        minLength: minLength,
        maxLength: maxLength,
      ),
      controller,
    );
  }

  // validate email address
  validateEmail(String value, var controller) {
    return _setStateOfFormField(
      FrontValidation.validateFormField(
        value,
        "Email",
        minLength: 8,
        email: true,
      ),
      controller,
    );
  }

  // validate phone number
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

  // validate confirm password
  validateConfirmPass(String value, String passwordValue, var controller) {
    return _setStateOfFormField(
      FrontValidation.confirmPassword(
          password: passwordValue, confirmPass: value),
      controller,
    );
  }
}
