import 'package:flutter/material.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/my_orders/my_orders_viewmodel.dart';
import 'package:marchant/ui/views/widgets/fading_circle.dart';
import 'package:stacked/stacked.dart';
import '../../common/app_colors.dart';
import '../../common/app_text_style.dart';
import '../widgets/custome_button.dart';
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
          backgroundColor: Colors.white,
          title: Text(
            viewModel.ordersHeader,
            style: AppTextStyle.h1Bold,
          ),
          bottom: TabBar(
            indicatorColor:
                kcPrimaryColor, // Setting the underline color to kcPrimaryColor
            tabs: [
              Tab(
                  child:
                      Text(viewModel.pendingTab, style: AppTextStyle.h3Bold)),
              Tab(
                  child:
                      Text(viewModel.deliveredTab, style: AppTextStyle.h3Bold)),
            ],
            onTap: (index) {
              if (index == 1) {
                viewModel
                    .getDeliveredOrders(); // Fetch delivered orders when the delivered tab is tapped
              }
            },

            // onTap: (index) {
            //   if (index ==1) {
            //     viewModel
            //         .getDeliveredOrders(); // Fetch delivered orders when the delivered tab is tapped
            //   } else if (index == 0) {
            //     viewModel.getOrders();
            //   }
            // },
          ),
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
              key: viewModel.refreshIndicatorKeyPending,
              displacement: 50,
              color: Colors.white,
              backgroundColor: kcPrimaryColor,
              onRefresh: viewModel.refreshPending,
              child: viewModel.isBusy
                  ? SizedBox(
                      height: screenHeight(context) * .3,
                      width: double.infinity,
                      child: const Center(
                        child: spinkit,
                      ),
                    )
                  : viewModel.errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                viewModel.errorMessage!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomeButton(
                                text: viewModel.retry,
                                onTap: viewModel.refreshPending,
                              ),
                            ],
                          ),
                        )
                      : viewModel.pendingOrders.isNotEmpty
                          ? SingleChildScrollView(
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
                                      onTap: () =>
                                          viewModel.onOrderTap(e.value),
                                      imageUrl: images,
                                      noPrice: false,
                                      price: double.parse((e.value.products
                                                  ?.first.totalAmount ??
                                              0)
                                          .toStringAsFixed(2)),
                                      widget: Text(
                                        '${e.value.products?.length} ${viewModel.productText}',
                                        style: AppTextStyle.h4Bold,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : Center(child: Text(viewModel.noOrdersAvail)),
            ),
            RefreshIndicator(
              key: viewModel.refreshIndicatorKeyDelivered,
              displacement: 50,
              color: Colors.white,
              backgroundColor: kcPrimaryColor,
              onRefresh: viewModel.refreshDelivered,
              child: viewModel.isBusy
                  ? SizedBox(
                      height: screenHeight(context) * .3,
                      width: double.infinity,
                      child: const Center(
                        child: spinkit,
                      ),
                    )
                  : viewModel.errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                viewModel.errorMessage!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomeButton(
                                text: viewModel.retry,
                                onTap: viewModel.refreshDelivered,
                              ),
                            ],
                          ),
                        )
                      : viewModel.deliveredOrders.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(
                                  height: screenHeight(context) * .4,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      viewModel.noDeliverOrders,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : SingleChildScrollView(
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
                                      onTap: () =>
                                          viewModel.onOrderTap(e.value),
                                      imageUrl: images,
                                      noPrice: false,
                                      price: double.parse((e.value.products
                                                  ?.first.totalAmount ??
                                              0)
                                          .toStringAsFixed(2)),
                                      widget: Text(
                                        '${e.value.products?.length} ${viewModel.productText}',
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
