import 'dart:core';

class FrontValidation {
  static final emailPattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final phoneNumPattern = RegExp(r'^([0]9)?[0-9]{10}$');

  // a class to help as validate different inputs
  static String validateFormField(
    String value,
    String fieldName, {
    int? maxLength,
    int? minLength,
    bool email = false,
    bool? canBeEmpty = false,
  }) {
    String msg = '';
    // a value should be empty.

    if (canBeEmpty == true && value.isEmpty) {
      // when empty is possible
      return msg;
    }

    if (value.isEmpty) {
      msg = '$fieldName can not be empty';
    }
    // a value should not be lessthan a specific length
    else if (minLength != null && value.length < minLength) {
      msg = 'Please provide a valid $fieldName';
    }
    // a valud should not be greaterthan a specific length
    else if (maxLength != null && value.length > maxLength) {
      msg = 'Please provide a valid $fieldName';
    }
    return email && msg.isEmpty ? emailValidation(value, msg) : msg;
  }

  static confirmPassword(
      {required String password, required String confirmPass}) {
    String msg = '';
    if (password != confirmPass) {
      msg = "Password mismatch occured";
    }
    return msg;
  }

  // validate email address
  static String emailValidation(String value, String msg) {
    return emailPattern.hasMatch(value) ? msg : "Invalid email";
  }

  // validate phone number
  static String phoneValidation(String value, String msg) {
    return phoneNumPattern.hasMatch(value) ? msg : "Invalid phone number";
  }
}
