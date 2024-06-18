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

  onSelected(String key) {
    _productState.onCategorySelected(key, reOrder: true);
    notifyListeners();
    _navigation.navigateTo(Routes
        .subCategoryView); // Navigate to SubcategoryPage using the generated Routes class
  }


void navigateToSubCategory(String categoryId) {
    _navigation.navigateToSubCategoryView(categoryValue: categoryId);
    // );
  }



}
