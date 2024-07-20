import 'package:easy_localization/easy_localization.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import '../../../../../services/state_service/user_service.dart';

class ManuProductDetailViewModel extends BaseViewModel {
  final _userService = locator<UserService>();

  String get role => _userService.user?.role ?? '';

  String get productDetailHeader => "product_detail_header".tr();
  String get productDetalistext => "more_details".tr();
  String get statusText => "status".tr();
}
