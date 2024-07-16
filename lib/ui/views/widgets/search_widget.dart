import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final double? width;
  final VoidCallback? onFilter;

  const SearchWidget({
    super.key,
    required this.searchController,
    this.width,
    this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.12,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: searchController,
                // style: AppTextStyle.h4Bold,
                style: const TextStyle(
                  color: Colors.white, // Set text color to white
                  fontSize: 16.0, // Adjust font size as needed
                  fontWeight: FontWeight.bold, // Adjust font weight as needed
                ),
                cursorColor: kcWhite,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.8),
                    size: 30,
                  ),
                  hintText: "Search",
                  hintStyle: AppTextStyle.withColor(
                    color: kcWhite,
                    style: AppTextStyle.h3Bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:marchant/ui/common/app_colors.dart';
// import 'package:marchant/ui/common/app_text_style.dart';
// // import 'package:marchant/ui/common/ui_helpers.dart';
// // import 'package:marchant/ui/views/widgets/icon_decore_widget.dart';

// class SearchWidget extends StatelessWidget {
//   const SearchWidget({super.key, this.width, this.onFilter});
//   final double? width;
//   final VoidCallback? onFilter;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.width * 0.12,
//       width: width ?? double.infinity,
//       alignment: Alignment.center,
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: TextField(
//                 style: AppTextStyle.h4Bold,
//                 cursorColor: kcPrimaryColorDark,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: Colors.black.withOpacity(0.5),
//                     size: 30,
//                   ),
//                   hintText: "Search",
//                   hintStyle: AppTextStyle.withColor(
//                     color: kcLightGrey,
//                     style: AppTextStyle.h3Bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // horizontalSpaceSmall,
//           // IconDecoreWidget(
//           //   icon: FontAwesomeIcons.sliders,
//           //   onTap: onFilter ?? () {},
//           //   forgroundColor: kcWhite,
//           //   backgroundColor: kcPrimaryColorDark,
//           //   roundness: 5,
//           // )
//         ],
//       ),
//     );
//   }
// }
