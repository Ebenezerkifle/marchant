

import 'package:flutter/material.dart';
import 'package:marchant/ui/views/page_builder/page_builder_view.dart';
import 'package:stacked/stacked.dart';
import 'manu_product_detail_viewmodel.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
// import 'package:marchant/ui/views/widgets/image_builder.dart';

class ManuProductDetailView extends StackedView<ManuProductDetailViewModel> {
  const ManuProductDetailView({super.key, required this.product});
  final ProductModel product;

  @override
  Widget builder(
    BuildContext context,
    ManuProductDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(title: 'Product detail'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // verticalSpaceMiddle,
                      // ImageBuilder(
                      //   image: product.productImage.first,
                      //   height: screenWidth(context) * .7,
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      // ),
                      verticalSpaceMiddle,
                      // Horizontally scrollable list of images with a clue icon
                      PageBuilderView(product: product),
                      verticalSpaceMiddle,
                      Text(
                        product.productName ?? '',
                        style: AppTextStyle.big,
                      ),
                      verticalSpaceSmall,
                      Text(
                        product.description ?? '',
                        style: AppTextStyle.h4Normal,
                        textAlign: TextAlign.justify,
                      ),
                      verticalSpaceMiddle,
                      const Text('More Details', style: AppTextStyle.h2Bold),
                      verticalSpaceSmall,
                      if (product.description != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: product.details!
                              .map(
                                (e) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: smallSize),
                                  child: Row(
                                    children: [
                                      horizontalSpaceSmall,
                                      Container(
                                        height: tinySize,
                                        width: tinySize,
                                        decoration: const BoxDecoration(
                                          color: kcDarkGreyColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      horizontalSpaceSmall,
                                      Flexible(
                                        child: Text(
                                          e,
                                          style: AppTextStyle.h3Normal,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  ManuProductDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ManuProductDetailViewModel();
}

// class _ImageCarousel extends StatefulWidget {
//   const _ImageCarousel({required this.product});
//   final ProductModel product;

//   @override
//   __ImageCarouselState createState() => __ImageCarouselState();
// }

// class __ImageCarouselState extends State<_ImageCarousel> {
//   late PageController _pageController;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: screenWidth(context) * .7,
//       child: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             itemCount: widget.product.productImage.length,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentPage = index;
//               });
//             },
//             itemBuilder: (context, index) {
//               return ImageBuilder(
//                 image: widget.product.productImage[index],
//                 height: screenWidth(context) * .7,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               );
//             },
//           ),
//           if (_currentPage > 0)
//             Positioned(
//               left: 10.0,
//               top: screenWidth(context) * .35 - 20, // Vertically centered
//               child: GestureDetector(
//                 onTap: () {
//                   if (_pageController.hasClients) {
//                     _pageController.previousPage(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeIn,
//                     );
//                   }
//                 },
//                 child: Icon(
//                   Icons.arrow_back_ios,
//                   color:
//                       kcPrimaryColor.withOpacity(0.7), // Slightly transparent
//                   size: 40,
//                 ),
//               ),
//             ),
//           if (_currentPage < widget.product.productImage.length - 1)
//             Positioned(
//               right: 10.0,
//               top: screenWidth(context) * .35 - 20, // Vertically centered
//               child: GestureDetector(
//                 onTap: () {
//                   if (_pageController.hasClients) {
//                     _pageController.nextPage(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeIn,
//                     );
//                   }
//                 },
//                 child: Icon(
//                   Icons.arrow_forward_ios,
//                   color:
//                       kcPrimaryColor.withOpacity(0.7), // Slightly transparent
//                   size: 40,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
