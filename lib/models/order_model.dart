// import 'package:marchant/models/cart_model.dart';
// import 'package:marchant/models/product_model.dart';

// class OrderModel {
//   List<Map<String, dynamic>> products;
//   String? id;
//   num? count;
//   num? totalPrice;

//   OrderModel({
//     required this.products,
//     this.id,
//     this.count,
//     this.totalPrice,
//   });

//   List<CartModel> get cartList => products.map((product) {
//     return CartModel(
//       id: product['productId'],
//       count: product['quantity'],
//       // Assuming you have a method to get a product by its ID
//       product: ProductModel(id: product['productId'], productName: 'Sample', salesPrice: 0),
//     );
//   }).toList();

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'products': products,
//     };
//   }

import 'package:marchant/models/product_model.dart';

import 'package:marchant/models/cart_model.dart';

class OrderModel {
  String? id;
  String? byRetailer;
  List<ProductModel>? products;
  num? totalAmount;
  String? status;
  String? activityStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? count;
  num? totalPrice;

  OrderModel({
    this.id,
    this.byRetailer,
    this.products,
    this.totalAmount,
    this.status,
    this.activityStatus,
    this.createdAt,
    this.updatedAt,
    this.count,
    this.totalPrice,
  });

  // Factory constructor to create an OrderModel from a map
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    var productsList = map['products'] as List;
    List<ProductModel> products = productsList
        .map((productMap) => ProductModel.fromMap(productMap))
        .toList();

    return OrderModel(
      id: map['_id'],
      byRetailer: map['byRetailer'],
      products: products,
      totalAmount: map['totalAmount'],
      status: map['status'],
      activityStatus: map['activityStatus'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      count: map['count'],
      totalPrice: map['totalPrice'],
    );
  }

  // Method to convert an OrderModel instance to a map
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'byRetailer': byRetailer,
      'products': products?.map((product) => product.toMap()).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'activityStatus': activityStatus,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'count': count,
      'totalPrice': totalPrice,
    };
  }

  // Method to get a list of CartModel from products
  List<CartModel> get cartList =>
      products?.map((product) {
        return CartModel(
          id: product.id,
          count: product.quantity?.toInt() ?? 0,
          product: product,
        );
      }).toList() ??
      [];
}

// import 'package:marchant/models/product_model.dart';
// import 'package:marchant/models/cart_model.dart';

// class OrderModel {
//   String? id;
//   String? byRetailer;
//   List<ProductModel>? products;
//   num? totalAmount;
//   String? status;
//   String? activityStatus;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   num? count;
//   num? totalPrice;
//   String? productImage;
//   String? productName;

//   OrderModel({
//     this.id,
//     this.byRetailer,
//     this.products,
//     this.totalAmount,
//     this.status,
//     this.activityStatus,
//     this.createdAt,
//     this.updatedAt,
//     this.count,
//     this.totalPrice,
//     this.productImage,
//     this.productName,
//   });

//   // Factory constructor to create an OrderModel from a map
//   factory OrderModel.fromMap(Map<String, dynamic> map) {
//     var productsList = map['products'] as List;
//     List<ProductModel> products = productsList.map((productMap) {
//       var productData = productMap['productId'];
//       return ProductModel.fromMap(productData);
//     }).toList();

//     return OrderModel(
//       id: map['_id'],
//       byRetailer: map['byRetailer'],
//       products: products,
//       totalAmount: map['totalAmount'],
//       productImage: products.isNotEmpty ? products[0].productImage?.first : null,
//       productName: products.isNotEmpty ? products[0].productName : null,
//       status: map['status'],
//       activityStatus: map['activityStatus'],
//       createdAt: DateTime.parse(map['createdAt']),
//       updatedAt: DateTime.parse(map['updatedAt']),
//       count: map['count'],
//       totalPrice: map['totalPrice'],
//     );
//   }

//   // Method to convert an OrderModel instance to a map
//   Map<String, dynamic> toMap() {
//     return {
//       '_id': id,
//       'byRetailer': byRetailer,
//       'products': products?.map((product) => product.toMap()).toList(),
//       'totalAmount': totalAmount,
//       'status': status,
//       'activityStatus': activityStatus,
//       'createdAt': createdAt?.toIso8601String(),
//       'updatedAt': updatedAt?.toIso8601String(),
//       'count': count,
//       'totalPrice': totalPrice,
//     };
//   }

//   // Method to get a list of CartModel from products
//   List<CartModel> get cartList => products?.map((product) {
//     return CartModel(
//       id: product.id,
//       count: product.quantity?.toInt() ?? 0,
//       product: product,
//     );
//   }).toList() ?? [];
// }
