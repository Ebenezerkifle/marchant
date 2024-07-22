import 'package:easy_localization/easy_localization.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart'; // Import the generated Routes class
import 'package:marchant/models/category_model.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CategoryListViewModel extends ReactiveViewModel {
  final _productState = locator<ProductStateService>();
  final _navigation = locator<NavigationService>();
  Map<String, Category> get allCategories => _productState.categories;
  Map<String, bool> get selected => _productState.selected;
  String get allCategoriesText => "all_categories".tr();

  void navigateToSubCategory(String categoryId) {
    _navigation.navigateToSubCategoryView(
        categoryValue: categoryId, subSubCategoryValue: '');
    // );
  }
}
