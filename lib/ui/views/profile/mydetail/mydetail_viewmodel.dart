import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart';
import 'package:marchant/services/api_service/authentication.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
// import '../../../../app/app.router.dart';
import '../../../../models/category_model.dart'; // Use MyCategory here
import '../../../../models/user_model.dart';
import '../../../../services/state_service/enrollment_state_service.dart';
import '../../../../services/state_service/snackbar_service.dart';
import '../../../../services/state_service/user_service.dart';
// import '../../../../services/storage_service.dart/session.dart';
import '../../../../services/validation_service/front_validation.dart';

class MydetailViewModel extends ReactiveViewModel {
  final _apiCall = Authentication();
  final _userService = locator<UserService>();
  final _navigation = locator<NavigationService>();
  final _enrollmentService = locator<EnrollmentStateService>();
  // final _landingStateService = locator<LandingStateService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  final bool _loading = false;
  bool get loading => _loading;

  Map<String, Category> topCategories = {};
  String? selectedCategory;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  String get role => _userService.user?.role ?? '';

  String get title => 'change_profile'.tr();
  double get iconSize => 15;
  String get phoneNumFieldHint => 'phone_number'.tr();
  String get firstName => 'first_name'.tr();
  String get lastName => 'last_name'.tr();
  String get location => 'location'.tr();
  String get tin => 'tin'.tr();
  String get city => 'city'.tr();
  String get subCity => 'sub_city'.tr();
  String get woreda => 'woreda'.tr();
  String get idNumber => 'id_number'.tr();
  String get change => 'change'.tr();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController tinController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController subCityController = TextEditingController();
  TextEditingController woredaController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();

  MydetailViewModel() {
    initialize();
  }

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
      locationController.text = user.location ?? '';
      tinController.text = user.tin ?? '';
      cityController.text = user.city ?? '';
      subCityController.text = user.subCity ?? '';
      woredaController.text = user.woreda ?? '';
      idNumberController.text = user.idNumber ?? '';
      phoneNumController.text = user.phoneNumber?.padLeft(10, '0') ?? '';
      selectedCategory = user.CategoryId;
    }
  }

  void setSelectedCategory(String? category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> onSubmit() async {
    _formError.remove('response');
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
            location: locationController.text,
            tin: tinController.text,
            city: cityController.text,
            subCity: subCityController.text,
            woreda: woredaController.text,
            idNumber: idNumberController.text,
          ),
        );

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
            notifyListeners();

            SnackBarService.showSnackBar(
              content: "success_profile_change",
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

  void validateText(String? value, var controller, String label,
      {int? minLength, int? maxLength}) {
    value != null && value.isEmpty
        ? null // Allow empty values for First Name and Last Name
        : _setStateOfFormField(
            FrontValidation.validateFormField(value ?? '', label,
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
