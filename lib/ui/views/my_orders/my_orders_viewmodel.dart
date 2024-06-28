import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/cart_model.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/state_service/orders_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MyOrdersViewModel extends ReactiveViewModel {
  final OrderStateService _orderState = locator<OrderStateService>();
  final _navigation = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_orderState];

  Map<String, OrderModel> get pendingOrders => _orderState.orders;
  Map<String, OrderModel> get deliveredOrders => _orderState.deliveredOrders;
  bool get isLoading => _orderState.isLoading;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKeyPending =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKeyDelivered =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    setBusy(true);
    await _orderState.getOrders();
    await _orderState.getDeliveredOrders();
    setBusy(false);
    notifyListeners();
  }

  void getOrders()async {
    setBusy(true);
    await _orderState.getOrders();
    setBusy(false);
  }

  void getDeliveredOrders() async {
    setBusy(true);
   await _orderState.getDeliveredOrders();
    setBusy(false);
  }

  Map<String, dynamic> getTitle(List<CartModel>? cartList) {
    Map<String, dynamic> response = {};
    String title = '';
    List<String> images = [];
    if (cartList != null) {
      // print('-------------here we are------------------');
      for (int i = 0; i < cartList.length; i++) {
        // print('**************');
        // print(cartList[i].product?.productImage.isNotEmpty);
        String img = cartList[i].product?.productImage.first ?? '';
        // print(img);
        if (i == 1) {
          images.add(cartList[i].product?.productImage.first ?? "");
        }
        if (i == 0) {
          images.add(img);
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
