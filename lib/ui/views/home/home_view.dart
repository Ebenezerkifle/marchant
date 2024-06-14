import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
import 'package:marchant/ui/views/widgets/custome_circular_card_widget.dart';
import 'package:marchant/ui/views/widgets/search_widget.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

// class HomeView extends StackedView<HomeViewModel> {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   Widget builder(
//     BuildContext context,
//     HomeViewModel viewModel,
//     Widget? child,
//   ) {
//     return Scaffold(
//       key: viewModel.scaffoldKey,
//       backgroundColor: kcWhite,
//       body: SafeArea(
//         top: true,
//         child: Column(
//           children: [
//             CustomeAppBar(
//               title: 'Marchant',
//               back: false,
//               widget: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: viewModel.changeUserRole,
//                     child: const Icon(
//                       FontAwesomeIcons.solidBell,
//                       color: kcPrimaryColor,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: middleSize,
//                 vertical: middleSize,
//               ),
//               child: SearchWidget(
//                 onFilter: viewModel.onFilter,
//               ),
//             ),
//             verticalSpaceSmall,
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: middleSize),
//                   child: Column(
//                     children: [
//                       CustomGrideWidget(
//                         column: 4,
//                         // row: 3,
//                         widgets: viewModel.categories.entries
//                             .map(
//                               (e) => Padding(
//                                 padding:
//                                     const EdgeInsets.only(right: smallSize),
//                                 child: CustomeCardWidget(
//                                   isCategory: true,
//                                   // onTap: () => viewModel.onSelected(e.key),
//                                    onTap: () {
//                                     // Navigate to subcategory view for the selected category
//                                     viewModel.navigateToSubCategory(e.key);
//                                   },
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                       verticalSpaceMedium,
//                       CustomeGrideWidget(
//                         widgets: viewModel.products.entries
//                             .map(
//                               (e) => CustomeCardWidget(
//                                 size: screenWidth(context) * .38,
//                                 onTap: () => viewModel.onItemSelected(e.value),
//                                 title: e.value.title ?? '',
//                                 details: e.value.details ?? [],
//                                 detailLimit: 3,
//                                 image: e.value.images?.first ?? '',
//                                 widget: Text(
//                                   '${e.value.price} ETB',
//                                   style: AppTextStyle.h4Bold,
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                       verticalSpaceLarge,
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             verticalSpaceSmall,
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   HomeViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       HomeViewModel();
// }

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      key: viewModel.scaffoldKey,
      backgroundColor: kcWhite,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(
              title: 'Marchant',
              back: false,
              widget: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    // onTap: viewModel.changeUserRole,
                    child: const Icon(
                      FontAwesomeIcons.solidBell,
                      color: kcPrimaryColor,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: middleSize,
                vertical: middleSize,
              ),
              child: SearchWidget(
                onFilter: viewModel.onFilter,
              ),
            ),
            verticalSpaceSmall,
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Column(
                    children: [
                      // CustomGrideWidget(
                      //   column: 4,
                      //   widgets: viewModel.categories.entries
                      //       .take(12) // Take only the first 12 items
                      //       .map(
                      //         (e) => Padding(
                      //           padding:
                      //               const EdgeInsets.only(right: smallSize),
                      //           child: CustomeCardWidget(
                      //             isCategory: true,
                      //             onTap: () {
                      //               // Navigate to subcategory view for the selected category
                      //               viewModel.navigateToSubCategory(e.key);
                      //             },
                      //             title: e.value.name ??
                      //                 '', // Display category name
                      //           ),
                      //         ),
                      //       )
                      //       .toList(),
                      // ),
                      CustomGrideWidget(
                        column: 4,
                        widgets: viewModel.categories.entries
                            .take(12) // Take only the first 12 items
                            .map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.only(right: smallSize),
                                child: CircularCardWidget(
                                  title: e.value.name ??
                                      '', // Display category name
                                  image:
                                      'assets/images/category.jpg', // Replace with actual image if available
                                  onTap: () {
                                    // Navigate to subcategory view for the selected category
                                    viewModel.navigateToSubCategory(e.key);
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),

                      verticalSpaceMedium,
                      CustomeGrideWidget(
                        widgets: viewModel.products.entries
                            .map(
                              (e) => CustomeCardWidget(
                                size: screenWidth(context) * .38,
                                onTap: () => viewModel.onItemSelected(e.value),
                                title: e.value.productName ?? '',
                                details: e.value.details ?? [],
                                detailLimit: 3,
                                image: e.value.productImage?.first ?? '',
                                widget: Text(
                                  '${e.value.salesPrice} ETB',
                                  style: AppTextStyle.h4Bold,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      verticalSpaceLarge,
                    ],
                  ),
                ),
              ),
            ),
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
