import 'package:flutter/material.dart';
import 'package:marchant/models/product_model.dart';
import 'package:stacked/stacked.dart';

class CartSheetModel extends BaseViewModel {
  TextEditingController controller = TextEditingController();
  ProductModel product;

  CartSheetModel({required this.product}) {
    controller.text = '1';
    _totalPrice = product.price ?? _totalPrice;
  }
  num _totalPrice = 0.0;
  num get totalPrice => _totalPrice;

  onChange() {
    num count = num.parse(controller.text);
    _totalPrice = (product.price ?? 0) * count;
    notifyListeners();
  }
}
