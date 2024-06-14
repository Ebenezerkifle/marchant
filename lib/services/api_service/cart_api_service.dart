import 'package:http/http.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/api_service/api_call_service.dart';
import 'package:marchant/services/api_service/api_constants.dart';

class CartApiService {
  // register new user
  Future<Response> createNewOrder(OrderModel orderModel) {
    return ApiCallService.postCall(
      '$baseUrl$orderUrl',
      'token',
    orderModel.toMap(),
      needToken: false,
    );
  }

  
}
