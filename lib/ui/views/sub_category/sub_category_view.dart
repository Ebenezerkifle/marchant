import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/category_widget.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
import 'package:marchant/ui/views/widgets/fading_circle.dart';

import 'package:stacked/stacked.dart';

import 'sub_category_viewmodel.dart';

class SubCategoryView extends StackedView<SubCategoryViewModel> {
  const SubCategoryView(
      {super.key,
      required this.categoryValue,
      required this.subSubCategoryValue});

  final String categoryValue;
  final String subSubCategoryValue;

  @override
  Widget builder(
    BuildContext context,
    SubCategoryViewModel viewModel,
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
              title: 'Subcategories',
              back: true,
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
                        // Categories Section
                        viewModel.isSubCategoriesBusy
                            ? SizedBox(
                                height: screenHeight(context) * .3,
                                width: double.infinity,
                                child: const Center(
                                  child: spinkit,
                                ),
                              )
                            : viewModel.categoryErrorMessage != null
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          viewModel.errorMessage!,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.red,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        CustomeButton(
                                          text: 'Retry',
                                          onTap: viewModel.refresh,
                                        ),
                                      ],
                                    ),
                                  )
                                : viewModel.subCategories.isNotEmpty
                                    ? SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: middleSize),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: viewModel
                                                    .getLimitedSubCategories()
                                                    .map((e) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right:
                                                                      smallSize),
                                                          child: CategoryWidget(
                                                            name: e.name ?? '',
                                                            selected: viewModel
                                                                    .selected
                                                                    .containsKey(
                                                                        e.id) &&
                                                                viewModel
                                                                        .selected[
                                                                    e.id]!,
                                                            onTap: () {
                                                              viewModel
                                                                  .toggleSelection(
                                                                      e.id ??
                                                                          '');
                                                              viewModel
                                                                  .getSubProducts(
                                                                      category:
                                                                          e.id ??
                                                                              '');
                                                            },
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                              if (viewModel
                                                  .hasMoreSubCategories)
                                                MoreButtonCategoryWidget(
                                                  name: 'more',
                                                  selected: false,
                                                  onTap:
                                                      viewModel.onMoreCategory,
                                                  roundness: 5,
                                                  hPadding: smallSize,
                                                  icon: const Icon(
                                                    FontAwesomeIcons
                                                        .ellipsisVertical,
                                                    color: kcPrimaryColor,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                            "No Sub Categories avaliable")),
                        verticalSpaceMedium,
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Our Products', style: AppTextStyle.h2Bold),
                          ],
                        ),
                        viewModel.isProductsBusy
                            ? SizedBox(
                                height: screenHeight(context) * .4,
                                width: double.infinity,
                                child: const Center(child: spinkit),
                              )
                            : viewModel.productErrorMessage != null
                                ? SizedBox(
                                    height: screenHeight(context) * .4,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            viewModel.productErrorMessage!,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.red,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          CustomeButton(
                                            text: 'Retry',
                                            onTap: viewModel.subProductRefresh,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : viewModel.subProducts.isEmpty
                                    ? SizedBox(
                                        height: screenHeight(context) * .4,
                                        width: double.infinity,
                                        child: const Center(
                                          child: Text(
                                            'No products found',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      )
                                    : CustomeGrideWidget(
                                        widgets: viewModel.subProducts.entries
                                            .map(
                                              (e) => CustomeCardWidget(
                                                size:
                                                    screenWidth(context) * .38,
                                                onTap: () => viewModel
                                                    .onItemSelected(e.value),
                                                title:
                                                    e.value.productName ?? '',
                                                // details: e.value.details ?? [],
                                                // detailLimit: 3,
                                                // image: e.value.productImage.first,
                                                image: e.value.productImage
                                                        .isNotEmpty
                                                    ? e.value.productImage.first
                                                    : 'assets/images/category.jpg',
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
          ],
        ),
      ),
    );
  }

  @override
  SubCategoryViewModel viewModelBuilder(BuildContext context) =>
      SubCategoryViewModel(
          categoryId: categoryValue, subSubCategoryId: subSubCategoryValue);
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:marchant/ui/common/app_colors.dart';
// import 'package:marchant/ui/common/app_text_style.dart';
// import 'package:marchant/ui/common/ui_helpers.dart';
// import 'package:marchant/ui/views/widgets/category_widget.dart';
// import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
// import 'package:marchant/ui/views/widgets/custome_button.dart';
// import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
// import 'package:marchant/ui/views/widgets/custome_circular_card_widget.dart';
// import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
// import 'package:marchant/ui/views/widgets/fading_circle.dart';

// import 'package:stacked/stacked.dart';

// import 'sub_category_viewmodel.dart';

// class SubCategoryView extends StackedView<SubCategoryViewModel> {
//   const SubCategoryView(
//       {Key? key,
//       required this.categoryValue,
//       required this.subSubCategoryValue})
//       : super(key: key);

//   final String categoryValue;
//   final String subSubCategoryValue;

//   @override
//   Widget builder(
//     BuildContext context,
//     SubCategoryViewModel viewModel,
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
//               title: 'Subcategories',
//               back: true,
//             ),
//             verticalSpaceSmall,
//             Expanded(
//               child: RefreshIndicator(
//                 key: viewModel.refreshIndicatorKey,
//                 displacement: 50,
//                 color: Colors.white,
//                 backgroundColor: kcPrimaryColor,
//                 onRefresh: viewModel.refresh,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: middleSize),
//                     child: Column(
//                       children: [
//                         // Categories Section
//                         viewModel.isSubCategoriesBusy
//                             ? SizedBox(
//                                 height: screenHeight(context) * .3,
//                                 width: double.infinity,
//                                 child: const Center(
//                                   child: spinkit,
//                                 ),
//                               )
//                             : viewModel.categoryErrorMessage != null
//                                 ? Center(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           viewModel.categoryErrorMessage!,
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                             color: Colors.red,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 20),
//                                         CustomeButton(
//                                           text: 'Retry',
//                                           onTap: viewModel.refresh,
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 : viewModel.subCategories.isNotEmpty
//                                     ? GridView.builder(
//                                         gridDelegate:
//                                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisCount:
//                                               4, // Number of columns in the grid
//                                           crossAxisSpacing:
//                                               10.0, // Space between columns
//                                           mainAxisSpacing:
//                                               10.0, // Space between rows
//                                           childAspectRatio:
//                                               1.0, // Aspect ratio of each item
//                                         ),
//                                         itemCount:
//                                             viewModel.subCategories.length > 3
//                                                 ? 4
//                                                 : viewModel
//                                                     .subCategories.length,
//                                         itemBuilder: (context, index) {
//                                           if (index == 3) {
//                                             // "More" button with circular shape
//                                             return InkWell(
//                                               onTap: viewModel.onMoreCategory,
//                                               child: CircularCardWidget(
//                                                 title: 'More',
//                                                 icon: FontAwesomeIcons
//                                                     .ellipsisVertical,

//                                                 onTap: viewModel.onMoreCategory,
//                                               ),
//                                             );
//                                           }
//                                           return CircularCardWidget(
//                                             title: viewModel
//                                                     .subCategories[index]
//                                                     .name ??
//                                                 '',
//                                             image: viewModel
//                                                     .subCategories[index]
//                                                     .image ??
//                                                 'assets/images/category.jpg',
//                                             onTap: () {
//                                               viewModel.toggleSelection(
//                                                   viewModel.subCategories[index]
//                                                           .id ??
//                                                       '');
//                                               viewModel.getSubProducts(
//                                                   category: viewModel
//                                                           .subCategories[index]
//                                                           .id ??
//                                                       '');
//                                             },
//                                           );
//                                         },
//                                       )
//                                     : const Center(
//                                         child: Text(
//                                             "No Sub Categories available")),
//                         verticalSpaceMedium,
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text('Our Products', style: AppTextStyle.h2Bold),
//                           ],
//                         ),
//                         viewModel.isProductsBusy
//                             ? SizedBox(
//                                 height: screenHeight(context) * .4,
//                                 width: double.infinity,
//                                 child: const Center(child: spinkit),
//                               )
//                             : viewModel.productErrorMessage != null
//                                 ? SizedBox(
//                                     height: screenHeight(context) * .4,
//                                     child: Center(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             viewModel.productErrorMessage!,
//                                             style: const TextStyle(
//                                               fontSize: 18,
//                                               color: Colors.red,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 20),
//                                           CustomeButton(
//                                             text: 'Retry',
//                                             onTap: viewModel.subProductRefresh,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 : viewModel.subProducts.isEmpty
//                                     ? SizedBox(
//                                         height: screenHeight(context) * .4,
//                                         width: double.infinity,
//                                         child: const Center(
//                                           child: Text(
//                                             'No products found',
//                                             style: TextStyle(
//                                               fontSize: 18,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     : CustomeGrideWidget(
//                                         widgets: viewModel.subProducts.entries
//                                             .map(
//                                               (e) => CustomeCardWidget(
//                                                 size:
//                                                     screenWidth(context) * .38,
//                                                 onTap: () => viewModel
//                                                     .onItemSelected(e.value),
//                                                 title:
//                                                     e.value.productName ?? '',
//                                                 details: e.value.details ?? [],
//                                                 detailLimit: 3,
//                                                 image: e.value.productImage
//                                                         .isNotEmpty
//                                                     ? e.value.productImage.first
//                                                     : 'assets/images/category.jpg',
//                                                 widget: Text(
//                                                   '${e.value.salesPrice} ETB',
//                                                   style: AppTextStyle.h4Bold,
//                                                 ),
//                                               ),
//                                             )
//                                             .toList(),
//                                       ),
//                         verticalSpaceLarge,
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   SubCategoryViewModel viewModelBuilder(BuildContext context) =>
//       SubCategoryViewModel(
//           categoryId: categoryValue, subSubCategoryId: subSubCategoryValue);
// }
