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


class CustomGrideWidget extends StatelessWidget {
  const CustomGrideWidget({
    Key? key,
    required this.widgets,
    this.column = 2,
    this.width,
  }) : super(key: key);

  final List<Widget> widgets;
  final int column;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if (widgets.isEmpty || column <= 0) {
      return Container(); // Return an empty container if there are no widgets or invalid column value
    }

    int row = max((widgets.length / column).ceil(), 1); // Ensure at least one row

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(row, (index) {
          int startIndex = index * column;
          int endIndex = min(startIndex + column, widgets.length);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: tinySize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(endIndex - startIndex, (index2) {
                return Padding(
                  padding: const EdgeInsets.only(right: smallSize),
                  child: widgets[startIndex + index2],
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}


















// class CustomGrideWidget extends StatefulWidget {
//   const CustomGrideWidget({
//     Key? key,
//     required this.widgets,
//     this.column = 4,
//     this.row = 3,
//     this.width,
//   }) : super(key: key);

//   final List<Widget> widgets;
//   final int column;
//   final int row;
//   final double? width;

//   @override
//   _CustomGrideWidgetState createState() => _CustomGrideWidgetState();
// }

// class _CustomGrideWidgetState extends State<CustomGrideWidget> {
//   int currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     if (widget.widgets.isEmpty || widget.column <= 0 || widget.row <= 0) {
//       return Container(); // Return an empty container if there are no widgets or invalid column/row value
//     }

//     int totalItemsPerPage = widget.row * widget.column;
//     int totalPages = (widget.widgets.length / totalItemsPerPage).ceil();
//     bool hasMore = widget.widgets.length > (currentPage + 1) * totalItemsPerPage;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             if (currentPage > 0)
//               IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: () {
//                   setState(() {
//                     currentPage = max(currentPage - 1, 0);
//                   });
//                 },
//               ),
//             Text(
//               "Page ${currentPage + 1} of $totalPages",
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//             if (hasMore || currentPage < totalPages - 1)
//               IconButton(
//                 icon: const Icon(Icons.arrow_forward_ios),
//                 onPressed: () {
//                   setState(() {
//                     currentPage = min(currentPage + 1, totalPages - 1);
//                   });
//                 },
//               ),
//           ],
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround, // Adjusted to space around
//             children: List.generate(totalPages, (index) {
//               int startIndex = index * totalItemsPerPage;
//               int endIndex = min(startIndex + totalItemsPerPage, widget.widgets.length);
//               return Column(
//                 children: List.generate(widget.row, (rowIndex) {
//                   int rowStartIndex = startIndex + (rowIndex * widget.column);
//                   int rowEndIndex = min(rowStartIndex + widget.column, endIndex);
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: tinySize),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: List.generate(rowEndIndex - rowStartIndex, (index2) {
//                         return Padding(
//                           padding: const EdgeInsets.only(right: smallSize),
//                           child: widget.widgets[rowStartIndex + index2],
//                         );
//                       }),
//                     ),
//                   );
//                 }),
//               );
//             }),
//           ),
//         ),
//         if (hasMore && currentPage == totalPages - 1)
//           Center(
//             child: TextButton(
//               onPressed: () {
//                 // Handle "More" button press (load more data, navigate to another page, etc.)
//               },
//               child: Text("More"),
//             ),
//           ),
//       ],
//     );
//   }
// }
