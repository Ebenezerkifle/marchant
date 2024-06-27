import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';
import 'package:stacked/stacked.dart';

import 'product_detail_viewmodel.dart';

class ProductDetailView extends StackedView<ProductDetailViewModel> {
  const ProductDetailView({super.key, required this.product});
  final ProductModel product;

  @override
  Widget builder(
    BuildContext context,
    ProductDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(title: 'Product detail'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: middleSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceMiddle,
                      ImageBuilder(
                        image: product.productImage.first,
                        height: screenWidth(context) * .7,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      verticalSpaceMiddle,
                      Text(
                        product.productName ?? '',
                        style: AppTextStyle.big,
                      ),
                      verticalSpaceSmall,
                      Text(
                        product.description ?? '',
                        style: AppTextStyle.h4Normal,
                        textAlign: TextAlign.justify,
                      ),
                      verticalSpaceMiddle,
                      const Text('More Details', style: AppTextStyle.h2Bold),
                      verticalSpaceSmall,
                      if (product.description != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: product.details!
                              .map(
                                (e) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: smallSize),
                                  child: Row(
                                    children: [
                                      horizontalSpaceSmall,
                                      Container(
                                        height: tinySize,
                                        width: tinySize,
                                        decoration: const BoxDecoration(
                                          color: kcDarkGreyColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      horizontalSpaceSmall,
                                      Flexible(
                                        child: Text(
                                          e,
                                          style: AppTextStyle.h3Normal,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      verticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Manufacturer: ',
                            style: AppTextStyle.h2Bold,
                          ),
                          Flexible(
                            child: Text(
                              product.companyName ?? 'Unknown Provider',
                              style: AppTextStyle.h4Normal,
                            ),
                          ),
                          TextButton(
                            onPressed: () => viewModel.onPressed(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'See More',
                                  style: AppTextStyle.h4Bold,
                                ),
                                horizontalSpaceTiny,
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: middleSize,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceMedium,
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding:
                            const EdgeInsets.symmetric(vertical: middleSize),
                        decoration: BoxDecoration(
                          color: kcLightGrey.withOpacity(.3),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Total Price',
                              style: AppTextStyle.h4Normal,
                            ),
                            Text(
                              '${product.salesPrice} ETB',
                              style: AppTextStyle.withColor(
                                color: kcPrimaryColor,
                                style: AppTextStyle.big,
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceLarge,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: smallSize,
          horizontal: smallSize,
        ),
        child: CustomeButton(
          text: 'Add to Cart',
          onTap: viewModel.onAddToCart,
          loading: viewModel.isBusy,
          icon: const Padding(
            padding: EdgeInsets.only(left: smallSize),
            child: Icon(
              FontAwesomeIcons.cartArrowDown,
              color: kcWhite,
            ),
          ),
        ),
      ),
    );
  }

  @override
  ProductDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProductDetailViewModel(product: product);
}
