import 'dart:convert';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'api_call_service.dart';
import 'api_constants.dart';

class ProductApiCallService {
  final _userService = locator<UserService>();

  Future<String> _getToken() async {
    return 'your_token';
  }

  // Get products
  Future<Map<String, ProductModel>> getProducts() async {
    final String categoryId = _userService.user?.CategoryId ?? '';

    String token = await _getToken(); // Get the token

    var response = await ApiCallService.getCall(
      '$baseUrl$productUrl/$categoryId',
      token,
      needToken: false,
    );
    Map<String, ProductModel> products = {};
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      var productData = body['data']['products'] as List<dynamic>;

      for (var ele in productData) {
        ProductModel c = ProductModel.fromMap(ele);

        products[c.id ?? ''] = c;
      }
    } else {
      throw Exception(response.body);
    }
    return products;
  }

  // Get sub products
  Future<Map<String, ProductModel>> getSubProducts(categoryId) async {
    String token = await _getToken(); // Get the token

    var response = await ApiCallService.getCall(
      '$baseUrl$productUrl/$categoryId',
      token,
      needToken: false,
    );
    Map<String, ProductModel> subProducts = {};

    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      var productData = body['data']['products'] as List<dynamic>;

      for (var ele in productData) {
        ProductModel c = ProductModel.fromMap(ele);

        subProducts[c.id ?? ''] = c;
      }
    }
    return subProducts;
  }
}
