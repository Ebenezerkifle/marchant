// // profile_viewmodel.dart
// import 'package:stacked/stacked.dart';
// import 'package:marchant/services/order_service.dart';
// import 'package:marchant/models/order_model.dart';

// class ProfileViewModel extends BaseViewModel {
//   final OrderService _orderService = OrderService();
//   List<OrderModel>? orders;

//   Future<void> fetchOrders() async {
//     setBusy(true);
//     orders = await _orderService.fetchOrders();
//     setBusy(false);
//     notifyListeners();
//   }
// }




import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/api_service/orders_api_service.dart';
import 'package:stacked/stacked.dart';


class OrderStateService with ListenableServiceMixin {
  OrderStateService() {
    listenToReactiveValues([
      _orders,
    ]);
    getOrders();
  }

  final _orders = ReactiveValue<Map<String, OrderModel>>({});
  Map<String, OrderModel> get orders => _orders.value;



  Future<void> getOrders() async {
    _orders.value.clear();
    _orders.value.addAll(await OrdersApiService().getOrders());
    notifyListeners();
  }

}



























