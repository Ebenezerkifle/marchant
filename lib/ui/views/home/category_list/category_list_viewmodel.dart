import 'package:marchant/app/app.locator.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CategoryListViewModel extends BaseViewModel {
  final _productState = locator<ProductStateService>();
  final _navigation = locator<NavigationService>();
  Map<String, String> get allCategories => _productState.categories;
  Map<String, String> get selected => _productState.selected;

  onSelected(String key) {
    _productState.onCategorySelected(key);
    notifyListeners();
    _navigation.back();
  }
}
