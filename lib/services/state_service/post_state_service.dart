import 'dart:convert';

import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/api_service/api_call_service.dart';
import 'package:marchant/services/api_service/api_constants.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'package:stacked/stacked.dart';

class PostStateService with ListenableServiceMixin {
  PostStateService() {
    listenToReactiveValues([]);
  }

  final _products = ReactiveValue<Map<String, ProductModel>>({});
  Map<String, ProductModel> get products => _products.value;

  sendProduct(ProductModel product) async {
    String url = '$baseUrl$createProdUrl';
    // api call
    var response = await ApiCallService.postCall(
      url,
      product.toMap(),
      needToken: true,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      getProducts();
    }
    return response;
  }

  getProducts() async {
    String url = '$baseUrl$getProductsByManufacturer';
    var token = await SessionService.getString(SessionKey.token);
    // api call
    var response = await ApiCallService.getCall(
      url,
      token,
      needToken: true,
    );
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      var productData = body['data']['products'];
      for (var ele in productData) {
        ProductModel c = ProductModel.fromMap(ele);
        _products.value[c.id ?? ''] = c;
        notifyListeners();
      }
    }
  }
}
