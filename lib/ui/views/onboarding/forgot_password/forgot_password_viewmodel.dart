import 'package:easy_localization/easy_localization.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/services/state_service/auth_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _stateService = locator<AuthStateService>();

  String get title => 'forgot_password'.tr();
  String get phoneNumber => 'phone_number'.tr();

  String _errorMsg = '';
  String get errorMsg => _errorMsg;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _phoneNum = '';

  void onPhoneNumberChanged(String phone) {
    if (phone.length == 10 &&
        (phone.startsWith('09') || phone.startsWith('07'))) {
      _hasError = false;
      _errorMsg = '';
      // Remove the first character (0) and prepend +251
      _phoneNum = '+251${phone.substring(1)}';
    } else {
      _hasError = true;
      _errorMsg = 'provide_valid'.tr();
    }
    notifyListeners();
  }

  void onNext() async {
    _hasError = false;
    if (_phoneNum.isNotEmpty && !_hasError) {
      // valid phone number
      _stateService.setPhoneNum(_phoneNum);
      _pushToOtpPage();
    } else {
      _errorMsg = 'valid_phoneNumber'.tr();
      _hasError = true;
      notifyListeners();
    }
  }

  void _pushToOtpPage() {
    _navigation.navigateToOtpView();
  }
}
