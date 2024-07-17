import 'package:easy_localization/easy_localization.dart';
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

class SubCategoryViewModel extends ReactiveViewModel {
  final _navigation = locator<NavigationService>();
  final _productState = locator<ProductStateService>();
  final _cartState = locator<CartStateService>();

  String categoryId;
  String? subSubCategoryId;
  String? categoryRefresh;

  List<Category> subCategories = [];
  final Map<String, bool> _selected = {};

  String? errorMessage;
  String? categoryErrorMessage;
  String? productErrorMessage;

  bool _isSubCategoriesBusy = false;
  bool _isProductsBusy = false;

  bool get isSubCategoriesBusy => _isSubCategoriesBusy;
  bool get isProductsBusy => _isProductsBusy;

  String get subCategory => "subCategory".tr();
  String get ourProducts => "our_products".tr();
  String get retry => "retry".tr();
  String get noProductsFound => "no_products_found".tr();
  String get noCategoriesFound => "no_categories_found".tr();
  String get search => "search".tr();

  final IconData _moreIcon = FontAwesomeIcons.ellipsisVertical;
  IconData get moreIcon => _moreIcon;

  Map<String, ProductModel> filteredProducts = {};
  String? filterQuery;

  final TextEditingController searchController = TextEditingController();

  SubCategoryViewModel({required this.categoryId, this.subSubCategoryId}) {
    loadSubCategories();
    getSubProducts();
    searchController.addListener(_onSearchChanged);
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_productState, _cartState];

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refresh() async {
    await getSubProducts();
    loadSubCategories();
    notifyListeners();
  }

  Future<void> subProductRefresh() async {
    await getSubProducts(category: categoryRefresh);
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  get scaffoldKey => _key;

  Map<String, Category> get categories => _productState.categories;
  Map<String, ProductModel> get subProducts => _productState.subProducts;

  Future<void> getSubProducts({String? category}) async {
    try {
      categoryRefresh = category;
      _isProductsBusy = true;
      productErrorMessage = null;
      notifyListeners();
      if (subSubCategoryId != null && subSubCategoryId!.isNotEmpty) {
        await _productState.getSubProducts(category ?? subSubCategoryId!);
      } else {
        await _productState.getSubProducts(category ?? categoryId);
      }
    } catch (e) {
      if (e.toString().contains('No products found for this category')) {
        _productState.subProducts.clear(); // Clear the products list
      } else {
        productErrorMessage = "something_went_wrong".tr();
      }
    } finally {
      categoryRefresh = null;
      _isProductsBusy = false;
      notifyListeners();
    }
  }

  Future<void> loadSubCategories() async {
    try {
      _isSubCategoriesBusy = true;
      notifyListeners();
      subCategories = getSubCategories();
    } catch (e) {
      categoryErrorMessage = "something_went_wrong".tr();
    } finally {
      _isSubCategoriesBusy = false;
      notifyListeners();
    }
  }

  List<Category> getSubCategories() {
    final subCategories = categories[categoryId]?.subcategory ?? [];
    return subCategories;
  }

  List<Category> getLimitedSubCategories() {
    return subCategories.take(3).toList();
  }

  bool get hasMoreSubCategories {
    return subCategories.length > 3;
  }

  void onItemSelected(ProductModel product) {
    _navigation.navigateToProductDetailView(product: product);
  }

  void onMoreCategory() {
    _navigation.navigateToSubCategoryListView(
        subCategories: subCategories, categoryValue: categoryId);
  }

  void onCartTap() {
    _navigation.navigateToCartView();
  }

  void onFilter() {
    // onFilter. show bottomsheet.
  }

  Map<String, bool> get selected => _selected;

  void toggleSelection(String id) {
    _selected.clear(); // Clear all selections
    _selected[id] = true; // Select the tapped item
    notifyListeners();
  }

  void _onSearchChanged() {
    filterProducts(searchController.text);
  }

  void filterProducts(String query) {
    filterQuery = query.toLowerCase();
    if (filterQuery?.isEmpty ?? true) {
      filteredProducts.clear();
    } else {
      filteredProducts = Map.fromEntries(subProducts.entries.where((entry) {
        final productName = entry.value.productName?.toLowerCase() ?? '';
        final searchLower = filterQuery!.toLowerCase();
        return productName.contains(searchLower);
      }));
    }
    notifyListeners();
  }
}
