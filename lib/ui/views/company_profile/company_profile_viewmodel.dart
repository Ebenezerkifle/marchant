import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/product_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CompanyProfileViewModel extends ReactiveViewModel {
  final _productState = locator<ProductStateService>();
  final _navigation = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_productState];

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  get scaffoldKey => _key;

  Map<String, ProductModel> get products => _productState.products;

  void onItemSelected(ProductModel product) {
    _navigation.navigateToProductDetailView(product: product);
  }
}
