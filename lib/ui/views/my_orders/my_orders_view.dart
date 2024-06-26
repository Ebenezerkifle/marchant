import 'package:flutter/material.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/my_orders/my_orders_viewmodel.dart';
import 'package:marchant/ui/views/widgets/custome_order_card.dart';
import 'package:marchant/ui/views/widgets/nothing_found.dart';
import 'package:stacked/stacked.dart';
import 'package:marchant/models/order_model.dart';

import '../../common/app_colors.dart';
import '../../common/app_text_style.dart';
import '../widgets/custome_list_tile.dart';

class MyOrdersView extends StackedView<MyOrdersViewModel> {
  const MyOrdersView({super.key});

  @override
  Widget builder(
    BuildContext context,
    MyOrdersViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Delivered'),
            ],
            onTap: (index) {
              if (index == 1 && viewModel.deliveredOrders.isEmpty) {
                viewModel
                    .getDeliveredOrders(); // Fetch delivered orders when the delivered tab is tapped
              }
            },
          ),
        ),
        body: viewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  viewModel.pendingOrders.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              verticalSpaceLarge,
                              NothingFound(),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          key: viewModel.refreshIndicatorKeyPending,
                          displacement: 50,
                          color: Colors.white,
                          backgroundColor: kcPrimaryColor,
                          onRefresh: viewModel.refresh,
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  viewModel.pendingOrders.entries.map((e) {
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
                                    price: e.value.totalAmount ?? 0,
                                    widget: Text(
                                      '${e.value.products?.first.quantity} Products',
                                      style: AppTextStyle.h4Bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                  viewModel.deliveredOrders.isEmpty
                      ? RefreshIndicator(
                          key: viewModel.refreshIndicatorKeyDelivered,
                          displacement: 50,
                          color: Colors.white,
                          backgroundColor: kcPrimaryColor,
                          onRefresh: viewModel.refresh,
                          child: ListView(
                            children: const [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'No delivered orders yet',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          key: viewModel.refreshIndicatorKeyDelivered,
                          displacement: 50,
                          color: Colors.white,
                          backgroundColor: kcPrimaryColor,
                          onRefresh: viewModel.refresh,
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  viewModel.deliveredOrders.entries.map((e) {
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
                                    price: e.value.totalAmount ?? 0,
                                    widget: Text(
                                      '${e.value.products?.first.quantity} Products',
                                      style: AppTextStyle.h4Bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }

  @override
  MyOrdersViewModel viewModelBuilder(BuildContext context) =>
      MyOrdersViewModel();

  @override
  void onViewModelReady(MyOrdersViewModel viewModel) {
    viewModel.getOrders(); // Fetch pending orders initially
  }
}

class OrderList extends StatelessWidget {
  final List<OrderModel> orders;

  const OrderList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Text(
          'No orders found',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(order: orders[index]);
      },
    );
  }
}
