import 'package:flutter/material.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';

class MultipleButtonsWidget extends StatelessWidget {
  const MultipleButtonsWidget({super.key, required this.buttons});
  final List<CustomeButton> buttons;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: buttons.map((e) => e).toList());
  }
}
