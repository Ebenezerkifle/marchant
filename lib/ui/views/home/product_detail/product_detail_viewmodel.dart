import 'package:marchant/app/app.bottomsheets.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProductDetailViewModel extends BaseViewModel {
  final _cartService = locator<CartStateService>();
  final _bottomSheet = locator<BottomSheetService>();

  final ProductModel product;
  ProductDetailViewModel({required this.product});

  Map<String, ProductModel> get _cartItems => _cartService.cartItems;
  onAddToCart() async {
    // add to cart.
    // setBusy(true);
    // if (!_cartItems.containsKey(product.id)) {
    //   _cartService.addToCart(product);
    //   SnackBarService.showSnackBar(content: 'Added to cart');
    // } else {
    //   SnackBarService.showSnackBar(content: 'Already added to Cart');
    // }
    // setBusy(false);
    // notifyListeners();

    _bottomSheet.showCustomSheet(
      variant: BottomSheetType.cart,
      data: product,
    );
  }
}
