import 'package:flutter/material.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/services/state_service/onboarding_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../services/validation_service/front_validation.dart';

class SignupViewModel extends FormViewModel {
  final _navigation = locator<NavigationService>();
  final _onboardingState = locator<OnboardingStateService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_onboardingState];

  String get signUpMsg => 'Create an Account';

  TextEditingController phoneNumController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  double get iconSize => 15;

  String get phoneNumFieldHint => 'Phone number';
 

  String get haveAccount => 'Aready have an Account?';

  String get image => 'assets/images/order_delivery.png';
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  // double get iconSize => 15;

  // String get phoneNumFieldHint => 'Phone number';
  String get passHint => 'password';
  String get confirmHint => 'confirm password';

  onSignIn() {
    _navigation.clearStackAndShow(Routes.loginView);
  }

  onNext() {
     // navigate to the next page.
    if (_formKey.currentState!.validate() && _formError.isEmpty) {
      _navigation.navigateToChooseCatagoryView();
    }
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
  validateAText(
    String value,
    String name,
    var controller, {
    int? maxLength,
    int? minLength,
  }) {
    return _setStateOfFormField(
      FrontValidation.validateFormField(
        value,
        name,
        minLength: minLength,
        maxLength: maxLength,
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

  // _setStateOfFormField(String msg, var controller) {
  //   // takes the validation result and set the state
  //   if (msg.isNotEmpty) {
  //     _formError[controller] = msg;
  //     notifyListeners();
  //     return;
  //   }
  //   _formError.remove(controller);
  //   notifyListeners();
  //   return;
  // }
  //--------------------------------------------
}
