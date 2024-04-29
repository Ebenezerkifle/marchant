import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:stacked/stacked.dart';

class CartViewModel extends ReactiveViewModel {
  final _cartService = locator<CartStateService>();
  @override
  List<ListenableServiceMixin> get listenableServices => [_cartService];

  Map<String, ProductModel> get cartItems => _cartService.cartItems;
  double get totalPrice => _cartService.totalPrice;
}
