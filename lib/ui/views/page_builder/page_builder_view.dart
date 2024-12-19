import 'package:flutter/material.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';
import 'package:stacked/stacked.dart';
import 'page_builder_viewmodel.dart';

class PageBuilderView extends StackedView<PageBuilderViewModel> {
  const PageBuilderView({required this.product, Key? key}) : super(key: key);
  final ProductModel product;

  @override
  Widget builder(
    BuildContext context,
    PageBuilderViewModel viewModel,
    Widget? child,
  ) {
    return SizedBox(
      height: screenWidth(context) * .7,
      child: Stack(
        children: [
          PageView.builder(
            controller: viewModel.pageController,
            itemCount: product.productImage.length,
            onPageChanged: viewModel.onPageChanged,
            itemBuilder: (context, index) {
              return ImageBuilder(
                image: product.productImage[index],
                height: screenWidth(context) * .7,
                width: double.infinity,
                fit: BoxFit.contain,
              );
            },
          ),
          if (viewModel.currentPage > 0)
            Positioned(
              left: 10.0,
              top: screenWidth(context) * .35 - 20, // Vertically centered
              child: GestureDetector(
                onTap: viewModel.goToPreviousPage,
                child: Icon(
                  Icons.arrow_back_ios,
                  color:
                      kcPrimaryColor.withOpacity(0.85), // Slightly transparent
                  size: 40,
                ),
              ),
            ),
          if (viewModel.currentPage < product.productImage.length - 1)
            Positioned(
              right: 10.0,
              top: screenWidth(context) * .35 - 20, // Vertically centered
              child: GestureDetector(
                onTap: viewModel.goToNextPage,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color:
                      kcPrimaryColor.withOpacity(0.85), // Slightly transparent
                  size: 40,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  PageBuilderViewModel viewModelBuilder(BuildContext context) =>
      PageBuilderViewModel();
}
