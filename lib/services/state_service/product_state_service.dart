import 'package:marchant/models/category_model.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/services/api_service/product_api_service.dart';
import 'package:stacked/stacked.dart';

import '../api_service/category_api_service.dart';

class ProductStateService with ListenableServiceMixin {
  ProductStateService() {
    listenToReactiveValues([
      _categories,
      _topCategories,
      _selected,
      _subCategories,
      _products,
    ]);
    getCategories();
    // _defaultSelected();
    getProducts();
  }

  final _products = ReactiveValue<Map<String, ProductModel>>({});
  Map<String, ProductModel> get products => _products.value;

  final _subProducts = ReactiveValue<Map<String, ProductModel>>({});
  Map<String, ProductModel> get subProducts => _subProducts.value;

  final _categories = ReactiveValue<Map<String, Category>>({});
  Map<String, Category> get categories => _categories.value;

  final _topCategories = ReactiveValue<Map<String, String>>({});
  Map<String, String> get topCategories => _topCategories.value;

  final _selected = ReactiveValue<Map<String, bool>>({});
  Map<String, bool> get selected => _selected.value;

  final _subCategories = ReactiveValue<Map<String, List<String>>>({});
  Map<String, List<String>> get subCategories => _subCategories.value;

  final _activeOrders = ReactiveValue<Map<String, OrderModel>>({});
  Map<String, OrderModel> get activeOrders => _activeOrders.value;

  final _isLoading = ReactiveValue<bool>(false);

  bool get isLoading => _isLoading.value;

  Future<void> getCategories() async {
    try {
      _isLoading.value = true;
      _categories.value.clear();
      _categories.value.addAll(await CategoryApiCallService().getCategories());
    } catch (e) {
      // Handle error
    } finally {
      _isLoading.value = false;
      notifyListeners();
    }
  }

  Future<void> getProducts() async {
    try {
      _isLoading.value = true;
      _products.value.clear();
      _products.value.addAll(await ProductApiCallService().getProducts());
    } catch (e) {
      //
    } finally {
      _isLoading.value = false;
      notifyListeners();
    }
  }

  Future<void> getSubProducts(categoryId) async {
    _subProducts.value.clear();
    _subProducts.value
        .addAll(await ProductApiCallService().getSubProducts(categoryId));
    // print(_subProducts.value.length);
    notifyListeners();
  }

  void placeOrder(OrderModel order) {
    String orderId =
        order.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    OrderModel updatedOrder = OrderModel(
      products: order.products,
      id: orderId,
      count: order.count,
      totalPrice: order.totalPrice,
    );
    _activeOrders.value[orderId] = updatedOrder;
    notifyListeners();
  }

  void clearState() {
    _products.value = {};
    _subProducts.value = {};
    _categories.value = {};
    _topCategories.value = {};
    _selected.value = {};
    _subCategories.value = {};
    _activeOrders.value = {};
    _isLoading.value = false;
    notifyListeners();
  }
}
