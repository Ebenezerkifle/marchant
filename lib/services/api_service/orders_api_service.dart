

import 'dart:convert';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'api_call_service.dart';
import 'api_constants.dart';

class OrdersApiService {

  // Simulating a token retrieval function
 Future<String> _getToken() async {
    return await SessionService.getString(SessionKey.token);
  }

  // Get Top orders
  Future<Map<String, OrderModel>> getOrders() async {
    String token = await _getToken();
    var response = await ApiCallService.getCall(
      '$baseUrl$readPendingOrderUrl',
      token,
      needToken: true,
    );
    Map<String, OrderModel> orders = {};
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      for (var ele in body['data']['orders']) {
        OrderModel c = OrderModel.fromMap(ele);
        orders[c.id ?? ''] = c;
      }
    }
    return orders;
  }

}
