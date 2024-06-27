import 'package:http/http.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/api_service/api_call_service.dart';
import 'package:marchant/services/api_service/api_constants.dart';

class CartApiService {

  // Create new order
  Future<Response> createNewOrder(OrderModel orderModel) async {
    return ApiCallService.postCall(
      '$baseUrl$orderUrl',
      orderModel.toMap(),
      needToken: true,
    );
  }
}
