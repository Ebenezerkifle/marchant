import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CartCalculatorModel extends BaseViewModel {
  TextEditingController controller = TextEditingController();
  Function(String?) onchange;
  CartCalculatorModel({
    required this.controller,
    required this.onchange,
  });

  add() {
    num count = num.parse(controller.text);
    count++;
    controller.text = count.toString();
    onchange(controller.text);
    notifyListeners();
  }

  subtract() {
    num count = num.parse(controller.text);
    if (count > 1) {
      count--;
      controller.text = count.toString();
      onchange(controller.text);
      notifyListeners();
    }
  }
}
