import 'package:marchant/models/cart_model.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/api_service/cart_api_service.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';

class CartStateService with ListenableServiceMixin {
  CartStateService() {
    listenToReactiveValues([]);
  }

  final _cartItems = ReactiveValue<Map<String, CartModel>>({});
  Map<String, CartModel> get cartItems => _cartItems.value;

  final _totalPrice = ReactiveValue<double>(0.0);
  double get totalPrice => _totalPrice.value;

  final _totalCount = ReactiveValue<num>(0);
  num get totalCount => _totalCount.value;

  final CartApiService _cartApiService = CartApiService();
  final ProductStateService _productStateService = ProductStateService();

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

  Future<void> placeOrder() async {
    List<ProductModel> products = _cartItems.value.values.map((cartItem) {
      return ProductModel(
        id: cartItem.product?.id,
        quantity: cartItem.count,
        // productName: cartItem.product?.productName,
        // salesPrice: cartItem.product?.salesPrice,
      );
    }).toList();
    print(
        "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
    OrderModel order = OrderModel(
      products: products,
      // totalAmount: _totalPrice.value,
      // count: _totalCount.value,
    );
    try {
      final response = await _cartApiService.createNewOrder(order);
      print(response.body);
      if (response.statusCode == 201) {
        _productStateService
            .placeOrder(order); // Store the order in the product state service
        clearCart(); // Clear cart after successful order placement
      } else {
        throw Exception('Failed to place order');
      }
    } catch (e) {
      // Handle error
      throw Exception('Failed to place order: $e');
    }
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
