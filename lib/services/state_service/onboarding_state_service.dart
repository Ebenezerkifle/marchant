import 'package:marchant/models/user_model.dart';
import 'package:stacked/stacked.dart';

class OnboardingStateService with ListenableServiceMixin {
  OnboardingStateService() {
    listenToReactiveValues([_userModel]);
  }

  final _userModel = ReactiveValue(UserModel());
  UserModel get userModel => _userModel.value;

  changeUserModel(UserModel user) {
    _userModel.value = user;
    notifyListeners();
  }
}
