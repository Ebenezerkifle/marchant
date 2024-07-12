import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/fading_circle.dart';
import 'package:marchant/ui/views/widgets/nothing_found.dart';
import 'package:marchant/ui/views/widgets/search_widget.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_text_style.dart';
import '../../widgets/custome_card_widget.dart';
import '../../widgets/custome_grid_widget.dart';
import 'manu_home_viewmodel.dart';

class ManuHomeView extends StackedView<ManuHomeViewModel> {
  const ManuHomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ManuHomeViewModel viewModel,
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
              title: 'Bale Suk',
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
                searchController: viewModel.searchController,
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
                child: viewModel.isBusy
                    ? SizedBox(
                        height: screenHeight(context) * .4,
                        width: double.infinity,
                        child: const Center(child: spinkit),
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
                        : viewModel.products.isNotEmpty
                            ? SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: middleSize),
                                  child: Column(
                                    children: [
                                      verticalSpaceMiddle,
                                      // Our Products Section Title
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('Your Products',
                                              style: AppTextStyle.h2Bold),
                                        ],
                                      ),
                                      verticalSpaceTiny,
                                      CustomeGrideWidget(
                                        widgets: viewModel.filterQuery !=
                                                    null &&
                                                viewModel
                                                    .filterQuery!.isNotEmpty
                                            ? viewModel.filteredProducts.entries
                                                .map(
                                                  (e) => CustomeCardWidget(
                                                    size: screenWidth(context) *
                                                        .38,
                                                    onTap: () => viewModel
                                                        .onItemSelected(
                                                            e.value),
                                                    title:
                                                        e.value.productName ??
                                                            '',
                                                    details:
                                                        e.value.details ?? [],
                                                    detailLimit: 3,
                                                    // image: e.value.productImage
                                                    //     .first,
                                                    image: e.value.productImage
                                                            .isNotEmpty
                                                        ? e.value.productImage
                                                            .first
                                                        : 'assets/images/category.jpg',
                                                    widget: Text(
                                                      '${e.value.salesPrice} ETB',
                                                      style:
                                                          AppTextStyle.h4Bold,
                                                    ),
                                                    status:
                                                        e.value.status ?? '',
                                                  ),
                                                )
                                                .toList()
                                            : viewModel.products.entries
                                                .map(
                                                  (e) => CustomeCardWidget(
                                                    size: screenWidth(context) *
                                                        .38,
                                                    onTap: () => viewModel
                                                        .onItemSelected(
                                                            e.value),
                                                    title:
                                                        e.value.productName ??
                                                            '',
                                                    details:
                                                        e.value.details ?? [],
                                                    detailLimit: 3,
                                                    // image: e.value.productImage
                                                    //     .first,
                                                    image: e.value.productImage
                                                            .isNotEmpty
                                                        ? e.value.productImage
                                                            .first
                                                        : 'assets/images/category.jpg', // default image

                                                    widget: Text(
                                                      '${e.value.salesPrice} ETB',
                                                      style:
                                                          AppTextStyle.h4Bold,
                                                    ),
                                                    status:
                                                        e.value.status ?? '',
                                                  ),
                                                )
                                                .toList(),
                                      ),
                                      verticalSpaceLarge,
                                    ],
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NothingFound(
                                    message:
                                        'You have no product which is live.',
                                    child: CustomeButton(
                                      text: 'Post Product',
                                      onTap: viewModel.onPostProduct,
                                    ),
                                  ),
                                ],
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ManuHomeViewModel viewModelBuilder(BuildContext context) =>
      ManuHomeViewModel();
}
