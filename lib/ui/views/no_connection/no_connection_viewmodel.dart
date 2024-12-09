
import 'dart:convert';

import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/user_model.dart';
import 'package:marchant/services/api_service/authentication.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NoConnectionViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _authentication = Authentication();
  final _userService = locator<UserService>();
  final _landingStateService = locator<LandingStateService>();

  Future<void> runStartupLogic() async {
    setBusy(true);
    var token = await SessionService.getString(SessionKey.token);
    var role = await SessionService.getString(SessionKey.role);
    if (token != null) {
      try {
        // Get user data using the token
        // Get user data using the token
        var response = await _authentication.tokenLogin(role);

        var body = jsonDecode(response.body);

        if (response.statusCode == 200) {
          // Validate and parse user data
          UserModel user = UserModel.fromMap(body);
          _userService.setUserData(user);
          _landingStateService.setUserRole(user.role);
          // Navigate to the landing view after successful login
          _navigationService.clearStackAndShow(Routes.landingView);
          return;
        } else {
          setBusy(false);
        }
      } catch (e) {
        setBusy(false);
      }
    } else {
      // Always navigate to the login view if no valid token or in case of an error
      _navigationService.replaceWithLoginView();
    }
  }
}
