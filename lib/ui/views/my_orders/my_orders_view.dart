import 'package:flutter/material.dart';
import 'package:marchant/ui/common/ui_helpers.dart';
import 'package:marchant/ui/views/my_orders/my_orders_viewmodel.dart';
import 'package:marchant/ui/views/widgets/nothing_found.dart';
import 'package:stacked/stacked.dart';
import 'package:marchant/models/order_model.dart';

class MyOrdersView extends StackedView<MyOrdersViewModel> {
  const MyOrdersView({super.key});

  @override
  Widget builder(
    BuildContext context,
    MyOrdersViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: viewModel.orders.isEmpty
          ? const Column(
                    children: [
                      verticalSpaceLarge,
                      NothingFound(),
                    ],
                  )
          : ListView.builder(
              itemCount: viewModel.orders.length,
              itemBuilder: (context, index) {
                var order = viewModel.orders.values.elementAt(index);
                return OrderCard(order: order);
              },
            ),
    );
  }

  @override
  MyOrdersViewModel viewModelBuilder(BuildContext context) => MyOrdersViewModel();

  @override
  void onViewModelReady(MyOrdersViewModel viewModel) {
    viewModel.getOrders();
  }
}
















class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Total Amount: ${order.totalAmount}'),
            Text('Status: ${order.status}'),
            const SizedBox(height: 8.0),
            const Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...order.products!.map((product) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Product Name: ${product.productName}, Quantity: ${product.quantity}',
                ),
              );
            }).toList(),
            const SizedBox(height: 8.0),
            Text('Created At: ${order.createdAt}'),
          ],
        ),
      ),
    );
  }
}









