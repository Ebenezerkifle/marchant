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


// import 'package:marchant/models/order_model.dart';
// import 'package:marchant/services/state_service/orders_state_service.dart';
// import 'package:stacked/stacked.dart';
// import '../../../app/app.locator.dart';

// class MyOrdersViewModel extends ReactiveViewModel {
//   final OrderStateService _orderState = locator<OrderStateService>();

//   bool _loading = true;
//   bool get loading => _loading;

//   @override
//   List<ListenableServiceMixin> get listenableServices => [_orderState];

//   Map<String, OrderModel> get orders => _orderState.orders;

//   List<OrderModel> get pendingOrders => orders.values.where((order) => order.status == 'Pending').toList();
//   List<OrderModel> get deliveredOrders => orders.values.where((order) => order.status == 'Delivered').toList();

//   Future<void> getOrders() async {
//     _loading = true;
//     notifyListeners();

//     await _orderState.getOrders();

//     _loading = false;
//     notifyListeners();
//   }
// }



