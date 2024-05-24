import 'package:flutter/material.dart';
import 'package:marchant/app/app.bottomsheets.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/cart_model.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/cart_state_service.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _productState = locator<ProductStateService>();
  final _cartState = locator<CartStateService>();
  final _bottomSheet = locator<BottomSheetService>();
  final _landingService = locator<LandingStateService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_productState, _cartState];

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  get scaffoldKey => _key;

  Map<String, String> get catagories => _productState.categories;
  Map<String, String> get topCategory => _productState.topCategories;

  Map<String, ProductModel> get products => _productState.products;

  Map<String, CartModel> get cartItems => _cartState.cartItems;
  Map<String, bool> get selected => _productState.selected
      .map((key, value) => MapEntry(key, value == 'true'));

//  Updated onSelected method to navigate to SubcategoryPage
  onSelected(var key) {
    if (_productState.selected.containsKey(key)) {
      _productState.selected.remove(key);
    } else {
      _productState.selected.clear(); // Clear previous selection
      _productState.selected[key] = true; // Convert bool to String
      _navigation.navigateToSubCategoryView(); // Navigate to SubcategoryPage
    }
    notifyListeners();
  }

  onItemSelecte(ProductModel product) {
    _navigation.navigateToProductDetailView(product: product);
  }

  onMoreCategory() {
    _navigation.navigateToCategoryListView();
  }

  onCartTap() {
    _navigation.navigateToCartView();
  }

  onFilter() {
    // onfilter. show bottomsheet.
    _bottomSheet.showCustomSheet(
      variant: BottomSheetType.filter,
      title: 'Filter',
    );
  }

  changeUserRole() {
    _landingService.changeUserRole(UserRole.manufacturor);
    notifyListeners();
  }
}
