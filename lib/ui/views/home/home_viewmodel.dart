import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/category_model.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _productState = locator<ProductStateService>();
  final _cartState = locator<CartStateService>();
  String? errorMessage;
  final IconData _moreIcon = FontAwesomeIcons.ellipsisVertical;
  IconData get moreIcon => _moreIcon;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_productState, _cartState];

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  get scaffoldKey => _key;

  Map<String, Category> get categories => _productState.categories;
  Map<String, ProductModel> get products => _productState.products;
  bool get isLoading => _productState.isLoading;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Future<void> refresh() async {
  //   await _productState.getProducts();
  //   await _productState.getCategories();
  // }

  HomeViewModel() {
    _getMyProducts();
  }

  Future<void> refresh() async {
    setBusy(true);
    await _getMyProducts();
    setBusy(false);
  }

  Future<void> _getMyProducts() async {
    try {
      setBusy(true);
      errorMessage = null; // Clear any existing error message
      await _productState.getProducts();
      await _productState.getCategories();
    } catch (e) {
      errorMessage = 'Failed to fetch products. Please try again later.';
    } finally {
      setBusy(false);
    }
  }
  // Method to navigate to SubCategoryView
  void navigateToSubCategory(String categoryId) {
    _navigation.navigateToSubCategoryView(
        categoryValue: categoryId, subSubCategoryValue: '');
    // );
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
    // onFilter.showbottomsheet.
    // _bottomSheet.showCustomSheet(
    //   variant: BottomSheetType.filter,
    //   title: 'Filter',
    // );
  }

  // void changeUserRole() {
  //   // changing user role
  // }
}





// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:marchant/app/app.locator.dart';
// import 'package:marchant/app/app.router.dart';
// import 'package:marchant/models/category_model.dart';
// import 'package:marchant/models/product_model.dart';
// import 'package:marchant/services/state_service/cart_state_service.dart';
// import 'package:marchant/services/state_service/product_state_service.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';

// class HomeViewModel extends ReactiveViewModel {
//   final _navigation = locator<NavigationService>();
//   final _productState = locator<ProductStateService>();
//   final _cartState = locator<CartStateService>();

//   String? errorMessage;

//   final IconData _moreIcon = FontAwesomeIcons.ellipsisVertical;
//   IconData get moreIcon => _moreIcon;

//   @override
//   List<ListenableServiceMixin> get listenableServices =>
//       [_productState, _cartState];

//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//   get scaffoldKey => _key;

//   Map<String, Category> get categories => _productState.categories;
//   Map<String, ProductModel> get products => _productState.products;
//   bool get isLoading => _productState.isLoading;

//   final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();

//   HomeViewModel() {
//     _getMyProducts();
//   }

//   Future<void> refresh() async {
//     setBusy(true);
//     await _getMyProducts();
//     setBusy(false);
//   }

//   Future<void> _getMyProducts() async {
//     try {
//       setBusy(true);
//       errorMessage = null; // Clear any existing error message
//       await _productState.getProducts();
//       await _productState.getCategories();
//     } catch (e) {
//       errorMessage = 'Failed to fetch products. Please try again later.';
//     } finally {
//       setBusy(false);
//     }
//   }

//   void navigateToSubCategory(String categoryId) {
//     _navigation.navigateToSubCategoryView(
//         categoryValue: categoryId, subSubCategoryValue: '');
//   }

//   void onItemSelected(ProductModel product) {
//     _navigation.navigateToProductDetailView(product: product);
//   }

//   void onMoreCategory() {
//     _navigation.navigateToCategoryListView();
//   }

//   void onCartTap() {
//     _navigation.navigateToCartView();
//   }

//   void onFilter() {
//     // onFilter.showbottomsheet.
//     // _bottomSheet.showCustomSheet(
//     //   variant: BottomSheetType.filter,
//     //   title: 'Filter',
//     // );
//   }
// }
