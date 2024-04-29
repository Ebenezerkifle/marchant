import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/custome_list_tile.dart';
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: middleSize),
                child: Column(
                    children: viewModel.cartItems.values
                        .map(
                          (value) => Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: smallSize),
                            child: CustomeListTile(
                              title: value.title ?? '',
                              imageUrl: (value.images != null &&
                                      value.images!.isNotEmpty)
                                  ? value.images!.first
                                  : '',
                              price: value.price ?? 0,
                              noPrice: false,
                              onTap: () {},
                            ),
                          ),
                        )
                        .toList()),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 150,
          width: screenWidth(context),
          padding: const EdgeInsets.symmetric(
            vertical: middleSize,
            horizontal: middleSize,
          ),
          child: Column(
            children: [
              const Text(
                'Details',
                style: AppTextStyle.h3Bold,
              ),
              const Divider(),
              _details('Total Price', '${viewModel.totalPrice} ETB'),
              _details('Item Count', '200'),
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
          style: AppTextStyle.h4Normal,
        ),
        Text(
          value,
          style: AppTextStyle.big,
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
