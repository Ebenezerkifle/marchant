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
  Future<List<Category>?> getCategories() async {
    String token = await _getToken(); // Get the token
    var response = await ApiCallService.getCall(
      '$baseUrl$categoryUrl',
      token,
      needToken: false,
    );
    print("****************************************************");
    print(response.statusCode);
    print("**********************************************************");
    List<Category> categories = [];

    if (response.statusCode == 200 || response.statusCode == 201) {
      // success.
      var body = jsonDecode(response.body);
      categories = Category.listFromApi(body['data']['categories']);
    }
     print("**************************************************");
    return categories;
   
  }
}












