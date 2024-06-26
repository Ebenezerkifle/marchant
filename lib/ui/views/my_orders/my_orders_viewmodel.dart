import 'package:flutter/material.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/state_service/orders_state_service.dart';
import 'package:stacked/stacked.dart';

class MyOrdersViewModel extends ReactiveViewModel {
  final OrderStateService _orderState = OrderStateService();

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
    await _orderState.getOrders();
    await _orderState.getDeliveredOrders();
    notifyListeners();
  }

  void getOrders() {
    _orderState.getOrders();
  }

  void getDeliveredOrders() {
    _orderState.getDeliveredOrders();
  }
}
