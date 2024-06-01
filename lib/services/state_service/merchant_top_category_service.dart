import 'package:marchant/models/category_model.dart';
import 'package:marchant/services/api_service/category_api_service.dart';
import 'package:stacked/stacked.dart';

class MerchantTopCategoryService with ListenableServiceMixin {
  final _apiCall = CategoryApiCallService();

  MerchantTopCategoryService() {
    listenToReactiveValues([_categories]);
    // add state variables which are supposed to be fired as soon as changed.
    getCategories();
  }
  final _categories = ReactiveValue<Map<String, Category>>({});
  Map<String, Category> get categories => _categories.value;

  getCategories() async {
    var response = await _apiCall.getCategories();
    _categories.value.clear();
    _categories.value.addAll(response);
    notifyListeners();
  }
}
