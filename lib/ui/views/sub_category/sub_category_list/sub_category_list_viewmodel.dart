
// import 'package:marchant/app/app.locator.dart';
// import 'package:marchant/app/app.router.dart'; // Import the generated Routes class
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';

// class SubCategoryListViewModel extends ReactiveViewModel {

//   final _navigation = locator<NavigationService>();
//   void navigateToSubCategory(String categoryId) {
//     _navigation.navigateToSubCategoryView(categoryValue: categoryId);
//     // );
//   }
// }







import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SubCategoryListViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();

// Method to navigate to SubCategoryView
  void navigateToSubCategory(String categoryId) {
    _navigation.navigateToSubCategoryView(categoryValue: categoryId);
    // );
  }
}
