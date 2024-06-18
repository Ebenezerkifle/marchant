import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/category_widget.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
import 'package:marchant/ui/views/widgets/custome_circular_card_widget.dart';
import 'package:marchant/ui/views/widgets/search_widget.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

// class HomeView extends StackedView<HomeViewModel> {
//   const HomeView({super.key});

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
//                         widgets: viewModel.categories.entries
//                             .take(12) // Take only the first 12 items
//                             .map(
//                               (e) {
//                                 String truncatedTitle = truncateTitle(e.value.name ?? '');
//                                 // print('Original: ${e.value.name}, Truncated: $truncatedTitle'); // Debug print
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: smallSize),
//                                   child: CircularCardWidget(
//                                     title: truncatedTitle,
//                                     image: 'assets/images/category.jpg', // Replace with actual image if available
//                                     onTap: () {
//                                       // Navigate to subcategory view for the selected category
//                                       viewModel.navigateToSubCategory(e.key);
//                                     },
//                                   ),
//                                 );
//                               },
//                             )
//                             .toList(),
//                       ),

//                       verticalSpaceMedium,
//                       CustomeGrideWidget(
//                         widgets: viewModel.products.entries
//                             .map(
//                               (e) {
//                                 return CustomeCardWidget(
//                                   size: screenWidth(context) * .38,
//                                   onTap: () => viewModel.onItemSelected(e.value),
//                                 title: e.value.productName ?? '',
//                                   details: e.value.details ?? [],
//                                   detailLimit: 3,
//                                   image: e.value.productImage?.first ?? '',
//                                   widget: Text(
//                                     '${e.value.salesPrice} ETB',
//                                     style: AppTextStyle.h4Bold,
//                                   ),
//                                 );
//                               },
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
//   HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
// }

// String truncateTitle(String title, {int charLimit = 8}) {
//   if (title.length <= charLimit) return title;
//   return '${title.substring(0, charLimit)}...';
// }
class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

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
              child: RefreshIndicator(
                key: viewModel.refreshIndicatorKey,
                displacement: 50,
                color: Colors.white,
                backgroundColor: kcPrimaryColor,
                onRefresh: viewModel.refresh,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: middleSize),
                    child: Column(
                      children: [
                        // Horizontal ListView to include CustomGridWidget and CategoryWidget
                        viewModel.categories.isEmpty
                            ? SizedBox(
                                height: screenHeight(context) * .3,
                                width: double.infinity,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    CustomGrideWidget(
                                      column: 4,
                                      row: 3,
                                      widgets: viewModel.categories.entries
                                          .take(
                                              24) // Take only the first 24 items
                                          .map(
                                            (e) => Padding(
                                              padding: const EdgeInsets.only(
                                                  right: smallSize),
                                              child: CircularCardWidget(
                                                title: truncateTitle(
                                                    e.value.name ?? ''),
                                                image:
                                                    'assets/images/category.jpg',
                                                onTap: () => viewModel
                                                    .navigateToSubCategory(
                                                        e.key),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    if (viewModel.categories.length > 24)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: smallSize),
                                        child: CategoryWidget(
                                          name: 'more',
                                          selected: true,
                                          onTap: viewModel.onMoreCategory,
                                          roundness: 5,
                                          hPadding: smallSize,
                                          icon: const Icon(
                                            FontAwesomeIcons.ellipsisVertical,
                                            color: kcWhite,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                        verticalSpaceMedium,
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: middleSize),
                          child:
                              Text('Our Products', style: AppTextStyle.h4Bold),
                        ),
                        viewModel.products.isEmpty
                            ? SizedBox(
                                height: screenHeight(context) * .4,
                                width: double.infinity,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              )
                            : CustomeGrideWidget(
                                widgets: viewModel.products.entries
                                    .map(
                                      (e) => CustomeCardWidget(
                                        size: screenWidth(context) * .38,
                                        onTap: () =>
                                            viewModel.onItemSelected(e.value),
                                        title: e.value.productName ?? '',
                                        details: e.value.details ?? [],
                                        detailLimit: 3,
                                        image:
                                            e.value.productImage?.first ?? '',
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
            ),
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

String truncateTitle(String title, {int charLimit = 8}) {
  if (title.length <= charLimit) return title;
  return '${title.substring(0, charLimit)}...';
}
