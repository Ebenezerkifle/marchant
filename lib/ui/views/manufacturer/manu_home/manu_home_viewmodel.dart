import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/state_service/post_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ManuHomeViewModel extends ReactiveViewModel {
  final _landingService = locator<LandingStateService>();
  final _postService = locator<PostStateService>();
  final _navigation = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_postService];

  Map<String, ProductModel> get products => _postService.products;

  ManuHomeViewModel() {
    _getMyProducts();
  }
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    setBusy(true);
    await _getMyProducts();
    setBusy(false);
  }

  _getMyProducts() async {
    setBusy(true);
    await _postService.getProducts();
    setBusy(false);
  }

  onPostProduct() {
    _landingService.setIndex(1);
  }

  void onItemSelected(ProductModel product) {
    _navigation.navigateToManuProductDetailView(product: product);
  }
}
