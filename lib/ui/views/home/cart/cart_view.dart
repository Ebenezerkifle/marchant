import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_list_tile.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';
import 'package:marchant/ui/widgets/cart_calculator/cart_calculator.dart';
import 'package:stacked/stacked.dart';

import 'cart_viewmodel.dart';

class CartView extends StackedView<CartViewModel> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CartViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              CustomeAppBar(title: 'Cart details'),
              viewModel.cartItems.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          ImageBuilder(
                            image: 'assets/images/empty_cart.png',
                            height: screenWidth(context),
                          ),
                          verticalSpaceSmall,
                          const Text(
                            'Nothing found on your cart!',
                            style: AppTextStyle.h3Normal,
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: middleSize),
                          child: Column(
                            children: [
                              verticalSpaceMiddle,
                              Column(
                                  children: viewModel.cartItems.entries
                                      .map(
                                        (value) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: smallSize),
                                          child: CustomeListTile(
                                            title: value.value.product!.title ??
                                                '',
                                            description: value
                                                .value.product?.description,
                                            imageUrl:
                                                (value.value.product!.images !=
                                                            null &&
                                                        value.value.product!
                                                            .images!.isNotEmpty)
                                                    ? value.value.product!
                                                        .images!.first
                                                    : '',
                                            price: value.value.totalPrice ?? 0,
                                            noPrice: false,
                                            onTap: () {},
                                            stackWidget: Positioned(
                                              top: tinySize,
                                              right: tinySize,
                                              child: GestureDetector(
                                                onTap: () => viewModel
                                                    .onRemove(value.key),
                                                child: const Icon(
                                                  FontAwesomeIcons.circleXmark,
                                                  color: kcPrimaryColorDark,
                                                ),
                                              ),
                                            ),
                                            engagingWidget: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: smallSize),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${value.value.count} Items',
                                                    style:
                                                        AppTextStyle.thinSmall,
                                                  ),
                                                  CartCalculator(
                                                    initialCount: value
                                                        .value.count
                                                        .toString(),
                                                    onChange: (count) =>
                                                        viewModel.onChange(
                                                            count ?? '1',
                                                            value.key),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()),
                              verticalSpaceLarge,
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 150,
          width: screenWidth(context),
          color: kcDarkGreyColor,
          padding: const EdgeInsets.symmetric(
            vertical: middleSize,
            horizontal: middleSize,
          ),
          child: Column(
            children: [
              Text(
                'Details',
                style: AppTextStyle.withColor(
                  color: kcWhite,
                  style: AppTextStyle.h3Bold,
                ),
              ),
              const Divider(),
              _details('Total Price', '${viewModel.totalPrice} ETB'),
              _details('Item Count', '${viewModel.totalCount}'),
            ],
          ),
        ));
  }

  _details(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: AppTextStyle.withColor(
            color: kcWhite,
            style: AppTextStyle.h4Normal,
          ),
        ),
        Text(
          value,
          style: AppTextStyle.withColor(
            color: kcWhite,
            style: AppTextStyle.big,
          ),
        )
      ],
    );
  }

  @override
  CartViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CartViewModel();
}
