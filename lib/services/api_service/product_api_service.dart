import 'dart:convert';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'api_call_service.dart';
import 'api_constants.dart';

class ProductApiCallService {
  final _userService = locator<UserService>();

  // Simulating a token retrieval function
  Future<String> _getToken() async {
    // return await SharedPreferenceService.getString(StorageKey.token);
    return 'your_token';
  }

  // Get products
  Future<Map<String, ProductModel>> getProducts() async {
    // print('******************************************Birhanu********************');
    final String categoryId = _userService.user?.CategoryId ?? '';

    String token = await _getToken(); // Get the token

    var response = await ApiCallService.getCall(
      '$baseUrl$productUrl/$categoryId',
      token,
      needToken: false,
    );
    // print(response.body);
    Map<String, ProductModel> products = {};
    // print('Initial categories: $categories');
    // print('Response status code: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      // print('Parsed body: $body');
      var productData = body['data']['products'] as List<dynamic>;

      // print('Category data: $categoryData');
      // print('Subcategories: $subCategories');
      for (var ele in productData) {
        ProductModel c = ProductModel.fromMap(ele);

        products[c.id ?? ''] = c;
        //}
      }
      // print('Products after processing: $products');
    } else {
      // print(
      //     'Error fetching categories: ${response.statusCode} ${response.reasonPhrase}');
    }
    // print('Final products: ${response.body}');
    return products;
  }

  // Get sub products
  Future<Map<String, ProductModel>> getSubProducts(categoryId) async {
    // print('******************************************Birhanu********************')

    String token = await _getToken(); // Get the token

    var response = await ApiCallService.getCall(
      '$baseUrl$productUrl/$categoryId',
      token,
      needToken: false,
    );
    Map<String, ProductModel> subProducts = {};
    // print('Initial categories: $categories');
    // print('Response status code: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      // print('Parsed body: $body');
      var productData = body['data']['products'] as List<dynamic>;
      // print('Category data: $categoryData');
      // print('Subcategories: $subCategories');
      for (var ele in productData) {
        ProductModel c = ProductModel.fromMap(ele);

        subProducts[c.id ?? ''] = c;
        //}
      }
      // print('Categories after processing: $categories');
    } else {
      // print(
      //     'Error fetching categories: ${response.statusCode} ${response.reasonPhrase}');
    }
    // print('Final categories: ${response.body}');
    return subProducts;
  }
}
