import 'package:marchant/models/category_model.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/models/product_model.dart';
import 'package:stacked/stacked.dart';

import '../api_service/category_api_service.dart';

class ProductStateService with ListenableServiceMixin {
  ProductStateService() {
    listenToReactiveValues([
      _categories,
      _topCategories,
      _selected,
      _subCategories,
      _selectedSubCategory,
      _products,
    ]);
    getCategories();
    _defaultSelected();
    _getProducts();
  }

  final _products = ReactiveValue<Map<String, ProductModel>>({});
  Map<String, ProductModel> get products => _products.value;

  final _categories = ReactiveValue<Map<String, Category>>({});
  Map<String, Category> get categories => _categories.value;

  final _topCategories = ReactiveValue<Map<String, String>>({});
  Map<String, String> get topCategories => _topCategories.value;

  final _selected = ReactiveValue<Map<String, bool>>({});
  Map<String, bool> get selected => _selected.value;

  final _subCategories = ReactiveValue<Map<String, List<String>>>({});
  Map<String, List<String>> get subCategories => _subCategories.value;

  final _selectedSubCategory = ReactiveValue<String?>(null);
  String? get selectedSubCategory => _selectedSubCategory.value;

  final _activeOrders = ReactiveValue<Map<String, OrderModel>>({});
  Map<String, OrderModel> get activeOrders => _activeOrders.value;

  onCategorySelected(String key, {bool reOrder = false}) {
    _selected.value.clear();
    _selected.value[key] = true;
    _selectedSubCategory.value = null; // Reset subcategory selection
    notifyListeners();
  }

  onSubCategorySelected(String key, String subCategory) {
    _selectedSubCategory.value = subCategory;
    notifyListeners();
  }

  _defaultSelected() {
    if (_topCategories.value.isNotEmpty) {
      var first = _topCategories.value.entries.first.key;
      _selected.value[first] = true;
      notifyListeners();
    }
  }

  int categoryLimit = 3;

  Future<void> getCategories() async {
    _categories.value.clear();
    _categories.value.addAll(await CategoryApiCallService().getCategories());
    notifyListeners();
  }

  _getProducts() {
    _products.value.clear();
    for (var ele in sampleProducts.entries) {
      _products.value[ele.key] = ele.value;
    }
    notifyListeners();
  }

  placeOrder(OrderModel order) {
    _activeOrders.value[order.id] = order;
    notifyListeners();
  }

  final Map<String, String> samples = {
    '1': 'Mobile',
    '2': 'Laptop',
    '3': 'Refrigerator',
    '4': 'TV',
    '5': 'Stove',
    '6': 'Bread maker',
    '7': 'Air conditioner',
    '8': 'Bread maker',
    '9': 'Air conditioner',
    '10': 'Bread maker',
    '11': 'Air conditioner',
    '12': 'Air conditioner',
  };

  Map<String, ProductModel> sampleProducts = {
    "a": ProductModel(
      id: 'f',
      title: 'OnePlus Open',
      description:
          "The number of foldable phones on the market has never been higher, thanks to the collective effort of just about every manufacturer, including Google with its Pixel Fold, Motorola with its Razr lineup, and OnePlus with the OnePlus Open. While Samsung has held the reins of the best foldable honor for years, I'm giving the top spot right now to the OnePlus Open. ",
      price: 42000.0,
      images: ['assets/images/iphone.jpg'],
      details: [
        '512GB Storage',
        'Brand new',
        '8 GB RAM',
        '5,050mAh battery with LTPO display',
        'Quality cameras all across the board'
      ],
      provider: 'Alsam Trading plc',
    ),
    "b": ProductModel(
      id: 'b',
      title: 'Samsung Ultra Note',
      description: 'This is the description of Samsung Ultra Note'
          ' so you better read it before you buy'
          ' anything! I think you understand me.'
          ' Haha I am joking, it is up to you!',
      price: 29000.0,
      images: ['assets/images/iphone.jpg'],
      details: [
        '64 GB Storage',
        'Slightly Used',
        '6 GB RAM',
        '24,000 mAh battery power'
      ],
      provider: 'Alsam Trading plc',
    ),
    "c": ProductModel(
      id: 'c',
      title: 'Samsung Galaxy S24 Ultra',
      description: 'This is the description of Samsung Ultra Note'
          ' so you better read it before you buy'
          ' anything! I think you understand me.'
          ' Haha I am joking, it is up to you!',
      price: 29000.0,
      images: ['assets/images/iphone.jpg'],
      details: [
        '64 GB Storage',
        'Slightly Used',
        '6 GB RAM',
        '24,000 mAh battery power',
        'Best display available in any smartphone'
      ],
      provider: 'Alsam Trading plc',
    ), //iPhone 15 Pro Max
    "d": ProductModel(
      id: 'd',
      title: 'iPhone 14 Pro',
      description: 'This is the description of the product'
          ' so you better read it before you buy'
          ' anything! I think you understand me.'
          ' Haha I am joking, it is up to you!',
      price: 15000.0,
      images: ['assets/images/iphone.jpg'],
      details: ['64 GB Storage', 'New', '6 GB RAM', '48 MP', '12 MP'],
      provider: 'Nardos Mobile',
    ),
    "e": ProductModel(
      id: 'e',
      title: 'iPhone 15 Pro Max',
      description: 'This is the description of the product'
          ' so you better read it before you buy'
          ' anything! I think you understand me.'
          ' Haha I am joking, it is up to you!',
      price: 19000.0,
      images: ['assets/images/iphone.jpg'],
      details: ['64 GB Storage', 'New', '6 GB RAM', '48 MP', '12 MP'],
      provider: 'Nardos Mobile',
    ),
    "f": ProductModel(
      id: 'f',
      title: 'Oppo Finder',
      description: 'This is the description of the product'
          ' so you better read it before you buy'
          ' anything! I think you understand me.'
          ' Haha I am joking, it is up to you!',
      price: 8000.0,
      images: ['assets/images/iphone.jpg'],
      details: ['64 GB Storage', 'New', '6 GB RAM', '48 MP', '12 MP'],
      provider: 'Nardos Mobile',
    ),
  };
}
