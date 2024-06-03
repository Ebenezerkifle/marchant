import 'package:marchant/models/category_model.dart';
import 'package:marchant/services/api_service/category_api_service.dart';
import 'package:stacked/stacked.dart';

class MerchantTopCategoryService with ListenableServiceMixin {
  final _apiCall = CategoryApiCallService();

  MerchantTopCategoryService() {
    listenToReactiveValues([_topCategories]);
    // add state variables which are supposed to be fired as soon as changed.
    getTopCategories();
  }
  final _topCategories = ReactiveValue<Map<String, Category>>({});
  Map<String, Category> get topCategories => _topCategories.value;

  getTopCategories() async {
    var response = await _apiCall.getTopCategories();
    _topCategories.value.clear();
    _topCategories.value.addAll(response);
    notifyListeners();
  }
}
