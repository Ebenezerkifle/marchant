import 'dart:convert';
import 'api_call_service.dart';
import 'api_constants.dart';
import 'package:marchant/models/category_model.dart';

class CategoryApiCallService {
  // Simulating a token retrieval function
  Future<String> _getToken() async {
    // return await SharedPreferenceService.getString(StorageKey.token);
    return 'your_token';
  }

  // Get Categories
  Future<Map<String, Category>> getCategories() async {
    String token = await _getToken(); // Get the token
    var response = await ApiCallService.getCall(
      '$baseUrl$categoryUrl',
      token,
      needToken: false,
    );
    Map<String, Category> categories = {};
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // success.
      var body = jsonDecode(response.body);
      for (var ele in body['data']['categories']) {
        Category c = Category.fromMap(ele);
        List<Category> sub = c.subcategory ?? [];
        for (var s in sub) {
          categories[s.id ?? ''] = s;
        }
      }
    }
    return categories;
  }
}
