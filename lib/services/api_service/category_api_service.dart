import 'dart:convert';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/services/state_service/user_service.dart';
import 'package:marchant/services/storage_service.dart/session.dart';
import 'api_call_service.dart';
import 'api_constants.dart';
import 'package:marchant/models/category_model.dart';

class CategoryApiCallService {
  final _userService = locator<UserService>();

  Future<String> _getToken() async {
    return await SessionService.getString(SessionKey.token);
    // return 'your token';
  }

  // Get Top Categories
  Future<Map<String, Category>> getTopCategories() async {
    String token = "";
    // String token = await _getToken();
    var response = await ApiCallService.getCall(
      '$baseUrl$categoryUrl',
      token,
      needToken: false,
    );

    Map<String, Category> topCategories = {};

    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      for (var ele in body['data']['categories']) {
        Category c = Category.fromMap(ele);
        topCategories[c.id ?? ''] = c;
      }
    } else {
      throw Exception(response.body);
    }
    return topCategories;
  }

  // Get Categories
  Future<Map<String, Category>> getCategories() async {
    final String categoryId = _userService.user?.CategoryId ?? '';

    // String token = await _getToken(); // Get the token
    String token = "";

    var response = await ApiCallService.getCall(
      '$baseUrl$categoryUrl/$categoryId',
      token,
      needToken: false,
    );
    Map<String, Category> categories = {};

    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      var categoryData = body['data']['category'];
      var subCategories = categoryData['subCategories'] as List<dynamic>;
      for (var ele in subCategories) {
        Category c = Category.fromMap(ele);

        categories[c.id ?? ''] = c;
      }
    } else {
      throw Exception(response.body);
    }
    return categories;
  }
}
