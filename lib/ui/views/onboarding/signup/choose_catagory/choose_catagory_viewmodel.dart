import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/category_model.dart';
import 'dart:convert';
import 'package:marchant/models/user_model.dart';
import 'package:marchant/services/state_service/merchant_enrollment_service.dart';
import 'package:marchant/services/state_service/merchant_top_category_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:marchant/services/api_service/authentication.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:marchant/services/storage_service.dart/session.dart';

class ChooseCategoryViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _apiService = Authentication();
  final _userService = UserService();
  final _topCategoryState = locator<MerchantTopCategoryService>();
  final _merchantEnrollmentService = locator<MerchantEnrollmentService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_topCategoryState];

  Map<String, Category> get catagories => _topCategoryState.categories;

  // Map<String, String> categories = {
  //   "a": "Electronics",
  //   "b": "Restaurant",
  //   "c": "Construction",
  //   "d": "Agriculture",
  //   "e": "Mini-market",
  // };

  Map<String, String> selected = {};

  // Validation of an input
  final Map<dynamic, String> _formError = {};
  Map<dynamic, String> get formError => _formError;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  bool _loading = false;
  bool get loading => _loading;

  onSelected(String key) {
    selected.clear();
    selected[key] = key;
    notifyListeners();
  }

  void onSubmit() async {
    // _formError.remove('response');
    if (selected.isNotEmpty) {
      _merchantEnrollmentService.setValue(
        CategoryId: selected.entries.first.key,
      );
      _loading = true;
      var response = await _apiService
          .registerNewUser(_merchantEnrollmentService.getAnObject());
      if (response.statusCode == 201 || response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var merchant = body['data']['newUser'];
        var token = body['data']['token'];
        _userService.setUserData(UserModel.fromMap(merchant));
        SessionService.setString(SessionKey.token, token);
        _navigation.clearStackAndShow(Routes.landingView);
      } else {
        try {
          var body = jsonDecode(response.body);
          _formError['response'] = body['message'];
        } catch (e) {
          _formError['response'] = response.body.toString();
        }
      }
      _loading = false;
      notifyListeners();
    }else{
      //todo
    }
  }
}
