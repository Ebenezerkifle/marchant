import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:marchant/app/app.bottomsheets.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:marchant/services/state_service/snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailViewModel extends BaseViewModel {
  final _cartService = locator<CartStateService>();
  final _bottomSheet = locator<BottomSheetService>();
  final _navigation = locator<NavigationService>();

  String get productDetailHeader => "product_detail_header".tr();
  String get productDetalistext => "more_details".tr();
  String get manufacturerText => "manufacturer".tr();
  String get unKnownText => "unknown".tr();
  String get seeMoreText => "see_more".tr();
  String get totalPriceText => "total_price".tr();
  String get addToCartText => "add_to_cart".tr();

  final ProductModel product;
  ProductDetailViewModel({required this.product});

  onPressed() {
    _navigation.navigateToCompanyProfileView(product: product);
  }

  onAddToCart() async {
    var compeleter = await _bottomSheet.showCustomSheet(
      variant: BottomSheetType.cart,
      data: product,
    );
    try {
      if (compeleter!.confirmed) {
        _cartService.addToCart(compeleter.data);
        SnackBarService.showSnackBar(content: 'Added_to_cart'.tr());
        //  _landingStateService.setIndex(1);
        //   _navigation.clearStackAndShow(Routes.landingView);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
