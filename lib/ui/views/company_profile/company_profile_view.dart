import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_card_widget.dart';
import 'package:marchant/ui/views/widgets/custome_grid_widget.dart';
import 'package:stacked/stacked.dart';
import './company_profile_viewmodel.dart';
import 'package:marchant/models/product_model.dart';

class CompanyProfileView extends StackedView<CompanyProfileViewModel> {
  const CompanyProfileView({super.key, required this.product});
  final ProductModel product;

  @override
  Widget builder(
    BuildContext context,
    CompanyProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      key: viewModel.scaffoldKey,
      backgroundColor: kcWhite,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: middleSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomeAppBar(title: 'Company Profile'),
                verticalSpaceMedium,
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      product.logoImage ??
                          'https://via.placeholder.com/100', // Placeholder image
                    ),
                  ),
                ),
                const SizedBox(height: mediumSize),
                Center(
                  child: Text(
                    product.companyName ?? "Unknown Company",
                    style: AppTextStyle.h1Bold,
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSpaceSmall,
                Center(
                  child: Text(
                    'TIN: ${product.TIN}',
                    style: AppTextStyle.h4Bold,
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSpaceLarge,
                const Text(
                  'Products:',
                  style: AppTextStyle.h2Bold,
                ),
                const Divider(thickness: 2),
                verticalSpaceMedium,
                CustomeGrideWidget(
                  widgets: viewModel.products.entries
                      .map(
                        (e) => CustomeCardWidget(
                          size: screenWidth(context) * .38,
                          onTap: () =>viewModel.onItemSelected(e.value),
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
                const SizedBox(height: largeSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  CompanyProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CompanyProfileViewModel();
}
