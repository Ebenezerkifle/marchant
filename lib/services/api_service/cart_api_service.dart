import 'package:http/http.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/services/api_service/api_call_service.dart';
import 'package:marchant/services/api_service/api_constants.dart';
import 'package:marchant/services/storage_service.dart/session.dart';

class CartApiService {
  Future<String> _getToken() async {
    return await SessionService.getString(SessionKey.token);
  }

  // Create new order
  Future<Response> createNewOrder(OrderModel orderModel) async {
    String token = await _getToken();
    return ApiCallService.postCall(
      '$baseUrl$orderUrl',
      orderModel.toMap(),
      needToken: true,
    );
  }
}
