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
    _getCategories();
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
    // Reorder the category if needed
    // reOrder ? _reOrderCategory(key) : null;
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

  void _getCategories() async {
    _categories.value.clear();
    _categories.value.addAll(await CategoryApiCallService().getCategories());
    print('------------------------length----------');
    print(_categories.value.length);
    // for (var ele in samples.entries) {
    //   _categories.value[ele.key] = ele.value;
    //   _topCategories.value[ele.key] = ele.value; // Always add to top categories
    //   // Mock subcategories for example purposes
    //   // Each top category has different subcategories
    //   if (ele.key == '1') {
    //     _subCategories.value[ele.key] = ['Sub1', 'Sub2', 'Sub3'];
    //   } else if (ele.key == '2') {
    //     _subCategories.value[ele.key] = ['Sub5', 'Sub6', 'Sub7'];
    //   } else if (ele.key == '3') {
    //     _subCategories.value[ele.key] = ['Sub8', 'Sub9'];
    //   } else if (ele.key == '4') {
    //     _subCategories.value[ele.key] = ['Sub10', 'Sub11'];
    //   } else if (ele.key == '5') {
    //     _subCategories.value[ele.key] = ['Sub12', 'Sub13'];
    //   } else if (ele.key == '6') {
    //     _subCategories.value[ele.key] = ['Sub14', 'Sub15'];
    //   } else if (ele.key == '7') {
    //     _subCategories.value[ele.key] = ['Sub16', 'Sub17'];
    //   } else if (ele.key == '8') {
    //     _subCategories.value[ele.key] = ['Sub18', 'Sub19'];
    //   } else if (ele.key == '9') {
    //     _subCategories.value[ele.key] = ['Sub20', 'Sub21'];
    //   } else if (ele.key == '10') {
    //     _subCategories.value[ele.key] = ['Sub22', 'Sub23'];
    //   } else if (ele.key == '11') {
    //     _subCategories.value[ele.key] = ['Sub24', 'Sub25'];
    //   } else if (ele.key == '12') {
    //     _subCategories.value[ele.key] = ['Sub26', 'Sub27'];
    //   }
    //   // You can add more conditions for subcategories here
    // }
    notifyListeners();
  }

  // _reOrderCategory(String key) {
  //   if (_categories.value.containsKey(key)) {
  //     String selected = _categories.value[key] ?? '';
  //     Map<String, String> temp = {};
  //     temp[key] = selected;
  //     _categories.value.remove(key);
  //     Map<String, String> reOrdered = {...temp, ..._categories.value};
  //     _categories.value.clear();
  //     _categories.value = reOrdered;
  //     notifyListeners();
  //   }
  // }

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
      description: 'This is th description of Samsun Ultra Note'
          ' so you better read it before you buy'
          ' any thing! I think you understand me.'
          ' Hahaha I am jokking, it is up to you!',
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
      description: 'This is th description of Samsun Ultra Note'
          ' so you better read it before you buy'
          ' any thing! I think you understand me.'
          ' Hahaha I am jokking, it is up to you!',
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
      description: 'This is th description of the product'
          ' so you better read it before you buy'
          ' any thing! I think you understand me.'
          ' Hahaha I am jokking, it is up to you!',
      price: 92000.0,
      images: ['assets/images/iphone.jpg'],
      details: [
        '256 GB Storage',
        'Brand new',
        '8 GB RAM',
        '48,000 mAh battery power'
      ],
      provider: 'Alsam Trading plc',
    ), //Google Pixel 8 Pro
    "e": ProductModel(
      id: 'e',
      title: 'Google Pixel 8 Pro',
      description:
          "When it comes to camera performance, you really can't go wrong with any of the flagship devices from the big three (Apple, Samsung, and Google). Depending on your preference for color temperature and feature set, you may lean towards one manufacturer over the other. But more often than not, it's Google's Pixel camera system that satisfies the most users, and the latest Pixel 8 Pro remains a champion both for instant capturing and post-processing. ",
      price: 92000.0,
      images: ['assets/images/iphone.jpg'],
      details: [
        '256 GB Storage',
        'Brand new',
        '8 GB RAM',
        '5,050mAh battery with LTPO display',
        'Quality cameras all across the board'
      ],
      provider: 'Alsam Trading plc',
    ),
    "f": ProductModel(
      id: 'a',
      title: 'iPhone 15 Pro Max',
      description:
          "The latest iPhone 15 Pro Max offers everything a premium flagship smartphone should, including a brilliant 6.7-inch AMOLED display for all the media consumption -- and mobile productivity, of course. This year's model also looks and feels different than any prior Pro Max devices, as it's made of titanium instead of stainless steel and, therefore, significantly lighter in the hand. This makes the iPhone 15 Pro Max noticeably more comfortable to use, as ZDNET Editor-in-Chief Jason Hiner noted in his review.",
      price: 92000.0,
      images: ['assets/images/iphone.jpg'],
      details: [
        '256 GB Storage',
        'Brand new',
        '8 GB RAM',
        '48,000 mAh battery power',
        '5X zoom camera for high-quality shots'
      ],
      provider: 'Alsam Trading plc',
    ),
  };
}
