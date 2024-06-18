// import 'package:flutter/material.dart';
// import 'package:marchant/ui/common/app_colors.dart';
// import 'package:marchant/ui/common/app_text_style.dart';
// import 'package:marchant/ui/common/ui_helpers.dart';
// import 'package:marchant/ui/views/widgets/image_builder.dart';

// class CustomeCardWidget extends StatelessWidget {
//   const CustomeCardWidget({
//     super.key,
//     this.title = "",
//     this.size,
//     this.small = false,
//     this.details = const [],
//     this.onTap,
//     this.centerText = false,
//     this.image = 'assets/images/iphone.jpg',
//     this.elevation = true,
//     this.widget = const SizedBox(),
//     this.video = false,
//     this.description,
//     this.detailLimit,
//     this.isCategory = false,
//   });
//   final String title;
//   final double? size;
//   final bool small;
//   final List<String> details;
//   final VoidCallback? onTap;
//   final bool centerText;
//   final String image;
//   final bool elevation;
//   final Widget widget;
//   final bool video;
//   final String? description;
//   final int? detailLimit;
//   final bool isCategory;

//   @override
//   Widget build(BuildContext context) {
//     double width = size ?? MediaQuery.of(context).size.width * .15;
//     int limit = (detailLimit != null && details.length > detailLimit!)
//         ? detailLimit!
//         : details.length;
//     return InkWell(
//       onTap: onTap,
//       child: Card(
//         child: Container(
//           padding:
//               elevation ? const EdgeInsets.all(10) : const EdgeInsets.all(0),
//           decoration: BoxDecoration(
//             color: kcCardColor,
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//             boxShadow: [
//               BoxShadow(
//                 color: elevation
//                     ? Colors.black.withOpacity(.05)
//                     : Colors.black.withOpacity(0.0),
//                 blurRadius: 3.0,
//                 offset: const Offset(1, 2),
//                 spreadRadius: 1,
//               )
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: centerText
//                 ? CrossAxisAlignment.center
//                 : CrossAxisAlignment.start,
//             children: [
//               ImageBuilder(
//                 image: image,
//                 width: width,
//                 height: width,
//                 circle: false,
//               ),
//               const SizedBox(height: smallSize),
//               small
//                   ? Text(title, style: AppTextStyle.thinSmall)
//                   : SizedBox(
//                       width: width,
//                       child: Column(
//                         crossAxisAlignment: centerText
//                             ? CrossAxisAlignment.center
//                             : CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             title,
//                             style: AppTextStyle.h3Bold,
//                             maxLines: 1,
//                             overflow: TextOverflow.clip,
//                           ),
//                           if (description != null) ...[
//                             Text(
//                               description!,
//                               style: AppTextStyle.h4Normal,
//                               maxLines: 2,
//                               overflow: TextOverflow.clip,
//                             ),
//                             verticalSpaceSmall,
//                           ],
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: List.generate(
//                               limit,
//                               (index) => Text(
//                                 details[index],
//                                 style: AppTextStyle.thinSmall,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ).toList(),
//                           ),
//                           const SizedBox(height: 10),
//                           widget
//                         ],
//                       ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';

class CustomeCardWidget extends StatelessWidget {
  const CustomeCardWidget({
    super.key,
    this.title = "",
    this.size,
    this.small = false,
    this.details = const [],
    this.onTap,
    this.centerText = false,
    this.image = 'assets/images/folder.png',
    this.elevation = true,
    this.widget = const SizedBox(),
    this.video = false,
    this.description,
    this.detailLimit,
    this.isCategory = false,
  });

  final String title;
  final double? size;
  final bool small;
  final List<String> details;
  final VoidCallback? onTap;
  final bool centerText;
  final String image;
  final bool elevation;
  final Widget widget;
  final bool video;
  final String? description;
  final int? detailLimit;
  final bool isCategory;

  @override
  Widget build(BuildContext context) {
    double width = size ?? MediaQuery.of(context).size.width * .15;

    if (isCategory) {
      return InkWell(
        onTap: onTap,
        child: Card(
          child: Container(
            // padding:
            //     elevation ? const EdgeInsets.all(10) : const EdgeInsets.all(0),
            child: Column(
              // crossAxisAlignment: centerText
              //     ? CrossAxisAlignment.center
              //     : CrossAxisAlignment.start,
              children: [
                ImageBuilder(
                  image: image,
                  width: width,
                  height: width,
                  // circle: false,
                ),
                // const SizedBox(height: smallSize),
              ],
            ),
          ),
        ),
      );
    } else {
      int limit = (detailLimit != null && details.length > detailLimit!)
          ? detailLimit!
          : details.length;

      return InkWell(
        onTap: onTap,
        child: Card(
          child: Container(
            padding:
                elevation ? const EdgeInsets.all(10) : const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: kcCardColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: elevation
                      ? Colors.black.withOpacity(.05)
                      : Colors.black.withOpacity(0.0),
                  blurRadius: 3.0,
                  offset: const Offset(1, 2),
                  spreadRadius: 1,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: centerText
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                ImageBuilder(
                  image: image,
                  width: width,
                  height: width,
                  circle: false,
                ),
                const SizedBox(height: smallSize),
                small
                    ? Text(title, style: AppTextStyle.thinSmall)
                    : SizedBox(
                        width: width,
                        child: Column(
                          crossAxisAlignment: centerText
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppTextStyle.h3Bold,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                            if (description != null) ...[
                              Text(
                                description!,
                                style: AppTextStyle.h4Normal,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                              verticalSpaceSmall,
                            ],
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                limit,
                                (index) => Text(
                                  details[index],
                                  style: AppTextStyle.thinSmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ).toList(),
                            ),
                            const SizedBox(height: 10),
                            widget,
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
