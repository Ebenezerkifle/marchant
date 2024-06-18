import 'dart:math';


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
              if (currentItem == widgets.length) {
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


// class CustomGrideWidget extends StatelessWidget {
//   const CustomGrideWidget({
//     Key? key,
//     required this.widgets,
//     this.column = 2,
//     this.width,
//   }) : super(key: key);

//   final List<Widget> widgets;
//   final int column;
//   final double? width;

//   @override
//   Widget build(BuildContext context) {
//     if (widgets.isEmpty || column <= 0) {
//       return Container(); // Return an empty container if there are no widgets or invalid column value
//     }

//     int row = max((widgets.length / column).ceil(), 1); // Ensure at least one row

//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: List.generate(row, (index) {
//           int startIndex = index * column;
//           int endIndex = min(startIndex + column, widgets.length);
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: tinySize),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: List.generate(endIndex - startIndex, (index2) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: smallSize),
//                   child: widgets[startIndex + index2],
//                 );
//               }),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

class CustomGrideWidget extends StatelessWidget {
  const CustomGrideWidget({
    super.key,
    required this.widgets,
    this.column = 2,
    this.row = 3,
    this.width,
  });

  final List<Widget> widgets;
  final int column;
  final int row;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if (widgets.isEmpty || column <= 0 || row <= 0) {
      return Container(); // Return an empty container if there are no widgets or invalid column/row value
    }

    int gridCount = column * row;
    int totalGrids = (widgets.length / gridCount).ceil();
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(totalGrids, (gridIndex) {
          int startIndex = gridIndex * gridCount;
          int endIndex = (startIndex + gridCount) > widgets.length ? widgets.length : (startIndex + gridCount);

          return Padding(
            padding: const EdgeInsets.only(right: 16.0), // Adjust as needed
            child: Column(
              children: List.generate(row, (rowIndex) {
                int rowStartIndex = startIndex + (rowIndex * column);
                int rowEndIndex = rowStartIndex + column > endIndex ? endIndex : rowStartIndex + column;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0), // Use actual padding value
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(rowEndIndex - rowStartIndex, (index2) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0), // Use actual padding value
                        child: widgets[rowStartIndex + index2],
                      );
                    }),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
