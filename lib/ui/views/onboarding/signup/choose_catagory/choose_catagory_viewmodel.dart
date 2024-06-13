import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/category_model.dart';
import 'dart:convert';
import 'package:marchant/models/user_model.dart';
import 'package:marchant/services/state_service/enrollment_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:marchant/services/state_service/user_service.dart';

class ChooseCategoryViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _enrollmentService = locator<EnrollmentStateService>();
  bool _loading = false;
  bool get loading => _loading;

  ChooseCategoryViewModel() {
    // get a category list.
    _init();
  }

  _init() async {
    _loading = true;
    notifyListeners();
    await _enrollmentService.getTopCategories();
    _loading = false;
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_enrollmentService];

  Map<String, Category> get topCatagories => _enrollmentService.topCategories;

  // Map<String, String> topCategories = {
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

  onSelected(String key) {
    selected.clear();
    selected[key] = key;
    notifyListeners();
  }

  onBack() {
    _navigation.back();
  }

  void onSubmit() async {
    if (selected.isNotEmpty) {
      _enrollmentService.setUserModel(categoryId: selected.entries.first.key);
      print('***********************************************************');
      print(selected.entries.first.key);
      _loading = true;

      var response = await _enrollmentService.registerAuser();
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var merchant = body['data']['retailer'][0];
        //  var token = body['data']['token'];
        _userService.setUserData(UserModel.fromMap(merchant));
        // SessionService.setString(SessionKey.token, token);
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
    } else {
      //todo
    }
  }
}
