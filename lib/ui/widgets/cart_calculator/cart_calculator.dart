import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/category_widget.dart';
import 'package:marchant/ui/views/widgets/input_field.dart';
import 'package:stacked/stacked.dart';

import 'cart_calculator_model.dart';

class CartCalculator extends StackedView<CartCalculatorModel> {
  const CartCalculator({
    super.key,
    required this.controller,
    required this.onChange,
  });
  final TextEditingController controller;
  final Function(String?) onChange;

  @override
  Widget builder(
    BuildContext context,
    CartCalculatorModel viewModel,
    Widget? child,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CategoryWidget(
          name: ' - ',
          selected: true,
          onTap: viewModel.subtract,
          roundness: 1,
          vPadding: tinySize,
          hPadding: middleSize,
        ),
        horizontalSpaceSmall,
        InputField(
          controller: viewModel.controller,
          width: 60, //todo would be good if this is dynamic
          height: 40,
          charLength: 3,
          onchange: (value) => onChange(value),
          centerText: true,
          hint: '1',
          inputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[1-9]')),
          ],
        ),
        horizontalSpaceSmall,
        CategoryWidget(
          name: ' + ',
          selected: true,
          onTap: viewModel.add,
          roundness: 1,
          vPadding: tinySize,
          hPadding: middleSize,
        )
      ],
    );
  }

  @override
  CartCalculatorModel viewModelBuilder(
    BuildContext context,
  ) =>
      CartCalculatorModel(controller: controller, onchange: onChange);
}
