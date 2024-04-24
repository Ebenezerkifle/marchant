import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/services/state_service/onboarding_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../services/validation_service/front_validation.dart';

class SignupFinalViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _onboardingState = locator<OnboardingStateService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_onboardingState];

  String get passMsg => 'Create password';

  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  double get iconSize => 15;

  String get phoneNumFieldHint => 'Phone number';
  String get passHint => 'password';
  String get confirmHint => 'confirm password';

  String get haveAccount => 'Aready have an Account?';

  onNext() {
    // navigate to the next page.
    if (_formKey.currentState!.validate() && _formError.isEmpty) {}
  }

  //------------------ Validation --------------
  final _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  final Map<dynamic, String> _formError = {};
  Map<dynamic, String> get formError => _formError;

  // validate password
  validatePassword(String value, var controller) {
    return _setStateOfFormField(
      FrontValidation.validateFormField(
        value,
        "Password",
        minLength: 6,
        maxLength: 20,
      ),
      controller,
    );
  }

  // a method to validate password field.
  validateConfirmPass(String value, String password, var controller) {
    return _setStateOfFormField(
      FrontValidation.confirmPassword(
        password: password,
        confirmPass: value,
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
}
