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

// class ChooseCategoryViewModel extends ReactiveViewModel {
//   final _navigation = locator<NavigationService>();
//   final _enrollmentService = locator<EnrollmentStateService>();
//   final _userService = locator<UserService>();
//   final _landingStateService = locator<LandingStateService>();

//   bool _loading = false;
//   bool get loading => _loading;

//   Map<String, Category> topCategories = {};
//   Map<String, String> selected = {};
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   final Map<dynamic, String> _formError = {};
//   Map<dynamic, String> get formError => _formError;

//   final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();

//   ChooseCategoryViewModel() {
//     _init();
//   }

//   _init() async {
//     await _loadCategories();
//   }

//   Future<void> _loadCategories() async {
//     setLoading(true);
//     try {
//       await _enrollmentService.getTopCategories();
//       topCategories = _enrollmentService.topCategories;
//       _errorMessage = null;
//     } catch (e) {
//       _errorMessage = 'Failed to load categories: $e';
//     }
//     setLoading(false);
//   }

//   Future<void> refresh() async {
//     await _loadCategories();
//   }

//   void setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }

//   @override
//   List<ListenableServiceMixin> get listenableServices => [_enrollmentService];

//   void onSelected(String key) {
//     selected.clear();
//     selected[key] = key;
//     notifyListeners();
//   }

//   void onBack() {
//     _navigation.back();
//   }

//   Future<void> onSubmit() async {
//     if (selected.isNotEmpty) {
//       _enrollmentService.setUserModel(categoryId: selected.entries.first.key);
//       setBusy(true);

//       try {
//         var response = await _enrollmentService.registerAuser();

//         if (response.statusCode == 201 || response.statusCode == 200) {
//           var body = jsonDecode(response.body);
//           var retailer = body['data']['retailer'];
//           var token = body['token'];

//           if (retailer != null && token != null) {
//             var newUserData = UserModel.fromMap(retailer);

//             _userService.setUserData(newUserData);
//             SessionService.setString(SessionKey.token, token);
//             _landingStateService.setIndex(0);
//             _navigation.clearStackAndShow(Routes.landingView);
//           } else {
//             _formError['response'] = 'No retailer data found';
//             _errorMessage = _formError['response'];
//           }
//         } else {
//           _handleErrorResponse(response);
//         }
//       } catch (e) {
//         _formError['response'] = 'An error occurred: $e';
//         _errorMessage = _formError['response'];
//       } finally {
//         setBusy(false);
//         notifyListeners();
//       }
//     }
//   }

//   void _handleErrorResponse(response) {
//     if (response.body.contains('{')) {
//       try {
//         var body = jsonDecode(response.body);
//         var message = body['message'];
//         _formError['response'] = message;
//       } catch (e) {
//         _formError['response'] = response.body.toString();
//       }
//     } else {
//       _formError['response'] = response.body.toString();
//     }
//     _errorMessage = _formError['response'];
//   }
// }



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:marchant/app/app.locator.dart';
// import 'package:marchant/app/app.router.dart';
// import 'package:marchant/models/category_model.dart';
// import 'package:marchant/models/user_model.dart';
// import 'package:marchant/services/state_service/enrollment_state_service.dart';
// import 'package:marchant/services/state_service/landing_state_servic.dart';
// import 'package:marchant/services/state_service/user_service.dart';
// import 'package:marchant/services/storage_service/session.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';

class ChooseCategoryViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _enrollmentService = locator<EnrollmentStateService>();
  final _userService = locator<UserService>();
  final _landingStateService = locator<LandingStateService>();

  bool _loading = false;
  bool get loading => _loading;

  Map<String, Category> topCategories = {};
  Map<String, String> selected = {};
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final Map<dynamic, String> _formError = {};
  Map<dynamic, String> get formError => _formError;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  ChooseCategoryViewModel() {
    _init();
  }

  void _init() async {
    await _loadCategories();
  }

  Future<void> _loadCategories() async {
    setLoading(true);
    try {
      await _enrollmentService.getTopCategories();
      topCategories = _enrollmentService.topCategories;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load categories';
    }
    setLoading(false);
  }

  Future<void> refresh() async {
    await _loadCategories();
  }

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_enrollmentService];

  void onSelected(String key) {
    selected.clear();
    selected[key] = key;
    notifyListeners();
  }

  void onBack() {
    _navigation.back();
  }
  String errorMsg = '';

  Future<void> onSubmit() async {
    if (selected.isNotEmpty) {
      _enrollmentService.setUserModel(categoryId: selected.entries.first.key);
      setBusy(true);

      try {
        var response = await _enrollmentService.registerAuser();

        if (response.statusCode == 201 || response.statusCode == 200) {
          var body = jsonDecode(response.body);
          var retailer = body['data']['retailer'];
          var token = body['token'];

          if (retailer != null && token != null) {
            var newUserData = UserModel.fromMap(retailer);

            _userService.setUserData(newUserData);
            SessionService.setString(SessionKey.token, token);
            _landingStateService.setIndex(0);
            _navigation.clearStackAndShow(Routes.landingView);
          } else {
            _formError['response'] = 'No retailer data found';
            _errorMessage = _formError['response'];
          }
        } else {
          _handleErrorResponse(response);
        }
      } catch (e) {
        _formError['response'] = 'An error occurred: $e';
        _errorMessage = _formError['response'];
      } finally {
        setBusy(false);
        notifyListeners();
      }
    }
  }

  void _handleErrorResponse(response) {
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
}
