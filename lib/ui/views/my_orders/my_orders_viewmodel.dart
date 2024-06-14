import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/cart_model.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class MyOrdersViewModel extends ReactiveViewModel {
  final _productState = locator<ProductStateService>();
  final _navigation = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_productState];

  Map<String, OrderModel> get activeOrders => _productState.activeOrders;

  Map<String, dynamic> getTitle(List<CartModel>? cartList) {
    Map<String, dynamic> response = {};
    String title = '';
    List<String> images = [];
    if (cartList != null) {
      for (int i = 0; i < cartList.length; i++) {
        if (i == 1) {
          images.add(cartList[i].product?.productImage?.first ?? "");
        }
        if (i == 0) {
          images.add(cartList[i].product?.productImage?.first ?? "");
          title = cartList[i].product?.productName ?? '';
          continue;
        } else if (i == cartList.length - 1) {
          title = '$title & ${cartList[i].product?.productName}';
          continue;
        }
        title = '$title, ${cartList[i].product?.productName}';
      }
    }
    response['title'] = title;
    response['images'] = images;
    return response;
  }

  onOrderTap(OrderModel e) {
    _navigation.navigateToCartView(order: e);
  }
}
