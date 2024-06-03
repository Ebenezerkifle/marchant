import 'dart:convert';
import 'package:marchant/services/state_service/user_service.dart';

import 'api_call_service.dart';
import 'api_constants.dart';
import 'package:marchant/models/category_model.dart';

class CategoryApiCallService {
  final _userService = UserService();

  // Simulating a token retrieval function
  Future<String> _getToken() async {
    // return await SharedPreferenceService.getString(StorageKey.token);
    return 'your_token';
  }

//get Top categoires
  Future<Map<String, Category>> getTopCategories() async {
    String token = await _getToken();
    var response = await ApiCallService.getCall(
      '$baseUrl$categoryUrl',
      token,
      needToken: false,
    );
    Map<String, Category> topCategories = {};
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      for (var ele in body['data']['categories']) {
        Category c = Category.fromMap(ele);
        topCategories[c.id ?? ''] = c; // Store the main categories
      }
    }
    print(response.statusCode);
    print(response.body);
    return topCategories;
  }

  // Get Categories
  Future<Map<String, Category>> getCategories() async {
    final String CategoryId = _userService.user.CategoryId??'';
    String token = await _getToken(); // Get the token
    var response = await ApiCallService.getCall(
      // '$baseUrl$categoryUrl',
      '$baseUrl$categoryUrl$CategoryId',
      token,
      needToken: false,
    );
    Map<String, Category> categories = {};
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // success.
      var body = jsonDecode(response.body);
      var categoryData = body['data']['category'];
      var subCategories = categoryData['subCategories'];
      for (var ele in subCategories) {
        Category c = Category.fromMap(ele);
        List<Category> sub = c.subcategory ?? [];
        for (var s in sub) {
          categories[s.id ?? ''] = s;
        }
      }
    }
    return categories;
  }

//   Future<Map<String, Category>> getSubCategories() async {
//   String token = await _getToken(); // Get the token
//   var response = await ApiCallService.getCall(
//     '$baseUrl$categoryUrl',
//     token,
//     needToken: false,
//   );

//   Map<String, Category> categories = {};

//   print(response.statusCode);
//   print(response.body);

//   if (response.statusCode == 200 || response.statusCode == 201) {
//     // success.
//     var body = jsonDecode(response.body);

//     // Iterate over each main category
//     for (var ele in body['data']['categories']) {
//       Category mainCategory = Category.fromMap(ele);

//       // Process subcategories of the main category
//       List<Category> subCategories = mainCategory.subcategory ?? [];
//       for (var sub in subCategories) {
//         categories[sub.id ?? ''] = sub;

//         // Process sub-subcategories of each subcategory
//         List<Category> subSubCategories = sub.subcategory ?? [];
//         for (var subSub in subSubCategories) {
//           categories[subSub.id ?? ''] = subSub;

//           // handle further nested categories here.
//         }
//       }
//     }
//   }

//   return categories;
// }

// Future<Map<String, Category>> getSubSubCategories() async {
//   String token = await _getToken(); // Get the token
//   var response = await ApiCallService.getCall(
//     '$baseUrl$categoryUrl',
//     token,
//     needToken: false,
//   );

//   Map<String, Category> categories = {};

//   print(response.statusCode);
//   print(response.body);

//   if (response.statusCode == 200 || response.statusCode == 201) {
//     // success.
//     var body = jsonDecode(response.body);

//     // Iterate over each main category
//     for (var ele in body['data']['categories']) {
//       Category mainCategory = Category.fromMap(ele);

//       // Process subcategories of the main category
//       List<Category> subCategories = mainCategory.subcategory ?? [];
//       for (var sub in subCategories) {
//         categories[sub.id ?? ''] = sub;

//         // Process sub-subcategories of each subcategory
//         List<Category> subSubCategories = sub.subcategory ?? [];
//         for (var subSub in subSubCategories) {
//           categories[subSub.id ?? ''] = subSub;

//           // Process sub-sub-subcategories of each sub-subcategory
//           List<Category> subSubSubCategories = subSub.subcategory ?? [];
//           for (var subSubSub in subSubSubCategories) {
//             categories[subSubSub.id ?? ''] = subSubSub;
//           }
//         }
//       }
//     }
//   }

//   return categories;
// }
}
