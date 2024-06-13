// import 'dart:convert';
// import 'package:marchant/app/app.locator.dart';
// import 'package:marchant/services/state_service/user_service.dart';

// import 'api_call_service.dart';
// import 'api_constants.dart';
// import 'package:marchant/models/category_model.dart';

// class CategoryApiCallService {
//   final _userService = locator<UserService>();

//   // Simulating a token retrieval function
//   Future<String> _getToken() async {
//     // return await SharedPreferenceService.getString(StorageKey.token);
//     return 'your_token';
//   }

// //get Top categoires
//   Future<Map<String, Category>> getTopCategories() async {
//     String token = await _getToken();
//     var response = await ApiCallService.getCall(
//       '$baseUrl$categoryUrl',
//       token,
//       needToken: false,
//     );
//     Map<String, Category> topCategories = {};
//     print(response.statusCode);
//     print(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       var body = jsonDecode(response.body);
//       for (var ele in body['data']['categories']) {
//         Category c = Category.fromMap(ele);
//         topCategories[c.id ?? ''] = c;
//         // Store the main categories
//       }
//     }
//     return topCategories;
//   }

//   // Get Categories
//   Future<Map<String, Category>> getCategories() async {
//     print(
//         '******************************************Birhanu********************');
//     final String categoryId =
//         _userService.user?.CategoryId ?? '6659c65f59673dcf677ee40b';

//     print(categoryId);
//     String token = await _getToken(); // Get the token
//     var response = await ApiCallService.getCall(
//       // '$baseUrl$categoryUrl',
//       '$baseUrl$categoryUrl/$categoryId',
//       token,
//       needToken: false,
//     );
//     Map<String, Category> categories = {};
//     print(categories);
//     // print(response.statusCode);
//     // print(response.body);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       // success.
//       var body = jsonDecode(response.body);
//       var categoryData = body['data']['category'];
//       var subCategories = categoryData['subCategories'] as List<dynamic>;
//       for (var ele in subCategories) {
//         Category c = Category.fromMap(ele);
//         List<Category> sub = c.subcategory ?? [];
//         for (var s in sub) {
//           categories[s.id ?? ''] = s;
//         }
//       }
//     }
//     return categories;
//   }

// //   Future<Map<String, Category>> getSubCategories() async {
// //   String token = await _getToken(); // Get the token
// //   var response = await ApiCallService.getCall(
// //     '$baseUrl$categoryUrl',
// //     token,
// //     needToken: false,
// //   );

// //   Map<String, Category> categories = {};

// //   print(response.statusCode);
// //   print(response.body);

// //   if (response.statusCode == 200 || response.statusCode == 201) {
// //     // success.
// //     var body = jsonDecode(response.body);

// //     // Iterate over each main category
// //     for (var ele in body['data']['categories']) {
// //       Category mainCategory = Category.fromMap(ele);

// //       // Process subcategories of the main category
// //       List<Category> subCategories = mainCategory.subcategory ?? [];
// //       for (var sub in subCategories) {
// //         categories[sub.id ?? ''] = sub;

// //         // Process sub-subcategories of each subcategory
// //         List<Category> subSubCategories = sub.subcategory ?? [];
// //         for (var subSub in subSubCategories) {
// //           categories[subSub.id ?? ''] = subSub;

// //           // handle further nested categories here.
// //         }
// //       }
// //     }
// //   }

// //   return categories;
// // }

// // Future<Map<String, Category>> getSubSubCategories() async {
// //   String token = await _getToken(); // Get the token
// //   var response = await ApiCallService.getCall(
// //     '$baseUrl$categoryUrl',
// //     token,
// //     needToken: false,
// //   );

// //   Map<String, Category> categories = {};

// //   print(response.statusCode);
// //   print(response.body);

// //   if (response.statusCode == 200 || response.statusCode == 201) {
// //     // success.
// //     var body = jsonDecode(response.body);

// //     // Iterate over each main category
// //     for (var ele in body['data']['categories']) {
// //       Category mainCategory = Category.fromMap(ele);

// //       // Process subcategories of the main category
// //       List<Category> subCategories = mainCategory.subcategory ?? [];
// //       for (var sub in subCategories) {
// //         categories[sub.id ?? ''] = sub;

// //         // Process sub-subcategories of each subcategory
// //         List<Category> subSubCategories = sub.subcategory ?? [];
// //         for (var subSub in subSubCategories) {
// //           categories[subSub.id ?? ''] = subSub;

// //           // Process sub-sub-subcategories of each sub-subcategory
// //           List<Category> subSubSubCategories = subSub.subcategory ?? [];
// //           for (var subSubSub in subSubSubCategories) {
// //             categories[subSubSub.id ?? ''] = subSubSub;
// //           }
// //         }
// //       }
// //     }
// //   }

// //   return categories;
// // }
// }

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
    }
    return topCategories;
  }

  // Get Categories
  Future<Map<String, Category>> getCategories() async {
    // print('******************************************Birhanu********************');
    final String categoryId =
        _userService.user?.CategoryId ?? '6669f80b707babd982746603';
        // '6659c65f59673dcf677ee40b';
    //

    //  '6659c65f59673dcf677ee40b';
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
    print('Final categories: ${response.body}');
    return categories;
  }
}
