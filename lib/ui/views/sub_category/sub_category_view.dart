import 'package:flutter/material.dart';
import 'package:marchant/models/category_model.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
// import 'package:marchant/ui/views/widgets/custom_app_bar.dart';
// import 'package:marchant/ui/views/widgets/custom_card_widget.dart';
// import 'package:marchant/ui/views/widgets/custom_grid_widget.dart';
// import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
// import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
// import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
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
                                  child: CustomeCardWidget(
                                    isCategory: true,
                                    onTap: () {
                                      // Implement any subcategory navigation if needed
                                    },
                                    title: subCategory.name??'', // Display subcategory name
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
                                title: e.value.title ?? '',
                                details: e.value.details ?? [],
                                detailLimit: 3,
                                image: e.value.images?.first ?? '',
                                widget: Text(
                                  '${e.value.price} ETB',
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
