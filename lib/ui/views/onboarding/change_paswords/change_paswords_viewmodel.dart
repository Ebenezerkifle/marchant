import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:marchant/app/app.dialogs.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/services/api_service/authentication.dart';
import 'package:marchant/services/state_service/request_status_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';

import '../../../../services/state_service/auth_state_service.dart';
import '../../../../services/state_service/snackbar_service.dart';
import '../../../../services/state_service/user_service.dart';
import '../../../../services/validation_service/front_validation.dart';

class ChangePasswordsViewModel extends BaseViewModel {
  final _apiCall = Authentication();
  final _userService = locator<UserService>();
  final _statusService = locator<RequestStatusService>();
  final _navigation = locator<NavigationService>();
  final _stateService = locator<AuthStateService>();
  final _dialog = locator<DialogService>();
  String _userId = '';
  String _role = '';

  final bool forget;

  ChangePasswordsViewModel({required this.forget}) // initialization
  {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      forget ? _init() : null;
    });
  }

  _init() async {
    // initialization
    // send phone number for verification.
    setBusy(true);
    _statusService.changeStatus(
      status: RequestStatuss.loading,
      description: "checking_phone_num".tr(),
    );
    _dialog.showCustomDialog(variant: DialogType.status);
    var response =
        await _apiCall.checkPhoneNumber(_stateService.phoneNum.substring(4));
    var status = RequestStatuss.none;
    var title = '';
    var description = '';

    if (response.statusCode == 200 || response.statusCode == 201) {
      status = RequestStatuss.success;
      title = 'success'.tr();
      description = 'found_phone_msg'.tr();
      var body = jsonDecode(response.body);
      _userId = body['id'];
      _role = body['role'];

      notifyListeners();
      // close dialog
      await Future.delayed(const Duration(seconds: 2), () {
        _dialog.completeDialog(DialogResponse(confirmed: true));
      });
    } else {
      status = RequestStatuss.error;
      title = 'error'.tr();
      description = "not_found_phone_msg".tr();
      // navigate to login page.
      Future.delayed(const Duration(seconds: 2), () {
        _navigation.clearStackAndShow(Routes.loginView);
      });
    }
    _statusService.changeStatus(
      status: status,
      title: title,
      description: description,
    );
    setBusy(false);
  }

  String get title => 'change_password'.tr();

  String get password => 'previous_password'.tr();
  TextEditingController passwordController = TextEditingController();
  String get passwordHint => '******';

  bool _prevPass = false;
  bool get prevPassVisible => _prevPass;

  togglePrevPass() {
    // previous password
    _prevPass = !_prevPass;
    notifyListeners();
  }

  String get newPassword => 'new_password'.tr();
  TextEditingController newPasswordController = TextEditingController();
  String get newPasswordHint => '******';

  bool _newPass = false;
  bool get newPassVisible => _newPass;

  toggleNewPass() {
    // new newPassword
    _newPass = !_newPass;
    notifyListeners();
  }

  String get confirmPassword => 'confirm_password'.tr();
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
      setBusy(true);

      Response response;
      if (forget) {
        response =
            await _apiCall.resetPassword(_userId, newPasswordController.text, _role);
      } else {
        var userId = _userService.user?.id ?? '';
        response = await _apiCall.changePassword(
          userId,
          passwordController.text,
          newPasswordController.text,
        );
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        // success
        // show snakbar here
        SnackBarService.showSnackBar(
          content: 'password_changed_success'.tr(),
        );
        // clear all fields for security reason.
        _clearFields();
        forget
            ? _navigation.clearStackAndShow(Routes.loginView)
            : _navigation.back();
      } else {
        setError(true);
        errorMsg = "something_went_wrong".tr();
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
