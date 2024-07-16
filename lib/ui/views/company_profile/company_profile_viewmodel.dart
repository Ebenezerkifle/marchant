
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marchant/app/app.locator.dart';
import 'package:marchant/app/app.router.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/state_service/post_state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CompanyProfileViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _postService = locator<PostStateService>();

  String? errorMessage;
  String? _manufacturer; //store the manufacturer

  String get companyProfileHeader => "company_profile".tr();
  String get unknown => "unknown".tr();
  String get productText => "products".tr();

  @override
  List<ListenableServiceMixin> get listenableServices => [_postService];

  Map<String, ProductModel> get products => _postService.products;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  get scaffoldKey => _key;

  CompanyProfileViewModel({required ProductModel product}) {
    _manufacturer = product.manufacturer; // Initialize the manufacturer
    _getApprovedProductsByManufacturer(_manufacturer);
    print(_manufacturer);
  }

  void onItemSelected(ProductModel product) {
    _navigation.navigateToManuProductDetailView(product: product);
  }

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    if (_manufacturer != null) {
      await _getApprovedProductsByManufacturer(_manufacturer);
    }
  }

  Future<void> _getApprovedProductsByManufacturer(String? manufacturer) async {
    try {
      setBusy(true);
      errorMessage = null; // Clear any existing error message
      await _postService.getApprovedProducts(manufacturer);
    } catch (e) {
      errorMessage = 'Failed to fetch products. Please try again later.';
    }
    setBusy(false);
    notifyListeners(); // Notify listeners after state changes
  }
}
