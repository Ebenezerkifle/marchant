import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/cart_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:marchant/services/state_service/snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CartViewModel extends ReactiveViewModel {
  final _cartService = locator<CartStateService>();
  final _navigation = locator<NavigationService>();
  @override
  List<ListenableServiceMixin> get listenableServices => [_cartService];

  CartViewModel() {
    // text editing controllers.
    for (var ele in cartItems.keys) {
      controllers[ele] = TextEditingController();
    }
  }

  Map<String, TextEditingController> controllers = {};
  Map<String, CartModel> get cartItems => _cartService.cartItems;
  double get totalPrice => _cartService.totalPrice;
  num get totalCount => _cartService.totalCount;

  onChange(String count, String cartKey) {
    //
    CartModel cartItem = cartItems[cartKey] ?? CartModel();
    num itemCount = num.parse(count);
    cartItem.count = itemCount;
    cartItem.totalPrice = itemCount * (cartItem.product?.price ?? 0);
    _cartService.addToCart(cartItem);
  }

  onRemove(String cartKey) {
    // on remove.
    _cartService.removeFromCart(cartKey);
  }

  onClearCart() {
    // clear the cart items.
    _cartService.clearCart();
    SnackBarService.showSnackBar(content: 'Successfully cleared.');
  }

  onPlaceOrder() async {
    // place order.....
    setBusy(true);
    await Future.delayed(const Duration(seconds: 3));
    _cartService.placeOrder();
    SnackBarService.showSnackBar(content: 'Successfully Ordered.');
    setBusy(false);
    _navigation.back();
  }

  getImage(CartModel cart) {
    return (cart.product!.images != null && cart.product!.images!.isNotEmpty)
        ? cart.product!.images!.first
        : '';
  }
}
