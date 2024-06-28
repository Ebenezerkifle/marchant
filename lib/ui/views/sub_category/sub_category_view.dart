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
  const SubCategoryView(
      {Key? key,
      required this.categoryValue,
      required this.subSubCategoryValue})
      : super(key: key);

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
                        // Show progress indicator during refresh
                        viewModel.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : viewModel.categories.isEmpty
                                ? SizedBox(
                                    height: screenHeight(context) * .3,
                                    width: double.infinity,
                                    child: const Center(
                                      child: Text(
                                        'No subcategories found',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
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
                                                          const EdgeInsets.only(
                                                              right: smallSize),
                                                      child: CategoryWidget(
                                                        name: e.name ?? '',
                                                        selected: viewModel
                                                                .selected
                                                                .containsKey(
                                                                    e.id) &&
                                                            viewModel.selected[
                                                                e.id]!,
                                                        onTap: () {
                                                          viewModel
                                                              .toggleSelection(
                                                                  e.id ?? '');
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
                                          if (viewModel.hasMoreSubCategories)
                                            CategoryWidget(
                                              name: 'more',
                                              selected: false,
                                              onTap: viewModel.onMoreCategory,
                                              roundness: 5,
                                              hPadding: smallSize,
                                              icon: const Icon(
                                                FontAwesomeIcons
                                                    .ellipsisVertical,
                                                color: kcWhite,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                        verticalSpaceMedium,
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Our Products', style: AppTextStyle.h2Bold),
                          ],
                        ),
                        viewModel.isBusy
                            ? SizedBox(
                                height: screenHeight(context) * .4,
                                width: double.infinity,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              )
                            : viewModel.subProducts.isEmpty && !viewModel.isBusy
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
                                            size: screenWidth(context) * .38,
                                            onTap: () => viewModel
                                                .onItemSelected(e.value),
                                            title: e.value.productName ?? '',
                                            details: e.value.details ?? [],
                                            detailLimit: 3,
                                            image: e.value.productImage.first,
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
