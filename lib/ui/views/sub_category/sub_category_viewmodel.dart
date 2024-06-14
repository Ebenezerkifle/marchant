// // import 'package:flutter/material.dart';
// // import 'package:marchant/app/app.locator.dart';
// // import 'package:marchant/app/app.router.dart';
// // import 'package:marchant/models/cart_model.dart';
// // import 'package:marchant/models/category_model.dart';
// // import 'package:marchant/models/product_model.dart';
// // import 'package:marchant/services/state_service/cart_state_service.dart';
// // import 'package:marchant/services/state_service/product_state_service.dart';
// // import 'package:stacked/stacked.dart';
// // import 'package:stacked_services/stacked_services.dart';

// // class SubCategoryViewModel extends ReactiveViewModel {
// //   final _navigation = locator<NavigationService>();
// //   final _productState = locator<ProductStateService>();
// //   final _cartState = locator<CartStateService>();

// //   @override
// //   List<ListenableServiceMixin> get listenableServices =>
// //       [_productState, _cartState];

// //   final GlobalKey<ScaffoldState> _key = GlobalKey();
// //   get scaffoldKey => _key;

// //   Map<String, Category> get categories => _productState.categories;
// //   Map<String, String> get topCategory => _productState.topCategories;
// //   Map<String, List<String>> get subCategories => _productState.subCategories;
// //   Map<String, bool> get selected => _productState.selected;
// //   Map<String, ProductModel> get products => _productState.products;
// //   Map<String, CartModel> get cartItems => _cartState.cartItems;
// //   String? get selectedSubCategory => _productState.selectedSubCategory;

// //   Map<String, String> get selectedCategoryOnHomepage =>
// //       _productState.topCategories;

// //   SubCategoryViewModel();

// //   List<Category> getSubCategories(String categoryId) {
// //     return categories[categoryId]?.subcategory ?? [];
// //   }

// //   void onSelected(String key) => _productState.onCategorySelected(key);
// //   void onSubCategorySelected(String key, String subCategory) =>
// //       _productState.onSubCategorySelected(key, subCategory);

// //   void onMoreCategory() {
// //     _navigation.navigateToCategoryListView();
// //   }

// //   void onItemSelected(ProductModel product) {
// //     _navigation.navigateToProductDetailView(product: product);
// //   }

// //   void onCartTap() {
// //     _navigation.navigateToCartView();
// //   }
// // }

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

  String categoryId = '';
  List<Category> subCategories = [];

  SubCategoryViewModel({required this.categoryId}) {
    subCategories = getSubCategories();
    getSubProducts();
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_productState, _cartState];

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  get scaffoldKey => _key;

  Map<String, Category> get categories => _productState.categories;
  Map<String, ProductModel> get subProducts => _productState.subProducts;

  getSubProducts({String? category}) {
    _productState.getSubProducts(category ?? categoryId);
  }

  List<Category> getSubCategories() {
    // Fetch and return the subcategories for the given categoryId
    final subCategories = categories[categoryId]?.subcategory ?? [];
    // print(categories[categoryId]);
    // print(categories[categoryId]?.toMap());
    print(subCategories);
    debugPrint('Fetching subcategories for categoryId: $categoryId');
    return subCategories;
  }

  void onItemSelected(ProductModel product) {
    _navigation.navigateToProductDetailView(product: product);
  }

  void onMoreCategory() {
    _navigation.navigateToCategoryListView();
  }

  void onCartTap() {
    _navigation.navigateToCartView();
  }

  void onFilter() {
    // onFilter. show bottomsheet.
    // _bottomSheet.showCustomSheet(
    //   variant: BottomSheetType.filter,
    //   title: 'Filter',
    // );
  }

  void changeUserRole() {
    // Your logic for changing user role
  }
  
}
