// import 'package:marchant/services/storage_service.dart/session.dart';
import 'package:stacked/stacked.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/storage_service.dart/session.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    var newUser = await SessionService.getBool(SessionKey.newUser);
    await Future.delayed(const Duration(seconds: 2));
    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
    if (newUser != null && !newUser) {
      _navigationService.replaceWithLandingView();
      return;
    }
    _navigationService.replaceWithLoginView();
  }
}
