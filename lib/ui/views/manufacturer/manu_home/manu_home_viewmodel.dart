import 'package:marchant/app/app.locator.dart';
import 'package:marchant/enums/user_role.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:stacked/stacked.dart';

class ManuHomeViewModel extends BaseViewModel {
  final _landingService = locator<LandingStateService>();

  changeUserRole() {
    _landingService.changeUserRole(UserRole.retailor);
    notifyListeners();
  }

  onPostProduct() {
    _landingService.setIndex(1);
  }
}
