
import 'dart:convert';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'api_call_service.dart';
import 'api_constants.dart';
import 'package:marchant/models/category_model.dart';

class CategoryApiCallService {
  final _userService = locator<UserService>();

  // Simulating a token retrieval function
  Future<String> _getToken() async {
    // return await SharedPreferenceService.getString(StorageKey.token);
    return 'your_token';
  }

  // Get Top Categories
  Future<Map<String, Category>> getTopCategories() async {
    String token = await _getToken();
    var response = await ApiCallService.getCall(
      '$baseUrl$categoryUrl',
      token,
      needToken: false,
    );
    Map<String, Category> topCategories = {};
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      for (var ele in body['data']['categories']) {
        Category c = Category.fromMap(ele);
        topCategories[c.id ?? ''] = c;
      }
    }else {
      throw Exception(response.body);
    }
    return topCategories;
  }

  // Get Categories
  Future<Map<String, Category>> getCategories() async {
    // print('******************************************Birhanu********************');
    // print(_userService.user);
    final String categoryId = _userService.user?.CategoryId ?? '';

    // print('Category ID: $categoryId');

    String token = await _getToken(); // Get the token

    var response = await ApiCallService.getCall(
      '$baseUrl$categoryUrl/$categoryId',
      token,
      needToken: false,
    );
    Map<String, Category> categories = {};
    // print('Initial categories: $categories');
    // print('Response status code: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      // print('Parsed body: $body');
      var categoryData = body['data']['category'];
      // print('Category data: $categoryData');
      var subCategories = categoryData['subCategories'] as List<dynamic>;
      // print('Subcategories: $subCategories');
      for (var ele in subCategories) {
        Category c = Category.fromMap(ele);
        // List<Category> sub = c.subcategory ?? [];
        //for (var s in sub) {
        categories[c.id ?? ''] = c;
        //}
      }
      // print('Categories after processing: $categories');
    } else {
      print(
          'Error fetching categories: ${response.statusCode} ${response.reasonPhrase}');
    }
    // print('Final categories: ${response.body}');
    return categories;
  }
}
