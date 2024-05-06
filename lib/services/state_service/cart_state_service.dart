import 'dart:math';

import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/cart_model.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';

class CartStateService with ListenableServiceMixin {
  CartStateService() {
    listenToReactiveValues([]);
  }
  final _productStateService = locator<ProductStateService>();

  final _cartItems = ReactiveValue<Map<String, CartModel>>({});
  Map<String, CartModel> get cartItems => _cartItems.value;

  final _totalPrice = ReactiveValue<double>(0.0);
  double get totalPrice => _totalPrice.value;

  final _totalCount = ReactiveValue<num>(0);
  num get totalCount => _totalCount.value;

  addToCart(CartModel cart) {
    _cartItems.value[cart.id ?? ''] = cart;
    notifyListeners();
    _totalPriceCalculator();
  }

  removeFromCart(String itemKey) {
    if (_cartItems.value.containsKey(itemKey)) {
      _cartItems.value.remove(itemKey);
      notifyListeners();
      _totalPriceCalculator();
    }
  }

  clearCart() {
    _cartItems.value.clear();
    notifyListeners();
  }

  placeOrder() {
    int randomId = Random().nextInt(1000);
    OrderModel order = OrderModel(
      id: randomId.toString(),
      cartList: _cartItems.value.values.toList(),
      count: _totalCount.value,
      totalPrice: _totalPrice.value,
    );
    _productStateService.placeOrder(order);
    clearCart();
  }

  _totalPriceCalculator() {
    _totalPrice.value = 0;
    _totalCount.value = 0;
    for (var element in _cartItems.value.values) {
      _totalPrice.value += element.totalPrice ?? 0;
      _totalCount.value += element.count ?? 0;
    }
    notifyListeners();
  }

  getCartItemById(String id) {
    if (_cartItems.value.containsKey(id)) {
      return _cartItems.value[id];
    }
    return null;
  }
}
