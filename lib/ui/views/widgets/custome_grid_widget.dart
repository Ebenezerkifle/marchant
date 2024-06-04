import 'package:flutter/material.dart';
import 'package:marchant/ui/common/ui_helpers.dart';

class CustomeGrideWidget extends StatelessWidget {
  const CustomeGrideWidget({
    super.key,
    required this.widgets,
    this.column = 2,
    this.width,
  });
  final List<Widget> widgets;
  final int column;
  final double? width;

  @override
  Widget build(BuildContext context) {
    int row = widgets.length ~/ column;
    widgets.length / column > row ? row++ : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(row, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: tinySize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(column, (index2) {
              int currentItem = index * column + index2;
              if (currentItem >= widgets.length) {
                return Container();
              }
              return widgets[currentItem];
            }),
          ),
        );
      }),
    );
  }
}
