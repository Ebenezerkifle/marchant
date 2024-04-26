import 'package:marchant/app/app.locator.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';

class CategoryListViewModel extends BaseViewModel {
  final _productState = locator<ProductStateService>();
  Map<String, String> get allCategories => _productState.categories;
}
