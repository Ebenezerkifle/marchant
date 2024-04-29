import 'package:marchant/models/product_model.dart';
import 'package:stacked/stacked.dart';

class ProductStateService with ListenableServiceMixin {
  ProductStateService() {
    listenToReactiveValues([_catagories, _topCategories, _selected]);
    _getCatagories();
    _defaultSelected();
    _getProducts();
  }

  final _products = ReactiveValue<Map<String, ProductModel>>({});
  Map<String, ProductModel> get products => _products.value;

  final _catagories = ReactiveValue<Map<String, String>>({});
  Map<String, String> get categories => _catagories.value;

  final _topCategories = ReactiveValue<Map<String, String>>({});
  Map<String, String> get topCategories => _topCategories.value;

  final _selected = ReactiveValue<Map<String, String>>({});
  Map<String, String> get selected => _selected.value;

  onCategorySelected(var key) {
    _selected.value.clear();
    _selected.value[key] = key;
    notifyListeners();
  }

  _defaultSelected() {
    if (_topCategories.value.isNotEmpty) {
      var first = _topCategories.value.entries.first.key;
      selected[first] = first;
      notifyListeners();
    }
  }

  int catagoryLimit = 3;
  _getCatagories() {
    _catagories.value.clear();
    int length = samples.length > 3 ? catagoryLimit : samples.length;
    int count = 0;
    for (var ele in samples.entries) {
      _catagories.value[ele.key] = ele.value;
      if (count < length) {
        _topCategories.value[ele.key] = ele.value;
      }
      count++;
    }
    notifyListeners();
  }

  _getProducts() {
    _products.value.clear();
    for (var ele in sampleProducts.entries) {
      _products.value[ele.key] = ele.value;
    }
    notifyListeners();
  }

  final Map<String, String> samples = {
    "1": "Mobile",
    "2": "Laptop",
    "3": "Refrigerator",
    "4": "TV",
    "5": "Stove",
    "6": "Bread maker",
    "7": "Air conditioner",
  };

  Map<String, ProductModel> sampleProducts = {
    "a": ProductModel(
      id: 'a',
      title: 'iPhone 15 Pro Max',
      description:
          "The latest iPhone 15 Pro Max offers everything a premium flagship smartphone should, including a brilliant 6.7-inch AMOLED display for all the media consumption -- and mobile productivity, of course. This year's model also looks and feels different than any prior Pro Max devices, as it's made of titanium instead of stainless steel and, therefore, significantly lighter in the hand. This makes the iPhone 15 Pro Max noticeably more comfortable to use, as ZDNET Editor-in-Chief Jason Hiner noted in his review.",
      price: 92000.0,
      images: [
        'https://www.zdnet.com/a/img/resize/6584fd84ad6d7b6f90ac4144f516cedc1c255b83/2023/10/05/c175a0e5-2ef1-400f-b90b-8dd3cf353de4/img-1927.jpg?auto=webp&fit=crop&height=360&width=640',
        'assets/images/iphone.jpg'
      ],
      details: [
        '256 GB Storage',
        'Brand new',
        '8 GB RAM',
        '48,000 mAh battery power',
        '5X zoom camera for high-quality shots'
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
      images: [
        'https://www.zdnet.com/a/img/resize/6d131bedca602d70bd3ed544d9b1f63e8737c22e/2024/01/31/66065279-c93c-4c83-8488-fb06abadc069/dsc01682.jpg?auto=webp&fit=crop&height=360&width=640',
        'assets/images/iphone.jpg'
      ],
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
      images: [
        'https://www.zdnet.com/a/img/resize/bc47d2d4386c37fb8845a61624bf04f98295a175/2023/10/05/487a7516-8c27-4547-9dd5-e78f40e8d112/google-pixel-8-pro-screen.jpg?auto=webp&fit=crop&height=360&width=640',
        'assets/images/iphone.jpg'
      ],
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
      id: 'f',
      title: 'OnePlus Open',
      description:
          "The number of foldable phones on the market has never been higher, thanks to the collective effort of just about every manufacturer, including Google with its Pixel Fold, Motorola with its Razr lineup, and OnePlus with the OnePlus Open. While Samsung has held the reins of the best foldable honor for years, I'm giving the top spot right now to the OnePlus Open. ",
      price: 42000.0,
      images: [
        'https://www.zdnet.com/a/img/resize/faa590fcf82713dd96f8e4d5180eb039fe8f6fb3/2023/12/26/d25c4e29-ab22-450d-90bc-64bb30f27abd/oneplus-open-folded.jpg?auto=webp&fit=crop&height=360&width=640',
        'assets/images/iphone.jpg'
      ],
      details: [
        '512GB Storage',
        'Brand new',
        '8 GB RAM',
        '5,050mAh battery with LTPO display',
        'Quality cameras all across the board'
      ],
      provider: 'Alsam Trading plc',
    ),
  };
}
