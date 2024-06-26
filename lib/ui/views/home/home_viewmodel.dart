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

  onSelected(var key) => _productState.onCategorySelected(key);
  get selected => _productState.selected;

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
