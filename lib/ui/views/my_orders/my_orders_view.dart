// import 'package:flutter/material.dart';
// import 'package:marchant/ui/common/ui_helpers.dart';
// import 'package:marchant/ui/views/my_orders/my_orders_viewmodel.dart';
// import 'package:marchant/ui/views/widgets/nothing_found.dart';
// import 'package:stacked/stacked.dart';
// import 'package:marchant/models/order_model.dart';

// class MyOrdersView extends StackedView<MyOrdersViewModel> {
//   const MyOrdersView({super.key});

//   @override
//   Widget builder(
//     BuildContext context,
//     MyOrdersViewModel viewModel,
//     Widget? child,
//   ) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Orders'),
//       ),
//       body: viewModel.orders.isEmpty
//           ? const Column(
//                     children: [
//                       verticalSpaceLarge,
//                       NothingFound(),
//                     ],
//                   )
//           : ListView.builder(
//               itemCount: viewModel.orders.length,
//               itemBuilder: (context, index) {
//                 var order = viewModel.orders.values.elementAt(index);
//                 return OrderCard(order: order);
//               },
//             ),
//     );
//   }

//   @override
//   MyOrdersViewModel viewModelBuilder(BuildContext context) => MyOrdersViewModel();

//   @override
//   void onViewModelReady(MyOrdersViewModel viewModel) {
//     viewModel.getOrders();
//   }
// }


// class OrderCard extends StatelessWidget {
//   final OrderModel order;

//   const OrderCard({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order ID: ${order.id}',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8.0),
//             Text('Total Amount: ${order.totalAmount}'),
//             Text('Status: ${order.status}'),
//             const SizedBox(height: 8.0),
//             const Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
//             ...order.products!.map((product) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Text(
//                   'Product Name: ${product.productName}, Quantity: ${product.quantity}',
//                 ),
//               );
//             }).toList(),
//             const SizedBox(height: 8.0),
//             Text('Created At: ${order.createdAt}'),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:marchant/ui/common/ui_helpers.dart';
// import 'package:marchant/ui/views/my_orders/my_orders_viewmodel.dart';
// import 'package:marchant/ui/views/widgets/nothing_found.dart';
// import 'package:stacked/stacked.dart';
// import 'package:marchant/models/order_model.dart';

// class MyOrdersView extends StackedView<MyOrdersViewModel> {
//   const MyOrdersView({super.key});

//   @override
//   Widget builder(
//     BuildContext context,
//     MyOrdersViewModel viewModel,
//     Widget? child,
//   ) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Orders'),
//       ),
//       body: viewModel.orders.isEmpty
//           ? const Column(
//                     children: [
//                       verticalSpaceLarge,
//                       NothingFound(),
//                     ],
//                   )
//           : ListView.builder(
//               itemCount: viewModel.orders.length,
//               itemBuilder: (context, index) {
//                 var order = viewModel.orders.values.elementAt(index);
//                 return OrderCard(order: order);
//               },
//             ),
//     );
//   }

//   @override
//   MyOrdersViewModel viewModelBuilder(BuildContext context) => MyOrdersViewModel();

//   @override
//   void onViewModelReady(MyOrdersViewModel viewModel) {
//     viewModel.getOrders();
//   }
// }
















// class OrderCard extends StatelessWidget {
//   final OrderModel order;

//   const OrderCard({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(8.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Order ID: ${order.id}',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8.0),
//             Text('Total Amount: ${order.totalAmount}'),
//             Text('Status: ${order.status}'),
//             const SizedBox(height: 8.0),
//             const Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
//             ...order.products!.map((product) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Text(
//                   'Product Name: ${product.productName}, Quantity: ${product.quantity}',
//                 ),
//               );
//             }).toList(),
//             const SizedBox(height: 8.0),
//             Text('Created At: ${order.createdAt}'),
//           ],
//         ),
//       ),
//     );
//   }
// }



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
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Delivered'),
            ],
          ),
        ),
        body: viewModel.orders.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox, size: 80, color: Colors.grey),
                    verticalSpaceLarge,
                    NothingFound(),
                  ],
                ),
              )
            : TabBarView(
                children: [
                  OrderList(
                    orders: viewModel.orders.values
                        .where((order) => order.status == 'Pending')
                        .toList(),
                  ),
                  OrderList(
                    orders: viewModel.orders.values
                        .where((order) => order.status == 'Delivered')
                        .toList(),
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
    viewModel.getOrders();
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

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Total Amount: ${order.totalAmount}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              'Status: ${order.status}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Products:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...order.products!.map((product) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Product Name: ${product.productName}, Quantity: ${product.quantity}',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              );
            }).toList(),
            const SizedBox(height: 8.0),
            Text(
              'Created At: ${order.createdAt}',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
