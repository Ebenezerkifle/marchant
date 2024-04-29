import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/cart_model.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:stacked/stacked.dart';

class CartSheetModel extends ReactiveViewModel {
  final _cartService = locator<CartStateService>();
  ProductModel product;

  @override
  List<ListenableServiceMixin> get listenableServices => [_cartService];

  CartSheetModel({required this.product}) {
    var cartItem = _cartService.getCartItemById(product.id ?? '');
    if (cartItem != null) {
      _totalPrice = cartItem.totalPrice ?? _totalPrice;
      _count = cartItem.count ?? 1;
    } else {
      _totalPrice = product.price ?? _totalPrice;
    }
  }
  num _totalPrice = 0.0;
  num get totalPrice => _totalPrice;
  num _count = 1;
  num get count => _count;

  onChange(count) {
    _count = num.parse(count);
    _totalPrice = (product.price ?? 0) * _count;
    notifyListeners();
  }

  CartModel getCartObject() {
    return CartModel(
      id: product.id,
      product: product,
      totalPrice: _totalPrice,
      count: _count,
    );
  }
}
