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

// import '../../../services/common_services/phone_service_service.dart';

// class HomeViewModel extends ReactiveViewModel {
//   final _navigation = locator<NavigationService>();
//   final _productState = locator<ProductStateService>();
//   final _cartState = locator<CartStateService>();
//   final _phoneService = locator<PhoneServiceService>();

//   String? errorMessage;
//   final IconData _moreIcon = FontAwesomeIcons.ellipsisVertical;
//   IconData get moreIcon => _moreIcon;

//   @override
//   List<ListenableServiceMixin> get listenableServices =>
//       [_productState, _cartState];

//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//   get scaffoldKey => _key;

//   final TextEditingController searchController = TextEditingController();

//   Map<String, Category> get categories => _productState.categories;
//   Map<String, ProductModel> get products => _productState.products;
//   Map<String, ProductModel> filteredProducts = {};
//   String? filterQuery;

//   // bool get isLoading => _productState.isLoading;

//   final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();

//   HomeViewModel() {
//     _getMyProducts();
//     searchController.addListener(_onSearchChanged);
//   }

//   Future<void> refresh() async {
//     await _getMyProducts();
//   }

//   Future<void> _getMyProducts() async {
//     try {
//       setBusy(true);
//       errorMessage = null; // Clear any existing error message
//        await _productState.getCategories();
//       await _productState.getProducts();

//     } catch (e) {
//       errorMessage = 'Failed to fetch products';
//     }
//     setBusy(false);
//     notifyListeners();
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

//   void _onSearchChanged() {
//     filterProducts(searchController.text);
//   }

//   void onFilter() {
//     // Placeholder for filter functionality
//   }

//   Future<void> makePhoneCall() async {
//     await _phoneService.makePhoneCall();
//   }

//   void filterProducts(String query) {
//     filterQuery = query
//         .toLowerCase(); // Convert the query to lowercase and assign to filterQuery

//     if (filterQuery?.isEmpty ?? true) {
//       // Check if filterQuery is null or empty
//       filteredProducts
//           .clear(); // If filterQuery is empty, clear filteredProducts map
//     } else {
//       // Perform custom fuzzy search on productName
//       filteredProducts = Map.fromEntries(products.entries.where((entry) {
//         final productName = entry.value.productName?.toLowerCase() ??
//             ''; // Get lowercase productName or empty string if null
//         final searchLower = filterQuery!
//             .toLowerCase(); // Get lowercase filterQuery (forced non-null assertion)

//         // Check if productName contains searchLower
//         return productName.contains(searchLower);
//       }));
//     }

//     notifyListeners(); // Notify listeners that filteredProducts have been updated
//   }
// }

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
import '../../../services/common_services/phone_service_service.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _productState = locator<ProductStateService>();
  final _cartState = locator<CartStateService>();
  final _phoneService = locator<PhoneServiceService>();

  // String? errorMessage;
  String? categoryErrorMessage;
  String? productErrorMessage;
  final IconData _moreIcon = FontAwesomeIcons.ellipsisVertical;
  IconData get moreIcon => _moreIcon;

  bool _isCategoriesBusy = false;
  bool _isProductsBusy = false;

  bool get isCategoriesBusy => _isCategoriesBusy;
  bool get isProductsBusy => _isProductsBusy;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_productState, _cartState];

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  get scaffoldKey => _key;

  final TextEditingController searchController = TextEditingController();

  Map<String, Category> get categories => _productState.categories;
  Map<String, ProductModel> get products => _productState.products;
  Map<String, ProductModel> filteredProducts = {};
  String? filterQuery;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  HomeViewModel() {
    _getCategories();
    _getMyProducts();
    searchController.addListener(_onSearchChanged);
  }

  Future<void> refresh() async {
    await _getCategories();
    await _getMyProducts();
  }

  Future<void> categoryRefresh() async {
    await _getCategories();
  }

  Future<void> productRefresh() async {
    await _getMyProducts();
  }

  Future<void> _getCategories() async {
    try {
      _isCategoriesBusy = true;
      categoryErrorMessage = null;
      notifyListeners();
      await _productState.getCategories();
    } catch (e) {
      categoryErrorMessage = 'Check your connection';
    } finally {
      _isCategoriesBusy = false;
      notifyListeners();
    }
  }

  Future<void> _getMyProducts() async {
    try {
      _isProductsBusy = true;
      productErrorMessage = null;
      notifyListeners();
      await _productState.getProducts();
    } catch (e) {
     
      if (e.toString().contains('No products found for this category')) {
        // productErrorMessage = 'No Products found';
        _productState.products.clear(); // Clear the products list
      } else {
        productErrorMessage = 'Check your connection';
      }
    } finally {
      _isProductsBusy = false;
      notifyListeners();
    }
  }

  void navigateToSubCategory(String categoryId) {
    _navigation.navigateToSubCategoryView(
        categoryValue: categoryId, subSubCategoryValue: '');
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

  void _onSearchChanged() {
    filterProducts(searchController.text);
  }

  void onFilter() {
    // Placeholder for filter functionality
  }

  Future<void> makePhoneCall() async {
    await _phoneService.makePhoneCall();
  }

  void filterProducts(String query) {
    filterQuery = query.toLowerCase();
    if (filterQuery?.isEmpty ?? true) {
      filteredProducts.clear();
    } else {
      filteredProducts = Map.fromEntries(products.entries.where((entry) {
        final productName = entry.value.productName?.toLowerCase() ?? '';
        final searchLower = filterQuery!.toLowerCase();
        return productName.contains(searchLower);
      }));
    }
    notifyListeners();
  }
}
