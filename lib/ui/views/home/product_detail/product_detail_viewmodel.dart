import 'package:flutter/foundation.dart';
import 'package:marchant/app/app.bottomsheets.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:marchant/services/state_service/snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailViewModel extends BaseViewModel {
  final _cartService = locator<CartStateService>();
  final _bottomSheet = locator<BottomSheetService>();

  final ProductModel product;
  ProductDetailViewModel({required this.product});

  onAddToCart() async {
    var compeleter = await _bottomSheet.showCustomSheet(
      variant: BottomSheetType.cart,
      data: product,
    );
    try {
      if (compeleter!.confirmed) {
        _cartService.addToCart(compeleter.data);
        SnackBarService.showSnackBar(content: 'Added to cart');
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
