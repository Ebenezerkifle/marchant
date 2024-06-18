import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
import 'package:marchant/ui/views/widgets/custome_circular_card_widget.dart';

import 'package:stacked/stacked.dart';

import 'sub_category_viewmodel.dart';

class SubCategoryView extends StackedView<SubCategoryViewModel> {
  const SubCategoryView({Key? key, required this.categoryValue})
      : super(key: key);

  final String categoryValue;

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
            // if (viewModel.isBusy)
            //   Center(child: CircularProgressIndicator())
            // else if (viewModel.subCategories.isEmpty)
            //   Center(
            //       child: Text(
            //           'No subcategories available for category: $categoryValue'))
            // else
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Column(
                    children: [
                      CustomGrideWidget(
                        column: 4,
                        widgets: viewModel.subCategories
                            .map(
                              (subCategory) => Padding(
                                padding:
                                    const EdgeInsets.only(right: smallSize),
                                // child: CustomeCardWidget(
                                //   isCategory: true,
                                //   onTap: () => viewModel.getSubProducts(
                                //       category: subCategory.id ?? ''),
                                //   title: subCategory.name ??
                                //       '', // Display subcategory name
                                // ),
                                child: CircularCardWidget(
                                  // isCategory: true,
                                  onTap: () => viewModel.getSubProducts(
                                      category: subCategory.id ?? ''),
                                  // title: subCategory.name ??'', // Display subcategory name
                                  title: truncateTitle(subCategory.name ?? ''),
                                  image:
                                      'assets/images/category.jpg', // Replace with actual image if available
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      verticalSpaceMedium,
                      CustomeGrideWidget(
                        widgets: viewModel.subProducts.entries
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
  SubCategoryViewModel viewModelBuilder(BuildContext context) =>
      SubCategoryViewModel(categoryId: categoryValue);
}

String truncateTitle(String title, {int charLimit = 6}) {
  if (title.length <= charLimit) return title;
  return '${title.substring(0, charLimit)}...';
}
