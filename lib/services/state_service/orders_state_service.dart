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

// import 'package:marchant/models/order_model.dart';
// import 'package:marchant/services/api_service/orders_api_service.dart';
// import 'package:stacked/stacked.dart';

// class OrderStateService with ListenableServiceMixin {
//   OrderStateService() {
//     listenToReactiveValues([
//       _orders,
//       _deliveredOrders,
//     ]);
//     getOrders();
//     getDeliveredOrders();
//   }

//   final _orders = ReactiveValue<Map<String, OrderModel>>({});
//   Map<String, OrderModel> get orders => _orders.value;
//   final _deliveredOrders = ReactiveValue<Map<String, OrderModel>>({});
//   Map<String, OrderModel> get deliveredOrders => _deliveredOrders.value;

//   Future<void> getOrders() async {
//     _orders.value.clear();
//     _orders.value.addAll(await OrdersApiService().getOrders());
//     notifyListeners();
//   }

//   Future<void> getDeliveredOrders() async {
//     _orders.value.clear();
//     _orders.value.addAll(await OrdersApiService().getDeliveredOrders());
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
      _deliveredOrders,
    ]);
    getOrders();
    getDeliveredOrders();
  }

  final _orders = ReactiveValue<Map<String, OrderModel>>({});
  final _deliveredOrders = ReactiveValue<Map<String, OrderModel>>({});
  final _isLoading = ReactiveValue<bool>(false);

  Map<String, OrderModel> get orders => _orders.value;
  Map<String, OrderModel> get deliveredOrders => _deliveredOrders.value;
  bool get isLoading => _isLoading.value;

  Future<void> getOrders() async {
    try {
      _isLoading.value = true;
      _orders.value = await OrdersApiService().getOrders();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading.value = false;
      notifyListeners();
    }
  }

  Future<void> getDeliveredOrders() async {
    try {
      _isLoading.value = true;
      _deliveredOrders.value = await OrdersApiService().getDeliveredOrders();
    } catch (e) {
      // Handle error
    } finally {
      _isLoading.value = false;
      notifyListeners();
    }
  }
}
