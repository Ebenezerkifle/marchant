import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _productState = locator<ProductStateService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_productState];

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  get scaffoldKey => _key;

  Map<String, String> get catagories => _productState.categories;
  Map<String, String> get topCategory => _productState.topCategories;

  Map<String, ProductModel> get products => _productState.products;

  onSelected(var key) => _productState.onCategorySelected(key);
  get selected => _productState.selected;

  onItemSelecte(ProductModel product) {
    _navigation.navigateToProductDetailView(product: product);
  }

  onMoreCategory() {
    _navigation.navigateToCategoryListView();
  }
}
