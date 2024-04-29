import 'package:marchant/models/product_model.dart';
import 'package:stacked/stacked.dart';

class CartStateService with ListenableServiceMixin {
  CartStateService() {
    listenToReactiveValues([]);
  }

  final _cartItems = ReactiveValue<Map<String, ProductModel>>({});
  Map<String, ProductModel> get cartItems => _cartItems.value;

  final _totalPrice = ReactiveValue<double>(0.0);
  double get totalPrice => _totalPrice.value;

  addToCart(ProductModel product) {
    _cartItems.value[product.id ?? ''] = product;
    notifyListeners();
    _totalPriceCalculator();
  }

  _totalPriceCalculator() {
    _totalPrice.value = 0;
    for (var element in _cartItems.value.values) {
      _totalPrice.value += element.price ?? 0;
    }
    notifyListeners();
  }
}
