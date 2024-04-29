import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CartCalculatorModel extends BaseViewModel {
  TextEditingController controller = TextEditingController();
  Function(String?) onchange;
  CartCalculatorModel(
    String? initialCount, {
    required this.onchange,
  }) {
    controller.text = initialCount ?? '1';
    notifyListeners();
  }

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
