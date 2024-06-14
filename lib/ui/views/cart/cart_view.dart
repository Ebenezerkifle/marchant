import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marchant/models/cart_model.dart';
import 'package:marchant/models/order_model.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/custome_list_tile.dart';
import 'package:marchant/ui/views/widgets/multiple_buttons_widget.dart';
import 'package:marchant/ui/views/widgets/nothing_found.dart';
import 'package:marchant/ui/widgets/cart_calculator/cart_calculator.dart';
import 'package:stacked/stacked.dart';

import 'cart_viewmodel.dart';

class CartView extends StackedView<CartViewModel> {
  const CartView({Key? key, this.order}) : super(key: key);
  final OrderModel? order;

  @override
  Widget builder(
    BuildContext context,
    CartViewModel viewModel,
    Widget? child,
  ) {
    List<CartModel> items = order != null
        ? order?.cartList ?? []
        : viewModel.cartItems.values.toList();

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(
              title: order != null ? 'Order details' : 'Cart details',
              back: order != null,
            ),
            Expanded(
              child: order == null && viewModel.cartItems.isEmpty
                  ? const Column(
                      children: [
                        verticalSpaceLarge,
                        NothingFound(message: 'Nothing found on your cart!'),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: middleSize),
                              child: Column(
                                children: [
                                  verticalSpaceMiddle,
                                  Column(
                                      children: items
                                          .map((value) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: smallSize),
                                              child: CustomeListTile(
                                                  title: value.product!.productName ??
                                                      '',
                                                  description: value
                                                      .product?.description,
                                                  imageUrl: [
                                                    viewModel.getImage(value),
                                                  ],
                                                  price: value.totalPrice ?? 0,
                                                  widget: order != null
                                                      ? Text(
                                                          '${value.count} Items',
                                                          style: AppTextStyle
                                                              .h4Bold)
                                                      : Container(),
                                                  noPrice: false,
                                                  onTap: () {},
                                                  stackWidget: order != null
                                                      ? null
                                                      : Positioned(
                                                          top: tinySize,
                                                          right: tinySize,
                                                          child:
                                                              GestureDetector(
                                                                  onTap: () => viewModel
                                                                      .onRemove(
                                                                          value.id ??
                                                                              ""),
                                                                  child:
                                                                      const Icon(
                                                                    FontAwesomeIcons
                                                                        .circleXmark,
                                                                    color:
                                                                        kcPrimaryColorDark,
                                                                  ))),
                                                  engagingWidget: order != null
                                                      ? null
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top:
                                                                      smallSize),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                    '${value.count} Items',
                                                                    style: AppTextStyle
                                                                        .thinSmall),
                                                                CartCalculator(
                                                                    initialCount: value
                                                                        .count
                                                                        .toString(),
                                                                    onChange: (count) => viewModel.onChange(
                                                                        count ??
                                                                            '1',
                                                                        value.id ??
                                                                            ''))
                                                              ])))))
                                          .toList()),
                                  verticalSpaceLarge,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: middleSize,
                            vertical: middleSize,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: screenWidth(context),
                                padding: const EdgeInsets.symmetric(
                                  vertical: middleSize,
                                  horizontal: middleSize,
                                ),
                                decoration: const BoxDecoration(
                                    color: kcDarkGreyColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Column(
                                  children: [
                                    Text('Details',
                                        style: AppTextStyle.withColor(
                                          color: kcWhite,
                                          style: AppTextStyle.h3Bold,
                                        )),
                                    const Divider(),
                                    _details('Total Price',
                                        '${order != null ? order!.totalPrice : viewModel.totalPrice} ETB'),
                                    _details('Item Count',
                                        '${order != null ? order!.count : viewModel.totalCount}'),
                                  ],
                                ),
                              ),
                              verticalSpaceLarge,
                              order != null
                                  ? Container()
                                  : MultipleButtonsWidget(
                                      buttons: [
                                        CustomeButton(
                                          text: 'Clear Cart',
                                          onTap: viewModel.onClearCart,
                                          textColor: kcDarkGreyColor,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .4,
                                          stroke: true,
                                        ),
                                        CustomeButton(
                                          text: 'Place Order',
                                          onTap: viewModel.onPlaceOrder,
                                          loading: viewModel.isBusy,
                                          iconOnly: viewModel.isBusy,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .4,
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
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
