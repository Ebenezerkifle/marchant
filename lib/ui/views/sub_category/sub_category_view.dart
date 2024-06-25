import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/category_widget.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';

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
                        viewModel.categories.isEmpty
                            ? SizedBox(
                                height: screenHeight(context) * .3,
                                width: double.infinity,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            // Horizontal scroll for subcategories
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: middleSize),
                                  child: Row(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: viewModel
                                            .getLimitedSubCategories()
                                            .map((e) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: smallSize),
                                                  child: CategoryWidget(
                                                    name: e.name ?? '',
                                                    selected: viewModel.selected
                                                            .containsKey(
                                                                e.id) &&
                                                        viewModel
                                                            .selected[e.id]!,
                                                    onTap: () {
                                                      viewModel.toggleSelection(
                                                          e.id ?? '');
                                                      viewModel.getSubProducts(
                                                          category: e.id ?? '');
                                                    },
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                      if (viewModel.hasMoreSubCategories)
                                        CategoryWidget(
                                          name: 'more',
                                          selected: false,
                                          onTap: viewModel.onMoreCategory,
                                          roundness: 5,
                                          hPadding: smallSize,
                                          icon: const Icon(
                                            FontAwesomeIcons.ellipsisVertical,
                                            color: kcWhite,
                                          ),
                                        ),
                                      horizontalSpaceMiddle,
                                    ],
                                  ),
                                ),
                              ),
                        verticalSpaceMedium,
                        // Our Products Section Title
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Our Products', style: AppTextStyle.h2Bold),
                          ],
                        ),

                        viewModel.subProducts.isEmpty
                            ? SizedBox(
                                height: screenHeight(context) * .4,
                                width: double.infinity,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : CustomeGrideWidget(
                                widgets: viewModel.subProducts.entries
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
  SubCategoryViewModel viewModelBuilder(BuildContext context) =>
      SubCategoryViewModel(categoryId: categoryValue);
}

String truncateTitle(String title, {int charLimit = 6}) {
  if (title.length <= charLimit) return title;
  return '${title.substring(0, charLimit)}...';
}
