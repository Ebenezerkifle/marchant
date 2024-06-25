import 'package:flutter/material.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/nothing_found.dart';
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
        body: SafeArea(
      top: true,
      child: Column(
        children: [
          CustomeAppBar(
            title: 'Merchant',
            back: false,
            phoneIcon: Icons.phone,
            phoneNumber: '889',
          ),
          Expanded(
            child: viewModel.products.isNotEmpty
                ? SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: middleSize),
                      child: Column(
                        children: [
                          verticalSpaceMedium,
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: middleSize),
                            child: Text(
                              'your Products',
                              style: AppTextStyle.h1Bold,
                            ),
                          ),
                          CustomeGrideWidget(
                            widgets: viewModel.products.entries
                                .map(
                                  (e) => CustomeCardWidget(
                                    size: screenWidth(context) * .38,
                                    onTap:
                                        () {}, // => viewModel.onItemSelected(e.value),
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
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NothingFound(
                        message: 'You have no product which is live.',
                        child: CustomeButton(
                          text: 'Post Product',
                          onTap: viewModel.onPostProduct,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    ));
  }

  @override
  ManuHomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ManuHomeViewModel();
}
