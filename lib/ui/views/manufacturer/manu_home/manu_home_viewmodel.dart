import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/landing_state_servic.dart';
import 'package:marchant/services/common_services/phone_service_service.dart';
import 'package:marchant/services/state_service/post_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ManuHomeViewModel extends ReactiveViewModel {
  final _landingService = locator<LandingStateService>();
  final _postService = locator<PostStateService>();
  final _navigation = locator<NavigationService>();
  final _phoneService = locator<PhoneServiceService>();

  String? errorMessage;

  @override
  List<ListenableServiceMixin> get listenableServices => [_postService];

  Map<String, ProductModel> get products => _postService.products;

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  get scaffoldKey => _key;

  ManuHomeViewModel() {
    _getMyProducts();
  }

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    await _getMyProducts();
  }

  Future<void> _getMyProducts() async {
    try {
      setBusy(true);
      errorMessage = null; // Clear any existing error message
      await _postService.getProducts();
    } catch (e) {
      errorMessage = 'Failed to fetch products. Please try again later.';
    }
    setBusy(false);
    notifyListeners();
  }

  onPostProduct() {
    _landingService.setIndex(1);
  }

  void onItemSelected(ProductModel product) {
    _navigation.navigateToManuProductDetailView(product: product);
  }

  Future<void> makePhoneCall() async {
    await _phoneService.makePhoneCall();
  }
}
