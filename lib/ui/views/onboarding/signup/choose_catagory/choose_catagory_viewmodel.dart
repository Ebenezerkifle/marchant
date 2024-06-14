import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/category_model.dart';
import 'package:marchant/models/user_model.dart';
import 'package:marchant/services/state_service/enrollment_state_service.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChooseCategoryViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _enrollmentService = locator<EnrollmentStateService>();
  final _userService = locator<UserService>();
  final _landingStateService = locator<LandingStateService>();

  bool _loading = false;
  bool get loading => _loading;

  ChooseCategoryViewModel() {
    _init();
  }

  _init() async {
    _loading = true;
    notifyListeners();
    try {
      await _enrollmentService.getTopCategories();
    } catch (e) {
      _errorMessage = 'Failed to load categories: $e';
      print(_errorMessage);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_enrollmentService];

  Map<String, Category> get topCatagories => _enrollmentService.topCategories;
  Map<String, String> selected = {};

  final Map<dynamic, String> _formError = {};
  Map<dynamic, String> get formError => _formError;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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
      setBusy(true);

      try {
        var response = await _enrollmentService.registerAuser();
        print('Response: ${response.statusCode} ${response.body}');

        if (response.statusCode == 201 || response.statusCode == 200) {
          var body = jsonDecode(response.body);
          // print('Body: $body');

          var retailer = body['data']['retailer'];
          var token = body['token'];

          print('Retailer: $retailer');
          print('Token: $token');

          if (retailer != null && token != null) {
            var newUserData = UserModel.fromMap(retailer);

            _userService.setUserData(newUserData);
            // print('User data after setting: ${_userService.user}');
            // print(_userService.user?.CategoryId);
            // print(_userService.user?.phoneNumber);
            SessionService.setString(SessionKey.token, token);
            _landingStateService.setIndex(0);
            _navigation.clearStackAndShow(Routes.landingView);
          } else {
            _formError['response'] = 'No retailer data found';
            _errorMessage = _formError['response'];
          }
        } else {
          // Handle other status codes
          if (response.body.contains('{')) {
            try {
              var body = jsonDecode(response.body);
              var message = body['message'];
              _formError['response'] = message;
            } catch (e) {
              _formError['response'] = response.body.toString();
            }
          } else {
            _formError['response'] = response.body.toString();
          }
          _errorMessage = _formError['response'];
        }
      } catch (e) {
        print('Error: $e');
        _formError['response'] = 'An error occurred: $e';
        _errorMessage = _formError['response'];
      } finally {
        setBusy(false);
        notifyListeners();
      }
    }
  }
}
