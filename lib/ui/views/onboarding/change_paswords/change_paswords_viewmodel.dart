import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:marchant/app/app.dialogs.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/services/api_service/authentication.dart';
import 'package:marchant/services/state_service/request_status_service_service.dart';
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
  final _statusService = locator<RequestStatusServiceService>();
  final _navigation = locator<NavigationService>();
  final _stateService = locator<AuthStateService>();
  final _dialog = locator<DialogService>();

  String _userId = '';
  String _role = '';
  final bool forget;

  ChangePasswordsViewModel({required this.forget}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      forget ? _init() : null;
    });
  }

  _init() async {
    _statusService.changeStatus(
      status: RequestStatus.loading,
      description: "checking_phone_num".tr(),
    );
    _dialog.showCustomDialog(variant: DialogType.status);

    final response =
        await _apiCall.checkPhoneNumber(_stateService.phoneNum.substring(4));

    var status = RequestStatus.none;
    var title = '';
    var description = '';

    if (response.statusCode == 200 || response.statusCode == 201) {
      status = RequestStatus.success;
      title = 'success'.tr();
      description = 'found_phone_msg'.tr();
      final body = jsonDecode(response.body);
      _userId = body['data']['id'];
      _role = body['data']['role'];

      notifyListeners();
      await Future.delayed(const Duration(seconds: 4), () {
        // _dialog.completeDialog(DialogResponse(confirmed: true));
      });
    } else {
      status = RequestStatus.error;
      title = 'error'.tr();
      description = "not_found_phone_msg".tr();
      Future.delayed(const Duration(seconds: 2), () {
        _navigation.clearStackAndShow(Routes.loginView);
      });
    }

    _statusService.changeStatus(
      status: status,
      title: title,
      description: description,
    );
  }

  String get title => 'change_password'.tr();

  String get password => 'previous_password'.tr();
  TextEditingController passwordController = TextEditingController();
  String get passwordHint => '******';

  bool _prevPassVisible = false;
  bool get prevPassVisible => _prevPassVisible;

  void togglePrevPass() {
    _prevPassVisible = !_prevPassVisible;
    notifyListeners();
  }

  String get newPassword => 'new_password'.tr();
  TextEditingController newPasswordController = TextEditingController();
  String get newPasswordHint => '******';

  bool _newPassVisible = false;
  bool get newPassVisible => _newPassVisible;

  void toggleNewPass() {
    _newPassVisible = !_newPassVisible;
    notifyListeners();
  }

  String get confirmPassword => 'confirm_password'.tr();
  TextEditingController confirmPasswordController = TextEditingController();
  String get confirmPasswordHint => '******';

  bool _confirmPassVisible = false;
  bool get confirmPassVisible => _confirmPassVisible;

  void toggleConfirmPass() {
    _confirmPassVisible = !_confirmPassVisible;
    notifyListeners();
  }

  String errorMsg = '';

  Future<void> onSubmit() async {
    errorMsg = '';
    if (_formKey.currentState!.validate() && _formError.isEmpty) {
      setBusy(true);

      Response response;
      if (forget) {
        response = await _apiCall.resetPassword(
            _userId, newPasswordController.text, _role);
      } else {
        final userId = _userService.user?.id ?? '';
        response = await _apiCall.changePassword(
          userId,
          passwordController.text,
          newPasswordController.text,
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        SnackBarService.showSnackBar(
          content: 'password_changed_success'.tr(),
        );
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

  void _clearFields() {
    passwordController.clear();
    confirmPasswordController.clear();
    newPasswordController.clear();
  }

  //---------------- FRONT END VALIDATION -------------

  final Map<dynamic, String> _formError = {};
  Map<dynamic, String> get formError => _formError;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  void _setStateOfFormField(String msg, var controller) {
    if (msg.isNotEmpty) {
      _formError[controller] = msg;
    } else {
      _formError.remove(controller);
    }
    notifyListeners();
  }

  // Validate text fields
  void validateText(String value, var controller, String label,
      {int? minLength, int? maxLength}) {
    _setStateOfFormField(
      FrontValidation.validateFormField(
        value,
        label,
        minLength: minLength,
        maxLength: maxLength,
      ),
      controller,
    );
  }

  // Validate email address
  void validateEmail(String value, var controller) {
    _setStateOfFormField(
      FrontValidation.validateFormField(
        value,
        "Email",
        minLength: 8,
        email: true,
      ),
      controller,
    );
  }

  // Validate phone number
  void validatePhoneNumber(String value, var controller) {
    _setStateOfFormField(
      FrontValidation.validateFormField(
        value,
        "Phone number",
        minLength: 10,
        maxLength: 10,
      ),
      controller,
    );
  }

  // Validate confirm password
  void validateConfirmPass(String value, String passwordValue, var controller) {
    _setStateOfFormField(
      FrontValidation.confirmPassword(
        password: passwordValue,
        confirmPass: value,
      ),
      controller,
    );
  }
}
