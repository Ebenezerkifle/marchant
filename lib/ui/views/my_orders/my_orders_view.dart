import 'package:flutter/material.dart';
import 'package:marchant/ui/common/app_text_style.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/widgets/custome_app_bar.dart';
import 'package:marchant/ui/views/widgets/custome_list_tile.dart';
import 'package:marchant/ui/views/widgets/nothing_found.dart';
import 'package:stacked/stacked.dart';

import 'my_orders_viewmodel.dart';

class MyOrdersView extends StackedView<MyOrdersViewModel> {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MyOrdersViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            CustomeAppBar(title: 'My Orders'),
            verticalSpaceMiddle,
            viewModel.activeOrders.isEmpty
                ? const NothingFound()
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            children: viewModel.activeOrders.entries.map((e) {
                              Map<String, dynamic> mergedData =
                                  viewModel.getTitle(e.value.cartList);
                              String title = mergedData['title'];
                              List<String> images = mergedData['images'];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: middleSize,
                                  vertical: smallSize,
                                ),
                                child: CustomeListTile(
                                  title: title,
                                  onTap: () => viewModel.onOrderTap(e.value),
                                  imageUrl: images,
                                  noPrice: false,
                                  price: e.value.totalPrice ?? 0,
                                  widget: Text(
                                    '${e.value.count} Products',
                                    style: AppTextStyle.h4Bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  @override
  MyOrdersViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MyOrdersViewModel();
}
