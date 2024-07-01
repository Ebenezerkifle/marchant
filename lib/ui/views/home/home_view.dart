import 'package:flutter/material.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
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
              onPhoneIconTap: viewModel.makePhoneCall,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Categories Section
                      viewModel.isBusy
                          ? SizedBox(
                              height: screenHeight(context) * .3,
                              width: double.infinity,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : viewModel.errorMessage != null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        viewModel.errorMessage!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      CustomeButton(
                                        text: 'Retry',
                                        onTap: viewModel.refresh,
                                      ),
                                    ],
                                  ),
                                )
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: smallSize,
                                    crossAxisSpacing: smallSize,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: viewModel.categories.length > 11
                                      ? 12
                                      : viewModel.categories.length,
                                  itemBuilder: (context, index) {
                                    if (index == 11) {
                                      // "More" button with circular shape
                                      return InkWell(
                                        child: CircularCardWidget(
                                          title: 'More',
                                          icon: viewModel.moreIcon,
                                          onTap: viewModel.onMoreCategory,
                                        ),
                                      );
                                    }
                                    return CircularCardWidget(
                                      title: viewModel.categories.entries
                                              .elementAt(index)
                                              .value
                                              .name ??
                                          '',
                                      image: viewModel.categories.entries
                                              .elementAt(index)
                                              .value
                                              .image ??
                                          'assets/images/category.jpg',
                                      onTap: () =>
                                          viewModel.navigateToSubCategory(
                                              viewModel.categories.entries
                                                  .elementAt(index)
                                                  .key),
                                    );
                                  },
                                ),
                      verticalSpaceMedium,
                      // Our Products Section Title
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Our Products', style: AppTextStyle.h2Bold),
                        ],
                      ),
                      // viewModel.isBusy

                      // ? SizedBox(
                      //     height: screenHeight(context) * .4,
                      //     width: double.infinity,
                      //     child: const Center(
                      //       child: CircularProgressIndicator(),
                      //     ),
                      //   )

                      // //  viewModel.isLoading
                      // //   ? SizedBox(
                      // //       height: screenHeight(context) * .4,
                      // //       width: double.infinity,
                      // //       child: const Center(
                      // //           child: CircularProgressIndicator()),
                      // //     )
                      // //   : viewModel.products.isEmpty && !viewModel.isLoading
                      // //       ? SizedBox(
                      // //           height: screenHeight(context) * .4,
                      // //           width: double.infinity,
                      // //           child: const Center(
                      // //             child: Text(
                      // //               'No products found',
                      // //               style: TextStyle(
                      // //                 fontSize: 18,
                      // //                 color: Colors.grey,
                      // //               ),
                      // //             ),
                      // //           ),
                      // //         )

                      viewModel.isBusy
                          ? SizedBox(
                              height: screenHeight(context) * .3,
                              width: double.infinity,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : viewModel.errorMessage != null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
