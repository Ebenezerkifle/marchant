import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart';
import 'package:marchant/services/api_service/authentication.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../models/category_model.dart'; // Use MyCategory here
import '../../../../models/user_model.dart';
import '../../../../services/state_service/enrollment_state_service.dart';
import '../../../../services/state_service/snackbar_service.dart';
import '../../../../services/state_service/user_service.dart';
import '../../../../services/storage_service.dart/session.dart';
import '../../../../services/validation_service/front_validation.dart';

class MydetailViewModel extends BaseViewModel {
  final _apiCall = Authentication();
  final _userService = locator<UserService>();
  final _navigation = locator<NavigationService>();
  final _enrollmentService = locator<EnrollmentStateService>();

  bool _loading = false;
  bool get loading => _loading;

  Map<String, Category> topCategories = {};
  String? selectedCategory;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  String get role => _userService.user?.role ?? '';

  String get title => 'Change Profile';
  double get iconSize => 15;
  String get phoneNumFieldHint => 'Phone number';
  String get fristName => 'First Name';
  String get lastName => 'Last Name';

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  String errorMsg = '';

  Future<void> initialize() async {
    await _loadCategories();
    _loadUserDetails();
  }

  Future<void> _loadCategories() async {
    try {
      await _enrollmentService.getTopCategories();
      topCategories = _enrollmentService.topCategories;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load categories';
    }
    notifyListeners();
  }

  void _loadUserDetails() {
    var user = _userService.user;
    if (user != null) {
      firstNameController.text = user.firstName ?? '';
      lastNameController.text = user.lastName ?? '';
      phoneNumController.text = user.phoneNumber?.padLeft(10, '0') ?? '';
      selectedCategory = user.CategoryId;
    }
  }

  void setSelectedCategory(String? category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> onSubmit() async {
    errorMsg = '';
    if (_formKey.currentState!.validate() && _formError.isEmpty) {
      setBusy(true);
      try {
        Response response = await _apiCall.changeUserProfile(
          UserModel(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            phoneNumber: phoneNumController.text.substring(1),
            CategoryId: selectedCategory,
          ),
        );
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          var body = jsonDecode(response.body);
          var userData = _userService.user?.role == "Retailer"
              ? body['data']['retailer']
              : body['data']['manufacturer'];

          if (userData != null) {
            // var token = body['token'];
            var newUserData = UserModel.fromMap(userData);
            _userService.setUserData(newUserData);
            // SessionService.setString(SessionKey.token, token);

            SnackBarService.showSnackBar(
              content: 'Your profile changed successfully',
            );
            _navigation.back();
          } else {
            _formError['response'] = 'User data not found in response';
          }
        } else {
          var errorMessage = 'Error updating profile';
          if (response.body.contains('{')) {
            try {
              var body = jsonDecode(response.body);
              errorMessage = body['message'];
            } catch (e) {
              errorMessage = 'Failed to decode error message';
            }
          } else {
            errorMessage = 'Unexpected error occurred';
          }
          _formError['response'] = errorMessage;
        }
      } catch (e) {
        print(e);
        _formError['response'] = 'Exception: ${e.toString()}';
      }

      setBusy(false);
      notifyListeners();
    }
  }

  final Map<dynamic, String> _formError = {};
  Map<dynamic, String> get formError => _formError;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  void _setStateOfFormField(String msg, var controller) {
    if (msg.isNotEmpty) {
      _formError[controller] = msg;
      notifyListeners();
    } else {
      _formError.remove(controller);
      notifyListeners();
    }
  }

  void validateText(String value, var controller, String label,
      {int? minLength, int? maxLength}) {
    _setStateOfFormField(
      FrontValidation.validateFormField(value, label,
          minLength: minLength, maxLength: maxLength),
      controller,
    );
  }

  void validatePhoneNumber(String value, var controller) {
    _setStateOfFormField(
      FrontValidation.validateFormField(value, 'Phone number',
          minLength: 10, maxLength: 10),
      controller,
    );
  }
}
