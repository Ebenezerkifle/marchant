import 'dart:convert';

import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/api_service/api_call_service.dart';
import 'package:marchant/services/api_service/api_constants.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'package:stacked/stacked.dart';

class PostStateService with ListenableServiceMixin {
  PostStateService() {
    listenToReactiveValues([
      _isLoading,
      _errorMessage,
    ]);
  }

  // New: Track loading and error state
  final ReactiveValue<bool> _isLoading = ReactiveValue(false);
  bool get isLoading => _isLoading.value;

  final ReactiveValue<String?> _errorMessage = ReactiveValue(null);
  String? get errorMessage => _errorMessage.value;

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

  // Fetch categories from the API and update state
  Future<void> getProducts() async {
    _isLoading.value = true; // Set loading state to true before API call
    _errorMessage.value = null; // Reset the error message before fetching data

    notifyListeners(); // Notify listeners of the loading state change
    String url = '$baseUrl$getProductsByManufacturer';

    try {
      var token = await SessionService.getString(SessionKey.token);
      var response = await ApiCallService.getCall(
        url,
        token,
        needToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var body = jsonDecode(response.body);
        var productData = body['data']['products'];
        for (var ele in productData) {
          ProductModel c = ProductModel.fromMap(ele);
          _products.value[c.id ?? ''] = c;
          notifyListeners();
        }
      } else {
        // Parse the response body as JSON
        var body = jsonDecode(response.body);
        // Safely extract the error message

        String errorMessage =
            body["message"] ?? "Failed to fetch products. Please try again.";
        errorMessage.contains("No products found for this manufacturer")
            ? null
            : _errorMessage.value = errorMessage; // Set error message
      }
    } catch (error) {
      String errorMessage = error.toString();
      _errorMessage.value =
          "Error during API call: $errorMessage"; // Set error message    } finally {
    } finally {
      _isLoading.value = false; // Set loading state to false after API call
    }
  }

  // getProducts() async {
  //   String url = '$baseUrl$getProductsByManufacturer';
  //   var token = await SessionService.getString(SessionKey.token);
  //   // api call
  //   var response = await ApiCallService.getCall(
  //     url,
  //     token,
  //     needToken: true,
  //   );
  //   print(
  //       "------------------------------------response data for get products -----------------------------");
  //   print(response.body);
  //   print(response.statusCode);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     var body = jsonDecode(response.body);
  //     var productData = body['data']['products'];
  //     for (var ele in productData) {
  //       ProductModel c = ProductModel.fromMap(ele);
  //       _products.value[c.id ?? ''] = c;
  //       notifyListeners();
  //     }
  //   } else {
  //     throw Exception(response.body);
  //   }
  // }

  getApprovedProducts(String? manufacturer) async {
    String url = '$baseUrl$getApprovedProductsByManufacturer$manufacturer';
    // print(url);
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
