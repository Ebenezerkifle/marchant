import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
import 'package:marchant/ui/views/widgets/category_widget.dart';
import 'package:stacked/stacked.dart';

import 'sub_category_viewmodel.dart';

class SubCategoryView extends StackedView<SubCategoryViewModel> {
  const SubCategoryView({Key? key, required this.categoryValue}) : super(key: key);
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
              title: categoryValue,
              back: true,
            ),
            verticalSpaceSmall,
            Padding(
              padding: const EdgeInsets.only(left: middleSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...viewModel.selectedCategoryOnHomepage.entries
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(right: tinySize),
                                  child: CategoryWidget(
                                    key: UniqueKey(),  // Ensure each CategoryWidget has a unique key
                                    name: e.value,
                                    selected: viewModel.selected.containsKey(e.key),
                                    onTap: () => viewModel.onSelected(e.key),
                                  ),
                                )),
                        CategoryWidget(
                          key: UniqueKey(),  // Ensure this widget also has a unique key
                          name: 'more',
                          selected: false,
                          onTap: viewModel.onMoreCategory,
                          roundness: 5,
                          hPadding: smallSize,
                          icon: Icon(FontAwesomeIcons.ellipsisVertical),
                        ),
                        horizontalSpaceMiddle,
                      ],
                    ),
                  ),
                  if (viewModel.selected.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: viewModel
                            .subCategories[viewModel.selected.keys.first]!
                            .map((subCategory) => GestureDetector(
                                  onTap: () {
                                    viewModel.onSubCategorySelected(
                                      viewModel.selected.keys.first,
                                      subCategory,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: tinySize, top: smallSize),
                                    child: CategoryWidget(
                                      key: UniqueKey(),  // Ensure each sub-category widget has a unique key
                                      name: subCategory,
                                      selected: viewModel.selectedSubCategory == subCategory,
                                      onTap: () {},
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
            verticalSpaceMedium,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: middleSize),
                      child: CustomeGrideWidget(
                        widgets: viewModel.products.entries
                            .map(
                              (e) => CustomeCardWidget(
                                key: UniqueKey(),  // Ensure each card widget has a unique key
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
                    ),
                    verticalSpaceLarge,
                  ],
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
  SubCategoryViewModel viewModelBuilder(BuildContext context) => SubCategoryViewModel();
}
