import 'package:flutter/foundation.dart';
import 'package:marchant/app/app.bottomsheets.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
// import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailViewModel extends BaseViewModel {
  final _cartService = locator<CartStateService>();
  final _bottomSheet = locator<BottomSheetService>();
  final _navigation = locator<NavigationService>();
  // final _landingStateService = locator<LandingStateService>();


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
        SnackBarService.showSnackBar(content: 'Added to cart');
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

// import 'package:flutter/foundation.dart';
// import 'package:marchant/app/app.bottomsheets.dart';
// import 'package:marchant/app/app.locator.dart';
// import 'package:marchant/models/product_model.dart';
// import 'package:marchant/services/state_service/cart_state_service.dart';
// import 'package:marchant/services/state_service/snackbar_service.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';

// class ProductDetailViewModel extends BaseViewModel {
//   final _cartService = locator<CartStateService>();
//   final _bottomSheet = locator<BottomSheetService>();

//   final ProductModel product;
//   final String defaultManufacturerLogo; // Add a default logo path (optional)
//   final String defaultManufacturerName; // Add a default manufacturer name

//   ProductDetailViewModel({
//     required this.product,
//     this.defaultManufacturerLogo = '', // Set default values if not provided
//     this.defaultManufacturerName = 'Unknown Manufacturer',
//   }) : assert(product != null); // Ensure product is not null

//   onAddToCart() async {
//     var compeleter = await _bottomSheet.showCustomSheet(
//       variant: BottomSheetType.cart,
//       data: product,
//     );
//     try {
//       if (compeleter!.confirmed) {
//         _cartService.addToCart(compeleter.data);
//         SnackBarService.showSnackBar(content: 'Added to cart');
//         notifyListeners();
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }
// }
