import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
import 'package:marchant/ui/views/widgets/custome_circular_card_widget.dart';
import 'package:marchant/ui/views/widgets/search_widget.dart';

import 'home_viewmodel.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomeAppBar(
              title: 'Merchant',
              back: false,
              phoneIcon: Icons.phone,
              phoneNumber: '889',
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
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Column(
                    children: [
                      // Categories Section
                      viewModel.categories.isEmpty
                          ? SizedBox(
                              height: screenHeight(context) * .3,
                              width: double.infinity,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Wrap(
                              spacing: smallSize,
                              runSpacing: smallSize,
                              children: [
                                // Display the first 11 category cards
                                 for (var i = 0; i < 11 && i < viewModel.categories.length; i++)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: smallSize),
                                    child: CircularCardWidget(
                                      title: truncateTitle(viewModel
                                              .categories.entries
                                              .elementAt(i)
                                              .value
                                              .name ??
                                          ''),
                                      image: viewModel.categories.entries.elementAt(i).value.image??
                                       'assets/images/category.jpg',
                                      onTap: () =>
                                          viewModel.navigateToSubCategory(
                                              viewModel.categories.entries
                                                  .elementAt(i)
                                                  .key),
                                    ),
                                  ),

                                // "More" button with circular shape
                                if (viewModel.categories.length > 11)
                                  InkWell(
                                    child: CircularCardWidget(
                                        title: 'More',
                                        icon: viewModel.moreIcon,
                                        onTap: viewModel.onMoreCategory),
                                  ),
                              ],
                            ),

                      verticalSpaceMedium,

                      // Our Products Section Title
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Our Products', style: AppTextStyle.h2Bold),
                        ],
                      ),

                      viewModel.products.isEmpty
                          ? SizedBox(
                              height: screenHeight(context) * .4,
                              width: double.infinity,
                              child: const Center(
                                child: CircularProgressIndicator(),
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
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

String truncateTitle(String title, {int charLimit = 8}) {
  if (title.length <= charLimit) return title;
  return '${title.substring(0, charLimit)}...';
}
