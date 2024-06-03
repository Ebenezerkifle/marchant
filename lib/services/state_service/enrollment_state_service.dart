import 'package:marchant/models/category_model.dart';
import 'package:marchant/models/user_model.dart';
import 'package:marchant/services/api_service/authentication.dart';
import 'package:marchant/services/api_service/category_api_service.dart';
import 'package:stacked/stacked.dart';

enum UserRole {
  marchant,
  manufacturor,
}

class EnrollmentStateService with ListenableServiceMixin {
  EnrollmentStateService() {
    listenToReactiveValues([_userModel, _topCategories]);
  }

  // stores the role of a user.
  final _userRole = ReactiveValue(UserRole.marchant);
  // set user role.
  setUserRole(UserRole role) {
    _userRole.value = role;
  }

  final _userModel = ReactiveValue(UserModel());

  setUserModel({
    var phoneNumber,
    var password,
    var categoryId,
  }) {
    _userModel.value = UserModel().copywith(
      phoneNumber: phoneNumber ?? _userModel.value.phoneNumber,
      password: password ?? _userModel.value.password,
      categoryId: categoryId ?? _userModel.value.categoryId,
    );
  }

  // enrollment.
  registerAuser() async {
    var response = await Authentication().registerNewUser(_userModel.value);
    return response;
  }

  final _topCategories = ReactiveValue<Map<String, Category>>({});
  Map<String, Category> get topCategories => _topCategories.value;

  getTopCategories() async {
    var response = await CategoryApiCallService().getTopCategories();
    _topCategories.value.clear();
    _topCategories.value.addAll(response);
    notifyListeners();
  }
}
