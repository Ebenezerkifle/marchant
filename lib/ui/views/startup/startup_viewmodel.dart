import 'dart:convert';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:marchant/models/user_model.dart';
import 'package:marchant/services/api_service/authentication.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import '../../../services/storage_service.dart/session.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _authentication = Authentication();
  final _landingStateService = locator<LandingStateService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    var token = await SessionService.getString(SessionKey.token);
    var role = await SessionService.getString(SessionKey.role);

    await Future.delayed(const Duration(seconds: 1));

    if (token != null && role != null) {
      try {
        // Get user data using the token
        var response = await _authentication.tokenLogin(role);
        var body = jsonDecode(response.body);

        if (body != null) {
          // Validate and parse user data
          UserModel user = UserModel.fromMap(body);
          _userService.setUserData(user);
          _landingStateService.setUserRole(user.role);
          // Navigate to the landing view after successful login
          _navigationService.clearStackAndShow(Routes.landingView);
          return;
        } else {}
      } catch (e) {
        print('Error during token login: $e');
      }
    } else {
      // Always navigate to the login view if no valid token or in case of an error
      _navigationService.replaceWithLoginView();
    }
  }
}
