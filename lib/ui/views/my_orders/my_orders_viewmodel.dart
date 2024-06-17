import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/state_service/orders_state_service.dart';
import 'package:stacked/stacked.dart';

class MyOrdersViewModel extends ReactiveViewModel {
  final OrderStateService _orderState = OrderStateService();

  @override
  List<ListenableServiceMixin> get listenableServices => [_orderState];

  Map<String, OrderModel> get orders => _orderState.orders;

  void getOrders() {
    _orderState.getOrders();
  }
}
