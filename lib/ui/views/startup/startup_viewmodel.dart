import 'dart:convert';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:marchant/enums/user_role.dart';
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

    await Future.delayed(const Duration(seconds: 2));

    if (token != null) {
      try {
        // Get user data using the token
        var response = await _authentication.tokenLogin(role);
        var body = jsonDecode(response.body);
        var merchant = body['user'];
        var token = body['token'];
        // Validate and parse user data
        if (merchant != null && merchant is Map<String, dynamic>) {
          UserModel user = UserModel.fromMap(merchant);
          _userService.setUserData(user);

          // Save the token
          await SessionService.setString(SessionKey.token, token);

          // Set landing page index based on user role
          UserRole? userRoleEnum = userRoleFromString(user.role);
          if (userRoleEnum == UserRole.retailor) {
            _landingStateService.setIndex(0);
          } else if (userRoleEnum == UserRole.manufacturer) {
            _landingStateService.setIndex(1);
          }

          // Set user role in landing state service
          _landingStateService.setUserRole(user.role);

          // Navigate to the landing view after successful login
          _navigationService.clearStackAndShow(Routes.landingView);
          return;
        }
      } catch (e) {
        print('Error during token login: $e');
      }
    }

    // Always navigate to the login view if no valid token or in case of an error
    _navigationService.replaceWithLoginView();
  }
}


// import 'package:stacked/stacked.dart';
// import 'package:marchant/app/app.locator.dart';
// import 'package:marchant/app/app.router.dart';
// import 'package:stacked_services/stacked_services.dart';

// class StartupViewModel extends BaseViewModel {
//   final _navigationService = locator<NavigationService>();

//   // Place anything here that needs to happen before we get into the application
//   Future runStartupLogic() async {
//     await Future.delayed(const Duration(seconds: 2));

//     // Always navigate to the login view
//     _navigationService.replaceWithLoginView();
//   }
// }
