import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/cart_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CartViewModel extends ReactiveViewModel {
  final _cartService = locator<CartStateService>();
  final _navigation = locator<NavigationService>();
  final _landingService = locator<LandingStateService>();
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
    cartItem.totalPrice = itemCount * (cartItem.product?.salesPrice ?? 0);
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
    setBusy(true);
    try {
      await _cartService.placeOrder();
      SnackBarService.showSnackBar(content: 'Successfully Ordered.');
      // _navigation.clearStackAndShow(Routes.myOrdersView);
      _landingService.setIndex(2);
    } catch (e) {
      SnackBarService.showSnackBar(content: 'Order failed: try again!');
    } finally {
      setBusy(false);
      _navigation.back();
    }
  }

  // onPlaceOrder() async {
  //   // place order.....
  //   setBusy(true);
  //   await Future.delayed(const Duration(seconds: 3));
  //   _cartService.placeOrder();
  //   SnackBarService.showSnackBar(content: 'Successfully Ordered.');
  //   setBusy(false);
  //   _navigation.back();
  // }

  getImage(CartModel cart) {
    return (cart.product!.productImage != null &&
            cart.product!.productImage!.isNotEmpty)
        ? cart.product!.productImage!.first
        : '';
  }
}
