import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/cart_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/state_service/orders_state_service.dart';

class CartViewModel extends ReactiveViewModel {
  final _cartService = locator<CartStateService>();
  final _navigation = locator<NavigationService>();
  final _landingService = locator<LandingStateService>();
  final OrderStateService _orderState = locator<OrderStateService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_cartService, _orderState];

  CartViewModel() {
    // text editing controllers.
    for (var ele in cartItems.keys) {
      controllers[ele] = TextEditingController();
    }
  }

  Map<String, TextEditingController> controllers = {};
  Map<String, CartModel> get cartItems => _cartService.cartItems;
  // double get totalPrice => _cartService.totalPrice;
  double get totalPrice =>
      double.parse(_cartService.totalPrice.toStringAsFixed(2));

  num get totalCount => _cartService.totalCount;

  onChange(String count, String cartKey) {
    //
    CartModel cartItem = cartItems[cartKey] ?? CartModel();
    num itemCount = num.parse(count);
    cartItem.count = itemCount;
    // cartItem.totalPrice = itemCount * (cartItem.product?.salesPrice ?? 0);
    cartItem.totalPrice = double.parse(
        (itemCount * (cartItem.product?.salesPrice ?? 0)).toStringAsFixed(2));
    _cartService.addToCart(cartItem);
  }

  onRemove(String cartKey) {
    // on remove.
    _cartService.removeFromCart(cartKey);
  }

  Future<void> refresh() async {
    try {
      setBusy(true);
      await _orderState.getOrders();
      await _orderState.getDeliveredOrders();
    } finally {
      setBusy(false);
    }
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
    setBusy(false);

    } catch (e) {
      SnackBarService.showSnackBar(content: e.toString());
    } finally {
      setBusy(false);
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
    return (cart.product!.productImage.isNotEmpty)
        ? cart.product!.productImage.first
        : '';
  }
}
