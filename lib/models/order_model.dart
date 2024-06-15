

import 'package:marchant/models/cart_model.dart';
import 'package:marchant/models/product_model.dart';

class OrderModel {
  List<Map<String, dynamic>> products;
  String? id;
  num? count;
  num? totalPrice;

  OrderModel({
    required this.products,
    this.id,
    this.count,
    this.totalPrice,
  });

  List<CartModel> get cartList => products.map((product) {
    return CartModel(
      id: product['productId'],
      count: product['quantity'],
      // Assuming you have a method to get a product by its ID
      product: ProductModel(id: product['productId'], productName: 'Sample', salesPrice: 0),
    );
  }).toList();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products,
    };
  }

  // Optional: Add a factory constructor to create a OrderModel from a map
  // factory OrderModel.fromMap(Map<String, dynamic> map) {
  //   return OrderModel(
  //     id: map['_id'],
  //     products: List<String>.from(map['products'] ?? []),
  //   );
  // }
}




// order_model.dart
// class Product {
//   final String productId;
//   final double price;
//   final int quantity;

//   Product({
//     required this.productId,
//     required this.price,
//     required this.quantity,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       productId: json['productId'],
//       price: json['price'],
//       quantity: json['quantity'],
//     );
//   }
// }

// class Order {
//   final String id;
//   final String byRetailer;
//   final List<Product> products;
//   final double totalAmount;
//   final String status;
//   final String activityStatus;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Order({
//     required this.id,
//     required this.byRetailer,
//     required this.products,
//     required this.totalAmount,
//     required this.status,
//     required this.activityStatus,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Order.fromJson(Map<String, dynamic> json) {
//     var productList = json['products'] as List;
//     List<Product> products = productList.map((i) => Product.fromJson(i)).toList();

//     return Order(
//       id: json['_id'],
//       byRetailer: json['byRetailer'],
//       products: products,
//       totalAmount: json['totalAmount'],
//       status: json['status'],
//       activityStatus: json['activityStatus'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
// }
