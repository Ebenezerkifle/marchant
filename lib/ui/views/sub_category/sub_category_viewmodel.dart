import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/category_model.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SubCategoryViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _productState = locator<ProductStateService>();
  final _cartState = locator<CartStateService>();

  String categoryId;
  String? subSubCategoryId;

  List<Category> subCategories = [];
  Map<String, bool> _selected = {};

  // Added properties for loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SubCategoryViewModel({required this.categoryId, this.subSubCategoryId}) {
    subCategories = getSubCategories();
    getSubProducts();
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_productState, _cartState];

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    _isLoading = true; // Set loading to true
    notifyListeners();
    await getSubProducts();
    getSubCategories();
    _isLoading = false; // Set loading to false after fetching
    notifyListeners();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  get scaffoldKey => _key;

  Map<String, Category> get categories => _productState.categories;
  Map<String, ProductModel> get subProducts => _productState.subProducts;

  getSubProducts({String? category}) async {
    setBusy(true);
    if (subSubCategoryId != null && subSubCategoryId!.isNotEmpty) {
      await _productState.getSubProducts(category ?? subSubCategoryId!);
    } else {
      await _productState.getSubProducts(category ?? categoryId);
    }
    setBusy(false);
  }

  List<Category> getSubCategories() {
    final subCategories = categories[categoryId]?.subcategory ?? [];
    debugPrint('Fetching subcategories for categoryId: $categoryId');
    return subCategories;
  }

  List<Category> getLimitedSubCategories() {
    return subCategories.take(3).toList();
  }

  bool get hasMoreSubCategories {
    return subCategories.length > 3;
  }

  void onItemSelected(ProductModel product) {
    _navigation.navigateToProductDetailView(product: product);
  }

  // void onMoreCategory() {
  //   _navigation.navigateToCategoryListView();
  // }

  void onMoreCategory() {
    _navigation.navigateToSubCategoryListView(
        subCategories: subCategories, categoryValue: categoryId);
  }

  void onCartTap() {
    _navigation.navigateToCartView();
  }

  void onFilter() {
    // onFilter. show bottomsheet.
  }

  Map<String, bool> get selected => _selected;

  void toggleSelection(String id) {
    _selected.clear(); // Clear all selections
    _selected[id] = true; // Select the tapped item
    notifyListeners();
  }
}
