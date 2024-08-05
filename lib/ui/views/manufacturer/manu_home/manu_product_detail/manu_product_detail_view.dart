// import 'package:flutter/material.dart';
// import 'package:marchant/ui/views/page_builder/page_builder_view.dart';
// import 'package:stacked/stacked.dart';
// import 'manu_product_detail_viewmodel.dart';
// import 'package:marchant/models/product_model.dart';
// import 'package:marchant/ui/common/app_colors.dart';
// import 'package:marchant/ui/common/app_text_style.dart';
// import 'package:marchant/ui/common/ui_helpers.dart';
// import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
// // import 'package:marchant/ui/views/widgets/image_builder.dart';

// class ManuProductDetailView extends StackedView<ManuProductDetailViewModel> {
//   const ManuProductDetailView({super.key, required this.product});
//   final ProductModel product;

//   @override
//   Widget builder(
//     BuildContext context,
//     ManuProductDetailViewModel viewModel,
//     Widget? child,
//   ) {
//     return Scaffold(
//       body: SafeArea(
//         top: true,
//         child: Column(
//           children: [
//             CustomeAppBar(title: viewModel.productDetailHeader),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: middleSize),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       verticalSpaceMiddle,
//                       // Horizontally scrollable list of images with a clue icon
//                       PageBuilderView(product: product),
//                       verticalSpaceMiddle,
//                       Text(
//                         product.productName ?? '',
//                         style: AppTextStyle.big,
//                       ),
//                       verticalSpaceSmall,
//                       Text(
//                         product.description ?? '',
//                         style: AppTextStyle.h4Normal,
//                         textAlign: TextAlign.justify,
//                       ),
//                       verticalSpaceMiddle,
//                       Text(viewModel.productDetalistext,
//                           style: AppTextStyle.h2Bold),
//                       verticalSpaceSmall,
//                       if (product.description != null)
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: product.details!
//                               .map(
//                                 (e) => Padding(
//                                   padding:
//                                       const EdgeInsets.only(bottom: smallSize),
//                                   child: Row(
//                                     children: [
//                                       horizontalSpaceSmall,
//                                       Container(
//                                         height: tinySize,
//                                         width: tinySize,
//                                         decoration: const BoxDecoration(
//                                           color: kcDarkGreyColor,
//                                           shape: BoxShape.circle,
//                                         ),
//                                       ),
//                                       horizontalSpaceSmall,
//                                       Expanded(
//                                         child: Text(
//                                           e,
//                                           style: AppTextStyle.h3Normal,
//                                           // maxLines: 1,
//                                           // overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                       verticalSpaceSmall,
//                       if (viewModel.role != "Retailer") ...[
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               viewModel.statusText,
//                               style: AppTextStyle.h2Bold,
//                             ),
//                             horizontalSpaceSmall, // Add some space between Text and Flexible
//                             Expanded(
//                               child: Text(
//                                 product.status ?? '',
//                                 style: AppTextStyle.h3Bold,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.clip,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ]
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   ManuProductDetailViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       ManuProductDetailViewModel();
// }




import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/views/page_builder/page_builder_view.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
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
            CustomeAppBar(title: viewModel.productDetailHeader),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMiddle,
                      // Horizontally scrollable list of images with a clue icon
                      PageBuilderView(product: product),
                      verticalSpaceMiddle,
                      Text(
                        product.productName ?? '',
                        style: AppTextStyle.h1Bold,
                      ),
                      verticalSpaceSmall,
                      Text(
                        product.description ?? '',
                        style: AppTextStyle.h4Normal,
                        textAlign: TextAlign.justify,
                      ),
                      verticalSpaceMiddle,
                      Text(viewModel.productDetalistext,
                          style: AppTextStyle.h2Bold),
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
                                      Expanded(
                                        child: Text(
                                          e,
                                          style: AppTextStyle.h3Normal,
                                          // maxLines: 1,
                                          // overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      if (viewModel.role == "Retailer") ...[
                        verticalSpaceMedium,
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding:
                              const EdgeInsets.symmetric(vertical: middleSize),
                          decoration: BoxDecoration(
                            color: kcLightGrey.withOpacity(.3),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                viewModel.totalPriceText,
                                style: AppTextStyle.h4Normal,
                              ),
                              Text(
                                '${product.salesPrice} ETB',
                                style: AppTextStyle.withColor(
                                  color: kcPrimaryColorDark,
                                  style: AppTextStyle.big,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      verticalSpaceSmall,
                      if (viewModel.role != "Retailer") ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              viewModel.statusText,
                              style: AppTextStyle.h2Bold,
                            ),
                            horizontalSpaceSmall, // Add some space between Text and Flexible
                            Expanded(
                              child: Text(
                                product.status ?? '',
                                style: AppTextStyle.h3Bold,
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
     bottomNavigationBar: viewModel.role == "Retailer" 
        ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: smallSize,
              horizontal: smallSize,
            ),
            child: CustomeButton(
              text: viewModel.addToCartText,
              onTap: viewModel.onAddToCart,
              loading: viewModel.isBusy,
              icon: const Padding(
                padding: EdgeInsets.only(left: smallSize),
                child: Icon(
                  FontAwesomeIcons.cartArrowDown,
                  color: kcWhite,
                ),
              ),
            ),
          )
        : null,
    );
  }

  @override
  ManuProductDetailViewModel viewModelBuilder(BuildContext context) =>
      ManuProductDetailViewModel(product: product);
}
