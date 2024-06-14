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
  const CompanyProfileView({Key? key, required this.product}) : super(key: key);
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
          child: Column(
            children: [
              CustomeAppBar(title: 'CompanyProfile'),
              Text(
                product.manufacturerId ?? "Unkown Company",
                style: AppTextStyle.h1Bold,
              ),
              const SizedBox(height: mediumSize),
              const Text(
                'License Number: ABC12345',
                style: AppTextStyle.h4Bold,
              ),
              const SizedBox(height: largeSize),
              const Text(
                'Products:',
                style: AppTextStyle.h2Bold,
              ),
              const SizedBox(height: mediumSize),
              verticalSpaceMedium,
              CustomeGrideWidget(
                widgets: viewModel.products.entries
                    .map(
                      (e) => CustomeCardWidget(
                        size: screenWidth(context) * .38,
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
    );
  }

  @override
  CompanyProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CompanyProfileViewModel();
}
