import 'package:flutter/material.dart';
import 'package:marchant/models/product_model.dart';
import 'package:marchant/ui/common/app_colors.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_button.dart';
import 'package:marchant/ui/views/widgets/image_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../widgets/cart_calculator/cart_calculator.dart';
import 'cart_sheet_model.dart';

class CartSheet extends StackedView<CartSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CartSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CartSheetModel viewModel,
    Widget? child,
  ) {
    ProductModel product = request.data ?? ProductModel();
    return SingleChildScrollView(
      child: Container(
        width: screenWidth(context),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              product.title ?? '',
              style: AppTextStyle.h1Bold,
            ),
            verticalSpaceMiddle,
            ImageBuilder(
              image: product.images?.first ?? '',
              height: screenWidth(context) * .5,
              width: screenWidth(context),
            ),
            verticalSpaceMiddle,
            CartCalculator(
              controller: viewModel.controller,
              onChange: (count) => viewModel.onChange(),
            ),
            verticalSpaceMiddle,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total price:',
                  style: AppTextStyle.h3Normal,
                ),
                Text(
                  '${viewModel.totalPrice} ETB',
                  style: AppTextStyle.h2Bold,
                )
              ],
            ),
            verticalSpaceLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomeButton(
                  text: 'Cancel',
                  onTap: () => completer!(
                    SheetResponse(confirmed: false),
                  ),
                  textColor: kcDarkGreyColor,
                  width: MediaQuery.of(context).size.width * .4,
                  stroke: true,
                ),
                CustomeButton(
                  text: 'Add',
                  onTap: () => completer!(
                    SheetResponse(
                      confirmed: true,
                      data: null,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * .4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  CartSheetModel viewModelBuilder(BuildContext context) =>
      CartSheetModel(product: request.data);
}
